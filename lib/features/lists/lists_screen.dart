import 'dart:async';

import '../../core/money/format_locale.dart';
import '../../core/text/list_title.dart';

import 'package:flutter/material.dart';
import 'package:napp_ads/napp_ads.dart';

import '../../core/theme/brand_wordmark.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../app/app_defaults.dart';
import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/money/money_format.dart';
import '../../core/money/money_parser.dart';
import '../../data/db/app_database.dart';
import 'list_detail_screen.dart';
import 'list_repository.dart';
import 'list_scheduling.dart';
import 'reminders/reminder_scheduler.dart';
import 'reminders/reminders_repository.dart';
import 'list_status.dart';
import '../voice_input/dictation_mic_button.dart';
import '../onboarding/coach_tour.dart';
import '../onboarding/first_run_guide.dart';

/// Liste durumlarının görünen adları (kanonik kod → l10n).
String statusLabel(AppLocalizations l10n, ListStatus status) =>
    switch (status) {
      ListStatus.draft => l10n.statusDraft,
      ListStatus.planned => l10n.statusPlanned,
      ListStatus.shopping => l10n.statusShopping,
      ListStatus.completed => l10n.statusCompleted,
      ListStatus.archived => l10n.statusArchived,
    };

/// Başlığın görünen değeri: kullanıcı başlığı yoksa üretilmiş ad.
String listDisplayTitle(AppLocalizations l10n, ShoppingList list) =>
    shoppingListTitle(list, fallback: l10n.listsTitle);

/// Aktif/tamamlanmış/arşiv sekmeli liste ekranı (spec §6.1).
class ListsScreen extends StatefulWidget {
  const ListsScreen({
    super.key,
    required this.repository,
    this.onOpenListDetail,
    this.reminderScheduler,
    this.bannerController,
    this.onScanReceipt,
    this.receiptBusy = false,
    this.onDiscover,
    this.planBadge,
  });

  final ListRepository repository;

  /// Test dikişi: liste detayına geçirilir (hatırlatma akışı).
  final ReminderScheduler? reminderScheduler;
  final BannerAdController? bannerController;

  /// Liste kartına dokununca detay ekranını açar; verilmediyse dahili olarak
  /// ListDetailScreen push edilir.
  final void Function(BuildContext context, int listId)? onOpenListDetail;
  final VoidCallback? onScanReceipt;
  final bool receiptBusy;
  final VoidCallback? onDiscover;

