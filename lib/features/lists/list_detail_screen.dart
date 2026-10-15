import '../../core/money/format_locale.dart';

import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/app_defaults.dart';
import '../../app/navigation.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/money/money_format.dart';
import '../../core/theme/semantic_colors.dart';
import '../../core/money/money.dart';
import '../../core/quantity/unit_display.dart';
import '../../data/db/app_database.dart';
import '../lists/item_form_sheet.dart';
import '../lists/list_repository.dart';
import '../lists/list_status.dart';
import '../lists/starter_categories.dart';
import '../shopping_mode/item_price_cell.dart';
import '../shopping_mode/item_status.dart';
import '../ads/ad_gate.dart';
import '../shopping_mode/shopping_mode_screen.dart';
import '../shopping_mode/shopping_repository.dart';
import '../shopping_mode/summary/result_repository.dart';
import '../shopping_mode/summary/summary_screen.dart';
import '../shopping_mode/summary/pdf_report.dart';
import '../history/price_history/price_history_sheet.dart';
import '../receipts/ocr_text_source.dart';
import '../receipts/parser/receipt_parser.dart';
import '../receipts/review/receipt_review_controller.dart';
import '../receipts/review/receipt_review_screen.dart';
import '../receipts/shelf_label/mlkit_text_source.dart';
import '../receipts/shelf_label/shelf_price_flow.dart';
import '../receipts/shelf_label/price_candidates.dart';
import '../voice_input/stt_speech_service.dart';
import '../voice_input/voice_input_service.dart';
import '../voice_input/list_draft_sheet.dart';
import '../voice_input/ai_list_parser.dart';
import 'item_repository.dart';
import '../voice_input/parser/parsed_item_candidate.dart';
import '../ai/ai_client.dart';
import 'reminders/local_notifications_scheduler.dart';
import 'reminders/reminder_scheduler.dart';
import 'reminders/reminders_repository.dart';

/// Liste detayı (spec §9 "Planlama liste detayı"): ürünler, ürün ekleme,
/// alışverişi başlat/bitir ve sonuç.
class ListDetailScreen extends StatefulWidget {
  const ListDetailScreen({
    super.key,
    required this.db,
    required this.listRepository,
    required this.listId,
    this.speechService,
    this.ocrSource,
    this.pickImage,
    this.reminderScheduler,
    this.onShelfPricePressed,
  });

  final AppDatabase db;
  final ListRepository listRepository;
  final int listId;

  /// Test enjeksiyonu; verilmezse Android cihaz içi platform servisi.
  final SpeechService? speechService;

  /// Test enjeksiyonu; verilmezse ML Kit (cihazda, model indirmesiz).
  final OcrTextSource? ocrSource;

  /// Test enjeksiyonu; verilmezse kamera. İptalde null.
  final Future<String?> Function()? pickImage;

  /// Test enjeksiyonu; verilmezse flutter_local_notifications adaptörü.
  final ReminderScheduler? reminderScheduler;
  final Future<String?> Function(BuildContext)? onShelfPricePressed;

  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen>
    with RouteAware, WidgetsBindingObserver {
  static _ListDetailScreenState? _visibleList;
  static Future<void>? _lockUpdates;
  static bool? _appliedAwake;
  static int _openLists = 0;
  ModalRoute<dynamic>? _route;
  bool _resumed = true;
  bool _keepAwake = false;
  bool _awake = false;
  bool _lockBusy = false;
  late final ShoppingRepository _shoppingRepo = ShoppingRepository(widget.db);
  late Future<ShoppingList> _listFuture;
  bool _busy = false;
  bool _editable = false;

  @override
  void initState() {
    super.initState();
    AdGate.shoppingModeActive = ++_openLists > 0;
    _keepAwake = AppDefaults.keepScreenAwake();
    _resumed =
        WidgetsBinding.instance.lifecycleState == null ||
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
    WidgetsBinding.instance.addObserver(this);
    _listFuture = _loadList();
  }

  @override
  void dispose() {
    AdGate.shoppingModeActive = --_openLists > 0;
    WidgetsBinding.instance.removeObserver(this);
    appRouteObserver.unsubscribe(this);
    if (identical(_visibleList, this)) _visibleList = null;
    _syncLock();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != _route) {
      appRouteObserver.unsubscribe(this);
      _route = route;
      if (route != null) appRouteObserver.subscribe(this, route);
    }
  }

