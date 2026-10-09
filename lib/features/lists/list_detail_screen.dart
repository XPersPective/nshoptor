import '../../core/money/format_locale.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/money_format.dart';
import '../../core/theme/semantic_colors.dart';
import '../../core/money/money.dart';
import '../../core/quantity/unit_display.dart';
import '../../data/db/app_database.dart';
import '../lists/item_form_sheet.dart';
import '../lists/list_repository.dart';
import '../lists/list_status.dart';
import '../lists/lists_screen.dart';
import '../lists/starter_categories.dart';
import '../shopping_mode/item_price_cell.dart';
import '../shopping_mode/item_status.dart';
import '../ads/ad_gate.dart';
import '../shopping_mode/shopping_mode_screen.dart';
import '../shopping_mode/shopping_repository.dart';
import '../shopping_mode/summary/summary_screen.dart';
import '../shopping_mode/summary/result_repository.dart';
import '../history/price_history/price_history_sheet.dart';
import '../receipts/ocr_text_source.dart';
import '../receipts/parser/receipt_parser.dart';
import '../receipts/review/receipt_review_controller.dart';
import '../receipts/review/receipt_review_screen.dart';
import '../receipts/shelf_label/mlkit_text_source.dart';
import '../receipts/shelf_label/shelf_price_flow.dart';
import '../voice_input/stt_speech_service.dart';
import '../voice_input/voice_input_service.dart';
import '../voice_input/voice_preview_sheet.dart';
import '../voice_input/list_draft_sheet.dart';
import '../../app/app_defaults.dart';
import '../../core/money/decimal_fixed.dart';
import 'item_repository.dart';
import '../ai/ai_client.dart';
import '../voice_input/parser/parsed_item_candidate.dart';
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
    this.onVoicePressed,
    this.onShelfPricePressed,
  });

  final AppDatabase db;
  final ListRepository listRepository;
  final int listId;

  /// Test enjeksiyonu; verilmezse platform servisi (speech_to_text).
  final SpeechService? speechService;

  /// Test enjeksiyonu; verilmezse ML Kit (cihazda, model indirmesiz).
  final OcrTextSource? ocrSource;

  /// Test enjeksiyonu; verilmezse kamera. İptalde null.
  final Future<String?> Function()? pickImage;

  /// Test enjeksiyonu; verilmezse flutter_local_notifications adaptörü.
  final ReminderScheduler? reminderScheduler;
  final Future<ParsedItemCandidate?> Function(BuildContext)? onVoicePressed;
  final Future<String?> Function(BuildContext)? onShelfPricePressed;

  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  late final ShoppingRepository _shoppingRepo = ShoppingRepository(widget.db);
  late Future<ShoppingList> _listFuture;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    AdGate.shoppingModeActive = true;
    _listFuture = widget.listRepository.getById(widget.listId);
  }

  @override
  void dispose() {
    AdGate.shoppingModeActive = false;
    super.dispose();
  }

  void _refresh() {
    setState(() {
      _listFuture = widget.listRepository.getById(widget.listId);
    });
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
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.reminderCancelled)));
      return;
    }
    final scheduler =
        widget.reminderScheduler ?? LocalNotificationsScheduler();
    final granted = await scheduler.ensurePermission();
    if (!granted) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.reminderPermissionDenied)));
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
    final local = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    // "Şimdi" seçilirse geçmiş zamana planlamayız: 30 sn sonrasına düşer
    // (OS'un geçmiş tetikleme davranışı cihaza göre değişken).
    final fireAt = local.isAfter(now)
        ? local
        : now.add(const Duration(seconds: 30));
    await repo.setReminder(
      listId: widget.listId,
      title: l10n.reminderTitle,
      body: l10n.reminderBody(
          list.title ?? list.generatedTitle ?? l10n.listsTitle),
      atUtc: fireAt.toUtc(),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.reminderScheduled)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.listsTitle), actions: [
        PopupMenuButton<String>(key: const Key('detail_more_menu'), tooltip: l10n.detailsSection,
          onSelected: (action) async {
            if (action == 'compare') {
              await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) =>
                CompareScreen(repository: ResultRepository(widget.db), listId: widget.listId)));
            } else if (action == 'reminder') {
              await _toggleReminder(context);
            } else if (action == 'unplanned') {
              final list = await _shoppingRepo.getList(widget.listId);
              if (!context.mounted) return;
              await showModalBottomSheet<void>(context: context, isScrollControlled: true,
                builder: (_) => PurchaseEntrySheet(repository: _shoppingRepo, list: list,
                  item: null, onShelfPricePressed: _shelfPrice));
            }
          },
          itemBuilder: (_) => [
            PopupMenuItem(value: 'compare', child: Text(l10n.compareAction)),
            PopupMenuItem(key: const Key('detail_set_reminder'), value: 'reminder', child: Text(l10n.setReminderAction)),
            PopupMenuItem(key: const Key('add_unplanned_button'), value: 'unplanned', child: Text(l10n.unplannedAddButton)),
          ]),
      ]),
      body: FutureBuilder<ShoppingList>(future: _listFuture, builder: (context, listSnap) {
        final list = listSnap.data;
        if (list == null) return const Center(child: CircularProgressIndicator());
        return StreamBuilder<List<PlannedItem>>(stream: _shoppingRepo.watchItems(widget.listId),
          builder: (context, itemSnap) => StreamBuilder<List<PurchaseEntry>>(
            stream: _shoppingRepo.watchEntries(widget.listId), builder: (context, entrySnap) {
              final items = itemSnap.data ?? const <PlannedItem>[];
              final entries = entrySnap.data ?? const <PurchaseEntry>[];
              final active = list.status != 'completed' && list.status != 'archived';
              return Column(children: [
                Expanded(child: ListView(padding: const EdgeInsets.symmetric(horizontal: 12), children: [
                Card(margin: const EdgeInsets.all(12), child: Padding(padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(list.title ?? list.generatedTitle ?? l10n.listsTitle, style: Theme.of(context).textTheme.titleLarge),
                    Chip(label: Text(statusLabel(l10n, ListStatus.fromDb(list.status)))),
                    _TotalsRow(items: items, entries: entries, currencyCode: list.currencyCode),
                  ]))),
                  if (items.isEmpty && entries.isEmpty) Padding(padding: const EdgeInsets.all(16),
                    child: Column(children: [Text(l10n.itemsEmptyTitle), Text(l10n.itemsEmptyBody),
                      OutlinedButton.icon(key: const Key('detail_voice_add_button'),
                        onPressed: () => _openItemFormWithVoice(context), icon: const Icon(Icons.mic_none),
                        label: Text(l10n.voiceAddItemAction))])),
                  for (final item in items) Card(key: Key('detail_item_${item.id}'),
                    child: Padding(padding: const EdgeInsets.all(12), child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Checkbox(key: Key('detail_check_${item.id}'), value: ItemStatus.fromDb(item.status).isInCart,
                            semanticLabel: item.name,
                            onChanged: _busy ? null : (checked) => _changeItem(item, entries, checked: checked!)),
                          Expanded(child: InkWell(onTap: _busy ? null : () => _enterActual(context, list, item, entries),
                            onLongPress: () => _openPriceHistory(context, item),
                            child: Padding(padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(item.name, style: Theme.of(context).textTheme.titleMedium)))),
                          PopupMenuButton<String>(key: Key('detail_item_menu_${item.id}'), tooltip: l10n.detailsSection,
                            onSelected: (action) {
                              if (action == 'edit') { _openItemForm(context, existing: item, entries: entries); }
                              else if (action == 'delete') { _changeItem(item, entries, remove: true); }
                              else if (action == 'history') { _openPriceHistory(context, item); }
                              else { _changeItem(item, entries, status: ItemStatus.fromDb(action)); }
                            }, itemBuilder: (_) => [
                              PopupMenuItem(value: 'edit', child: Text(l10n.editAction)),
                              PopupMenuItem(value: 'delete', child: Text(l10n.deleteButton)),
                              PopupMenuItem(value: 'history', child: Text(l10n.priceHistoryTitle)),
                              PopupMenuItem(value: 'notFound', child: Text(l10n.statusNotFound)),
                              PopupMenuItem(value: 'gaveUp', child: Text(l10n.statusGaveUp)),
                            ]),
                        ]),
                        Text('${item.plannedQuantity} ${unitDisplayNameFromDb(item.plannedUnitCode, l10n)}'),
                        if (!ItemStatus.fromDb(item.status).isInCart && item.status != 'pending')
                          Text(item.status == 'notFound' ? l10n.statusNotFound : l10n.statusGaveUp),
                        ItemPriceCell(prices: ItemPrices.of(item, entries), currencyCode: list.currencyCode,
                          onEnter: _busy ? null : () => _enterActual(context, list, item, entries),
                          onScan: _busy ? null : () => _enterActual(context, list, item, entries, scan: true)),
                      ]))),
                  for (final e in entries.where((e) => e.plannedItemId == null)) Card(child: Padding(
                    padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(e.name), Text('${e.actualQuantity} ${unitDisplayNameFromDb(e.actualUnitCode, l10n)}'),
                      Text('${l10n.compareUnplanned} · ${formatMoney(Money.fromMinorUnits(e.actualLineTotalMinorUnits,
                        Currency.fromCode(list.currencyCode)), locale: formatLocaleCode(context))}'),
                    ]))),
                ])),
                SafeArea(top: false, child: Padding(padding: const EdgeInsets.all(12),
                  child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Wrap(alignment: WrapAlignment.spaceEvenly, children: [
                      IconButton.filled(key: const Key('detail_add_item_button'), tooltip: l10n.addItemTooltip,
                        style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
                        onPressed: _busy ? null : () => _openItemForm(context), icon: const Icon(Icons.add)),
                      IconButton(key: const Key('detail_quick_list'), tooltip: l10n.quickListAction,
                        onPressed: _busy ? null : () => _openQuickList(context), icon: const Icon(Icons.mic_none)),
                      IconButton(key: const Key('detail_scan_receipt'), tooltip: l10n.scanReceiptAction,
                        onPressed: _busy ? null : () => _scanReceipt(context), icon: const Icon(Icons.receipt_long)),
                    ]),
                    if (active) FilledButton.icon(key: const Key('detail_finish_button'),
                      onPressed: _busy ? null : () => _finishAndShowResult(context),
                      icon: const Icon(Icons.check), label: Text(l10n.finishAndSeeResult, textAlign: TextAlign.center)),
                  ]))),
              ]);
            }));
      }),
    );
  }

  Future<void> _changeItem(PlannedItem item, List<PurchaseEntry> entries,
      {bool checked = false, bool remove = false, ItemStatus? status}) async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context);
    if (remove || !checked && entries.any((e) => e.plannedItemId == item.id)) {
      final confirmed = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
        title: Text(item.name), content: Text(remove ? l10n.deleteItemConfirm : l10n.clearPurchaseConfirm),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancelButton)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(remove ? l10n.deleteButton : l10n.saveButton))]));
      if (confirmed != true || !mounted) return;
    }
    setState(() => _busy = true);
    try {
      if (remove) { await ItemRepository(widget.db).removeItem(item.id); }
      else { await _shoppingRepo.setItemStatus(item.id, status ?? (checked ? ItemStatus.inCart : ItemStatus.pending)); }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
          SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true));
      }
    } finally { if (mounted) { setState(() => _busy = false); } }
  }

  /// Gerçek fiyatı satırdan gir (PB-062): elle ya da kamerayla; kayıt anında
  /// satırda tahmini → gerçek ve fark görünür.
  Future<void> _enterActual(BuildContext context, ShoppingList list, PlannedItem item,
      List<PurchaseEntry> entries, {bool scan = false}) async {
    String? price;
    if (scan) {
      price = await _shelfPrice(context);
      if (price == null || !context.mounted) return;
    }
    await _openItemForm(context, existing: item, entries: entries,
      initialActualPrice: price, focusActual: true);
  }

  Future<void> _openItemForm(BuildContext context,
      {ParsedItemCandidate? prefill, PlannedItem? existing,
       List<PurchaseEntry> entries = const [], String? initialActualPrice, bool focusActual = false}) async {
    await StarterCategories().seedIfEmpty(widget.db);
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ItemFormSheet(
        db: widget.db,
        starterCategories: StarterCategories(),
        listId: widget.listId,
        existing: existing, entries: existing == null ? const [] : entries.where((e) => e.plannedItemId == existing.id).toList(),
        initialActualPrice: initialActualPrice, focusActual: focusActual,
        initialName: prefill?.name,
        initialQuantity: prefill?.quantity?.toDbString(),
        initialUnitCode: prefill?.unitCode,
        initialUnitPrice: prefill?.unitPrice?.toDbString(),
        onVoicePressed: _voiceCandidate,
        onShelfPricePressed: _shelfPrice,
      ),
    );
    _refresh();
  }

  /// Cümleden/sesten çok ürün (PB-050): önizlemede seçilenler eklenir.
  Future<void> _openQuickList(BuildContext context) async {
    final picked = await showModalBottomSheet<List<ParsedItemCandidate>>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ListDraftSheet(
        speechService: widget.speechService ?? SttSpeechService(),
      ),
    );
    if (picked == null || picked.isEmpty) return;
    final repo = ItemRepository(widget.db);
    for (final c in picked) {
      await repo.addItem(
        listId: widget.listId,
        name: c.name,
        quantity: c.quantity ?? DecimalFixed.fromInt(1),
        unitCode: (c.unitCode ?? AppDefaults.defaultUnit()).dbCode,
        priceIsUnitPrice: c.isUnitPrice ?? false,
        price: c.unitPrice,
      );
    }
    _refresh();
  }

  /// Boş durumun "Sesle ekle" kısayolu (PB-039): doğrulama önizlemesi →
  /// doldurulmuş ürün formu (C-003: onaysız kayıt yok).
  Future<void> _openItemFormWithVoice(BuildContext context) async {
    final candidate = await _voiceCandidate(context);
    if (candidate == null || !context.mounted) return;
    await _openItemForm(context, prefill: candidate);
  }

  Future<String?> _pickImage() async {
    if (widget.pickImage != null) return widget.pickImage!();
    return (await ImagePicker().pickImage(source: ImageSource.camera))?.path;
  }

  /// Görseli okur; ML Kit kaynağı yalnız bu çağrı boyunca açık kalır.
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

  Future<ParsedItemCandidate?> _voiceCandidate(BuildContext context) =>
      widget.onVoicePressed?.call(context) ?? showModalBottomSheet<ParsedItemCandidate>(
        context: context,
        isScrollControlled: true,
        builder: (_) => VoicePreviewSheet(
          service: widget.speechService ?? SttSpeechService(),
        ),
      );

  Future<String?> _shelfPrice(BuildContext context) async {
    if (widget.onShelfPricePressed != null) return widget.onShelfPricePressed!(context);
    final list = await widget.listRepository.getById(widget.listId);
    if (!context.mounted) return null;
    return readShelfPrice(
      context,
      currencyCode: list.currencyCode,
      pickImage: widget.pickImage,
      ocrSource: widget.ocrSource,
    );
  }

  /// Fiş: tara → ayrıştır → inceleme; onaya dek DB yazımı yok (spec §6.9).
  Future<void> _scanReceipt(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final list = await widget.listRepository.getById(widget.listId);
    final scan = await _scan();
    if (scan == null || !context.mounted) return;
    if (scan.lines.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.ocrNoText)));
      return;
    }
    final parsed = ReceiptParser(currency: list.currencyCode).parse(scan);
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ReceiptReviewScreen(
          controller: ReceiptReviewController(
            db: widget.db,
            listId: widget.listId,
            parseResult: parsed,
            ai: AiService.client,
            localeCode: Localizations.localeOf(context).languageCode,
          ),
          currency: list.currencyCode,
          plannedItems: (widget.db.select(
            widget.db.plannedItems,
          )..where((t) => t.listId.equals(widget.listId))).get(),
        ),
      ),
    );
    _refresh();
  }

  Future<void> _openPriceHistory(BuildContext context, PlannedItem item) async {
    final productId =
        item.productId ??
        (await (widget.db.select(widget.db.productMemory)
                  ..where((t) => t.normalizedName.equals(item.normalizedName)))
                .getSingleOrNull())
            ?.id;
    if (!context.mounted) return;
    if (productId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).noObservations)),
      );
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PriceHistoryScreen(
          db: widget.db,
          productId: productId,
          productName: item.name,
        ),
      ),
    );
  }

  /// Alışverişi tamamlar ve sonuç ekranını açar (spec §6.11).
  Future<void> _finishAndShowResult(BuildContext context) async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context);
    final result = await ResultRepository(widget.db).compute(widget.listId);
    if (!context.mounted) return;
    if (result.rows.any((r) => r.notTaken || !r.actualKnown)) {
      final confirmed = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
        content: Text(l10n.completionWarning), actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancelButton)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.finishAndSeeResult))]));
      if (confirmed != true || !context.mounted) return;
    }
    setState(() => _busy = true);
    try {
      await widget.db.transaction(() async {
        await _shoppingRepo.startShopping(widget.listId);
        await widget.listRepository.changeStatus(widget.listId, ListStatus.completed);
      });
      if (!context.mounted) return;
      await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SummaryScreen(
          repository: ResultRepository(widget.db),
          listId: widget.listId,
        ),
      ),
    );
      if (mounted) _refresh();
    } catch (_) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.saveFailed), showCloseIcon: true));
    } finally { if (mounted) { setState(() => _busy = false); } }
  }
}


