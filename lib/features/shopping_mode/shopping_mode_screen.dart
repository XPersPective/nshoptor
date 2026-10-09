import '../../core/money/format_locale.dart';
import 'package:flutter/material.dart';

import '../ads/ad_gate.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/money/money_format.dart';
import '../../core/money/money.dart';
import '../../core/money/money_parser.dart';
import '../../core/quantity/unit_code.dart';
import '../../data/db/app_database.dart';
import '../receipts/shelf_label/shelf_price_flow.dart';
import '../voice_input/parser/parsed_item_candidate.dart';
import 'item_price_cell.dart';
import 'item_status.dart';
import 'shopping_repository.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Alışveriş modu ekranı (spec §6.5-6.6): üst özet şeridi + filtre
/// çipleri + ürün satırları. Tek elle kullanım için büyük dokunma
/// hedefleri; her ürün dokunuşunda gerçek fiyat girişi açılır.
class ShoppingModeScreen extends StatefulWidget {
  const ShoppingModeScreen({
    super.key,
    required this.repository,
    required this.listId,
    this.onVoicePressed,
    this.onShelfPricePressed,
  });

  final ShoppingRepository repository;
  final int listId;

  /// Sesle plansız ürün ekleme (PB-039): doğrulama önizlemesi → doldurulmuş
  /// hızlı giriş. Verilmezse mikrofon düğmesi görünmez.
  final Future<ParsedItemCandidate?> Function(BuildContext context)?
      onVoicePressed;

  /// Satırdaki kamera düğmesi: raf etiketinden fiyat (PB-062). Verilmezse gerçek
  /// kamera + ML Kit akışı kullanılır.
  final Future<String?> Function(BuildContext context)? onShelfPricePressed;

  @override
  State<ShoppingModeScreen> createState() => _ShoppingModeScreenState();
}

class _ShoppingModeScreenState extends State<ShoppingModeScreen> {
  CartFilter _filter = CartFilter.all;
  ShoppingList? _list;
  bool _keepAwake = false;

  @override
  void initState() {
    AdGate.shoppingModeActive = true;
    super.initState();
    widget.repository.getList(widget.listId).then((list) {
      if (mounted) setState(() => _list = list);
    });
  }

  @override
  void dispose() {
    AdGate.shoppingModeActive = false;
    // Ekrandan çıkınca normal ekran zamanlayıcısına dön.
    WakelockPlus.disable();
    super.dispose();
  }

