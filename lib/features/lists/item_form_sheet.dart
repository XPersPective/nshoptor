import '../../core/money/format_locale.dart';

import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';

import '../../core/calc/price_input.dart';
import '../../core/money/money.dart';
import '../../core/money/money_format.dart';
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
import '../shopping_mode/item_status.dart';
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
  bool _priceIsUnitPrice = false;
  bool _actualPriceIsUnitPrice = false;
  bool _quantityChanged = false;
  bool _homeBasisInvalid = false;
  bool _actualBasisInvalid = false;
  bool _homeMeaningRequired = false;
  bool _actualMeaningRequired = false;
  DecimalFixed? _pendingActualPrice;
  String? _categoryName;
  bool _required = false;
  int? _categoryId;
  List<Category> _categories = const [];
  String? _quantityError;
  String? _priceError;
  String? _nameError;
  String _currencyCode = 'TRY';
  final _actualPrice = TextEditingController();
  final _homePriceFocus = FocusNode();
  final _marketPriceFocus = FocusNode();
  // Hidden from the form; preserved when the store price is re-recorded.
  int _existingDiscountMinor = 0;
  bool _actualChanged = false;
  bool _photoCurrencyMismatch = false;
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
      _priceIsUnitPrice = item.pricingInputMode == 'unitPrice';
      _price.text = _priceIsUnitPrice
          ? (item.plannedUnitPrice == null
                ? ''
                : _displayUnitAmount(
                    DecimalFixed.parse(item.plannedUnitPrice!),
                    _unit,
                    _unit,
                  ).toInputString())
          : (item.plannedLineTotalMinorUnits == null
                ? ''
                : DecimalFixed.fromMinorUnits(
                    item.plannedLineTotalMinorUnits!,
                    Currency.fromCode(_currencyCode).minorUnitDigits,
                  ).toInputString());
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
      _actualPriceIsUnitPrice =
          widget.entries.length == 1 && first.pricingInputMode != 'lineTotal';
      final quantity = _actualQuantity;
      final known = widget.entries.every(hasMarketPrice);
      if (known && quantity != null && quantity.isPositive) {
        final net = widget.entries.fold<int>(
          0,
          (s, e) => s + e.actualLineTotalMinorUnits,
        );
        final amount = _actualPriceIsUnitPrice && first.actualUnitPrice != null
            ? _displayUnitAmount(
                DecimalFixed.parse(first.actualUnitPrice!),
                _actualUnit,
                _actualUnit,
              )
            : _actualPriceIsUnitPrice
            ? PriceInput.unitFromTotal(
                amount: DecimalFixed.fromMinorUnits(
                  net + _existingDiscountMinor,
                  digits,
                ),
                quantity: quantity,
                quantityUnit: _actualUnit,
                priceUnit: PriceInput.displayUnit(_actualUnit),
              )
            : DecimalFixed.fromMinorUnits(net, digits);
        _actualPrice.text = local(_trimZeros(amount.toInputString()));
      }
    }
    final candidate = widget.initialCandidate;
    if (candidate != null &&
        candidate.unitPrice != null &&
        widget.existing == null) {
      final actual = candidate.priceDestination == VoicePriceDestination.actual;
      try {
        if (candidate.currencyCode != null &&
            candidate.currencyCode != _currencyCode) {
          throw const FormatException('Currency mismatch');
        }
        final amount = candidate.isUnitPrice == true
            ? _displayUnitAmount(
                candidate.unitPrice!,
                candidate.priceUnitCode ?? _unit,
                actual ? _actualUnit : _unit,
              )
            : candidate.unitPrice!;
        (actual ? _actualPrice : _price).text = local(amount.toInputString());
      } catch (_) {
        if (actual) {
          _actualBasisInvalid = true;
        } else {
          _homeBasisInvalid = true;
        }
      }
    } else if (widget.initialUnitPrice != null && widget.existing == null) {
      _priceIsUnitPrice = true;
      final amount = _tryParse(_price.text);
      if (amount != null) {
        _price.text = local(
          _displayUnitAmount(amount, _unit, _unit).toInputString(),
        );
      }
    }
    if (widget.initialActualPrice != null) {
      _actualPriceIsUnitPrice = true;
      final amount = _tryParse(local(widget.initialActualPrice!));
      _actualPrice.text = amount == null
          ? local(widget.initialActualPrice!)
          : local(
              _displayUnitAmount(
                amount,
                _actualUnit,
                _actualUnit,
              ).toInputString(),
            );
      _actualChanged = true;
    }
    if (widget.initialActualCandidate != null) {
      _applyPhoto(widget.initialActualCandidate!);
    }
    if (widget.focusActual) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final bothEmpty =
            _price.text.trim().isEmpty && _actualPrice.text.trim().isEmpty;
        (bothEmpty || _mixedUnits ? _homePriceFocus : _marketPriceFocus)
            .requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _detailsController.dispose();
    _name.dispose();
    _brand.dispose();
    _quantity.dispose();
    _price.dispose();
    _homePriceFocus.dispose();
    _marketPriceFocus.dispose();
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
    if (_homeBasisInvalid ||
        _homeMeaningRequired ||
        priceState == false ||
        price != null && price.isNegative) {
      setState(() => _priceError = l10n.invalidPriceError);
      return;
    }

    final actualPrice = _tryParse(_actualPrice.text);
    if (_photoCurrencyMismatch ||
        _actualBasisInvalid ||
        _actualMeaningRequired ||
        _actualChanged &&
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
          priceUnitCode: _priceIsUnitPrice
              ? PriceInput.displayUnit(_unit).dbCode
              : null,
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
          final actualQuantity = _actualQuantity;
          if (actualQuantity == null || !actualQuantity.isPositive) {
            throw const FormatException('Invalid actual quantity');
          }
          int? grossMinor;
          DecimalFixed? canonicalUnit;
          var discount = 0;
          if (actualPrice != null) {
            if (_actualPriceIsUnitPrice) {
              grossMinor = PriceInput.total(
                amount: actualPrice,
                quantity: actualQuantity,
                quantityUnit: _actualUnit,
                isUnitPrice: true,
                priceUnit: PriceInput.displayUnit(_actualUnit),
              ).toMinorUnits(digits);
              discount = _existingDiscountMinor.clamp(0, grossMinor);
              canonicalUnit = PriceInput.total(
                amount: actualPrice,
                quantity: DecimalFixed.fromInt(1),
                quantityUnit: _actualUnit,
                isUnitPrice: true,
                priceUnit: PriceInput.displayUnit(_actualUnit),
              );
            } else {
              // The amount the customer pays already includes any receipt discount.
              discount = _existingDiscountMinor;
              grossMinor = actualPrice.toMinorUnits(digits) + discount;
            }
          }
          await ShoppingRepository(_db).recordPurchase(
            listId: widget.listId,
            plannedItemId: id,
            name: name,
            normalizedName: normalizeName(name),
            quantity: actualQuantity,
            unitCode: _actualUnit.dbCode,
            unitPrice: canonicalUnit,
            lineTotalMinor: grossMinor,
            discountMinor: discount,
            pricingInputMode: _actualPriceIsUnitPrice
                ? 'unitPrice'
                : 'lineTotal',
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

  UnitCode get _actualUnit =>
      !_quantityChanged && widget.entries.isNotEmpty && !_mixedUnits
      ? UnitCode.values.firstWhere(
          (u) =>
              u.dbCode == widget.entries.first.actualUnitCode ||
              u.name == widget.entries.first.actualUnitCode,
        )
      : _unit;

  DecimalFixed? get _actualQuantity =>
      !_quantityChanged && widget.entries.isNotEmpty && !_mixedUnits
      ? widget.entries.fold<DecimalFixed>(
          DecimalFixed.zero(),
          (sum, e) => sum + DecimalFixed.parse(e.actualQuantity),
        )
      : _tryParse(_quantity.text);

  DecimalFixed _displayUnitAmount(
    DecimalFixed amount,
    UnitCode sourceBasis,
    UnitCode quantityUnit,
  ) => PriceInput.total(
    amount: amount,
    quantity: DecimalFixed.fromInt(1),
    quantityUnit: PriceInput.displayUnit(quantityUnit),
    isUnitPrice: true,
    priceUnit: sourceBasis,
  );

  void _quantityOrUnitChanged({
    UnitCode? oldHomeBasis,
    UnitCode? oldActualBasis,
  }) {
    oldHomeBasis ??= PriceInput.displayUnit(_unit);
    oldActualBasis ??= PriceInput.displayUnit(_actualUnit);
    _quantityChanged = true;
    void convert(
      TextEditingController field,
      bool isUnit,
      UnitCode oldBasis,
      UnitCode nextBasis,
      bool actual,
    ) {
      final amount = _tryParse(field.text);
      if (!isUnit || amount == null || oldBasis == nextBasis) return;
      try {
        field.text = _displayUnitAmount(
          amount,
          oldBasis,
          nextBasis,
        ).toInputString().replaceAll('.', _separators.decimal);
      } catch (_) {
        if (actual) {
          _actualBasisInvalid = true;
        } else {
          _homeBasisInvalid = true;
        }
      }
    }

    convert(
      _price,
      _priceIsUnitPrice,
      oldHomeBasis,
      PriceInput.displayUnit(_unit),
      false,
    );
    convert(
      _actualPrice,
      _actualPriceIsUnitPrice,
      oldActualBasis,
      PriceInput.displayUnit(_actualUnit),
      true,
    );
    if (_actualPrice.text.trim().isNotEmpty) _actualChanged = true;
    setState(() {});
  }

  void _switchPriceMode(bool actual, bool isUnit) {
    final controller = actual ? _actualPrice : _price;
    final oldMode = actual ? _actualPriceIsUnitPrice : _priceIsUnitPrice;
    final amount = _tryParse(controller.text);
    final quantity = actual ? _actualQuantity : _tryParse(_quantity.text);
    final unit = actual ? _actualUnit : _unit;
    final confirming = actual && _pendingActualPrice != null;
    if (confirming) {
      controller.text = _pendingActualPrice!.toInputString().replaceAll(
        '.',
        _separators.decimal,
      );
      _pendingActualPrice = null;
    }
    if (!confirming && amount != null && oldMode != isUnit) {
      if (quantity == null || !quantity.isPositive) {
        setState(() => _quantityError = _l10n.invalidQuantityError);
        return;
      }
      final discount = actual
          ? DecimalFixed.fromMinorUnits(
              _existingDiscountMinor,
              Currency.fromCode(_currencyCode).minorUnitDigits,
            )
          : DecimalFixed.zero();
      final converted = isUnit
          ? PriceInput.unitFromTotal(
              amount: amount + discount,
              quantity: quantity,
              quantityUnit: unit,
              priceUnit: PriceInput.displayUnit(unit),
            )
          : PriceInput.total(
                  amount: amount,
                  quantity: quantity,
                  quantityUnit: unit,
                  isUnitPrice: true,
                  priceUnit: PriceInput.displayUnit(unit),
                ) -
                discount;
      controller.text = (converted.isNegative ? DecimalFixed.zero() : converted)
          .toInputString()
          .replaceAll('.', _separators.decimal);
    }
    setState(() {
      if (actual) {
        _actualPriceIsUnitPrice = isUnit;
        _actualChanged = true;
        _actualMeaningRequired = false;
        _actualBasisInvalid = false;
        _actualError = null;
      } else {
        _priceIsUnitPrice = isUnit;
        _homeMeaningRequired = false;
        _homeBasisInvalid = false;
        _priceError = null;
      }
    });
  }

  String? _calculatedHint(bool actual) {
    final amount = _tryParse((actual ? _actualPrice : _price).text);
    final quantity = actual ? _actualQuantity : _tryParse(_quantity.text);
    if (amount == null ||
        quantity == null ||
        !quantity.isPositive ||
        amount.isNegative) {
      return null;
    }
    try {
      final unit = actual ? _actualUnit : _unit;
      final isUnit = actual ? _actualPriceIsUnitPrice : _priceIsUnitPrice;
      final currency = Currency.fromCode(_currencyCode);
      final discount = actual
          ? DecimalFixed.fromMinorUnits(
              _existingDiscountMinor,
              currency.minorUnitDigits,
            )
          : DecimalFixed.zero();
      final value = isUnit
          ? PriceInput.total(
                  amount: amount,
                  quantity: quantity,
                  quantityUnit: unit,
                  isUnitPrice: true,
                  priceUnit: PriceInput.displayUnit(unit),
                ) -
                discount
          : PriceInput.unitFromTotal(
              amount: amount + discount,
              quantity: quantity,
              quantityUnit: unit,
              priceUnit: PriceInput.displayUnit(unit),
            );
      final money = formatMoney(
        Money.fromMinorUnits(
          (value.isNegative ? DecimalFixed.zero() : value).toMinorUnits(
            currency.minorUnitDigits,
          ),
          currency,
        ),
        locale: formatLocaleCode(context),
      );
      return isUnit
          ? _l10n.lineTotalCalculated(money)
          : _l10n.unitPriceCalculated(
              '$money / ${unitDisplayName(PriceInput.displayUnit(unit), _l10n)}',
            );
    } catch (_) {
      return null;
    }
  }

  Widget _priceModeField(bool actual) {
    final required = actual ? _actualMeaningRequired : _homeMeaningRequired;
    final mode = actual ? _actualPriceIsUnitPrice : _priceIsUnitPrice;
    return KeyedSubtree(
      key: ValueKey('mode_${actual}_${mode}_$required'),
      child: DropdownButtonFormField<bool>(
        key: Key(actual ? 'item_actual_price_mode' : 'item_price_mode'),
        initialValue: required ? null : mode,
        isExpanded: true,
        decoration: InputDecoration(labelText: _l10n.pricingModeLabel),
        items: [
          DropdownMenuItem(
            value: false,
            child: Text(_l10n.pricingModeLineTotal),
          ),
          DropdownMenuItem(
            value: true,
            child: Text(
              '${_l10n.pricingModeUnitPrice} / ${unitDisplayName(PriceInput.displayUnit(actual ? _actualUnit : _unit), _l10n)}',
            ),
          ),
        ],
        onChanged: _saving || actual && _mixedUnits
            ? null
            : (value) {
                if (value != null) _switchPriceMode(actual, value);
              },
      ),
    );
  }

  void _applyCandidate(ParsedItemCandidate candidate) {
    _name.text = candidate.name;
    if (candidate.quantity != null) {
      _quantity.text = candidate.quantity!.toInputString();
    }
    if (candidate.unitCode != null) {
      _unit = candidate.unitCode!;
    }
    if (candidate.unitPrice != null) {
      final actual = candidate.priceDestination == VoicePriceDestination.actual;
      (actual ? _actualPrice : _price).text = candidate.unitPrice!
          .toInputString();
      if (actual) {
        _actualPriceIsUnitPrice = candidate.isUnitPrice == true;
        _actualChanged = true;
        _actualMeaningRequired = candidate.requiresPriceConfirmation;
      } else {
        _priceIsUnitPrice = candidate.isUnitPrice == true;
        _homeMeaningRequired = candidate.requiresPriceConfirmation;
      }
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
    if (c.currencyCode != _currencyCode) {
      _photoCurrencyMismatch = true;
      _actualError = _l10n.invalidAmountError;
      return;
    }
    try {
      final quantity = _actualQuantity;
      if (quantity == null || !quantity.isPositive) {
        throw const FormatException('Missing quantity');
      }
      if (c.priceQuantity != null && c.unitCode == null) {
        throw const FormatException('Missing package unit');
      }
      if (!c.isUnitPrice &&
          c.priceQuantity == null &&
          c.unitCode == null &&
          quantity.compareTo(DecimalFixed.fromInt(1)) != 0) {
        _pendingActualPrice = c.value;
        _actualMeaningRequired = true;
        _actualError = _l10n.pricingModeLabel;
        return;
      }
      final amount = c.priceQuantity != null
          ? _displayUnitAmount(
              c.value.divide(c.priceQuantity!, scale: DecimalFixed.maxFractionDigits),
              c.unitCode!,
              _actualUnit,
            )
          : c.isUnitPrice
          ? _displayUnitAmount(c.value, c.unitCode ?? _actualUnit, _actualUnit)
          : c.value;
      _actualPriceIsUnitPrice = c.isUnitPrice || c.priceQuantity != null;
      _pendingActualPrice = null;
      _actualPrice.text = amount.toInputString().replaceAll(
        '.',
        _separators.decimal,
      );
      _photoCurrencyMismatch = false;
      _actualBasisInvalid = false;
      _actualMeaningRequired = false;
      _actualError = null;
      _actualChanged = true;
      if (c.productName != null && c.productName!.isNotEmpty) {
        _name.text = c.productName!;
      }
    } catch (_) {
      _actualBasisInvalid = true;
      _actualError = _l10n.invalidAmountError;
    }
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
                        final oldHome = PriceInput.displayUnit(_unit);
                        final oldActual = PriceInput.displayUnit(_actualUnit);
                        _unit = v ?? _unit;
                        _quantityOrUnitChanged(
                          oldHomeBasis: oldHome,
                          oldActualBasis: oldActual,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _priceModeField(false),
            const SizedBox(height: 8),
            TextField(
              key: const Key('item_price_field'),
              controller: _price,
              focusNode: _homePriceFocus,
              onChanged: (_) => setState(() {
                _homeBasisInvalid = false;
              }),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: _priceIsUnitPrice
                    ? '${l10n.compareEstimated} / ${unitDisplayName(PriceInput.displayUnit(_unit), l10n)}'
                    : l10n.compareEstimated,
                errorText: _priceError,
                helperText: _calculatedHint(false),
              ),
            ),
            const SizedBox(height: 12),
            _priceModeField(true),
            const SizedBox(height: 8),
            TextField(
              key: const Key('item_actual_price_field'),
              controller: _actualPrice,
              focusNode: _marketPriceFocus,
              enabled: !_mixedUnits,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: _actualPriceIsUnitPrice
                    ? '${l10n.compareActual} / ${unitDisplayName(PriceInput.displayUnit(_actualUnit), l10n)}'
                    : l10n.compareActual,
                errorText: _actualError,
                helperText: _mixedUnits
                    ? l10n.purchaseAnalyticsHint
                    : _calculatedHint(true),
                suffixIcon:
                    widget.onShelfCandidatePressed == null || _mixedUnits
                    ? null
                    : IconButton(
                        key: const Key('item_scan_actual_price'),
                        tooltip: l10n.tipShelfCamera,
                        icon: const Icon(Icons.photo_camera_outlined),
                        onPressed: _scanActualPrice,
                      ),
              ),
              onChanged: (_) {
                setState(() {
                  _actualChanged = true;
                  _photoCurrencyMismatch = false;
                  _actualBasisInvalid = false;
                  _actualMeaningRequired = false;
                  _pendingActualPrice = null;
                  _actualError = null;
                });
              },
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
  String toInputString() {
    final value = toDbString();
    if (!value.contains('.')) return value;
    return value
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }

  bool equals(DecimalFixed other) => compareTo(other) == 0;
}
