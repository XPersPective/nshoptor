import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/calc/price_input.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/core/quantity/unit_conversion.dart';

void main() {
  final d = DecimalFixed.parse;
  test('selected quantity totals are never multiplied twice', () {
    expect(
      PriceInput.total(
        amount: d('350'),
        quantity: d('400'),
        quantityUnit: UnitCode.gram,
        isUnitPrice: false,
      ),
      d('350'),
    );
    expect(
      PriceInput.total(
        amount: d('260'),
        quantity: d('2'),
        quantityUnit: UnitCode.paket,
        isUnitPrice: false,
      ),
      d('260'),
    );
    expect(
      PriceInput.unitFromTotal(
        amount: d('350'),
        quantity: d('400'),
        quantityUnit: UnitCode.gram,
        priceUnit: UnitCode.kilogram,
      ),
      d('875'),
    );
    expect(
      PriceInput.unitFromTotal(
        amount: d('260'),
        quantity: d('2'),
        quantityUnit: UnitCode.paket,
      ),
      d('130'),
    );
  });
  test('shelf price basis and explicit package size determine totals', () {
    expect(
      PriceInput.total(
        amount: d('45'),
        quantity: d('2'),
        quantityUnit: UnitCode.kilogram,
        isUnitPrice: true,
        priceUnit: UnitCode.kilogram,
      ),
      d('90'),
    );
    expect(
      PriceInput.total(
        amount: d('875'),
        quantity: d('400'),
        quantityUnit: UnitCode.gram,
        isUnitPrice: true,
        priceUnit: UnitCode.kilogram,
      ),
      d('350'),
    );
    expect(
      PriceInput.total(
        amount: d('350'),
        quantity: d('800'),
        quantityUnit: UnitCode.gram,
        isUnitPrice: true,
        priceUnit: UnitCode.gram,
        priceQuantity: d('400'),
      ),
      d('700'),
    );
    expect(
      PriceInput.total(
        amount: d('10'),
        quantity: d('500'),
        quantityUnit: UnitCode.mililitre,
        isUnitPrice: true,
        priceUnit: UnitCode.litre,
      ),
      d('5'),
    );
  });
  test('zero is known; currency rounding happens at the boundary', () {
    expect(
      PriceInput.total(
        amount: d('0'),
        quantity: d('2'),
        quantityUnit: UnitCode.adet,
        isUnitPrice: false,
      ).isZero,
      isTrue,
    );
    final amount = PriceInput.total(
      amount: d('1.235'),
      quantity: d('3'),
      quantityUnit: UnitCode.adet,
      isUnitPrice: true,
    );
    expect(amount.toMinorUnits(3), 3705);
    expect(amount.toMinorUnits(2), 371);
    expect(amount.toMinorUnits(0), 4);
  });
  test('invalid quantity, price and incompatible dimensions fail closed', () {
    expect(
      () => PriceInput.total(
        amount: d('1'),
        quantity: d('0'),
        quantityUnit: UnitCode.gram,
        isUnitPrice: false,
      ),
      throwsArgumentError,
    );
    expect(
      () => PriceInput.total(
        amount: d('-1'),
        quantity: d('1'),
        quantityUnit: UnitCode.gram,
        isUnitPrice: false,
      ),
      throwsArgumentError,
    );
    expect(
      () => PriceInput.total(
        amount: d('1'),
        quantity: d('1'),
        quantityUnit: UnitCode.gram,
        isUnitPrice: true,
        priceUnit: UnitCode.litre,
      ),
      throwsA(isA<UnsupportedConversionError>()),
    );
    expect(
      () => PriceInput.total(
        amount: d('1'),
        quantity: d('1'),
        quantityUnit: UnitCode.gram,
        isUnitPrice: true,
        priceQuantity: d('0'),
      ),
      throwsArgumentError,
    );
  });
}