  /// Plan simgesi (ana sayfanın üstünde); verilmezse gösterilmez.
  final Widget? planBadge;

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  String _query = '';
  final _searchController = TextEditingController();
  bool _editorOpen = false;
  ListSortMode _sort = ListSortMode.fromCode(AppDefaults.listSort());
  final _orders = <ListStatus, List<int>>{};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sortLabel = switch (_sort) {
      ListSortMode.date => l10n.listSortDate,
      ListSortMode.title => l10n.listSortAz,
      ListSortMode.manual => l10n.listSortManual,
    };
    // F26: sort sits at the end of the tabs row (start in RTL).
    final sortButton = Semantics(
      value: sortLabel,
      child: IconButton(
        key: const Key('lists_sort_button'),
        tooltip: '${l10n.listSortLabel}: $sortLabel',
        icon: Icon(switch (_sort) {
          ListSortMode.date => Icons.event_outlined,
          ListSortMode.title => Icons.sort_by_alpha,
          ListSortMode.manual => Icons.drag_indicator,
        }),
        onPressed: () => setState(() {
          _sort = _sort.next;
          AppDefaults.setListSort(_sort.name);
        }),
      ),
    );
    final helpInAppBar = MediaQuery.sizeOf(context).width >= 380;
    final helpButton = TourAnchor(
      id: TourTargets.listsHelp,
      child: IconButton(
        key: const Key('lists_help_button'),
        tooltip: l10n.howToUseLabel,
        icon: const Icon(Icons.help_outline),
        onPressed: () => showFirstRunGuide(context),
      ),
    );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const BrandTitle(),
          // F26/F02: [Discover][Pro] — Pro ends 16dp from the screen edge;
          // Discover's 48dp target leaves a 12dp gap between glyph and badge.
          // F40: [?] replays the coach-mark tour; below 380dp the brand
          // would shrink past legibility with long plan names, so it moves
          // to the tabs row beside sort.
          actions: [
            if (helpInAppBar) helpButton,
            if (widget.onDiscover != null)
              TourAnchor(
                id: TourTargets.listsDiscover,
                child: IconButton(
                  key: const Key('home_nav_discover'),
                  tooltip: l10n.navDiscover,
                  icon: const Icon(Icons.explore_outlined),
                  onPressed: widget.onDiscover,
                ),
              ),
            if (widget.planBadge != null) ...[
              TourAnchor(id: TourTargets.listsPlan, child: widget.planBadge!),
              const SizedBox(width: 16),
            ] else
              const SizedBox(width: 4),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: TourAnchor(
              id: TourTargets.listsTabs,
              child: Row(
                children: [
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        Tab(
                          key: const Key('lists_tab_active'),
                          text: l10n.listsTabActive,
                        ),
                        Tab(
                          key: const Key('lists_tab_completed'),
                          text: l10n.listsTabCompleted,
                        ),
                        Tab(
                          key: const Key('lists_tab_archived'),
                          text: l10n.listsTabArchived,
                        ),
                      ],
                    ),
                  ),
                  if (!helpInAppBar) helpButton,
                  sortButton,
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            // F26/F27: no show/hide toggle; search stays under the tabs and
            // filters whichever sort order is active.
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: TextField(
                key: const Key('lists_search_field'),
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  isDense: true,
                  labelText: l10n.searchListHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          key: const Key('lists_search_clear'),
                          constraints: const BoxConstraints(
                            minWidth: 48,
                            minHeight: 48,
                          ),
                          tooltip: MaterialLocalizations.of(context)
                              .clearButtonTooltip,
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                ),
                onChanged: (v) => setState(() => _query = v.trim()),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _ListsTab(
                    repository: widget.repository,
                    query: _query,
                    sort: _sort,
                    statuses: const {
                      ListStatus.draft,
                      ListStatus.planned,
                      ListStatus.shopping,
                    },
                    orderKey: ListStatus.draft,
                    order: _orders[ListStatus.draft],
                    onReorder: (lists, oldIndex, newIndex) => _reorderLists(
                      ListStatus.draft,
                      lists,
                      oldIndex,
                      newIndex,
                    ),
                    emptyText: l10n.listsEmpty,
                    onOpenListDetail: widget.onOpenListDetail,
                    reminderScheduler: widget.reminderScheduler,
                    bannerController: widget.bannerController,
                  ),
                  _ListsTab(
                    repository: widget.repository,
                    query: _query,
                    sort: _sort,
                    statuses: const {ListStatus.completed},
                    orderKey: ListStatus.completed,
                    order: _orders[ListStatus.completed],
                    onReorder: (lists, oldIndex, newIndex) => _reorderLists(
                      ListStatus.completed,
                      lists,
                      oldIndex,
                      newIndex,
                    ),
                    emptyText: l10n.listsEmpty,
                    onOpenListDetail: widget.onOpenListDetail,
                    reminderScheduler: widget.reminderScheduler,
                    bannerController: widget.bannerController,
                  ),
                  _ListsTab(
                    repository: widget.repository,
                    query: _query,
                    sort: _sort,
                    statuses: const {ListStatus.archived},
                    orderKey: ListStatus.archived,
                    order: _orders[ListStatus.archived],
                    onReorder: (lists, oldIndex, newIndex) => _reorderLists(
                      ListStatus.archived,
                      lists,
                      oldIndex,
                      newIndex,
                    ),
                    emptyText: l10n.listsEmpty,
                    onOpenListDetail: widget.onOpenListDetail,
                    reminderScheduler: widget.reminderScheduler,
                    bannerController: widget.bannerController,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: MediaQuery.viewInsetsOf(context).bottom > 0
            ? null
            : SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: TourAnchor(
                            id: TourTargets.listsNew,
                            child: FilledButton(
                              key: const Key('lists_new_list_button'),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                minimumSize: const Size(48, 48),
                              ),
                              onPressed: _editorOpen
                                  ? null
                                  : () => _openEditor(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.add),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      l10n.newListButton,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (widget.onScanReceipt != null) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: TourAnchor(
                              id: TourTargets.listsReceipt,
                              child: FilledButton.tonal(
                                key: const Key('lists_receipt_button'),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  minimumSize: const Size(48, 48),
                                ),
                                onPressed: widget.receiptBusy
                                    ? null
                                    : widget.onScanReceipt,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.receipt_long_outlined),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        l10n.fromReceiptListButton,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _openEditor(BuildContext context) async {
    if (_editorOpen) return;
    setState(() => _editorOpen = true);
    try {
      await showListEditor(
        context,
        widget.repository,
        reminderScheduler: widget.reminderScheduler,
        bannerController: widget.bannerController,
      );
    } finally {
      if (mounted) setState(() => _editorOpen = false);
    }
  }

  void _reorderLists(
    ListStatus status,
    List<ShoppingList> lists,
    int oldIndex,
    int newIndex,
  ) {
    final ordered = lists.map((list) => list.id).toList();
    final moved = ordered.removeAt(oldIndex);
    ordered.insert(newIndex, moved);
    setState(() => _orders[status] = ordered);
    unawaited(widget.repository.reorderLists(ordered));
  }
}

Future<void> showListEditor(
  BuildContext context,
  ListRepository repository, {
  ShoppingList? existing,
  ReminderScheduler? reminderScheduler,
  BannerAdController? bannerController,
}) async {
  final id = await showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _ListEditorSheet(
      repository: repository,
      l10n: AppLocalizations.of(context),
      existing: existing,
      reminderScheduler: reminderScheduler,
    ),
  );
  if (existing == null && id != null && context.mounted) {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ListDetailScreen(
          db: repository.db,
          listRepository: repository,
          listId: id,
          reminderScheduler: reminderScheduler,
          bannerController: bannerController,
        ),
      ),
    );
  }
}