  Future<void> _toggleKeepAwake() async {
    final next = !_keepAwake;
    setState(() => _keepAwake = next);
    if (next) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.shoppingTitle),
        actions: [
          if (widget.onVoicePressed != null)
            IconButton(
              key: const Key('shopping_voice_button'),
              tooltip: l10n.voiceStartListening,
              onPressed: () => _openVoiceEntry(context),
              icon: const Icon(Icons.mic_none),
            ),
          IconButton(
            key: const Key('keep_awake_toggle'),
            tooltip: l10n.keepScreenAwake,
            onPressed: _toggleKeepAwake,
            icon: Icon(
              _keepAwake ? Icons.lightbulb : Icons.lightbulb_outline,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<CartSummary>(
            stream: widget.repository.watchSummary(widget.listId),
            builder: (context, snapshot) {
              final summary = snapshot.data;
              if (summary == null || _list == null) {
                return const SizedBox(height: 96);
              }
              return _SummaryStrip(summary: summary, currencyCode: _list!.currencyCode);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final f in CartFilter.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        label: Text(_filterLabel(l10n, f)),
                        selected: _filter == f,
                        onSelected: (_) => setState(() => _filter = f),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<PlannedItem>>(
              stream: widget.repository.watchItems(widget.listId),
              builder: (context, snapshot) {
                final items = (snapshot.data ?? const <PlannedItem>[])
                    .where(_matchesFilter)
                    .toList();
                if (items.isEmpty) {
                  return const SizedBox.shrink();
                }
                return StreamBuilder<List<PurchaseEntry>>(
                  stream: widget.repository.watchEntries(widget.listId),
                  builder: (context, entriesSnap) {
                    final entries = entriesSnap.data ?? const <PurchaseEntry>[];
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) => _ItemTile(
                        repository: widget.repository,
                        item: items[index],
                        entries: entries,
                        currencyCode: _list?.currencyCode ?? 'TRY',
                        onShelfPricePressed: widget.onShelfPricePressed ?? _defaultShelfPrice,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: OutlinedButton.icon(
              key: const Key('add_unplanned_button'),
              onPressed: _list == null ? null : () => _openUnplannedSheet(context, _list!),
              icon: const Icon(Icons.add_shopping_cart),
              label: Text(l10n.unplannedAddButton),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _defaultShelfPrice(BuildContext context) => readShelfPrice(
        context,
        currencyCode: _list?.currencyCode ?? 'TRY',
      );

  bool _matchesFilter(PlannedItem item) {
    final status = ItemStatus.tryFromDb(item.status) ?? ItemStatus.pending;
    switch (_filter) {
      case CartFilter.all:
        return true;
      case CartFilter.toBuy:
        return !status.isClosed;
      case CartFilter.inCart:
        return status.isInCart;
      case CartFilter.notFound:
        return status == ItemStatus.notFound || status == ItemStatus.gaveUp;
      case CartFilter.required:
        return item.requiredFlag;
    }
  }

  String _filterLabel(AppLocalizations l10n, CartFilter f) => switch (f) {
        CartFilter.all => l10n.filterAll,
        CartFilter.toBuy => l10n.filterToBuy,
        CartFilter.inCart => l10n.filterInCart,
        CartFilter.notFound => l10n.filterNotFound,
        CartFilter.required => l10n.filterRequired,
      };

  Future<void> _openUnplannedSheet(
      BuildContext context, ShoppingList list) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => PurchaseEntrySheet(
        repository: widget.repository,
        list: list,
        item: null,
      ),
    );
  }

  /// Sesle plansız ürün: önizleme → doldurulmuş hızlı giriş (C-003).
  Future<void> _openVoiceEntry(BuildContext context) async {
    final candidate = await widget.onVoicePressed!(context);
    if (candidate == null || !context.mounted) return;
    final list = await widget.repository.getList(widget.listId);
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => PurchaseEntrySheet(
        repository: widget.repository,
        list: list,
        item: null,
        initialCandidate: candidate,
      ),
    );
  }
}

class _SummaryStrip extends StatelessWidget {
  const _SummaryStrip({required this.summary, required this.currencyCode});

  final CartSummary summary;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(currencyCode);
    String money(int minor) => formatMoney(
        Money.fromMinorUnits(minor, currency),
        locale: formatLocaleCode(context));
    final budgetLine = summary.budgetRemainingMinor == null
        ? null
        : summary.isOverBudget
            ? '${l10n.summaryBudgetOver}: ${money(summary.budgetRemainingMinor!.abs())}'
            : '${l10n.summaryBudgetRemaining}: ${money(summary.budgetRemainingMinor!)}';
    return Container(
      key: const Key('summary_strip'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _SummaryCell(label: l10n.summaryPlannedTotal, value: money(summary.plannedTotalMinor)),
              _SummaryCell(label: l10n.summaryInCart, value: money(summary.cartActualMinor)),
              _SummaryCell(label: l10n.summaryRemainingPlan, value: money(summary.remainingPlanMinor)),
              _SummaryCell(label: l10n.summaryProjected, value: money(summary.projectedCheckoutMinor)),
            ],
          ),
          const SizedBox(height: 4),
          // Wrap: uzun çevirilerde iki metin alt alta iner (PB-061).
          Wrap(
            spacing: 12,
            children: [
              Text(l10n.itemsProgress('${summary.doneCount}', '${summary.totalCount}'),
                  style: Theme.of(context).textTheme.bodySmall),
              if (budgetLine != null)
                Text(budgetLine, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCell extends StatelessWidget {
  const _SummaryCell({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(value, style: Theme.of(context).textTheme.titleSmall),
          ),
        ],
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.repository,
    required this.item,
    required this.entries,
    required this.currencyCode,
    this.onShelfPricePressed,
  });

  final ShoppingRepository repository;
  final PlannedItem item;
  final List<PurchaseEntry> entries;
  final String currencyCode;
  final Future<String?> Function(BuildContext context)? onShelfPricePressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = ItemStatus.tryFromDb(item.status) ?? ItemStatus.pending;
    return ListTile(
      key: Key('item_tile_${item.id}'),
      // Satıra dokunmak da girişi açar (C-004): mağazada tek dokunuşla
      // gerçek fiyat yazılır; onay kutusu ikinci yoldur.
      onTap: () => _openEntry(context),
      leading: Checkbox(
        value: status.isInCart,
        onChanged: (checked) async {
          if (checked ?? false) {
            await _openEntry(context);
          } else {
            await repository.setItemStatus(item.id, ItemStatus.pending);
          }
        },
      ),
      title: Text(
        item.name + (item.requiredFlag ? ' ★' : ''),
        overflow: TextOverflow.ellipsis,
        semanticsLabel: item.requiredFlag ? '${item.name} (${l10n.filterRequired})' : null,
      ),
      subtitle: Text(_statusLabel(l10n, status)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ItemPriceCell(
            prices: ItemPrices.of(item, entries),
            currencyCode: currencyCode,
            onEnter: () => _openEntry(context),
            onScan: onShelfPricePressed == null ? null : () => _scanThenEnter(context),
          ),
          PopupMenuButton<String>(
        onSelected: (action) async {
          switch (action) {
            case 'notFound':
              await repository.setItemStatus(item.id, ItemStatus.notFound);
            case 'gaveUp':
              await repository.setItemStatus(item.id, ItemStatus.gaveUp);
            case 'pending':
              await repository.setItemStatus(item.id, ItemStatus.pending);
          }
        },
        itemBuilder: (_) => [
          if (status != ItemStatus.pending)
            PopupMenuItem(value: 'pending', child: Text(l10n.statusPending)),
          PopupMenuItem(value: 'notFound', child: Text(l10n.statusNotFound)),
          PopupMenuItem(value: 'gaveUp', child: Text(l10n.statusGaveUp)),
        ],
          ),
        ],
      ),
    );
  }

  /// Kamera: etiketi oku → fiyat dolu giriş sayfası (tek dokunuş + onay).
  Future<void> _scanThenEnter(BuildContext context) async {
    final price = await onShelfPricePressed!(context);
    if (price == null || !context.mounted) return;
    await _openEntry(context, initialPrice: price);
  }

  Future<void> _openEntry(BuildContext context, {String? initialPrice}) async {
    final list = await repository.getList(item.listId);
    if (!context.mounted) return;
    final mine = entries.where((e) => e.plannedItemId == item.id);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => PurchaseEntrySheet(
        repository: repository,
        list: list,
        item: item,
        initialPrice: initialPrice,
        existing: mine.isEmpty ? null : mine.first,
        onShelfPricePressed: onShelfPricePressed,
      ),
    );
  }

  String _statusLabel(AppLocalizations l10n, ItemStatus status) =>
      switch (status) {
        ItemStatus.pending => l10n.statusPending,
        ItemStatus.inCart => l10n.statusInCart,
        ItemStatus.notFound => l10n.statusNotFound,
        ItemStatus.gaveUp => l10n.statusGaveUp,
        ItemStatus.alternativeBought => l10n.statusAlternative,
      };
}

class PurchaseEntrySheet extends StatefulWidget {
  const PurchaseEntrySheet({
    super.key,
    required this.repository,
    required this.list,
    required this.item,
    this.initialCandidate,
    this.initialPrice,
    this.existing,
    this.onShelfPricePressed,
  });

  final ShoppingRepository repository;
  final ShoppingList list;
  final PlannedItem? item;

  /// Kamerayla okunmuş birim fiyat (DB biçimi, nokta ondalık); alana yazılır.
  final String? initialPrice;

  /// Bu ürün için daha önce girilmiş gerçek alım; düzenlemede alanlar dolar.
  final PurchaseEntry? existing;

  /// Raf etiketini kamerayla okutur ve fiyatı döndürür; null → düğme yok.
  final Future<String?> Function(BuildContext context)? onShelfPricePressed;

  /// Sesle girişte öndoldurulan aday (ad/miktar/birim fiyat).
  final ParsedItemCandidate? initialCandidate;

  @override
  State<PurchaseEntrySheet> createState() => _PurchaseEntrySheetState();
}

class _PurchaseEntrySheetState extends State<PurchaseEntrySheet> {
  late final TextEditingController _name = TextEditingController(
    text: widget.item?.name ?? widget.initialCandidate?.name ?? '',
  );
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _price = TextEditingController();
  bool _quantityPrefilled = false;
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _alternative = TextEditingController();

  bool get _isUnplanned => widget.item == null;

  @override
  void dispose() {
    _name.dispose();
    _quantity.dispose();
    _price.dispose();
    _discount.dispose();
    _alternative.dispose();
    super.dispose();
  }

  AppLocalizations get _l10n => AppLocalizations.of(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_quantityPrefilled) {
      _quantityPrefilled = true;
      final decimalSep = MoneySeparators.forLocaleCode(formatLocaleCode(context))
          .decimal;
      // Planlı miktarda kullanıcıya yerel ayracıyla önerilir (1.5 → 1,5).
      final planned = widget.item?.plannedQuantity ??
          widget.initialCandidate?.quantity?.toDbString() ??
          '1';
      _quantity.text = planned.replaceAll('.', decimalSep);
      final voiced = widget.initialCandidate;
      if (voiced?.unitPrice != null) {
        _price.text = voiced!.unitPrice!.toDbString().replaceAll(
            '.', decimalSep);
      }
      final prev = widget.existing;
      if (prev != null) {
        _quantity.text = prev.actualQuantity.replaceAll('.', decimalSep);
        if (prev.actualUnitPrice != null) {
          _price.text = prev.actualUnitPrice!.replaceAll('.', decimalSep);
        }
      }
      if (widget.initialPrice != null) {
        _price.text = widget.initialPrice!.replaceAll('.', decimalSep);
      }
    }
  }

  /// Etiketi okutur; okunan fiyat alana yazılır (kullanıcı değiştirip kaydeder).
  Future<void> _scan() async {
    final value = await widget.onShelfPricePressed!(context);
    if (value == null || !mounted) return;
    final sep = MoneySeparators.forLocaleCode(formatLocaleCode(context)).decimal;
    setState(() => _price.text = value.replaceAll('.', sep));
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    final separators = MoneySeparators.forLocaleCode(formatLocaleCode(context));
    // Planlı üründe negatif miktar = kontrollü iade satırı (spec §6.5).
    final allowNegative = !_isUnplanned;
    DecimalFixed quantity;
    try {
      quantity = MoneyParser.parseDecimal(_quantity.text.trim(),
          separators: separators, requirePositive: !allowNegative);
    } on FormatException {
      return;
    }
    DecimalFixed? unitPrice;
    if (_price.text.trim().isNotEmpty) {
      try {
        unitPrice = MoneyParser.parseDecimal(_price.text.trim(),
            separators: separators, requirePositive: false);
      } on FormatException {
        return;
      }
    }
    var discountMinor = 0;
    if (_discount.text.trim().isNotEmpty) {
      try {
        final d = MoneyParser.parseDecimal(_discount.text.trim(),
            separators: separators, requirePositive: true);
        discountMinor = d.toMinorUnits(
            Currency.fromCode(widget.list.currencyCode).minorUnitDigits);
      } on FormatException {
        discountMinor = 0;
      }
    }
    final alternative = _alternative.text.trim();

    await widget.repository.recordPurchase(
      listId: widget.list.id,
      plannedItemId: widget.item?.id,
      name: name,
      normalizedName: name.toLowerCase(),
      quantity: quantity,
      unitCode: widget.item?.plannedUnitCode ?? UnitCode.adet.dbCode,
      unitPrice: unitPrice,
      discountMinor: discountMinor,
      alternativeName: alternative.isEmpty ? null : alternative,
    );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = _l10n;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _isUnplanned
                ? l10n.quickEntryTitle
                : widget.item!.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          if (_isUnplanned) ...[
            TextField(
              key: const Key('entry_name_field'),
              controller: _name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: l10n.itemNameLabel),
            ),
            const SizedBox(height: 12),
          ],
          // Fiyat önce ve odaklı (C-004): mağazada en sık girilen değer.
          TextField(
            key: const Key('entry_price_field'),
            controller: _price,
            autofocus: true,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.actualPriceLabel,
              suffixIcon: widget.onShelfPricePressed == null
                  ? null
                  : IconButton(
                      key: const Key('entry_scan_price'),
                      tooltip: l10n.scanPriceLabel,
                      icon: const Icon(Icons.photo_camera_outlined),
                      onPressed: _scan,
                    ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('entry_quantity_field'),
            controller: _quantity,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: l10n.actualQuantityLabel),
          ),
          // İndirim/alternatif ikincil: katlanır bölüm (C-004).
          ExpansionTile(
            key: const Key('entry_details_expand'),
            title: Text(l10n.itemDetailsSection),
            childrenPadding: const EdgeInsets.only(bottom: 8),
            children: [
              TextField(
                controller: _discount,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: l10n.discountLabel),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _alternative,
                decoration:
                    InputDecoration(labelText: l10n.alternativeNameLabel),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FilledButton(
            key: const Key('entry_save_button'),
            onPressed: _save,
            child: Text(l10n.savePurchaseButton),
          ),
        ],
      ),
    );
  }
}
