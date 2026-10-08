import '../../core/money/format_locale.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/money_format.dart';
import '../../core/money/money.dart';
import '../../core/quantity/unit_display.dart';
import '../../data/db/app_database.dart';
import '../lists/item_form_sheet.dart';
import '../lists/list_repository.dart';
import '../lists/list_status.dart';
import '../lists/lists_screen.dart';
import '../lists/starter_categories.dart';
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
import '../receipts/shelf_label/price_candidate_sheet.dart';
import '../receipts/shelf_label/price_candidates.dart';
import '../receipts/shelf_label/ai_label_reader.dart';
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

  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  late final ShoppingRepository _shoppingRepo = ShoppingRepository(widget.db);
  late Future<ShoppingList> _listFuture;

  @override
  void initState() {
    super.initState();
    _listFuture = widget.listRepository.getById(widget.listId);
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
      appBar: AppBar(
        title: Text(l10n.listsTitle),
        actions: [
          IconButton(
            key: const Key('detail_quick_list'),
            icon: const Icon(Icons.auto_awesome_outlined),
            tooltip: l10n.quickListAction,
            onPressed: () => _openQuickList(context),
          ),
          IconButton(
            key: const Key('detail_compare'),
            icon: const Icon(Icons.compare_arrows),
            tooltip: l10n.compareAction,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => CompareScreen(
                  repository: ResultRepository(widget.db),
                  listId: widget.listId,
                ),
              ),
            ),
          ),
          IconButton(
            key: const Key('detail_set_reminder'),
            icon: const Icon(Icons.alarm_add_outlined),
            tooltip: l10n.setReminderAction,
            onPressed: () => _toggleReminder(context),
          ),
          IconButton(
            key: const Key('detail_scan_receipt'),
            icon: const Icon(Icons.receipt_long),
            tooltip: l10n.scanReceiptAction,
            onPressed: () => _scanReceipt(context),
          ),
        ],
      ),
      body: FutureBuilder<ShoppingList>(
        future: _listFuture,
        builder: (context, snapshot) {
          final list = snapshot.data;
          if (list == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final currency = Currency.fromCode(list.currencyCode);
          return StreamBuilder<List<PlannedItem>>(
            stream: _shoppingRepo.watchItems(widget.listId),
            builder: (context, snapshot) {
              final items = snapshot.data ?? const <PlannedItem>[];
              final plannedMinor = items.fold<int>(
                0,
                (a, i) => a + (i.plannedLineTotalMinorUnits ?? 0),
              );
              return Column(
                children: [
                  // Tek satır özet (C-004): jargonsuz "Planlanan ₺X · n ürün".
                  Card(
                    margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list.title ??
                                      list.generatedTitle ??
                                      l10n.listsTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l10n.plannedTotalSummary(
                                    items.length,
                                    formatMoney(
                                      Money.fromMinorUnits(
                                        plannedMinor,
                                        currency,
                                      ),
                                      locale: formatLocaleCode(context),
                                    ),
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            label: Text(
                              statusLabel(
                                l10n,
                                ListStatus.tryFromDb(list.status) ??
                                    ListStatus.draft,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: items.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shopping_basket_outlined,
                                  size: 56,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  l10n.itemsEmptyTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l10n.itemsEmptyBody,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 12),
                                OutlinedButton.icon(
                                  key: const Key('detail_voice_add_button'),
                                  onPressed: () =>
                                      _openItemFormWithVoice(context),
                                  icon: const Icon(Icons.mic_none),
                                  label: Text(l10n.voiceAddItemAction),
                                ),
                                const SizedBox(height: 8),
                                TextButton.icon(
                                  key: const Key('detail_quick_list_empty'),
                                  onPressed: () => _openQuickList(context),
                                  icon: const Icon(Icons.auto_awesome_outlined),
                                  label: Text(l10n.quickListAction),
                                ),
                              ],
                            ),
                          )
                        : ListView(
                            children: [
                              for (final item in items)
                                ListTile(
                                  key: Key('detail_item_${item.id}'),
                                  title: Text(item.name),
                                  onTap: () =>
                                      _openPriceHistory(context, item),
                                  subtitle: Text(
                                    '${item.plannedQuantity} ${unitDisplayNameFromDb(item.plannedUnitCode, l10n)}',
                                  ),
                                  // Tahmini fiyat yoksa soluk tire: fiyat
                                  // girilmediği net görünür (C-004).
                                  trailing: item.plannedLineTotalMinorUnits ==
                                          null
                                      ? Text(
                                          '—',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        )
                                      : Text(
                                          formatMoney(
                                            Money.fromMinorUnits(
                                              item.plannedLineTotalMinorUnits!,
                                              currency,
                                            ),
                                            locale: Localizations.localeOf(
                                                  context,
                                                ).languageCode,
                                          ),
                                        ),
                                ),
                            ],
                          ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      // Dikey: uzun çevirilerde iki buton yan yana sığmaz (PB-061).
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FilledButton.icon(
                            key: const Key('detail_start_shopping'),
                            onPressed: list.status == 'shopping'
                                ? () => _openShopping(context)
                                : () => _startShopping(context),
                            icon: const Icon(Icons.shopping_cart),
                            label: Text(
                              list.status == 'shopping'
                                  ? l10n.continueShoppingLabel
                                  : l10n.startShoppingLabel,
                            ),
                          ),
                          if (list.status == 'shopping') ...[
                            const SizedBox(height: 8),
                            FilledButton.tonal(
                              key: const Key('detail_finish_button'),
                              onPressed: () => _finishAndShowResult(context),
                              child: Text(l10n.finishAndSeeResult, textAlign: TextAlign.center),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('detail_add_item_button'),
        heroTag: 'detailAddItem',
        tooltip: l10n.addItemTooltip,
        onPressed: () => _openItemForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _startShopping(BuildContext context) async {
    await _shoppingRepo.startShopping(widget.listId);
    _refresh();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ShoppingModeScreen(
          repository: ShoppingRepository(widget.db),
          listId: widget.listId,
          onVoicePressed: _voiceCandidate,
        ),
      ),
    );
    _refresh();
  }

  Future<void> _openShopping(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ShoppingModeScreen(
          repository: ShoppingRepository(widget.db),
          listId: widget.listId,
          onVoicePressed: _voiceCandidate,
        ),
      ),
    );
    _refresh();
  }

  Future<void> _openItemForm(BuildContext context,
      {ParsedItemCandidate? prefill}) async {
    await StarterCategories().seedIfEmpty(widget.db);
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ItemFormSheet(
        db: widget.db,
        starterCategories: StarterCategories(),
        listId: widget.listId,
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
      showModalBottomSheet<ParsedItemCandidate>(
        context: context,
        isScrollControlled: true,
        builder: (_) => VoicePreviewSheet(
          service: widget.speechService ?? SttSpeechService(),
        ),
      );

  Future<String?> _shelfPrice(BuildContext context) async {
    final list = await widget.listRepository.getById(widget.listId);
    final scan = await _scan();
    if (scan == null || !context.mounted) return null;
    final local = ShelfPriceExtractor(defaultCurrency: list.currencyCode)
        .extract(scan.lines);
    final client = AiService.client;
    final lang = Localizations.localeOf(context).languageCode;
    final ocrText = scan.lines.map((l) => l.text).join(String.fromCharCode(10));
    final fromAi = client == null
        ? const <PriceCandidate>[]
        : await AiLabelReader(client, localeCode: lang)
            .read(ocrText, currencyCode: list.currencyCode);
    if (!context.mounted) return null;
    final candidates = [
      ...fromAi,
      ...local.where((c) => !fromAi.any((a) => a.value == c.value)),
    ];
    final picked = await showPriceCandidateSheet(context, candidates);
    return picked?.value.toDbString();
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
    await widget.listRepository.changeStatus(
      widget.listId,
      ListStatus.completed,
    );
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SummaryScreen(
          repository: ResultRepository(widget.db),
          listId: widget.listId,
        ),
      ),
    );
    _refresh();
  }
}
