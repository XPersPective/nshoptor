import '../../core/money/format_locale.dart';
import 'package:flutter/material.dart';


import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/money/money_parser.dart';
import '../../core/quantity/unit_code.dart';
import '../../data/db/app_database.dart';
import '../voice_input/parser/parsed_item_candidate.dart';
import 'shopping_repository.dart';
import '../lists/list_detail_screen.dart';
import '../lists/list_repository.dart';

/// Alışveriş modu ekranı (spec §6.5-6.6): üst özet şeridi + filtre
/// çipleri + ürün satırları. Tek elle kullanım için büyük dokunma
/// hedefleri; her ürün dokunuşunda gerçek fiyat girişi açılır.
class ShoppingModeScreen extends StatelessWidget {
  const ShoppingModeScreen({super.key, required this.repository, required this.listId,
    this.onVoicePressed, this.onShelfPricePressed});
  final ShoppingRepository repository;
  final int listId;
  final Future<ParsedItemCandidate?> Function(BuildContext)? onVoicePressed;
  final Future<String?> Function(BuildContext)? onShelfPricePressed;
  @override
  Widget build(BuildContext context) => ListDetailScreen(db: repository.db,
    listRepository: ListRepository(repository.db), listId: listId,
    onVoicePressed: onVoicePressed, onShelfPricePressed: onShelfPricePressed);
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
