import '../../core/money/format_locale.dart';
import '../../core/widgets/price_mode_selector.dart';
import '../../core/quantity/unit_display.dart';
import '../../core/calc/price_input.dart';

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
  const ShoppingModeScreen({
    super.key,
    required this.repository,
    required this.listId,
    this.onVoicePressed,
    this.onShelfPricePressed,
  });
  final ShoppingRepository repository;
  final int listId;
  final Future<ParsedItemCandidate?> Function(BuildContext)? onVoicePressed;
  final Future<String?> Function(BuildContext)? onShelfPricePressed;
  @override
  Widget build(BuildContext context) => ListDetailScreen(
    db: repository.db,
    listRepository: ListRepository(repository.db),
    listId: listId,
    onShelfPricePressed: onShelfPricePressed,
  );
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
  final _priceFocus = FocusNode();
  bool _unitMode = false;
  bool _needsMeaning = false;
  bool _quantityPrefilled = false;
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _alternative = TextEditingController();

  bool get _isUnplanned => widget.item == null;

  @override
  void dispose() {
    _name.dispose();
    _quantity.dispose();
    _price.dispose();
    _priceFocus.dispose();
    _discount.dispose();
    _alternative.dispose();
    super.dispose();
  }

  AppLocalizations get _l10n => AppLocalizations.of(context);

  UnitCode get _entryUnit =>
      widget.initialCandidate?.unitCode ??
      UnitCode.values.firstWhere(
        (u) =>
            u.dbCode ==
                (widget.existing?.actualUnitCode ??
                    widget.item?.plannedUnitCode ??
                    'piece') ||
            u.name ==
                (widget.existing?.actualUnitCode ??
                    widget.item?.plannedUnitCode ??
                    'piece'),
      );

  DecimalFixed _parse(String text) => MoneyParser.parseDecimal(
    text,
    separators: MoneySeparators.forLocaleCode(formatLocaleCode(context)),
    requirePositive: false,
  );

  String _localAmount(DecimalFixed amount) {
    var value = amount.toDbString();
    if (value.contains('.')) {
      value = value
          .replaceFirst(RegExp(r'0+$'), '')
          .replaceFirst(RegExp(r'\.$'), '');
    }
    return value.replaceAll(
      '.',
      MoneySeparators.forLocaleCode(formatLocaleCode(context)).decimal,
    );
  }

  void _switchMode(bool next) {
    try {
      if (_price.text.trim().isNotEmpty &&
          !_needsMeaning &&
          next != _unitMode) {
        final quantity = _parse(_quantity.text), amount = _parse(_price.text);
        final discount = _discount.text.trim().isEmpty
            ? DecimalFixed.zero()
            : _parse(_discount.text);
        if (quantity.isPositive && !amount.isNegative && !discount.isNegative) {
          final converted = next
              ? (amount + discount).divide(
                  quantity,
                  scale: DecimalFixed.maxFractionDigits,
                )
              : amount * quantity - discount;
          _price.text = _localAmount(
            converted.isNegative ? DecimalFixed.zero() : converted,
          );
        }
      }
    } catch (_) {
      /* Incomplete inputs remain editable and are checked on save. */
    }
    setState(() {
      _unitMode = next;
      _needsMeaning = false;
    });
    _priceFocus.requestFocus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_quantityPrefilled) {
      _quantityPrefilled = true;
      final decimalSep = MoneySeparators.forLocaleCode(
        formatLocaleCode(context),
      ).decimal;
      // Planlı miktarda kullanıcıya yerel ayracıyla önerilir (1.5 → 1,5).
      final planned =
          widget.item?.plannedQuantity ??
          widget.initialCandidate?.quantity?.toDbString() ??
          '1';
      _quantity.text = planned.replaceAll('.', decimalSep);
      final voiced = widget.initialCandidate;
      if (voiced?.unitPrice != null) {
        _unitMode = voiced!.isUnitPrice == true;
        _needsMeaning = voiced.requiresPriceConfirmation;
        _price.text = voiced.unitPrice!.toDbString().replaceAll(
          '.',
          decimalSep,
        );
        if (_unitMode) {
          _price.text = _localAmount(
            PriceInput.total(
              amount: voiced.unitPrice!,
              quantity: DecimalFixed.fromInt(1),
              quantityUnit: _entryUnit,
              isUnitPrice: true,
              priceUnit: voiced.priceUnitCode,
            ),
          );
        }
      }
      final prev = widget.existing;
      if (prev != null) {
        _unitMode = prev.pricingInputMode != 'lineTotal';
        _quantity.text = prev.actualQuantity.replaceAll('.', decimalSep);
        if (_isUnplanned && !_unitMode) {
          _price.text = _localAmount(
            DecimalFixed.fromMinorUnits(
              prev.actualLineTotalMinorUnits,
              Currency.fromCode(widget.list.currencyCode).minorUnitDigits,
            ),
          );
        } else if (prev.actualUnitPrice != null) {
          _price.text = prev.actualUnitPrice!.replaceAll('.', decimalSep);
        }
        _discount.text = _localAmount(
          DecimalFixed.fromMinorUnits(
            prev.discountMinorUnits,
            Currency.fromCode(widget.list.currencyCode).minorUnitDigits,
          ),
        );
      }
      if (widget.initialPrice != null) {
        _unitMode = true;
        _price.text = widget.initialPrice!.replaceAll('.', decimalSep);
      }
    }
  }

  /// Etiketi okutur; okunan fiyat alana yazılır (kullanıcı değiştirip kaydeder).
  Future<void> _scan() async {
    final value = await widget.onShelfPricePressed!(context);
    if (value == null || !mounted) return;
    final sep = MoneySeparators.forLocaleCode(formatLocaleCode(context))
        .decimal;
    setState(() {
      _price.text = value.replaceAll('.', sep);
      _unitMode = true;
      _needsMeaning = false;
    });
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty || _needsMeaning) return;
    final separators = MoneySeparators.forLocaleCode(formatLocaleCode(context));
    // Planlı üründe negatif miktar = kontrollü iade satırı (spec §6.5).
    final allowNegative = !_isUnplanned;
    DecimalFixed quantity;
    try {
      quantity = MoneyParser.parseDecimal(
        _quantity.text.trim(),
        separators: separators,
        requirePositive: !allowNegative,
      );
    } on FormatException {
      return;
    }
    DecimalFixed? unitPrice;
    if (_price.text.trim().isNotEmpty) {
      try {
        unitPrice = MoneyParser.parseDecimal(
          _price.text.trim(),
          separators: separators,
          requirePositive: false,
        );
      } on FormatException {
        return;
      }
    }
    var discountMinor = 0;
    if (unitPrice?.isNegative ?? false) return;
    if (_discount.text.trim().isNotEmpty) {
      try {
        final d = MoneyParser.parseDecimal(
          _discount.text.trim(),
          separators: separators,
          requirePositive: true,
        );
        discountMinor = d.toMinorUnits(
          Currency.fromCode(widget.list.currencyCode).minorUnitDigits,
        );
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
      unitCode: _entryUnit.dbCode,
      unitPrice: _isUnplanned && !_unitMode ? null : unitPrice,
      lineTotalMinor: _isUnplanned && !_unitMode && unitPrice != null
          ? unitPrice.toMinorUnits(
                  Currency.fromCode(widget.list.currencyCode).minorUnitDigits,
                ) +
                discountMinor
          : null,
      pricingInputMode: _isUnplanned
          ? (_unitMode ? 'unitPrice' : 'lineTotal')
          : null,
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _isUnplanned ? l10n.quickEntryTitle : widget.item!.name,
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
            if (_isUnplanned) ...[
              PriceModeSelector(
                value: _needsMeaning ? null : _unitMode,
                keyPrefix: 'entry_price_mode',
                unitLabel: unitDisplayName(_entryUnit, l10n),
                semanticLabel: l10n.compareActual,
                onChanged: _switchMode,
              ),
              const SizedBox(height: 8),
            ],
            TextField(
              key: const Key('entry_price_field'),
              controller: _price,
              focusNode: _priceFocus,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l10n.actualPriceLabel,
                suffixIcon: widget.onShelfPricePressed == null
                    ? null
                    : IconButton(
                        key: const Key('entry_scan_price'),
                        tooltip: l10n.tipShelfCamera,
                        icon: const Icon(Icons.photo_camera_outlined),
                        onPressed: _scan,
                      ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('entry_quantity_field'),
              controller: _quantity,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
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
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(labelText: l10n.discountLabel),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _alternative,
                  decoration: InputDecoration(
                    labelText: l10n.alternativeNameLabel,
                  ),
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
      ),
    );
  }
}