  void _visible(bool visible) {
    if (visible) {
      _visibleList = this;
      _keepAwake = AppDefaults.keepScreenAwake();
    } else if (identical(_visibleList, this)) {
      _visibleList = null;
    }
    _syncLock();
  }

  @override
  void didPush() => _visible(true);
  @override
  void didPopNext() => _visible(true);
  @override
  void didPushNext() => _visible(false);
  @override
  void didPop() => _visible(false);
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _resumed = state == AppLifecycleState.resumed;
    _syncLock();
  }

  // Native operations are global; serialize across nested list routes and use the latest owner.
  Future<void> _syncLock() {
    final update = (_lockUpdates ?? Future<void>.value()).then((_) async {
      final owner = _visibleList;
      final want = owner != null && owner._resumed && owner._keepAwake;
      try {
        if (_appliedAwake != want) {
          await WakelockPlus.toggle(enable: want);
          _appliedAwake = want;
        }
        if (owner != null && owner.mounted && identical(owner, _visibleList)) {
          owner.setState(() => owner._awake = want);
        }
      } catch (_) {
        if (owner != null && owner.mounted && identical(owner, _visibleList)) {
          owner.setState(() => owner._awake = _appliedAwake ?? false);
          if (want || _appliedAwake == true) {
            ScaffoldMessenger.of(owner.context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(owner.context).keepAwakeFailed,
                  ),
                  showCloseIcon: true,
                  duration: const Duration(days: 1),
                ),
              );
          }
        }
      }
    });
    _lockUpdates = update;
    return update.whenComplete(() {
      if (identical(_lockUpdates, update)) _lockUpdates = null;
    });
  }

  Future<void> _toggleAwake() async {
    if (_lockBusy) return;
    final desired = !_awake;
    setState(() {
      _lockBusy = true;
      _keepAwake = desired;
    });
    try {
      await _syncLock();
      if (mounted && _awake == desired) AppDefaults.setKeepScreenAwake(desired);
    } finally {
      if (mounted) setState(() => _lockBusy = false);
    }
  }

  void _refresh() {
    if (!mounted) return;
    setState(() {
      _listFuture = _loadList();
    });
  }

  Future<ShoppingList> _loadList() async {
    final list = await widget.listRepository.getById(widget.listId);
    if (mounted) {
      setState(
        () =>
            _editable = list.status != 'completed' && list.status != 'archived',
      );
    }
    return list;
  }

  Future<void> _finishAndShowResult() async {
    if (_busy || !_editable) return;
    setState(() => _busy = true);
    final l10n = AppLocalizations.of(context);
    try {
      final repository = ResultRepository(widget.db);
      final result = await repository.compute(widget.listId);
      if (!mounted) return;
      if (result.rows.any((row) => row.notTaken || !row.actualKnown)) {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Text(l10n.completionWarning),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.cancelButton),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n.finishAndSeeResult),
              ),
            ],
          ),
        );
        if (confirmed != true || !mounted) return;
      }
      await widget.db.transaction(() async {
        await _shoppingRepo.startShopping(widget.listId);
        await widget.listRepository.changeStatus(
          widget.listId,
          ListStatus.completed,
        );
      });
      if (!mounted) return;
      _refresh();
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              SummaryScreen(repository: repository, listId: widget.listId),
        ),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  RemindersRepository _remindersRepo() => RemindersRepository(
    widget.db,
    widget.reminderScheduler ?? LocalNotificationsScheduler(),
  );

  /// Aktif hatırlatma varsa kaldırır, yoksa tarih+saat seçtirip kurar.
  /// İzin yalnızca bu akışta istenir (spec §6.13).
  Future<void> _toggleReminder(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final repo = _remindersRepo();
    final active = await repo.activeForList(widget.listId);
    if (active != null) {
      await repo.cancelReminder(active.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text(l10n.reminderCancelled), showCloseIcon: true),
        );
      return;
    }
    final scheduler = widget.reminderScheduler ?? LocalNotificationsScheduler();
    final granted = await scheduler.ensurePermission();
    if (!granted) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(l10n.reminderPermissionDenied),
            showCloseIcon: true,
            duration: const Duration(days: 1),
          ),
        );
      return;
    }
    final list = await _listFuture;
    if (!context.mounted) return;
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      helpText: l10n.reminderPickDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      initialDate: now,
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      helpText: l10n.reminderPickTime,
      initialTime: TimeOfDay.now(),
    );
    if (time == null || !context.mounted) return;
    final local = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    // "Şimdi" seçilirse geçmiş zamana planlamayız: 30 sn sonrasına düşer
    // (OS'un geçmiş tetikleme davranışı cihaza göre değişken).
    final fireAt = local.isAfter(now)
        ? local
        : now.add(const Duration(seconds: 30));
    await repo.setReminder(
      listId: widget.listId,
      title: l10n.reminderTitle,
      body: l10n.reminderBody(
        list.title ?? list.generatedTitle ?? l10n.listsTitle,
      ),
      atUtc: fireAt.toUtc(),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(l10n.reminderScheduled), showCloseIcon: true),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<ShoppingList>(
          future: _listFuture,
          builder: (context, snapshot) => Text(
            snapshot.data?.title ??
                snapshot.data?.generatedTitle ??
                l10n.listsTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          IconButton.filledTonal(
            key: const Key('list_keep_awake'),
            tooltip: l10n.keepAwakeLabel,
            isSelected: _awake,
            icon: const Icon(Icons.screen_lock_portrait_outlined),
            selectedIcon: const Icon(Icons.screen_lock_portrait),
            onPressed: _lockBusy ? null : _toggleAwake,
          ),
          PopupMenuButton<String>(
            key: const Key('detail_more_menu'),
            tooltip: l10n.detailsSection,
            onSelected: (action) async {
              if (action == 'pdf') {
                if (_busy) return;
                setState(() => _busy = true);
                await showPdfReport(context, widget.db, widget.listId);
                if (mounted) setState(() => _busy = false);
              } else if (action == 'compare') {
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => CompareScreen(
                      repository: ResultRepository(widget.db),
                      listId: widget.listId,
                    ),
                  ),
                );
              } else if (action == 'reminder') {
                await _toggleReminder(context);
              } else if (action == 'unplanned') {
                final list = await _shoppingRepo.getList(widget.listId);
                if (!context.mounted) return;
                await showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => PurchaseEntrySheet(
                    repository: _shoppingRepo,
                    list: list,
                    item: null,
                    onShelfPricePressed: _shelfPrice,
                  ),
                );
              } else if (action == 'receipt') {
                await _scanReceipt(context);
              } else if (action == 'archive') {
                await widget.listRepository.changeStatus(
                  widget.listId,
                  ListStatus.archived,
                );
                if (context.mounted) Navigator.of(context).maybePop();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'compare', child: Text(l10n.compareAction)),
              PopupMenuItem(
                key: const Key('detail_report_pdf'),
                value: 'pdf',
                child: Text(l10n.reportPdfAction),
              ),
              PopupMenuItem(
                key: const Key('detail_set_reminder'),
                value: 'reminder',
                child: Text(l10n.setReminderAction),
              ),
              if (_editable)
                PopupMenuItem(
                  key: const Key('add_unplanned_button'),
                  value: 'unplanned',
                  child: Text(l10n.unplannedAddButton),
                ),
              if (_editable)
                PopupMenuItem(
                  key: const Key('detail_scan_receipt'),
                  value: 'receipt',
                  child: Text(l10n.scanReceiptAction),
                ),
              PopupMenuItem(value: 'archive', child: Text(l10n.archiveAction)),
            ],
          ),
        ],
      ),
      body: FutureBuilder<ShoppingList>(
        future: _listFuture,
        builder: (context, listSnap) {
          if (listSnap.hasError) {
            return Center(
              child: TextButton(
                onPressed: _refresh,
                child: Text(l10n.saveFailed),
              ),
            );
          }
          final list = listSnap.data;
          if (list == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return StreamBuilder<List<PlannedItem>>(
            stream: _shoppingRepo.watchItems(widget.listId),
            builder: (context, itemSnap) => StreamBuilder<List<PurchaseEntry>>(
              stream: _shoppingRepo.watchEntries(widget.listId),
              builder: (context, entrySnap) {
                final items = itemSnap.data ?? const <PlannedItem>[];
                final entries = entrySnap.data ?? const <PurchaseEntry>[];
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        children: [
                          Card(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _TotalsRow(
                                    items: items,
                                    entries: entries,
                                    currencyCode: list.currencyCode,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (items.isEmpty && entries.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(l10n.itemsEmptyTitle),
                                  Text(l10n.itemsEmptyBody),
                                ],
                              ),
                            ),
                          if (items.isNotEmpty)
                            ReorderableListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              buildDefaultDragHandles: false,
                              itemCount: items.length,
                              onReorderItem: (oldIndex, newIndex) =>
                                  _reorderItems(items, oldIndex, newIndex),
                              itemBuilder: (context, index) => _buildItemCard(
                                context,
                                items[index],
                                entries,
                                list,
                                index,
                              ),
                            ),
                          for (final e in entries.where(
                            (e) => e.plannedItemId == null,
                          ))
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e.name),
                                    Text(
                                      '${e.actualQuantity} ${unitDisplayNameFromDb(e.actualUnitCode, l10n)}',
                                    ),
                                    Text(
                                      '${l10n.compareUnplanned} · ${formatMoney(Money.fromMinorUnits(e.actualLineTotalMinorUnits, Currency.fromCode(list.currencyCode)), locale: formatLocaleCode(context))}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (_editable &&
                              (items.isNotEmpty || entries.isNotEmpty))
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: OutlinedButton.icon(
                                key: const Key('detail_finish_button'),
                                onPressed: _busy ? null : _finishAndShowResult,
                                icon: const Icon(Icons.check),
                                label: Text(
                                  l10n.finishAndSeeResult,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (_editable)
                      SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                // Tap = one item in the full form; mic = many
                                // items spoken at once (draft with approval).
                                child: TextField(
                                  key: const Key('detail_quick_entry'),
                                  readOnly: true,
                                  enabled: !_busy,
                                  onTap: () => _openItemForm(context),
                                  decoration: InputDecoration(
                                    hintText: l10n.itemFormTitle,
                                    prefixIcon: const Icon(Icons.add),
                                    suffixIcon: IconButton(
                                      key: const Key('detail_quick_list'),
                                      tooltip: l10n.voiceStartListening,
                                      onPressed: _busy
                                          ? null
                                          : () => _openQuickList(
                                              context,
                                              autoListen: true,
                                            ),
                                      icon: const Icon(Icons.mic_none),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemCard(
    BuildContext context,
    PlannedItem item,
    List<PurchaseEntry> entries,
    ShoppingList list,
    int index,
  ) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    final card = Dismissible(
      key: ValueKey('detail_item_${item.id}'),
      direction: _editable
          ? DismissDirection.horizontal
          : DismissDirection.none,
      background: Container(
        color: colors.errorContainer,
        alignment: AlignmentDirectional.centerStart,
        padding: const EdgeInsetsDirectional.only(start: 24),
        child: Icon(Icons.delete_outline, color: colors.onErrorContainer),
      ),
      secondaryBackground: Container(
        color: colors.errorContainer,
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsetsDirectional.only(end: 24),
        child: Icon(Icons.delete_outline, color: colors.onErrorContainer),
      ),
      confirmDismiss: (_) => _deleteItem(item),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _busy || !_editable
              ? null
              : () => _openItemForm(context, existing: item, entries: entries),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      key: Key('detail_check_${item.id}'),
                      value: ItemStatus.fromDb(item.status).isInCart,
                      semanticLabel: item.name,
                      onChanged: _busy || !_editable
                          ? null
                          : (checked) =>
                                _changeItem(item, entries, checked: checked!),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.plannedQuantity} ${unitDisplayNameFromDb(item.plannedUnitCode, l10n)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            ItemPriceCell(
                              prices: ItemPrices.of(item, entries),
                              currencyCode: list.currencyCode,
                            ),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      key: Key('detail_item_menu_${item.id}'),
                      tooltip: l10n.detailsSection,
                      onSelected: (action) {
                        if (action == 'delete') {
                          _changeItem(item, entries, remove: true);
                        } else {
                          _openPriceHistory(context, item, list);
                        }
                      },
                      itemBuilder: (_) => [
                        if (_editable)
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(l10n.deleteButton),
                          ),
                        PopupMenuItem(
                          value: 'history',
                          child: Text(l10n.priceHistoryTitle),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return KeyedSubtree(
      key: ValueKey('detail_reorder_${item.id}'),
      child: _editable
          ? ReorderableDelayedDragStartListener(index: index, child: card)
          : card,
    );
  }

  Future<bool> _deleteItem(PlannedItem item) async {
    if (_busy) return false;
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final snapshot = await ItemRepository(widget.db).deleteItem(item.id);
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(l10n.listDeleted),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: l10n.undoButton,
                onPressed: () => ItemRepository(widget.db).undoDelete(snapshot),
              ),
            ),
          );
      }
      return true;
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true),
          );
      }
      return false;
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _reorderItems(
    List<PlannedItem> items,
    int oldIndex,
    int newIndex,
  ) async {
    final ordered = [...items];
    final moved = ordered.removeAt(oldIndex);
    ordered.insert(newIndex, moved);
    try {
      await ItemRepository(widget.db)
          .reorderItems(widget.listId, ordered.map((item) => item.id).toList());
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).saveFailed),
              showCloseIcon: true,
            ),
          );
      }
    }
  }

  Future<void> _changeItem(
    PlannedItem item,
    List<PurchaseEntry> entries, {
    bool checked = false,
    bool remove = false,
    ItemStatus? status,
  }) async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context);
    if (remove || !checked && entries.any((e) => e.plannedItemId == item.id)) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(item.name),
          content: Text(
            remove ? l10n.deleteItemConfirm : l10n.clearPurchaseConfirm,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.cancelButton),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(remove ? l10n.deleteButton : l10n.saveButton),
            ),
          ],
        ),
      );
      if (confirmed != true || !mounted) return;
    }
    setState(() => _busy = true);
    try {
      if (remove) {
        await ItemRepository(widget.db).removeItem(item.id);
      } else {
        await _shoppingRepo.setItemStatus(
          item.id,
          status ?? (checked ? ItemStatus.inCart : ItemStatus.pending),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(l10n.saveFailed),
              showCloseIcon: true,
              duration: const Duration(days: 1),
            ),
          );
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _openItemForm(
    BuildContext context, {
    ParsedItemCandidate? prefill,
    PlannedItem? existing,
    List<PurchaseEntry> entries = const [],
    String? initialActualPrice,
    PriceCandidate? initialActualCandidate,
    bool focusActual = false,
  }) async {
    await StarterCategories().seedIfEmpty(widget.db);
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ItemFormSheet(
        db: widget.db,
        starterCategories: StarterCategories(),
        listId: widget.listId,
        existing: existing,
        entries: existing == null
            ? const []
            : entries.where((e) => e.plannedItemId == existing.id).toList(),
        initialActualPrice: initialActualPrice,
        initialActualCandidate: initialActualCandidate,
        focusActual: focusActual,
        initialCandidate: prefill,
        initialName: prefill?.name,
        initialQuantity: prefill?.quantity?.toDbString(),
        initialUnitCode: prefill?.unitCode,
        initialUnitPrice: prefill?.unitPrice?.toDbString(),
        // Voice belongs to the fixed bottom quick-entry control. Keeping a
        // second mic in the edit sheet reintroduces the duplicate-session bug.
        onShelfCandidatePressed: _shelfCandidate,
      ),
    );
    _refresh();
  }

  /// Cümleden/sesten çok ürün (PB-050): önizlemede seçilenler eklenir.
  Future<void> _openQuickList(
    BuildContext context, {
    String? initialText,
    bool autoListen = false,
  }) async {
    final picked = await showModalBottomSheet<ListDraft>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ListDraftSheet(
        speechService: widget.speechService ?? SttSpeechService(),
        initialText: initialText,
        autoListen: autoListen,
        allowTitle: false,
        onApprove: (draft) =>
            ItemRepository(widget.db).addCandidates(widget.listId, draft.items),
      ),
    );
    if (picked == null || !mounted) return;
    _refresh();
  }

  Future<String?> _pickImage() async {
    if (widget.pickImage != null) return widget.pickImage!();
    return (await ImagePicker().pickImage(source: ImageSource.camera))?.path;
  }

  Future<OcrScanResult?> _scan() async {
    final path = await _pickImage();
    if (path == null) return null;
    if (widget.ocrSource != null) return widget.ocrSource!.scan(path);
    final source = MlKitTextSource();
    try {
      return await source.scan(path);
    } finally {
      source.dispose();
    }
  }

  Future<void> _scanReceipt(BuildContext context) async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final list = await widget.listRepository.getById(widget.listId);
      final scan = await _scan();
      if (scan == null || !context.mounted) return;
      final parsed = ReceiptParser(currency: list.currencyCode).parse(scan);
      if (parsed.lines.isEmpty) return;
      final controller = ReceiptReviewController(
        db: widget.db,
        listId: widget.listId,
        parseResult: parsed,
        ai: AiService.client,
        localeCode: Localizations.localeOf(context).languageCode,
      );
      try {
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ReceiptReviewScreen(
              controller: controller,
              currency: list.currencyCode,
              plannedItems: ItemRepository(widget.db).getItems(widget.listId),
            ),
          ),
        );
      } finally {
        controller.dispose();
      }
      if (mounted) _refresh();
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(content: Text(l10n.ocrNoText), showCloseIcon: true),
          );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<String?> _shelfPrice(BuildContext context) async =>
      (await _shelfCandidate(context))?.value.toDbString();

  Future<PriceCandidate?> _shelfCandidate(BuildContext context) async {
    final list = await widget.listRepository.getById(widget.listId);
    if (!context.mounted) return null;
    if (widget.onShelfPricePressed != null) {
      final text = await widget.onShelfPricePressed!(context);
      final value = text == null ? null : DecimalFixed.tryParse(text);
      return value == null
          ? null
          : PriceCandidate(
              value: value,
              currencyCode: list.currencyCode,
              sourceLine: '',
              confidence: 'manual',
              isUnitPrice: true,
            );
    }
    return readShelfCandidate(
      context,
      currencyCode: list.currencyCode,
      pickImage: widget.pickImage,
      ocrSource: widget.ocrSource,
    );
  }

  Future<void> _openPriceHistory(
    BuildContext context,
    PlannedItem item,
    ShoppingList list,
  ) async {
    final productId =
        item.productId ??
        (await (widget.db.select(widget.db.productMemory)
                  ..where((t) => t.normalizedName.equals(item.normalizedName)))
                .getSingleOrNull())
            ?.id;
    if (!context.mounted) return;
    if (productId == null) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).noObservations),
            showCloseIcon: true,
          ),
        );
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PriceHistoryScreen(
          db: widget.db,
          productId: productId,
          productName: item.name,
          currencyCode: list.currencyCode,
          unitCode: item.plannedUnitCode,
        ),
      ),
    );
  }
}