class _ListsTab extends StatelessWidget {
  const _ListsTab({
    required this.repository,
    required this.query,
    required this.sort,
    required this.statuses,
    required this.orderKey,
    required this.order,
    required this.onReorder,
    required this.emptyText,
    required this.onOpenListDetail,
    this.reminderScheduler,
    this.bannerController,
  });

  final ListRepository repository;
  final String query;
  final ListSortMode sort;
  final Set<ListStatus> statuses;
  final ListStatus orderKey;
  final List<int>? order;
  final void Function(List<ShoppingList>, int, int) onReorder;
  final String emptyText;
  final void Function(BuildContext, int)? onOpenListDetail;
  final ReminderScheduler? reminderScheduler;
  final BannerAdController? bannerController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ShoppingList>>(
      stream: repository.watchAll(),
      builder: (context, snapshot) {
        final lists = sortShoppingLists(
          (snapshot.data ?? const <ShoppingList>[])
              .where(
                (list) => statuses.contains(ListStatus.tryFromDb(list.status)),
              )
              .where(
                (list) =>
                    query.isEmpty ||
                    shoppingListTitle(list)
                        .toLowerCase()
                        .contains(query.toLowerCase()),
              ),
          mode: sort,
          localeCode: Localizations.localeOf(context).languageCode,
          fallbackTitle: AppLocalizations.of(context).listsTitle,
        );
        if (lists.isEmpty) {
          final colors = Theme.of(context).colorScheme;
          // Scrolls when the always-visible search leaves little height
          // (320dp, 2x text) instead of overflowing.
          return LayoutBuilder(
            builder: (context, box) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: box.maxHeight),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colors.secondaryContainer,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Icon(
                            Icons.receipt_long_outlined,
                            size: 30,
                            color: colors.onSecondaryContainer,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          emptyText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        // A filtered manual list keeps its saved order without drag handles:
        // reordering a subset would rewrite the hidden lists' positions.
        if (sort != ListSortMode.manual || query.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 12),
            itemCount: lists.length,
            itemBuilder: (context, index) => _ListCard(
              key: ValueKey('sorted_${lists[index].id}'),
              repository: repository,
              list: lists[index],
              onOpen: onOpenListDetail,
              reminderScheduler: reminderScheduler,
              bannerController: bannerController,
            ),
          );
        }
        final customOrder = order ?? const <int>[];
        lists.sort((a, b) {
          final ai = customOrder.indexOf(a.id);
          final bi = customOrder.indexOf(b.id);
          if (ai >= 0 && bi >= 0) return ai.compareTo(bi);
          if (ai >= 0) return -1;
          if (bi >= 0) return 1;
          final byOrder = a.sortOrder.compareTo(b.sortOrder);
          if (byOrder != 0) return byOrder;
          final created = a.createdAt.compareTo(b.createdAt);
          return created == 0 ? a.id.compareTo(b.id) : created;
        });
        return ReorderableListView.builder(
          padding: const EdgeInsets.only(bottom: 12),
          buildDefaultDragHandles: false,
          itemCount: lists.length,
          onReorderItem: (oldIndex, newIndex) =>
              onReorder(lists, oldIndex, newIndex),
          itemBuilder: (context, index) => KeyedSubtree(
            key: ValueKey('reorder_${orderKey.name}_${lists[index].id}'),
            child: ReorderableDelayedDragStartListener(
              index: index,
              child: _ListCard(
                repository: repository,
                list: lists[index],
                onOpen: onOpenListDetail,
                reminderScheduler: reminderScheduler,
                bannerController: bannerController,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({
    super.key,
    required this.repository,
    required this.list,
    this.onOpen,
    this.reminderScheduler,
    this.bannerController,
  });

  final ListRepository repository;
  final ShoppingList list;
  final void Function(BuildContext, int)? onOpen;
  final ReminderScheduler? reminderScheduler;
  final BannerAdController? bannerController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = ListStatus.tryFromDb(list.status)!;
    return Dismissible(
      key: ValueKey('list_${list.id}'),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: AlignmentDirectional.centerStart,
        padding: const EdgeInsetsDirectional.only(start: 24),
        child: Icon(
          Icons.delete_outline,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
      secondaryBackground: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsetsDirectional.only(end: 24),
        child: Icon(
          Icons.delete_outline,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
      confirmDismiss: (_) async {
        try {
          final snapshot = await repository.deleteList(list.id);
          if (context.mounted) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text(l10n.listDeleted),
                  showCloseIcon: true,
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: l10n.undoButton,
                    onPressed: () => repository.undoDelete(snapshot),
                  ),
                ),
              );
          }
          return true;
        } catch (_) {
          return false;
        }
      },
      child: Card(
        child: ListTile(
          leading: Icon(
            status == ListStatus.completed
                ? Icons.task_alt_outlined
                : status == ListStatus.archived
                ? Icons.inventory_2_outlined
                : Icons.shopping_basket_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
          onTap: () {
            final open = onOpen;
            if (open != null) {
              open(context, list.id);
            } else {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ListDetailScreen(
                    db: repository.db,
                    listRepository: repository,
                    listId: list.id,
                    reminderScheduler: reminderScheduler,
                    bannerController: bannerController,
                  ),
                ),
              );
            }
          },
          title: Text(
            listDisplayTitle(l10n, list),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: list.plannedAt == null && list.budgetMinorUnits == null
              ? null
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (list.plannedAt != null)
                      Text(shoppingDateText(context, list.plannedAt!)),
                    if (list.budgetMinorUnits != null)
                      Text(
                        formatMoney(
                          Money.fromMinorUnits(
                            list.budgetMinorUnits!,
                            Currency.fromCode(list.currencyCode),
                          ),
                          locale: formatLocaleCode(context),
                        ),
                      ),
                  ],
                ),
          trailing: PopupMenuButton<String>(
            tooltip: l10n.editAction,
            onSelected: (action) => _onAction(context, action),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'edit', child: Text(l10n.editAction)),
              PopupMenuItem(
                value: 'duplicate',
                child: Text(l10n.duplicateAction),
              ),
              if (status != ListStatus.archived)
                PopupMenuItem(value: 'archive', child: Text(l10n.archiveAction))
              else
                PopupMenuItem(
                  value: 'unarchive',
                  child: Text(l10n.unarchiveAction),
                ),
              PopupMenuItem(value: 'delete', child: Text(l10n.deleteButton)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onAction(BuildContext context, String action) async {
    final l10n = AppLocalizations.of(context);
    switch (action) {
      case 'edit':
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (_) => _ListEditorSheet(
            repository: repository,
            l10n: l10n,
            existing: list,
            reminderScheduler: reminderScheduler,
          ),
        );
      case 'duplicate':
        await repository.duplicateList(list.id);
      case 'archive':
        await repository.changeStatus(list.id, ListStatus.archived);
      case 'unarchive':
        await repository.changeStatus(list.id, ListStatus.draft);
      case 'delete':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(l10n.deleteButton),
            content: Text(l10n.deleteListConfirm),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.cancelButton),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(l10n.deleteButton),
              ),
            ],
          ),
        );
        if (confirmed == true && context.mounted) {
          final messenger = ScaffoldMessenger.of(context);
          final DeletedListSnapshot snapshot;
          try {
            snapshot = await repository.deleteList(list.id);
          } catch (_) {
            if (context.mounted) {
              messenger
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text(l10n.saveFailed),
                    showCloseIcon: true,
                    duration: const Duration(days: 1),
                  ),
                );
            }
            return;
          }
          if (!context.mounted) return;
          messenger
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(l10n.listDeleted),
                showCloseIcon: true,
                action: SnackBarAction(
                  label: l10n.undoButton,
                  onPressed: () => repository.undoDelete(snapshot),
                ),
              ),
            );
        }
    }
  }
}

