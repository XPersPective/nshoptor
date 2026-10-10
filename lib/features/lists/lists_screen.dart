import '../../core/money/format_locale.dart';
import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../app/app_defaults.dart';
import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import '../../core/money/money_format.dart';
import '../../core/money/money_parser.dart';
import '../../data/db/app_database.dart';
import 'list_detail_screen.dart';
import 'list_repository.dart';
import 'reminders/reminder_scheduler.dart';
import 'list_status.dart';

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
    list.title ?? list.generatedTitle ?? l10n.listsTitle;

/// Aktif/tamamlanmış/arşiv sekmeli liste ekranı (spec §6.1).
class ListsScreen extends StatefulWidget {
  const ListsScreen({
    super.key,
    required this.repository,
    this.onOpenListDetail,
    this.reminderScheduler,
  });

  final ListRepository repository;

  /// Test dikişi: liste detayına geçirilir (hatırlatma akışı).
  final ReminderScheduler? reminderScheduler;

  /// Liste kartına dokununca detay ekranını açar; verilmediyse dahili olarak
  /// ListDetailScreen push edilir.
  final void Function(BuildContext context, int listId)? onOpenListDetail;

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.listsTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.listsTabActive),
              Tab(text: l10n.listsTabCompleted),
              Tab(text: l10n.listsTabArchived),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: TextField(
                key: const Key('lists_search_field'),
                decoration: InputDecoration(
                  hintText: l10n.searchListHint,
                  prefixIcon: const Icon(Icons.search),
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
                    statuses: const {
                      ListStatus.draft,
                      ListStatus.planned,
                      ListStatus.shopping,
                    },
                    emptyText: l10n.listsEmpty,
                    onOpenListDetail: widget.onOpenListDetail,
                    reminderScheduler: widget.reminderScheduler,
                  ),
                  _ListsTab(
                    repository: widget.repository,
                    query: _query,
                    statuses: const {ListStatus.completed},
                    emptyText: l10n.listsEmpty,
                    onOpenListDetail: widget.onOpenListDetail,
                    reminderScheduler: widget.reminderScheduler,
                  ),
                  _ListsTab(
                    repository: widget.repository,
                    query: _query,
                    statuses: const {ListStatus.archived},
                    emptyText: l10n.listsEmpty,
                    onOpenListDetail: widget.onOpenListDetail,
                    reminderScheduler: widget.reminderScheduler,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          key: const Key('lists_new_list_button'),
          heroTag: 'listsFab',
          onPressed: () => _openEditor(context),
          icon: const Icon(Icons.add),
          label: Text(l10n.newListButton),
        ),
      ),
    );
  }

  Future<void> _openEditor(BuildContext context, {ShoppingList? existing}) {
    return showListEditor(context, widget.repository, existing: existing,
        reminderScheduler: widget.reminderScheduler);
  }
}

Future<void> showListEditor(BuildContext context, ListRepository repository,
    {ShoppingList? existing, ReminderScheduler? reminderScheduler}) async {
    final id = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ListEditorSheet(
        repository: repository,
        l10n: AppLocalizations.of(context),
        existing: existing,
      ),
    );
    if (existing == null && id != null && context.mounted) {
      await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) =>
        ListDetailScreen(db: repository.db, listRepository: repository,
          listId: id, reminderScheduler: reminderScheduler)));
    }
}

class _ListsTab extends StatelessWidget {
  const _ListsTab({
    required this.repository,
    required this.query,
    required this.statuses,
    required this.emptyText,
    required this.onOpenListDetail,
    this.reminderScheduler,
  });