/// Başlık kartında hep görünen toplamlar: tahmini, gerçek ve fark (PB-062).
class _TotalsRow extends StatelessWidget {
  const _TotalsRow({
    required this.items,
    required this.entries,
    required this.currencyCode,
  });

  final List<PlannedItem> items;
  final List<PurchaseEntry> entries;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currency = Currency.fromCode(currencyCode);
    final locale = formatLocaleCode(context);
    String money(int minor) =>
        formatMoney(Money.fromMinorUnits(minor, currency), locale: locale);
    var planned = 0;
    var comparedPlanned = 0; // tahmini de olan ve gerçeği girilen ürünler
    var comparedActual = 0;
    var actual = 0;
    var comparedCount = 0;
    for (final item in items) {
      final line = item.plannedLineTotalMinorUnits ?? 0;
      planned += line;
      final mine = entries.where((e) => e.plannedItemId == item.id);
      if (mine.isNotEmpty) {
        final sum = mine.fold<int>(
          0,
          (a, e) => a + e.actualLineTotalMinorUnits,
        );
        actual += sum;
        // Fark yalnız elma-elma: tahmini girilmemiş ürün farkı şişirmez.
        if (item.plannedLineTotalMinorUnits != null &&
            ItemPrices.of(item, entries).hasActual) {
          comparedCount++;
          comparedPlanned += line;
          comparedActual += sum;
        }
      }
    }
    // Plansız alımlar da gerçek toplama girer.
    for (final e in entries.where((e) => e.plannedItemId == null)) {
      actual += e.actualLineTotalMinorUnits;
    }
    final diff = comparedActual - comparedPlanned;
    final muted = theme.textTheme.labelSmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    final stacked = MediaQuery.textScalerOf(context).scale(14) > 18;
    Widget cell(String label, String value, {Color? color, Key? key}) {
      final content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: muted),
          Text(
            value,
            key: key,
            style: theme.textTheme.titleMedium?.copyWith(color: color),
          ),
        ],
      );
      return stacked
          ? Padding(padding: const EdgeInsets.only(bottom: 8), child: content)
          : Expanded(child: content);
    }

    final delta = comparedCount == 0 || diff == 0
        ? null
        : SemanticDelta.resolve(
            direction: diff > 0
                ? SpendingDirection.overPlan
                : SpendingDirection.underPlan,
            brightness: theme.brightness,
          );
    final known = entries.any(
      (e) =>
          e.grossTotalMinorUnits != null ||
          e.actualLineTotalMinorUnits != 0 ||
          e.source == 'receiptOcr',
    );
    final unknown = items.any(
      (i) =>
          ItemStatus.fromDb(i.status).isInCart &&
          !ItemPrices.of(i, entries).hasActual,
    );
    final cells = [
      cell(
        l10n.compareEstimated,
        items.every((i) => i.plannedLineTotalMinorUnits == null)
            ? '—'
            : money(planned),
        key: const Key('total_planned'),
      ),
      cell(
        l10n.compareActual,
        known ? '${money(actual)}${unknown ? ' + —' : ''}' : '—',
        key: const Key('total_actual'),
      ),
      cell(
        l10n.compareDiff,
        delta == null
            ? (comparedCount == 0 ? '—' : '0')
            : '${diff > 0 ? '+' : '−'}${money(diff.abs())}',
        color: delta?.color,
        key: const Key('total_diff'),
      ),
    ];
    return stacked
        ? Column(
            key: const Key('detail_totals'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cells,
          )
        : Row(key: const Key('detail_totals'), children: cells);
  }
}
