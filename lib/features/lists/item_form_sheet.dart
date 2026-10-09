import '../../core/money/format_locale.dart';

import 'package:drift/drift.dart' show OrderingTerm;
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
import 'item_repository.dart';
import '../shopping_mode/shopping_repository.dart';
import '../../core/util/normalize_name.dart';

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
    this.initialCandidate,
    this.initialQuantity,
    this.initialUnitCode,
    this.initialUnitPrice,
    this.onVoicePressed,
    this.onShelfPricePressed,
    this.existing,
    this.entries = const [],
    this.initialActualPrice,
    this.focusActual = false,
  });

  final AppDatabase db;
  final StarterCategories starterCategories;
  final int listId;
  final PlannedItem? existing;
  final List<PurchaseEntry> entries;
  final String? initialActualPrice;
  final bool focusActual;

  /// Ses önizlemesi gibi akışlardan öndoldurulan değerler (spec §6.7:
  /// sonuç düzenlenebilir önizlemeye gider, doğrudan kaydedilmez).
  final String? initialName;
  final ParsedItemCandidate? initialCandidate;
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
  String? _categoryName;
  bool _required = false;
  int? _categoryId;
  List<Category> _categories = const [];
  String? _quantityError;
  String? _priceError;
  String? _nameError;
  String _currencyCode = 'TRY';
  final _actualQuantity = TextEditingController(text: '1');
  final _actualPrice = TextEditingController();
  final _discount = TextEditingController();
  UnitCode? _actualUnit;
  bool _actualPriceIsUnit = true;
  bool _actualChanged = false;
  bool _prefilled = false;
  bool _currencyLoaded = false;
  bool _saving = false;
  String? _actualError;
  String? _saveError;
  // ponytail: one actual unit per form; mixed-unit records need a per-unit editor and stay untouched here.
  bool get _mixedUnits => widget.entries.map((e) => e.actualUnitCode).toSet().length > 1;

  @override
  void initState() {
    super.initState();
    final c = widget.initialCandidate;
    if (c != null) _applyCandidate(c);
    (_db.select(
      _db.categories,
    )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get().then((rows) {
      if (mounted) setState(() => _categories = rows);
    });
    (_db.select(
      _db.shoppingLists,
    )..where((t) => t.id.equals(widget.listId))).getSingle().then((list) {
      if (mounted) { setState(() {
        _currencyCode = list.currencyCode;
        _currencyLoaded = true;
        _prefillFields();
      }); }
    });
  }

  AppDatabase get _db => widget.db;
  AppLocalizations get _l10n => AppLocalizations.of(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _prefillFields();
  }

  void _prefillFields() {
    if (_prefilled || !_currencyLoaded) return;
    _prefilled = true;
    String local(String value) => value.replaceAll('.', _separators.decimal);
    final item = widget.existing;
    if (item != null) {
      _name.text = item.name; _brand.text = item.brand ?? ''; _note.text = item.note ?? '';
      _quantity.text = item.plannedQuantity;
      _unit = UnitCode.values.firstWhere((u) => u.dbCode == item.plannedUnitCode || u.name == item.plannedUnitCode);
      _priceIsUnitPrice = item.pricingInputMode == 'unitPrice';
      _price.text = (_priceIsUnitPrice ? item.plannedUnitPrice :
          item.plannedLineTotalMinorUnits == null ? null : DecimalFixed.fromMinorUnits(
            item.plannedLineTotalMinorUnits!, Currency.fromCode(_currencyCode).minorUnitDigits).toDbString()) ?? '';
      _maxPrice.text = item.maxAcceptablePrice ?? ''; _required = item.requiredFlag;
      _categoryId = item.categoryId;
    }
    for (final c in [_quantity, _price, _maxPrice]) { c.text = local(c.text); }
    _actualQuantity.text = local(item?.plannedQuantity ?? widget.initialQuantity ?? '1');
    if (widget.entries.isNotEmpty && !_mixedUnits) {
      final first = widget.entries.first;
      _actualUnit = UnitCode.values.firstWhere((u) => u.dbCode == first.actualUnitCode || u.name == first.actualUnitCode);
      _actualQuantity.text = local(widget.entries.fold(DecimalFixed.zero(),
        (s, e) => s + DecimalFixed.parse(e.actualQuantity)).toDbString());
      _actualPriceIsUnit = widget.entries.length == 1 && first.actualUnitPrice != null;
      final digits = Currency.fromCode(_currencyCode).minorUnitDigits;
      _actualPrice.text = local(_actualPriceIsUnit ? first.actualUnitPrice! :
        widget.entries.every((e) => e.grossTotalMinorUnits == null && e.source != 'receiptOcr') ? '' :
        DecimalFixed.fromMinorUnits(widget.entries.fold<int>(0,
          (s, e) => s + e.actualLineTotalMinorUnits + e.discountMinorUnits), digits).toDbString());
      _discount.text = local(DecimalFixed.fromMinorUnits(widget.entries.fold<int>(0,
        (s, e) => s + e.discountMinorUnits), digits).toDbString());
    }
    if (widget.initialActualPrice != null) {
      _actualPrice.text = local(widget.initialActualPrice!);
      _actualPriceIsUnit = true; _actualChanged = true;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _brand.dispose();
    _quantity.dispose();
    _price.dispose();
    _maxPrice.dispose();
    _note.dispose();
    _actualQuantity.dispose(); _actualPrice.dispose(); _discount.dispose();
    super.dispose();
  }

  MoneySeparators get _separators =>
      MoneySeparators.forLocaleCode(formatLocaleCode(context));

  /// Ayrıştırma; boş veya geçersiz girdide null döner (build sırasında
  /// fırlatmaz). Geçersiz-girdi ayrımı [_fieldState] ile yapılır.
  DecimalFixed? _tryParse(String text) {
    final t = text.trim();
    if (t.isEmpty) return null;
    try {
      return MoneyParser.parseDecimal(
        t,
        separators: _separators,
        requirePositive: false,
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
        formatMoney(
          Money.fromMinorUnits(total.toMinorUnits(digits), currency),
          locale: formatLocaleCode(context),
        ),
      );
    }
    final unitPrice = price.divide(qty, scale: DecimalFixed.maxFractionDigits);
    return l10n.unitPriceCalculated(
      formatMoney(
        Money.fromMinorUnits(unitPrice.toMinorUnits(digits), currency),
        locale: formatLocaleCode(context),
      ),
    );
  }

  Future<void> _save() async {
    if (_saving) return;
    final l10n = _l10n;
    setState(() {
      _quantityError = null;
      _priceError = null;
      _nameError = null;
      _actualError = null; _saveError = null;
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
    if (priceState == false || price != null && price.isNegative) {
      setState(() => _priceError = l10n.invalidPriceError);
      return;
    }

    final actualPrice = _tryParse(_actualPrice.text);
    final actualQuantity = _tryParse(_actualQuantity.text);
    final discount = _tryParse(_discount.text) ?? DecimalFixed.zero();
    if (_actualChanged && (_mixedUnits || actualQuantity == null || actualQuantity.isZero ||
        _fieldState(_actualPrice.text) == false || (actualPrice?.isNegative ?? false) ||
        _fieldState(_discount.text) == false || discount.isNegative)) {
      setState(() => _actualError = l10n.invalidAmountError); return;
    }
    setState(() => _saving = true);
    try {
      await _db.transaction(() async {
        final id = await ItemRepository(_db).addItem(listId: widget.listId,
          existingId: widget.existing?.id, name: name, quantity: quantity,
          unitCode: _unit.dbCode, priceIsUnitPrice: _priceIsUnitPrice, price: price,
          brand: _brand.text.trim().isEmpty ? null : _brand.text.trim(), categoryId: _categoryId, categoryName: _categoryName,
          maxAcceptablePrice: _tryParse(_maxPrice.text), requiredFlag: _required,
          note: _note.text.trim().isEmpty ? null : _note.text.trim());
        if (_actualChanged) {
          final list = await ShoppingRepository(_db).getList(widget.listId);
          final digits = Currency.fromCode(list.currencyCode).minorUnitDigits;
          await ShoppingRepository(_db).recordPurchase(listId: widget.listId, plannedItemId: id,
            name: name, normalizedName: normalizeName(name), quantity: actualQuantity!,
            unitCode: (_actualUnit ?? _unit).dbCode,
            unitPrice: _actualPriceIsUnit ? actualPrice : null,
            lineTotalMinor: _actualPriceIsUnit ? null : actualPrice?.toMinorUnits(digits),
            discountMinor: discount.toMinorUnits(digits));
        }
      });
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) setState(() => _saveError = l10n.saveFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  // Ses girişi çıktısını forma uygular (spec §6.7: doğrulanmadan kaydolmaz).
  Future<void> _onVoicePressed() async {
    final handler = widget.onVoicePressed;
    if (handler == null) return;
    final candidate = await handler(context);
    if (candidate == null || !mounted) return;
    setState(() => _applyCandidate(candidate));
  }

  void _applyCandidate(ParsedItemCandidate candidate) {
    _name.text = candidate.name;
    if (candidate.quantity != null) _quantity.text = candidate.quantity!.toDbString();
    if (candidate.unitCode != null) _unit = candidate.unitCode!;
    if (candidate.unitPrice != null) _price.text = candidate.unitPrice!.toDbString();
    if (candidate.isUnitPrice != null) _priceIsUnitPrice = candidate.isUnitPrice!;
    if (candidate.brand != null) _brand.text = candidate.brand!;
    if (candidate.category != null) { _categoryName = candidate.category; _categoryId = null; }
    // Initial values are localized by _prefillFields after context is available.
    if (_prefilled) {
      for (final field in [_quantity, _price]) { field.text = field.text.replaceAll('.', _separators.decimal); }
    }
  }

  Future<void> _onShelfPricePressed() async {
    final price = await widget.onShelfPricePressed!(context);
    if (price != null && mounted) { setState(() {
      _actualPrice.text = price.replaceAll('.', _separators.decimal);
      _actualPriceIsUnit = true; _actualChanged = true;
    }); }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = _l10n;
    if (!_currencyLoaded) return const Center(child: CircularProgressIndicator());
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
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('item_name_field'),
              controller: _name,
              autofocus: !widget.focusActual,
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
                labelText: '${l10n.compareEstimated} · ${_priceIsUnitPrice
                    ? l10n.pricingModeUnitPrice
                    : l10n.pricingModeLineTotal}',
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
                    // Uzun birim adları (ör. de "Schachtel") dar ekranda taşmasın.
                    isExpanded: true,
                    decoration: InputDecoration(labelText: l10n.unitLabel),
                    items: UnitCode.values
                        .map(
                          (u) => DropdownMenuItem(
                            value: u,
                            child: Text(
                              unitDisplayName(u, l10n),
                              overflow: TextOverflow.ellipsis,
                            ),
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
            TextField(key: const Key('item_actual_price_field'), controller: _actualPrice,
              autofocus: widget.focusActual,
              enabled: !_mixedUnits,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: '${l10n.compareActual} · ${_actualPriceIsUnit ? l10n.pricingModeUnitPrice : l10n.pricingModeLineTotal}',
                errorText: _actualError, helperText: l10n.priceOptionalHint,
                suffixIcon: widget.onShelfPricePressed == null ? null : IconButton(
                  key: const Key('item_shelf_label_button'), tooltip: l10n.scanPriceLabel,
                  onPressed: _mixedUnits ? null : _onShelfPricePressed,
                  icon: const Icon(Icons.photo_camera_outlined))),
              onChanged: (_) => setState(() => _actualChanged = true)),
            const SizedBox(height: 12),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: TextField(key: const Key('item_actual_quantity_field'),
                controller: _actualQuantity, enabled: !_mixedUnits,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                decoration: InputDecoration(labelText: l10n.actualQuantityLabel),
                onChanged: (_) => _actualChanged = true)),
              const SizedBox(width: 8),
              Expanded(child: DropdownButtonFormField<String>(key: const Key('item_actual_unit_field'),
                initialValue: (_actualUnit ?? _unit).dbCode, isExpanded: true,
                decoration: InputDecoration(labelText: l10n.unitLabel),
                items: UnitCode.values.map((u) => DropdownMenuItem(value: u.dbCode,
                  child: Text(unitDisplayName(u, l10n)))).toList(),
                onChanged: _mixedUnits ? null : (v) => setState(() {
                  _actualUnit = UnitCode.fromDbCode(v!); _actualChanged = true;
                }))),
            ]),
            if (_mixedUnits) Text(l10n.purchaseAnalyticsHint),
            ExpansionTile(
              key: const Key('item_details_expand'),
              title: Text(l10n.itemDetailsSection),
              childrenPadding: const EdgeInsets.only(bottom: 8),
              children: [
                DropdownButtonFormField<bool>(key: const Key('item_actual_pricing_mode'),
                  initialValue: _actualPriceIsUnit, isExpanded: true,
                  decoration: InputDecoration(labelText: l10n.actualPriceLabel),
                  items: [DropdownMenuItem(value: true, child: Text(l10n.pricingModeUnitPrice)),
                    DropdownMenuItem(value: false, child: Text(l10n.pricingModeLineTotal))],
                  onChanged: _mixedUnits ? null : (v) => setState(() {
                    _actualPriceIsUnit = v!; _actualChanged = true;
                  })),
                const SizedBox(height: 12),
                TextField(key: const Key('item_discount_field'), controller: _discount,
                  enabled: !_mixedUnits, keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: l10n.discountLabel),
                  onChanged: (_) => _actualChanged = true),
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
                if (_categoryName != null) TextFormField(
                  key: const Key('item_candidate_category'), initialValue: widget.starterCategories.labelOf(l10n, _categoryName!),
                  decoration: InputDecoration(labelText: l10n.categoryLabel),
                  onChanged: (value) => _categoryName = value.trim().isEmpty ? null : value.trim(),
                ),
                DropdownButtonFormField<int>(
                  isExpanded: true,
                  key: ValueKey('item_category_$_categoryId'),
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
                  onChanged: (v) => setState(() { _categoryId = v; _categoryName = null; }),
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
              onPressed: _saving ? null : _save,
              child: Text(l10n.saveButton),
            ),
            if (_saveError != null) Text(_saveError!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ),
      ),
    );
  }
}

/// Ad normalize etme (ItemRepository ile aynı kural; UI kaydetmede kullanır).
String normalizeItemName(String name) => normalizeName(name);

extension _DecimalEquals on DecimalFixed {
  bool equals(DecimalFixed other) => compareTo(other) == 0;
}
