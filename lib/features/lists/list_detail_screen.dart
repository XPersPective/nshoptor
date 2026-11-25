import 'dart:async';

import '../../core/money/format_locale.dart';
import '../../core/money/money_parser.dart';

import 'package:flutter/material.dart';

import '../engagement/review_moments.dart';

import 'package:wakelock_plus/wakelock_plus.dart';

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
import '../history/reports/report_document.dart';
import '../history/reports/report_export_service.dart';
import '../history/reports/report_repository.dart';
import '../history/reports/report_share_menu.dart';
import '../../core/text/store_name.dart';

import 'package:napp_ads/napp_ads.dart';

import '../history/insights/budget_alerts.dart';
import '../history/insights/budget_check.dart';
import '../history/price_history/price_history_sheet.dart';
import '../onboarding/coach_tour.dart';
import '../onboarding/first_run_guide.dart';
import '../receipts/ocr_text_source.dart';
import '../receipts/receipt_capture_flow.dart';
import '../receipts/receipt_image_store.dart';
import '../receipts/receipt_repository.dart';
import '../receipts/shelf_label/shelf_price_flow.dart';
import '../receipts/shelf_label/price_candidates.dart';
import '../voice_input/stt_speech_service.dart';
import '../voice_input/voice_input_service.dart';
import '../voice_input/list_draft_sheet.dart';
import '../voice_input/ai_list_parser.dart';
import 'item_repository.dart';
import 'item_list_view.dart';
import 'taxonomy/item_sort.dart';
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
    this.receiptImageStore,
    this.reminderScheduler,
    this.onShelfPricePressed,
    this.bannerController,
    this.reportExportService,
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
  final ReceiptImageStore? receiptImageStore;

  /// Test enjeksiyonu; verilmezse flutter_local_notifications adaptörü.
  final ReminderScheduler? reminderScheduler;
  final Future<String?> Function(BuildContext)? onShelfPricePressed;
  final BannerAdController? bannerController;

  /// Test enjeksiyonu; verilmezse sistem paylaşım/yazdırma servisi.
  final ReportExportService? reportExportService;

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
  late final ReceiptRepository _receiptRepo = ReceiptRepository(
    widget.db,
    images: widget.receiptImageStore,
  );
  late final Stream<List<ListReceipt>> _receipts = _receiptRepo.watchForList(
    widget.listId,
  );
  late Future<ShoppingList> _listFuture;
  bool _busy = false;
  bool _reminderBusy = false;
  bool _itemFormOpen = false;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  ItemSortMode _sortMode = ItemSortMode.custom;
  bool _sortBusy = false;
  bool _editable = false;
  ListStatus? _status;
  BudgetStatus? _budgetStatus;
  final _contentShown = Completer<void>();

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
    if (AppDefaults.detailTourPending()) unawaited(_continueTour());
  }

  /// PB-201: the lists tour continues here once, after the list is shown.
  Future<void> _continueTour() async {
    try {
      await _listFuture;
    } catch (_) {
      return;
    }
    // Items decide which controls (Items row, sort) are on screen.
    await _contentShown.future;
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted || ModalRoute.of(context)?.isCurrent == false) return;
    await runDetailTour(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
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
      if (mounted && _awake == desired) {
        AppDefaults.setKeepScreenAwake(desired);
        // The icon alone is ambiguous: say what was switched.
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(
                desired
                    ? AppLocalizations.of(context).keepAwakeOn
                    : AppLocalizations.of(context).keepAwakeOff,
              ),
            ),
          );
      }
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
    final sortMode = await ItemSortPreferences(widget.db).read(widget.listId);
    final budget = await evaluateBudgetStatus(widget.db, listId: widget.listId);
    if (mounted) {
      setState(() {
        _sortMode = sortMode;
        _status = ListStatus.fromDb(list.status);
        _editable = list.status != 'completed' && list.status != 'archived';
        _budgetStatus = budget;
      });
      _alertBudget(budget);
    }
    return list;
  }

  /// 80% / 100% weekly and monthly budget notifications (F33).
  void _alertBudget(BudgetStatus status) {
    unawaited(
      BudgetAlerts.check(
        status,
        AppLocalizations.of(context),
        locale: formatLocaleCode(context),
        reference: DateTime.now(),
        listId: widget.listId,
      ),
    );
  }

  Future<void> _checkBudgetAndWarn() async {
    final status = await evaluateBudgetStatus(widget.db, listId: widget.listId);
    if (!mounted) return;
    setState(() => _budgetStatus = status);
    _alertBudget(status);
    if (!status.anyOver) return;
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(status.currencyCode);
    final locale = formatLocaleCode(context);
    String money(int minor) =>
        formatMoney(Money.fromMinorUnits(minor, currency), locale: locale);
    final parts = <String>[
      if (status.listOver)
        '${l10n.budgetLabel}: ${l10n.monthlyLimitOver(money(status.listOverMinor))}',
      if (status.weekOver)
        '${l10n.spanWeek}: ${l10n.monthlyLimitOver(money(status.weekOverMinor))}',
      if (status.monthOver)
        '${l10n.monthlyLimitTitle}: ${l10n.monthlyLimitOver(money(status.monthOverMinor))}',
    ];
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          key: const Key('budget_over_snackbar'),
          content: Text(parts.join(' · ')),
          showCloseIcon: true,
        ),
      );
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
      // Natural stop: shopping is over and the result was seen.
      final reviewAttempted =
          await ReviewMoments.instance?.afterShopping() ?? false;
      if (!reviewAttempted) await AdGate.maybeShowInterstitial();
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

  /// Aktif hatırlatma varsa kaldırır, yoksa tarih+saat seçtirip kurar.
  /// İzin yalnızca bu akışta istenir (spec §6.13).
  Future<void> _toggleReminder(BuildContext context) async {
    if (_reminderBusy) return;
    _reminderBusy = true;
    final l10n = AppLocalizations.of(context);
    final scheduler = widget.reminderScheduler ?? LocalNotificationsScheduler();
    final repo = RemindersRepository(widget.db, scheduler);
    try {
      final active = await repo.activeForList(widget.listId);
      if (active != null) {
        await repo.cancelReminder(active.id);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(l10n.reminderCancelled),
              showCloseIcon: true,
            ),
          );
        return;
      }
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
      final schedulingNow = DateTime.now();
      final fireAt = local.isAfter(schedulingNow)
          ? local
          : schedulingNow.add(const Duration(seconds: 30));
      final scheduled = await repo.setReminder(
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
          SnackBar(
            content: Text(
              scheduled
                  ? l10n.reminderScheduled
                  : l10n.reminderPermissionDenied,
            ),
            showCloseIcon: true,
          ),
        );
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true),
          );
      }
    } finally {
      _reminderBusy = false;
    }
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
            tooltip: _awake ? l10n.keepAwakeOn : l10n.keepAwakeOff,
            isSelected: _awake,
            icon: const Icon(Icons.light_mode_outlined),
            selectedIcon: const Icon(Icons.light_mode),
            onPressed: _lockBusy ? null : _toggleAwake,
          ),
          PopupMenuButton<String>(
            key: const Key('detail_more_menu'),
            tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
            onSelected: (action) async {
              if (action == 'share') {
                if (_busy) return;
                await _shareReport(context);
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
                await _checkBudgetAndWarn();
              } else if (action == 'receipt') {
                await _scanReceipt(context);
              } else if (action == 'help') {
                await runDetailTour(context);
              } else if (action == 'archive') {
                await widget.listRepository.changeStatus(
                  widget.listId,
                  ListStatus.archived,
                );
                if (context.mounted) Navigator.of(context).maybePop();
              } else if (action == 'continue') {
                if (_busy || _status != ListStatus.completed) return;
                setState(() => _busy = true);
                try {
                  await widget.listRepository.changeStatus(
                    widget.listId,
                    ListStatus.shopping,
                  );
                  _refresh();
                } catch (_) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.saveFailed),
                        showCloseIcon: true,
                      ),
                    );
                  }
                } finally {
                  if (mounted) setState(() => _busy = false);
                }
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'compare', child: Text(l10n.compareAction)),
              PopupMenuItem(
                key: const Key('detail_report_share'),
                value: 'share',
                child: Text(l10n.reportShareAction),
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
              if (_status == ListStatus.completed)
                PopupMenuItem(
                  key: const Key('detail_continue_shopping'),
                  value: 'continue',
                  child: Text(l10n.continueShoppingLabel),
                ),
              PopupMenuItem(value: 'archive', child: Text(l10n.archiveAction)),
              PopupMenuItem(
                key: const Key('detail_how_to_use'),
                value: 'help',
                child: Text(l10n.howToUseLabel),
              ),
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
                if (itemSnap.hasData &&
                    entrySnap.hasData &&
                    !_contentShown.isCompleted) {
                  _contentShown.complete();
                }
                final locale = Localizations.localeOf(context).languageCode;
                final searching = _searchQuery.trim().isNotEmpty;
                final orderedItems = sortedItemsForView(
                  items,
                  entries,
                  mode: _sortMode,
                  localeCode: locale,
                );
                final reorderable =
                    canReorderItemView(_sortMode, _searchQuery) && !_sortBusy;
                final visibleItems = orderedItems
                    .where(
                      (item) =>
                          matchesItemSearch(item.name, _searchQuery, locale),
                    )
                    .toList();
                final unplanned = entries
                    .where(
                      (entry) =>
                          entry.plannedItemId == null &&
                          matchesItemSearch(entry.name, _searchQuery, locale),
                    )
                    .toList();
                final alphabeticalRows = _sortMode == ItemSortMode.alphabetical
                    ? alphabeticalItemRows(items, entries, localeCode: locale)
                          .where(
                            (row) => matchesItemSearch(
                              row.name,
                              _searchQuery,
                              locale,
                            ),
                          )
                          .toList()
                    : const <ItemViewRow>[];
                final material = MaterialLocalizations.of(context);
                final pendingCount = visibleItems
                    .where((item) => !isItemPurchased(item.id, entries))
                    .length;
                final bannerSlot = widget.bannerController == null
                    ? null
                    : selectListBannerSlot(
                        pendingCount: pendingCount,
                        totalCount: visibleItems.length + unplanned.length,
                        seed: widget.listId,
                      );
                final headingStyle = Theme.of(context).textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600);
                final hasProducts = items.isNotEmpty || entries.isNotEmpty;
                // F25: "Products" heading row; the sort control sits at the
                // row end (start in RTL through Row directionality).
                final productsHeader = Row(
                  key: const Key('detail_products_header'),
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 4),
                        child: Semantics(
                          header: true,
                          child: Text(
                            l10n.groupsSection,
                            key: const Key('detail_products_heading'),
                            style: headingStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: PopupMenuButton<ItemSortMode>(
                        key: const Key('detail_item_sort'),
                        tooltip: l10n.listSortLabel,
                        initialValue: _sortMode,
                        enabled: !_busy && !_sortBusy,
                        onSelected: _changeSort,
                        itemBuilder: (_) => [
                          CheckedPopupMenuItem(
                            value: ItemSortMode.custom,
                            checked: _sortMode == ItemSortMode.custom,
                            child: Text(l10n.listSortManual),
                          ),
                          CheckedPopupMenuItem(
                            value: ItemSortMode.alphabetical,
                            checked: _sortMode == ItemSortMode.alphabetical,
                            child: Text(l10n.listSortAz),
                          ),
                        ],
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 48),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.sort),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    _sortMode == ItemSortMode.custom
                                        ? l10n.listSortManual
                                        : l10n.listSortAz,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
                // F25/F27: compact search lives with the product list and
                // filters whichever sort order is active.
                final searchField = Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: TextField(
                    key: const Key('detail_item_search'),
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) => setState(() => _searchQuery = value),
                    onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: material.searchFieldLabel,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isEmpty
                          ? null
                          : IconButton(
                              key: const Key('detail_search_clear'),
                              constraints: const BoxConstraints(
                                minWidth: 48,
                                minHeight: 48,
                              ),
                              tooltip: material.clearButtonTooltip,
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            ),
                    ),
                  ),
                );
                return Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<List<ListReceipt>>(
                        stream: _receipts,
                        builder: (context, receiptSnap) {
                          final receipts =
                              receiptSnap.data ?? const <ListReceipt>[];
                          final printedAt = receipts
                              .map((r) => r.printedAt)
                              .whereType<DateTime>()
                              .firstOrNull;
                          return ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            children: [
                              TourAnchor(
                                id: TourTargets.detailTotals,
                                child: Card(
                                  margin: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 8,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Semantics(
                                          header: true,
                                          child: Text(
                                            l10n.compareTotal,
                                            key: const Key(
                                              'detail_totals_heading',
                                            ),
                                            style: headingStyle,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        _TotalsRow(
                                          items: items,
                                          entries: entries,
                                          currencyCode: list.currencyCode,
                                        ),
                                        _BudgetWarningRow(
                                          list: list,
                                          entries: entries,
                                          status: _budgetStatus,
                                        ),
                                        // F19: the printed receipt date/time.
                                        if (printedAt != null)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.event_outlined,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    l10n.receiptDateLabel(
                                                      _formatPrinted(
                                                        context,
                                                        printedAt,
                                                      ),
                                                    ),
                                                    key: const Key(
                                                      'detail_receipt_date',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (receipts.isNotEmpty)
                                _ReceiptsSection(
                                  receipts: receipts,
                                  fallbackCurrency: list.currencyCode,
                                  fallbackStore: list.title,
                                  onOpen: _busy || !_editable
                                      ? null
                                      : (receipt) => _scanReceipt(
                                          context,
                                          resumeDraftId: receipt.id,
                                        ),
                                  onDelete: _busy ? null : _deleteReceipt,
                                ),
                              if (hasProducts) ...[
                                TourAnchor(
                                  id: TourTargets.detailItems,
                                  child: productsHeader,
                                ),
                                searchField,
                              ],
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
                              if (searching &&
                                  visibleItems.isEmpty &&
                                  unplanned.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      const Icon(Icons.search_off),
                                      Text(
                                        '${l10n.statusNotFound}: $_searchQuery',
                                        textAlign: TextAlign.center,
                                      ),
                                      TextButton.icon(
                                        key: const Key('detail_search_reset'),
                                        onPressed: () {
                                          _searchController.clear();
                                          setState(() => _searchQuery = '');
                                          FocusScope.of(context).unfocus();
                                        },
                                        icon: const Icon(Icons.clear),
                                        label: Text(
                                          material.clearButtonTooltip,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (_sortMode == ItemSortMode.alphabetical) ...[
                                for (final (rowIndex, row)
                                    in alphabeticalRows.indexed)
                                  if (row.item != null)
                                    _buildItemCard(
                                      context,
                                      row.item!,
                                      entries,
                                      list,
                                      rowIndex,
                                      draggable: false,
                                      showBannerBelow: bannerSlot == rowIndex,
                                    )
                                  else
                                    _buildUnplannedCard(
                                      context,
                                      row.entry!,
                                      list,
                                    ),
                              ] else ...[
                                if (visibleItems.isNotEmpty)
                                  ReorderableListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    buildDefaultDragHandles: false,
                                    itemCount: visibleItems.length,
                                    onReorderItem: (oldIndex, newIndex) =>
                                        !reorderable
                                        ? null
                                        : _reorderItems(
                                            orderedItems,
                                            entries,
                                            oldIndex,
                                            newIndex,
                                          ),
                                    itemBuilder: (context, index) =>
                                        _buildItemCard(
                                          context,
                                          visibleItems[index],
                                          entries,
                                          list,
                                          index,
                                          draggable: reorderable,
                                          showBannerBelow: bannerSlot == index,
                                        ),
                                  ),
                                for (final entry in unplanned)
                                  _buildUnplannedCard(context, entry, list),
                              ],
                              if (_editable &&
                                  (items.isNotEmpty || entries.isNotEmpty))
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: OutlinedButton.icon(
                                    key: const Key('detail_finish_button'),
                                    onPressed: _busy
                                        ? null
                                        : _finishAndShowResult,
                                    icon: const Icon(Icons.check),
                                    label: Text(
                                      l10n.finishAndSeeResult,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    if (_editable)
                      SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TourAnchor(
                                id: TourTargets.detailAdd,
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
                                      tooltip: l10n.tipVoiceAdd,
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
                              const SizedBox(height: 8),
                              TourAnchor(
                                id: TourTargets.detailReceipt,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        key: const Key('detail_receipt_button'),
                                        onPressed: _busy
                                            ? null
                                            : () => _scanReceipt(context),
                                        icon: const Icon(
                                          Icons.receipt_long_outlined,
                                        ),
                                        label: Text(
                                          l10n.scanReceiptAction,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton.outlined(
                                      key: const Key('detail_receipt_help'),
                                      tooltip: l10n.howToUseLabel,
                                      onPressed: () => showScanHelpDialog(
                                        context,
                                        isReceipt: true,
                                      ),
                                      icon: const Icon(Icons.help_outline),
                                    ),
                                  ],
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

  Widget _buildUnplannedCard(
    BuildContext context,
    PurchaseEntry entry,
    ShoppingList list,
  ) {
    final l10n = AppLocalizations.of(context);
    final amount = formatMoney(
      Money.fromMinorUnits(
        entry.actualLineTotalMinorUnits,
        Currency.fromCode(list.currencyCode),
      ),
      locale: formatLocaleCode(context),
    );
    // A receipt discount is not a product: name it and show only its amount.
    if (entry.normalizedName == 'discount') {
      return Card(
        key: ValueKey('detail_unplanned_${entry.id}'),
        child: ListTile(
          leading: const Icon(Icons.local_offer_outlined),
          title: Text(l10n.receiptDiscountLine),
          trailing: Text(amount),
        ),
      );
    }
    return Card(
      key: ValueKey('detail_unplanned_${entry.id}'),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.name),
            Text(
              '${MoneySeparators.forLocaleCode(formatLocaleCode(context)).formatInput(entry.actualQuantity)} ${unitDisplayNameFromDb(entry.actualUnitCode, l10n)}',
            ),
            Text('${l10n.compareUnplanned} · $amount'),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(
    BuildContext context,
    PlannedItem item,
    List<PurchaseEntry> entries,
    ShoppingList list,
    int index, {
    bool draggable = true,
    bool showBannerBelow = false,
  }) {
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
              : () => _openItemForm(
                  context,
                  existing: item,
                  entries: entries,
                  focusActual: true,
                ),
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
                      value: isItemPurchased(item.id, entries),
                      shape: const CircleBorder(),
                      materialTapTargetSize: MaterialTapTargetSize.padded,
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
                              '${MoneySeparators.forLocaleCode(formatLocaleCode(context)).formatInput(item.plannedQuantity)} ${unitDisplayNameFromDb(item.plannedUnitCode, l10n)}',
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    final reorderableCard = _editable && draggable
        ? ReorderableDelayedDragStartListener(index: index, child: card)
        : card;
    return KeyedSubtree(
      key: ValueKey('detail_reorder_${item.id}'),
      child: showBannerBelow && widget.bannerController != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                reorderableCard,
                Padding(
                  key: const Key('list_sparse_banner'),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: BannerAdWidget(controller: widget.bannerController!),
                ),
              ],
            )
          : reorderableCard,
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

  Future<void> _changeSort(ItemSortMode mode) async {
    if (_busy || _sortBusy || mode == _sortMode) return;
    setState(() => _sortBusy = true);
    try {
      await ItemSortPreferences(widget.db).write(widget.listId, mode);
      if (mounted) setState(() => _sortMode = mode);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).saveFailed)),
        );
      }
    } finally {
      if (mounted) setState(() => _sortBusy = false);
    }
  }

  Future<void> _reorderItems(
    List<PlannedItem> items,
    List<PurchaseEntry> entries,
    int oldIndex,
    int newIndex,
  ) async {
    if (_busy ||
        _sortBusy ||
        !_editable ||
        !canReorderItemView(_sortMode, _searchQuery)) {
      return;
    }
    final ordered = reorderItemGroup(items, entries, oldIndex, newIndex);
    if (ordered == null) return;
    setState(() => _busy = true);
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
    } finally {
      if (mounted) setState(() => _busy = false);
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
    if (checked && !isItemPurchased(item.id, entries)) {
      await _openItemForm(
        context,
        existing: item,
        entries: entries,
        focusActual: true,
      );
      return;
    }
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
    if (_itemFormOpen) return;
    _itemFormOpen = true;
    try {
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
          onShelfCandidatePressed: _shelfCandidate,
          onPriceHistory: existing == null
              ? null
              : () async {
                  final list = await widget.listRepository.getById(
                    widget.listId,
                  );
                  if (context.mounted) {
                    await _openPriceHistory(context, existing, list);
                  }
                },
        ),
      );
      _refresh();
      await _checkBudgetAndWarn();
    } finally {
      _itemFormOpen = false;
    }
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

  Future<void> _shareReport(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    await shareReportFromMenu(
      context,
      service: widget.reportExportService ?? const ReportExportService(),
      onBusy: (busy) {
        if (mounted) setState(() => _busy = busy);
      },
      document: () async {
        final report = await ReportRepository(widget.db)
            .shopping(widget.listId);
        return ReportDocument(
          title:
              report.list.title ??
              report.list.generatedTitle ??
              l10n.listsTitle,
          currencyCode: report.list.currencyCode,
          shopping: [report],
        );
      },
    );
  }

  Future<void> _deleteReceipt(ListReceipt receipt) async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.receiptDeleteAction),
        content: Text(l10n.receiptDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelButton),
          ),
          FilledButton(
            key: const Key('receipt_delete_confirm'),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _busy = true);
    try {
      await _receiptRepo.delete(receipt.id);
      if (!mounted) return;
      _refresh();
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text(l10n.receiptDeleted), showCloseIcon: true),
        );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true),
          );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _scanReceipt(BuildContext context, {int? resumeDraftId}) async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final list = await widget.listRepository.getById(widget.listId);
      if (!context.mounted) return;
      await openReceiptCaptureFlow(
        context,
        db: widget.db,
        listId: widget.listId,
        currencyCode: list.currencyCode,
        pickImage: widget.pickImage,
        ocrSource: widget.ocrSource,
        imageStore: widget.receiptImageStore,
        ai: AiService.client,
        resumeDraftId: resumeDraftId,
      );
      if (mounted) {
        _refresh();
        await _checkBudgetAndWarn();
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true),
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
    final known = entries.any(hasMarketPrice);
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

class _BudgetWarningRow extends StatelessWidget {
  const _BudgetWarningRow({
    required this.list,
    required this.entries,
    required this.status,
  });

  final ShoppingList list;
  final List<PurchaseEntry> entries;
  final BudgetStatus? status;

  @override
  Widget build(BuildContext context) {
    final actualMinor = entries.fold<int>(
      0,
      (sum, entry) => sum + entry.actualLineTotalMinorUnits,
    );
    final listBudget = list.budgetMinorUnits;
    final listOverBy = listBudget != null && actualMinor > listBudget
        ? actualMinor - listBudget
        : 0;
    final weekOverBy = status != null && status!.weekOver
        ? status!.weekOverMinor
        : 0;
    final monthOverBy = status != null && status!.monthOver
        ? status!.monthOverMinor
        : 0;
    if (listOverBy <= 0 && weekOverBy <= 0 && monthOverBy <= 0) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(list.currencyCode);
    final locale = formatLocaleCode(context);
    String money(int minor) =>
        formatMoney(Money.fromMinorUnits(minor, currency), locale: locale);
    final messages = <String>[
      if (listOverBy > 0)
        '${l10n.budgetLabel}: ${l10n.monthlyLimitOver(money(listOverBy))}',
      if (weekOverBy > 0)
        '${l10n.spanWeek}: ${l10n.monthlyLimitOver(money(weekOverBy))}',
      if (monthOverBy > 0)
        '${l10n.monthlyLimitTitle}: ${l10n.monthlyLimitOver(money(monthOverBy))}',
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        messages.join(' · '),
        key: const Key('detail_budget_warning'),
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

String _formatPrinted(BuildContext context, DateTime at) {
  final material = MaterialLocalizations.of(context);
  final local = at.toLocal();
  final date = material.formatShortDate(local);
  if (local.hour == 0 && local.minute == 0) return date;
  final time = material.formatTimeOfDay(
    TimeOfDay.fromDateTime(local),
    alwaysUse24HourFormat:
        MediaQuery.maybeAlwaysUse24HourFormatOf(context) ?? false,
  );
  return '$date $time';
}

/// F13: every receipt of the list with its state; long lists stay short.
class _ReceiptsSection extends StatefulWidget {
  const _ReceiptsSection({
    required this.receipts,
    required this.fallbackCurrency,
    this.fallbackStore,
    required this.onOpen,
    required this.onDelete,
  });

  final List<ListReceipt> receipts;
  final String fallbackCurrency;

  /// The list's own name (a receipt's store) when the draft has none yet.
  final String? fallbackStore;
  final ValueChanged<ListReceipt>? onOpen;
  final ValueChanged<ListReceipt>? onDelete;

  static const collapsedCount = 3;

  @override
  State<_ReceiptsSection> createState() => _ReceiptsSectionState();
}

class _ReceiptsSectionState extends State<_ReceiptsSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final receipts = widget.receipts;
    final overflow = receipts.length > _ReceiptsSection.collapsedCount;
    final shown = _expanded || !overflow
        ? receipts
        : receipts.take(_ReceiptsSection.collapsedCount).toList();
    return Card(
      key: const Key('detail_receipts_section'),
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
              child: Semantics(
                header: true,
                child: Text(
                  '${l10n.listReceiptsSection} (${receipts.length})',
                  key: const Key('detail_receipts_heading'),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            for (final receipt in shown) _row(context, receipt),
            if (overflow)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  key: const Key('detail_receipts_toggle'),
                  style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
                  onPressed: () => setState(() => _expanded = !_expanded),
                  child: Text(
                    _expanded
                        ? l10n.listReceiptsShowLess
                        : l10n.listReceiptsShowAll(receipts.length),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, ListReceipt receipt) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final complete = SemanticDelta.palette(SpendingDirection.underPlan);
    final (icon, color, stateText) = switch (receipt.state) {
      ListReceiptState.complete => (
        Icons.check_circle_outline,
        dark ? complete.dark : complete.light,
        l10n.receiptStateComplete,
      ),
      ListReceiptState.readyToReview => (
        Icons.fact_check_outlined,
        theme.colorScheme.primary,
        l10n.receiptReadDoneBody,
      ),
      ListReceiptState.incomplete => (
        Icons.pending_outlined,
        dark ? const Color(0xFFFFB951) : const Color(0xFF8A5300),
        l10n.receiptStateIncomplete,
      ),
      ListReceiptState.failed => (
        Icons.error_outline,
        theme.colorScheme.error,
        l10n.receiptStateFailed,
      ),
    };
    final cleaned = receipt.store == null ? '' : cleanStoreName(receipt.store!);
    final fallback = widget.fallbackStore?.trim() ?? '';
    final store = cleaned.isNotEmpty
        ? cleaned
        : fallback.isNotEmpty
        ? fallback
        : l10n.receiptStoreUnknown;
    final total = receipt.totalMinor == null
        ? null
        : formatMoney(
            Money.fromMinorUnits(
              receipt.totalMinor!,
              Currency.fromCode(
                receipt.currencyCode ?? widget.fallbackCurrency,
              ),
            ),
            locale: formatLocaleCode(context),
          );
    final subtitle = [
      if (receipt.printedAt != null)
        _formatPrinted(context, receipt.printedAt!),
      stateText,
    ].join(' · ');
    final canOpen =
        (receipt.state == ListReceiptState.incomplete ||
            receipt.state == ListReceiptState.readyToReview) &&
        widget.onOpen != null;
    final delete = widget.onDelete;
    return ListTile(
      key: ValueKey('detail_receipt_${receipt.id}'),
      minTileHeight: 56,
      contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 4),
      leading: Icon(icon, color: color),
      title: Text(store, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, style: TextStyle(color: color)),
      onTap: canOpen ? () => widget.onOpen!(receipt) : null,
      onLongPress: delete == null ? null : () => delete(receipt),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (total != null)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.3,
              ),
              child: Text(
                total,
                key: ValueKey('detail_receipt_total_${receipt.id}'),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          PopupMenuButton<String>(
            key: ValueKey('detail_receipt_menu_${receipt.id}'),
            tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
            enabled: delete != null || canOpen,
            onSelected: (value) {
              if (value == 'delete') delete?.call(receipt);
              if (value == 'continue') widget.onOpen?.call(receipt);
            },
            itemBuilder: (_) => [
              if (canOpen)
                PopupMenuItem(
                  value: 'continue',
                  child: Text(l10n.receiptContinueAction),
                ),
              PopupMenuItem(
                key: ValueKey('detail_receipt_delete_${receipt.id}'),
                value: 'delete',
                enabled: delete != null,
                child: Text(l10n.receiptDeleteAction),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