/// Başlık kartında hep görünen toplamlar: tahmini, gerçek ve fark (PB-062).
class _TotalsRow extends StatelessWidget {
  const _TotalsRow({required this.items, required this.entries, required this.currencyCode});

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
        final sum = mine.fold<int>(0, (a, e) => a + e.actualLineTotalMinorUnits);
        actual += sum;
        // Fark yalnız elma-elma: tahmini girilmemiş ürün farkı şişirmez.
        if (item.plannedLineTotalMinorUnits != null && ItemPrices.of(item, entries).hasActual) {
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
    final muted = theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    final stacked = MediaQuery.textScalerOf(context).scale(14) > 18;
    Widget cell(String label, String value, {Color? color, Key? key}) {
      final content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(label, style: muted), Text(value, key: key,
          style: theme.textTheme.titleMedium?.copyWith(color: color))]);
      return stacked ? Padding(padding: const EdgeInsets.only(bottom: 8), child: content) : Expanded(child: content);
    }

    final delta = comparedCount == 0 || diff == 0
        ? null
        : SemanticDelta.resolve(
            direction: diff > 0 ? SpendingDirection.overPlan : SpendingDirection.underPlan,
            brightness: theme.brightness,
          );
    final known = entries.any((e) => e.grossTotalMinorUnits != null || e.actualLineTotalMinorUnits != 0 || e.source == 'receiptOcr');
    final unknown = items.any((i) => ItemStatus.fromDb(i.status).isInCart && !ItemPrices.of(i, entries).hasActual);
    final cells = [
        cell(l10n.compareEstimated, items.every((i) => i.plannedLineTotalMinorUnits == null) ? '—' : money(planned), key: const Key('total_planned')),
        cell(l10n.compareActual, known ? '${money(actual)}${unknown ? ' + —' : ''}' : '—', key: const Key('total_actual')),
        cell(l10n.compareDiff, delta == null ? (comparedCount == 0 ? '—' : '0') : '${diff > 0 ? '+' : '−'}${money(diff.abs())}',
          color: delta?.color, key: const Key('total_diff')),
    ];
    return stacked ? Column(key: const Key('detail_totals'), crossAxisAlignment: CrossAxisAlignment.start, children: cells) :
      Row(key: const Key('detail_totals'), children: cells);

  }
}
