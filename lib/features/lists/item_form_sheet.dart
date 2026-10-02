import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:flutter/material.dart';

import '../../core/calc/line_calc.dart';
import '../../core/l10n/generated/app_localizations.dart';
import '../voice_input/parser/parsed_item_candidate.dart';
import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/money/money_format.dart';
import '../../core/money/money.dart';
import '../../core/money/money_parser.dart';
import '../../core/quantity/unit_code.dart';
import '../../core/quantity/unit_display.dart';
import '../../data/db/app_database.dart';
import '../../app/app_defaults.dart';
import 'starter_categories.dart';

/// Birimlerin varsayılan tam sayı tercihi (spec §6.2): adet/düzine tam sayı
/// ister; kütle/hacim/uzunluk ondalıklı kabul eder. Model katmanı ondalığı
/// engellemez; bu yalnız form doğrulamasıdır.
bool unitPrefersInteger(UnitCode unit) =>
    unit == UnitCode.adet || unit == UnitCode.duzine;

/// Planlanan ürün ekleme/düzenleme formu (spec §6.2).
class ItemFormSheet extends StatefulWidget {
  const ItemFormSheet({
    super.key,
    required this.db,
    required this.starterCategories,
    required this.listId,
    this.initialName,
    this.initialQuantity,
    this.initialUnitCode,
    this.initialUnitPrice,
    this.onVoicePressed,
    this.onShelfPricePressed,
  });

  final AppDatabase db;
  final StarterCategories starterCategories;
  final int listId;

  /// Ses önizlemesi gibi akışlardan öndoldurulan değerler (spec §6.7:
  /// sonuç düzenlenebilir önizlemeye gider, doğrudan kaydedilmez).
  final String? initialName;
  final String? initialQuantity;
  final UnitCode? initialUnitCode;
  final String? initialUnitPrice;

  /// Verilince mikrofon düğmesi çıkar; kullanıcı sesle girişi kontrol eder.
  final Future<ParsedItemCandidate?> Function(BuildContext context)?
  onVoicePressed;

  /// Verilince raf etiketi düğmesi çıkar; seçilen birim fiyat dizesi döner.
  final Future<String?> Function(BuildContext context)? onShelfPricePressed;

  @override
  State<ItemFormSheet> createState() => _ItemFormSheetState();
}

class _ItemFormSheetState extends State<ItemFormSheet> {
  late final TextEditingController _name = TextEditingController(
    text: widget.initialName ?? '',
  );
  final _brand = TextEditingController();
  late final TextEditingController _quantity = TextEditingController(
    text: widget.initialQuantity ?? '1',
  );
  late final TextEditingController _price = TextEditingController(
    text: widget.initialUnitPrice ?? '',
  );
  final _maxPrice = TextEditingController();
  final _note = TextEditingController();

  late UnitCode _unit = widget.initialUnitCode ?? AppDefaults.defaultUnit();
  bool _priceIsUnitPrice = true;
  bool _required = false;
  int? _categoryId;
  List<Category> _categories = const [];
  String? _quantityError;
  String? _priceError;
  String? _nameError;
  String _currencyCode = 'TRY';

  @override
  void initState() {
    super.initState();
    (_db.select(
      _db.categories,
    )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get().then((rows) {
      if (mounted) setState(() => _categories = rows);
    });
    (_db.select(
      _db.shoppingLists,
    )..where((t) => t.id.equals(widget.listId))).getSingle().then((list) {
      if (mounted) setState(() => _currencyCode = list.currencyCode);
    });
  }

  AppDatabase get _db => widget.db;
  AppLocalizations get _l10n => AppLocalizations.of(context);

  @override
  void dispose() {
    _name.dispose();
    _brand.dispose();
    _quantity.dispose();
    _price.dispose();
    _maxPrice.dispose();
    _note.dispose();
    super.dispose();
  }

  MoneySeparators get _separators => MoneySeparators.forLocaleCode(
    Localizations.localeOf(context).languageCode,
  );

  /// Ayrıştırma; boş veya geçersiz girdide null döner (build sırasında
  /// fırlatmaz). Geçersiz-girdi ayrımı [_fieldState] ile yapılır.
  DecimalFixed? _tryParse(String text) {
    final t = text.trim();
    if (t.isEmpty) return null;
    try {
      return MoneyParser.parseDecimal(
        t,
        separators: _separators,
        requirePositive: true,
      );
    } on FormatException {
      return null;
    }
  }

  /// null: boş · true: geçerli · false: geçersiz
  bool? _fieldState(String text) {
    if (text.trim().isEmpty) return null;
    return _tryParse(text) != null;
  }

  /// Girilmeyen tarafın hesaplanmış değeri (spec §6.2: çift yönlü).
  String _otherSidePreview() {
    final qty = _tryParse(_quantity.text);
    final price = _tryParse(_price.text);
    if (qty == null || price == null || !qty.isPositive) return '';
    final currency = Currency.fromCode(_currencyCode);
    final digits = currency.minorUnitDigits;
    final l10n = _l10n;
    if (_priceIsUnitPrice) {
      final total = LineCalc.plannedLineTotal(qty, price);
      return l10n.lineTotalCalculated(
        formatMoney(Money.fromMinorUnits(total.toMinorUnits(digits), currency)),
      );
    }
    final unitPrice = price.divide(qty, scale: DecimalFixed.maxFractionDigits);
    return l10n.unitPriceCalculated(
      formatMoney(
        Money.fromMinorUnits(unitPrice.toMinorUnits(digits + 2), currency),
      ),
    );
  }

  Future<void> _save() async {
    final l10n = _l10n;
    setState(() {
      _quantityError = null;
      _priceError = null;
      _nameError = null;
    });

    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = l10n.invalidNameError);
      return;
    }