  final ListRepository repository;
  final String query;
  final Set<ListStatus> statuses;
  final String emptyText;
  final void Function(BuildContext, int)? onOpenListDetail;
  final ReminderScheduler? reminderScheduler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ShoppingList>>(
      stream: repository.watchAll(),
      builder: (context, snapshot) {
        final lists = (snapshot.data ?? const <ShoppingList>[])
            .where((l) => statuses.contains(ListStatus.tryFromDb(l.status)))
            .where((l) =>
                query.isEmpty ||
                (l.title ?? l.generatedTitle ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        if (lists.isEmpty) {
          final colors = Theme.of(context).colorScheme;
          return Center(
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context, index) => _ListCard(
            repository: repository,
            list: lists[index],
            onOpen: onOpenListDetail,
            reminderScheduler: reminderScheduler,
          ),
        );
      },
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({
    required this.repository,
    required this.list,
    this.onOpen,
    this.reminderScheduler,
  });

  final ListRepository repository;
  final ShoppingList list;
  final void Function(BuildContext, int)? onOpen;
  final ReminderScheduler? reminderScheduler;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = ListStatus.tryFromDb(list.status)!;
    return Card(
      child: ListTile(
        onTap: () {
          final open = onOpen;
          if (open != null) {
            open(context, list.id);
          } else {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (_) => ListDetailScreen(
                db: repository.db,
                listRepository: repository,
                listId: list.id,
                reminderScheduler: reminderScheduler,
              ),
            ));
          }
        },
        title: Text(listDisplayTitle(l10n, list),
            overflow: TextOverflow.ellipsis),
        subtitle: Text(
          [
            statusLabel(l10n, status),
            // Bütçe yoksa "0,00" yazılmaz (yanıltıcıydı).
            if (list.budgetMinorUnits != null)
              formatMoney(
                Money.fromMinorUnits(
                    list.budgetMinorUnits!, Currency.fromCode(list.currencyCode)),
                locale: formatLocaleCode(context),
              ),
          ].join(' · '),
        ),
        trailing: PopupMenuButton<String>(
          tooltip: l10n.editAction,
          onSelected: (action) => _onAction(context, action),
          itemBuilder: (_) => [
            PopupMenuItem(value: 'edit', child: Text(l10n.editAction)),
            PopupMenuItem(value: 'duplicate', child: Text(l10n.duplicateAction)),
            if (status != ListStatus.archived)
              PopupMenuItem(value: 'archive', child: Text(l10n.archiveAction))
            else
              PopupMenuItem(
                  value: 'unarchive', child: Text(l10n.unarchiveAction)),
            PopupMenuItem(value: 'delete', child: Text(l10n.deleteButton)),
          ],
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
          final snapshot = await repository.deleteList(list.id);
          if (!context.mounted) return;
          messenger..clearSnackBars()..showSnackBar(
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
  });

  final ListRepository repository;
  final AppLocalizations l10n;
  final ShoppingList? existing;

  @override
  State<_ListEditorSheet> createState() => _ListEditorSheetState();
}

class _ListEditorSheetState extends State<_ListEditorSheet> {
  late final TextEditingController _title =
      TextEditingController(text: widget.existing?.title ?? '');
  late final TextEditingController _budget = TextEditingController();
  String? _budgetPrefilled;
  late String _currency = widget.existing?.currencyCode ?? AppDefaults.defaultCurrency();
  late final TextEditingController _note =
      TextEditingController(text: widget.existing?.note ?? '');
  String? _budgetError;
  String? _saveError;
  bool _saving = false;

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
          existing.budgetMinorUnits!, Currency.fromCode(existing.currencyCode), sep);
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
      final value = MoneyParser.parseDecimal(text,
          separators: MoneySeparators.forLocaleCode(localeCode),
          requirePositive: true);
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
      final generated =
          title.isEmpty ? widget.l10n.autoListTitle(_formatDate(now)) : null;
      createdId = await widget.repository.createList(
        title: title.isEmpty ? null : title,
        generatedTitle: generated,
        currencyCode: _currency,
        budgetMinorUnits: budgetMinor,
        note: _note.text.trim().isEmpty ? null : _note.text.trim(),
      );
    } else {
      final currencyChanged = existing.currencyCode != _currency;
      final hasAmounts = existing.budgetMinorUnits != null;
      if (currencyChanged && hasAmounts) {
        final reset = await _askCurrencyChange();
        if (reset == null) return; // kullanıcı vazgeçti
        await widget.repository.changeCurrency(existing.id, _currency,
            resetAmounts: reset);
      } else if (currencyChanged) {
        await widget.repository.changeCurrency(existing.id, _currency,
            resetAmounts: false);
      }
      await widget.repository.updateTitle(
          existing.id, title.isEmpty ? null : title);
      if (budgetMinor != existing.budgetMinorUnits) {
        await widget.repository.updateBudget(existing.id, budgetMinor);
      }
      await widget.repository.updateNote(
          existing.id, _note.text.trim().isEmpty ? null : _note.text.trim());
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
      child: SingleChildScrollView(child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            key: const Key('list_title_field'),
            controller: _title,
            decoration: InputDecoration(labelText: l10n.listTitleHint),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            isExpanded: true,
            key: const Key('list_currency_field'),
            initialValue: _currency,
            decoration: InputDecoration(labelText: l10n.currencyLabel),
            items: Currency.all
                .map((c) => DropdownMenuItem(value: c.code, child: Text(c.code)))
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
          const SizedBox(height: 16),
          FilledButton(
            key: const Key('list_save_button'),
            onPressed: _saving ? null : () async {
              setState(() { _budgetError = null; _saveError = null; _saving = true; });
              try {
                await _save();
              } on _BudgetFormatException {
                if (mounted) setState(() => _budgetError = l10n.invalidAmountError);
              } catch (_) {
                if (mounted) setState(() => _saveError = l10n.saveFailed);
              } finally {
                if (mounted) setState(() => _saving = false);
              }
            },
            child: Text(l10n.saveButton),
          ),
          if (_saveError != null) Text(_saveError!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          TextButton(key: const Key('list_cancel_button'),
            onPressed: _saving ? null : () => Navigator.of(context).pop(),
            child: Text(l10n.cancelButton)),
        ],
      )),
    );
  }
}

class _BudgetFormatException implements Exception {
  const _BudgetFormatException();
}
