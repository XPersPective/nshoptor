import '../../core/money/format_locale.dart';

import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';

import '../../core/calc/line_calc.dart';
import '../../core/l10n/generated/app_localizations.dart';
import '../voice_input/parser/parsed_item_candidate.dart';
import '../receipts/shelf_label/price_candidates.dart';
import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/money/money_parser.dart';
import '../../core/quantity/unit_code.dart';
import '../../core/quantity/unit_display.dart';
import '../../data/db/app_database.dart';
import '../../app/app_defaults.dart';
import 'starter_categories.dart';
import '../voice_input/dictation_mic_button.dart';
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
    this.onShelfPricePressed,
    this.onShelfCandidatePressed,
    this.initialActualCandidate,
    this.existing,
    this.entries = const [],
    this.initialActualPrice,
    this.focusActual = false,
    this.onPriceHistory,
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

  /// Verilince raf etiketi düğmesi çıkar; seçilen birim fiyat dizesi döner.
  final Future<String?> Function(BuildContext context)? onShelfPricePressed;
  final Future<PriceCandidate?> Function(BuildContext context)?
  onShelfCandidatePressed;
  final PriceCandidate? initialActualCandidate;

  /// Mevcut ürünün fiyat geçmişi (satırdaki menünün yerine).
  final VoidCallback? onPriceHistory;

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
  final _actualPrice = TextEditingController();
  // Hidden from the form; preserved when the store price is re-recorded.
  int _existingDiscountMinor = 0;
  bool _actualChanged = false;
  bool _prefilled = false;
  bool _currencyLoaded = false;
  bool _saving = false;
  String? _actualError;
  String? _saveError;
  final _detailsController = ExpansibleController();
  // ponytail: one actual unit per form; mixed-unit records need a per-unit editor and stay untouched here.
  bool get _mixedUnits =>
      widget.entries.map((e) => e.actualUnitCode).toSet().length > 1;

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
      if (mounted) {
        setState(() {
          _currencyCode = list.currencyCode;
          _currencyLoaded = true;
          _prefillFields();
        });
      }
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
      _name.text = item.name;
      _brand.text = item.brand ?? '';
      _note.text = item.note ?? '';
      _quantity.text = item.plannedQuantity;
      _unit = UnitCode.values.firstWhere(
        (u) =>
            u.dbCode == item.plannedUnitCode || u.name == item.plannedUnitCode,
      );
      // The form speaks only unit prices; line-total items already store one.
      _price.text = _trimZeros(item.plannedUnitPrice ?? '');
      _maxPrice.text = item.maxAcceptablePrice ?? '';
      _required = item.requiredFlag;
      _categoryId = item.categoryId;
    }
    for (final c in [_quantity, _price, _maxPrice]) {
      c.text = local(c.text);
    }
    if (widget.entries.isNotEmpty && !_mixedUnits) {
      final digits = Currency.fromCode(_currencyCode).minorUnitDigits;
      _existingDiscountMinor = widget.entries.fold<int>(
        0,
        (s, e) => s + e.discountMinorUnits,
      );
      final first = widget.entries.first;
      final quantity = widget.entries.fold(
        DecimalFixed.zero(),
        (s, e) => s + DecimalFixed.parse(e.actualQuantity),
      );
      final unknown = widget.entries.every(
        (e) => e.grossTotalMinorUnits == null && e.source != 'receiptOcr',
      );
      _actualPrice.text = local(
        widget.entries.length == 1 && first.actualUnitPrice != null
            ? first.actualUnitPrice!
            : unknown || !quantity.isPositive
            ? ''
            : DecimalFixed.fromMinorUnits(
                widget.entries.fold<int>(
                  0,
                  (s, e) =>
                      s + e.actualLineTotalMinorUnits + e.discountMinorUnits,
                ),
                digits,
              ).divide(quantity, scale: digits).toDbString(),
      );
    }
    if (widget.initialActualPrice != null) {
      _actualPrice.text = local(widget.initialActualPrice!);
      _actualChanged = true;
    }
    if (widget.initialActualCandidate != null) {
      _applyPhoto(widget.initialActualCandidate!);
    }
  }

  @override
  void dispose() {
    _detailsController.dispose();
    _name.dispose();
    _brand.dispose();
    _quantity.dispose();
    _price.dispose();
    _maxPrice.dispose();
    _note.dispose();
    _actualPrice.dispose();
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

  Future<void> _save() async {
    if (_saving) return;
    final l10n = _l10n;
    setState(() {
      _quantityError = null;
      _priceError = null;
      _nameError = null;
      _actualError = null;
      _saveError = null;
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
    if (_actualChanged &&
        (_mixedUnits ||
            _fieldState(_actualPrice.text) == false ||
            (actualPrice?.isNegative ?? false))) {
      setState(() => _actualError = l10n.invalidAmountError);
      return;
    }
    setState(() => _saving = true);
    try {
      await _db.transaction(() async {
        final id = await ItemRepository(_db).addItem(
          listId: widget.listId,
          existingId: widget.existing?.id,
          name: name,
          quantity: quantity,
          unitCode: _unit.dbCode,
          priceIsUnitPrice: _priceIsUnitPrice,
          price: price,
          brand: _brand.text.trim().isEmpty ? null : _brand.text.trim(),
          categoryId: _categoryId,
          categoryName: _categoryName,
          maxAcceptablePrice: _tryParse(_maxPrice.text),
          requiredFlag: _required,
          note: _note.text.trim().isEmpty ? null : _note.text.trim(),
        );
        if (_actualChanged) {
          final list = await ShoppingRepository(_db).getList(widget.listId);
          final digits = Currency.fromCode(list.currencyCode).minorUnitDigits;
          await ShoppingRepository(_db).recordPurchase(
            listId: widget.listId,
            plannedItemId: id,
            name: name,
            normalizedName: normalizeName(name),
            // Store quantity follows the list quantity (user: it may change in
            // the shop); the form records the store unit price only.
            quantity: quantity,
            unitCode: _unit.dbCode,
            unitPrice: actualPrice,
            discountMinor: actualPrice == null
                ? 0
                : _existingDiscountMinor.clamp(
                    0,
                    LineCalc.plannedLineTotal(
                      quantity,
                      actualPrice,
                    ).toMinorUnits(digits),
                  ),
          );
        }
      });
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) setState(() => _saveError = l10n.saveFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  /// Derived unit prices keep 6 digits ("1.999000"); show only what matters,
  /// never fewer than the currency's digits.
  String _trimZeros(String value) {
    final dot = value.indexOf('.');
    if (dot < 0) return value;
    final keep = dot + 1 + Currency.fromCode(_currencyCode).minorUnitDigits;
    var end = value.length;
    while (end > keep && value[end - 1] == '0') {
      end--;
    }
    return value.substring(0, end);
  }

  void _quantityOrUnitChanged() {
    // An existing store price is per unit: its line total follows the quantity.
    if (widget.entries.isNotEmpty && _actualPrice.text.trim().isNotEmpty) {
      _actualChanged = true;
    }
    setState(() {});
  }

  void _applyCandidate(ParsedItemCandidate candidate) {
    _name.text = candidate.name;
    if (candidate.quantity != null) {
      _quantity.text = candidate.quantity!.toDbString();
    }
    if (candidate.unitCode != null) {
      _unit = candidate.unitCode!;
    }
    if (candidate.unitPrice != null) {
      _price.text = candidate.unitPrice!.toDbString();
    }
    if (candidate.isUnitPrice != null) {
      _priceIsUnitPrice = candidate.isUnitPrice!;
    }
    if (candidate.brand != null) _brand.text = candidate.brand!;
    if (candidate.category != null) {
      _categoryName = candidate.category;
      _categoryId = null;
    }
    // Initial values are localized by _prefillFields after context is available.
    if (_prefilled) {
      for (final field in [_quantity, _price]) {
        field.text = field.text.replaceAll('.', _separators.decimal);
      }
    }
  }

  Future<void> _scanActualPrice() async {
    final candidate = await widget.onShelfCandidatePressed?.call(context);
    if (candidate == null || !mounted) return;
    setState(() => _applyPhoto(candidate));
  }

  void _applyPhoto(PriceCandidate c) {
    if (c.productName != null && c.productName!.isNotEmpty) {
      _name.text = c.productName!;
    }
    _actualPrice.text = c.value.toDbString().replaceAll(
      '.',
      _separators.decimal,
    );
    _actualChanged = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = _l10n;
    if (!_currencyLoaded) {
      return const Center(child: CircularProgressIndicator());
    }
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
            TextField(
              key: const Key('item_name_field'),
              controller: _name,
              autofocus: !widget.focusActual,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l10n.itemNameLabel,
                errorText: _nameError,
                suffixIcon: DictationMicButton(
                  key: const Key('item_name_mic'),
                  controller: _name,
                ),
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
                    onChanged: (_) => _quantityOrUnitChanged(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: KeyedSubtree(
                    key: ValueKey(_unit),
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
                      onChanged: (v) {
                        _unit = v ?? _unit;
                        _quantityOrUnitChanged();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Evdeki/Çarşıdaki fiyat hep birim fiyattır: "/ kg" eki bunu söyler.
            TextField(
              key: const Key('item_price_field'),
              controller: _price,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText:
                    '${l10n.compareEstimated} / ${unitDisplayName(_unit, l10n)}',
                errorText: _priceError,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('item_actual_price_field'),
              controller: _actualPrice,
              autofocus: widget.focusActual,
              enabled: !_mixedUnits,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText:
                    '${l10n.compareActual} / ${unitDisplayName(_unit, l10n)}',
                errorText: _actualError,
                helperText: _mixedUnits ? l10n.purchaseAnalyticsHint : null,
                suffixIcon: widget.onShelfCandidatePressed == null || _mixedUnits
                    ? null
                    : IconButton(
                        key: const Key('item_scan_actual_price'),
                        tooltip: l10n.tipShelfCamera,
                        icon: const Icon(Icons.photo_camera_outlined),
                        onPressed: _scanActualPrice,
                      ),
              ),
              onChanged: (_) => _actualChanged = true,
            ),
            ExpansionTile(
              key: const Key('item_details_expand'),
              controller: _detailsController,
              title: Text(l10n.itemDetailsSection),
              childrenPadding: const EdgeInsets.only(top: 12, bottom: 8),
              children: [
                TextField(
                  key: const Key('item_brand_field'),
                  controller: _brand,
                  decoration: InputDecoration(labelText: l10n.brandLabel),
                ),
                const SizedBox(height: 12),
                if (_categoryName != null)
                  TextFormField(
                    key: const Key('item_candidate_category'),
                    initialValue: widget.starterCategories.labelOf(
                      l10n,
                      _categoryName!,
                    ),
                    decoration: InputDecoration(labelText: l10n.categoryLabel),
                    onChanged: (value) => _categoryName = value.trim().isEmpty
                        ? null
                        : value.trim(),
                  )
                else
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
                    onChanged: (v) => setState(() {
                      _categoryId = v;
                      _categoryName = null;
                    }),
                  ),
                const SizedBox(height: 12),
                TextField(
                  key: const Key('item_note_field'),
                  controller: _note,
                  decoration: InputDecoration(labelText: l10n.itemNoteLabel),
                ),
                if (widget.onPriceHistory != null && widget.existing != null)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton.icon(
                      key: const Key('item_price_history'),
                      onPressed: widget.onPriceHistory,
                      icon: const Icon(Icons.show_chart),
                      label: Text(l10n.priceHistoryTitle),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            FilledButton(
              key: const Key('item_save_button'),
              onPressed: _saving ? null : _save,
              child: Text(l10n.saveButton),
            ),
            if (_saveError != null)
              Text(
                _saveError!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
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