    // Miktar: boş olamaz; geçersiz ya da (tam sayı tercih eden birimde)
    // kesirliyse hata.
    final quantityText = _quantity.text.trim();
    final quantityState = _fieldState(quantityText);
    final quantity = _tryParse(quantityText);
    if (quantityState == null ||
        quantityState == false ||
        quantity == null ||
        !quantity.isPositive ||
        (unitPrefersInteger(_unit) && !quantity.rescale(0).equals(quantity))) {
      setState(() => _quantityError = l10n.invalidQuantityError);
      return;
    }

    // Fiyat: boş olabilir (fiyatsız plan); doluysa geçerli olmalı.
    final priceState = _fieldState(_price.text);
    final price = _tryParse(_price.text);
    if (priceState == false || price != null && !price.isPositive) {
      setState(() => _priceError = l10n.invalidPriceError);
      return;
    }

    final list = await (_db.select(
      _db.shoppingLists,
    )..where((t) => t.id.equals(widget.listId))).getSingle();
    final digits = Currency.fromCode(list.currencyCode).minorUnitDigits;
    DecimalFixed? unitPrice;
    int? lineTotalMinor;
    if (price != null) {
      if (_priceIsUnitPrice) {
        unitPrice = price;
        lineTotalMinor = LineCalc.plannedLineTotal(
          quantity,
          price,
        ).toMinorUnits(digits);
      } else {
        lineTotalMinor = price.toMinorUnits(digits);
        unitPrice = price.divide(
          quantity,
          scale: DecimalFixed.maxFractionDigits,
        );
      }
    }
    await _db
        .into(_db.plannedItems)
        .insert(
          PlannedItemsCompanion.insert(
            listId: widget.listId,
            name: name,
            normalizedName: normalizeItemName(name),
            brand: Value(
              _brand.text.trim().isEmpty ? null : _brand.text.trim(),
            ),
            categoryId: Value(_categoryId),
            plannedQuantity: quantity.toDbString(),
            plannedUnitCode: _unit.dbCode,
            pricingInputMode: _priceIsUnitPrice ? 'unitPrice' : 'lineTotal',
            plannedUnitPrice: Value(unitPrice?.toDbString()),
            plannedLineTotalMinorUnits: Value(lineTotalMinor),
            maxAcceptablePrice: Value(_tryParse(_maxPrice.text)?.toDbString()),
            requiredFlag: Value(_required),
            note: Value(_note.text.trim().isEmpty ? null : _note.text.trim()),
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  // Ses girişi çıktısını forma uygular (spec §6.7: doğrulanmadan kaydolmaz).
  Future<void> _onVoicePressed() async {
    final handler = widget.onVoicePressed;
    if (handler == null) return;
    final candidate = await handler(context);
    if (candidate == null) return;
    setState(() {
      _name.text = candidate.name;
      if (candidate.quantity != null) {
        _quantity.text = candidate.quantity!.toDbString();
      }
      if (candidate.unitCode != null) _unit = candidate.unitCode!;
      if (candidate.unitPrice != null) {
        _price.text = candidate.unitPrice!.toDbString();
      }
    });
  }

  Future<void> _onShelfPricePressed() async {
    final price = await widget.onShelfPricePressed!(context);
    if (price != null && mounted) setState(() => _price.text = price);
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
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.itemFormTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (widget.onVoicePressed != null)
                  IconButton(
                    key: const Key('item_voice_button'),
                    icon: const Icon(Icons.mic_none),
                    tooltip: l10n.voiceStartListening,
                    onPressed: () => _onVoicePressed(),
                  ),
                if (widget.onShelfPricePressed != null)
                  IconButton(
                    key: const Key('item_shelf_label_button'),
                    icon: const Icon(Icons.document_scanner_outlined),
                    tooltip: l10n.shelfLabelAction,
                    onPressed: _onShelfPricePressed,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('item_name_field'),
              controller: _name,
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l10n.itemNameLabel,
                errorText: _nameError,
              ),
            ),
            const SizedBox(height: 12),
            // Tahmini fiyat: ikinci alan — "domates, 14 TL" akışı iki
            // dokunuşta tamamlanır (C-004). Miktar varsayılanı 1'dir.
            TextField(
              key: const Key('item_price_field'),
              controller: _price,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: _priceIsUnitPrice
                    ? l10n.pricingModeUnitPrice
                    : l10n.pricingModeLineTotal,
                helperText: l10n.priceOptionalHint,
                errorText: _priceError,
              ),
              onChanged: (_) => setState(() {}),
            ),
            if (_otherSidePreview().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _otherSidePreview(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('item_quantity_field'),
                    controller: _quantity,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.quantityLabel,
                      errorText: _quantityError,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  key: const Key('item_quantity_plus_one'),
                  onPressed: () => setState(() {
                    final q = _tryParse(_quantity.text) ?? DecimalFixed.zero();
                    _quantity.text = (q + DecimalFixed.fromInt(1)).toDbString();
                  }),
                  child: const Text('+1'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<UnitCode>(
                    key: const Key('item_unit_field'),
                    initialValue: _unit,
                    decoration: InputDecoration(labelText: l10n.unitLabel),
                    items: UnitCode.standard()
                        .map(
                          (u) => DropdownMenuItem(
                            value: u,
                            child: Text(unitDisplayName(u, l10n)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _unit = v ?? _unit),
                  ),
                ),
              ],
            ),
            // Gelişmiş alanlar katlanır: ana akış yalnız ad+fiyat+miktar
            // ister; kalanlar "Ayrıntılar"ta (C-004).
            ExpansionTile(
              key: const Key('item_details_expand'),
              title: Text(l10n.itemDetailsSection),
              childrenPadding: const EdgeInsets.only(bottom: 8),
              children: [
                SegmentedButton<bool>(
                  key: const Key('item_pricing_mode'),
                  segments: [
                    ButtonSegment(
                      value: true,
                      label: Text(l10n.pricingModeUnitPrice),
                    ),
                    ButtonSegment(
                      value: false,
                      label: Text(l10n.pricingModeLineTotal),
                    ),
                  ],
                  selected: {_priceIsUnitPrice},
                  onSelectionChanged: (s) =>
                      setState(() => _priceIsUnitPrice = s.first),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _brand,
                  decoration: InputDecoration(labelText: l10n.brandLabel),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  key: const Key('item_category_field'),
                  initialValue: _categoryId,
                  decoration: InputDecoration(labelText: l10n.categoryLabel),
                  items: _categories
                      .map(
                        (c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(
                            widget.starterCategories.labelOf(l10n, c.name),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _categoryId = v),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _maxPrice,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(labelText: l10n.maxPriceLabel),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _note,
                  decoration: InputDecoration(labelText: l10n.itemNoteLabel),
                ),
                CheckboxListTile(
                  key: const Key('item_required_toggle'),
                  value: _required,
                  title: Text(l10n.requiredItemToggle),
                  onChanged: (v) => setState(() => _required = v ?? false),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 8),
            FilledButton(
              key: const Key('item_save_button'),
              onPressed: _save,
              child: Text(l10n.saveButton),
            ),
          ],
        ),
      ),
    );
  }
}

/// Ad normalize etme (ItemRepository ile aynı kural; UI kaydetmede kullanır).
String normalizeItemName(String name) => name
    .toLowerCase()
    .replaceAll('ç', 'c')
    .replaceAll('ğ', 'g')
    .replaceAll('ı', 'i')
    .replaceAll('ö', 'o')
    .replaceAll('ş', 's')
    .replaceAll('ü', 'u')
    .replaceAll(RegExp(r'[^a-z0-9 ]'), '')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

extension _DecimalEquals on DecimalFixed {
  bool equals(DecimalFixed other) => compareTo(other) == 0;
}