class _ListEditorSheet extends StatefulWidget {
  const _ListEditorSheet({
    required this.repository,
    required this.l10n,
    this.existing,
    this.reminderScheduler,
  });

  final ListRepository repository;
  final AppLocalizations l10n;
  final ShoppingList? existing;
  final ReminderScheduler? reminderScheduler;

  @override
  State<_ListEditorSheet> createState() => _ListEditorSheetState();
}

class _ListEditorSheetState extends State<_ListEditorSheet> {
  late final TextEditingController _title = TextEditingController(
    text: widget.existing?.title ?? '',
  );
  late final TextEditingController _budget = TextEditingController();
  String? _budgetPrefilled;
  late DateTime? _plannedAt = widget.existing?.plannedAt;
  late String _reminderMode = AppDefaults.datedReminderMode();
  late String _currency =
      widget.existing?.currencyCode ?? AppDefaults.defaultCurrency();
  late final TextEditingController _note = TextEditingController(
    text: widget.existing?.note ?? '',
  );
  String? _budgetError;
  String? _saveError;
  bool _saving = false;
  final _detailsController = ExpansibleController();

  @override
  void initState() {
    super.initState();
    _title.addListener(_capitalizeTitle);
  }

  void _capitalizeTitle() {
    final value = ListTitleFormatter(localeCode: widget.l10n.localeName)
        .formatEditUpdate(_title.value, _title.value);
    if (value != _title.value) _title.value = value;
  }

  /// Bütçe minor unit değerini, kullanıcının dilindeki ondalık ayracıyla
  /// girdi dizesine çevirir (tr: `100,00`, en: `100.00`).
  String _minorToInput(int minor, Currency c, String decimalSep) {
    final div = c.minorUnitDigits == 0 ? 1 : _pow10(c.minorUnitDigits);
    final major = minor ~/ div;
    final frac = minor % div;
    if (c.minorUnitDigits == 0) return '$major';
    return '$major$decimalSep${frac.toString().padLeft(c.minorUnitDigits, '0')}';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_budgetPrefilled == null && widget.existing?.budgetMinorUnits != null) {
      _budgetPrefilled = '';
      final existing = widget.existing!;
      final sep = MoneySeparators.forLocaleCode(formatLocaleCode(context))
          .decimal;
      _budget.text = _minorToInput(
        existing.budgetMinorUnits!,
        Currency.fromCode(existing.currencyCode),
        sep,
      );
    }
  }

  static int _pow10(int n) {
    var v = 1;
    for (var i = 0; i < n; i++) {
      v *= 10;
    }
    return v;
  }

  @override
  void dispose() {
    _title.removeListener(_capitalizeTitle);
    _title.dispose();
    _budget.dispose();
    _note.dispose();
    super.dispose();
  }

  /// Bütçe girdisini kullanıcının dilindeki ayraçlarla minor unite çevirir;
  /// geçersiz girdi [_BudgetFormatException] verir.
  int? _parseBudgetMinor() {
    final text = _budget.text.trim();
    if (text.isEmpty) return null;
    final localeCode = Localizations.localeOf(context).languageCode;
    try {
      final value = MoneyParser.parseDecimal(
        text,
        separators: MoneySeparators.forLocaleCode(localeCode),
        requirePositive: true,
      );
      return value.toMinorUnits(Currency.fromCode(_currency).minorUnitDigits);
    } on FormatException {
      throw const _BudgetFormatException();
    }
  }

  Future<void> _save() async {
    final existing = widget.existing;
    final title = _title.text.trim();
    final budgetMinor = _parseBudgetMinor();

    int? createdId;
    if (existing == null) {
      final now = DateTime.now();
      final generated = title.isEmpty
          ? widget.l10n.autoListTitle(_formatDate(now))
          : null;
      createdId = await widget.repository.createList(
        title: title.isEmpty ? null : title,
        titleLocaleCode: widget.l10n.localeName,
        generatedTitle: generated,
        currencyCode: _currency,
        plannedAt: _plannedAt,
        budgetMinorUnits: budgetMinor,
        note: _note.text.trim().isEmpty ? null : _note.text.trim(),
      );
    } else {
      final currencyChanged = existing.currencyCode != _currency;
      final hasAmounts = existing.budgetMinorUnits != null;
      if (currencyChanged && hasAmounts) {
        final reset = await _askCurrencyChange();
        if (reset == null) return; // kullanıcı vazgeçti
        await widget.repository.changeCurrency(
          existing.id,
          _currency,
          resetAmounts: reset,
        );
      } else if (currencyChanged) {
        await widget.repository.changeCurrency(
          existing.id,
          _currency,
          resetAmounts: false,
        );
      }
      await widget.repository.updateTitle(
        existing.id,
        title.isEmpty ? null : title,
        titleLocaleCode: widget.l10n.localeName,
      );
      if (budgetMinor != existing.budgetMinorUnits) {
        await widget.repository.updateBudget(existing.id, budgetMinor);
      }
      if (_plannedAt != existing.plannedAt) {
        await widget.repository.updatePlannedAt(existing.id, _plannedAt);
      }
      await widget.repository.updateNote(
        existing.id,
        _note.text.trim().isEmpty ? null : _note.text.trim(),
      );
    }
    AppDefaults.setDatedReminderMode(_reminderMode);
    final targetId = createdId ?? existing!.id;
    final scheduler = widget.reminderScheduler;
    if (scheduler != null) {
      try {
        final repo = RemindersRepository(widget.repository.db, scheduler);
        if (_plannedAt == null || _reminderMode == 'none') {
          if (existing != null && _plannedAt == null) {
            final active = await repo.activeForList(targetId);
            if (active != null) await repo.cancelReminder(active.id);
          }
        } else {
          final granted = await scheduler.ensurePermission();
          if (granted) {
            final desired = _reminderMode == '1h'
                ? _plannedAt!.subtract(const Duration(hours: 1))
                : _plannedAt!;
            final now = DateTime.now();
            final fireAt = desired.isAfter(now)
                ? desired
                : now.add(const Duration(seconds: 30));
            final displayName = title.isNotEmpty
                ? title
                : (existing?.generatedTitle ?? widget.l10n.listsTitle);
            await repo.setReminder(
              listId: targetId,
              title: widget.l10n.reminderTitle,
              body: widget.l10n.reminderBody(displayName),
              atUtc: fireAt.toUtc(),
            );
          }
        }
      } catch (_) {
        // Optional reminder scheduling never blocks saving the list (N063/N064).
      }
    }
    if (mounted) Navigator.of(context).pop(createdId);
  }

  Future<bool?> _askCurrencyChange() {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(widget.l10n.currencyLabel),
        content: Text(widget.l10n.currencyChangeWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(widget.l10n.keepAmountsAction),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(widget.l10n.resetAmountsAction),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: const Key('list_title_field'),
              controller: _title,
              textCapitalization: TextCapitalization.sentences,
              inputFormatters: [
                ListTitleFormatter(localeCode: l10n.localeName),
              ],
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: l10n.listTitleHint,
                suffixIcon: DictationMicButton(
                  key: const Key('list_title_mic'),
                  controller: _title,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ShoppingDateField(
              value: _plannedAt,
              enabled: !_saving,
              onChanged: (value) => setState(() => _plannedAt = value),
            ),
            if (_plannedAt != null) ...[
              const SizedBox(height: 8),
              Wrap(
                key: const Key('dated_list_reminder_mode'),
                spacing: 8,
                runSpacing: 4,
                children: [
                  ChoiceChip(
                    key: const Key('dated_reminder_none'),
                    label: Text(l10n.cancelButton),
                    selected: _reminderMode == 'none',
                    onSelected: _saving
                        ? null
                        : (_) => setState(() => _reminderMode = 'none'),
                  ),
                  ChoiceChip(
                    key: const Key('dated_reminder_same_day'),
                    label: Text(l10n.setReminderAction),
                    selected: _reminderMode == 'same_day',
                    onSelected: _saving
                        ? null
                        : (_) => setState(() => _reminderMode = 'same_day'),
                  ),
                  ChoiceChip(
                    key: const Key('dated_reminder_1h'),
                    label: Text('${l10n.setReminderAction} (-1h)'),
                    selected: _reminderMode == '1h',
                    onSelected: _saving
                        ? null
                        : (_) => setState(() => _reminderMode = '1h'),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            ExpansionTile(
              key: const Key('list_details_expand'),
              controller: _detailsController,
              title: Text(l10n.detailsSection),
              childrenPadding: const EdgeInsets.only(top: 12, bottom: 8),
              children: [
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  key: const Key('list_currency_field'),
                  initialValue: _currency,
                  decoration: InputDecoration(labelText: l10n.currencyLabel),
                  items: Currency.all
                      .map(
                        (c) => DropdownMenuItem(
                          value: c.code,
                          child: Text(c.code),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _currency = v ?? _currency),
                ),
                const SizedBox(height: 12),
                TextField(
                  key: const Key('list_budget_field'),
                  controller: _budget,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.budgetLabel,
                    errorText: _budgetError,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _note,
                  decoration: InputDecoration(labelText: l10n.noteLabel),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('list_save_button'),
              onPressed: _saving
                  ? null
                  : () async {
                      setState(() {
                        _budgetError = null;
                        _saveError = null;
                        _saving = true;
                      });
                      try {
                        await _save();
                      } on _BudgetFormatException {
                        if (mounted) {
                          _detailsController.expand();
                          setState(
                            () => _budgetError = l10n.invalidAmountError,
                          );
                        }
                      } catch (_) {
                        if (mounted) {
                          setState(() => _saveError = l10n.saveFailed);
                        }
                      } finally {
                        if (mounted) setState(() => _saving = false);
                      }
                    },
              child: Text(l10n.saveButton),
            ),
            if (_saveError != null)
              Text(
                _saveError!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            TextButton(
              key: const Key('list_cancel_button'),
              onPressed: _saving ? null : () => Navigator.of(context).pop(),
              child: Text(l10n.cancelButton),
            ),
          ],
        ),
      ),
    );
  }
}

class _BudgetFormatException implements Exception {
  const _BudgetFormatException();
}
