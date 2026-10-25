import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/quantity/unit_display.dart';

void main() {
  group('formatQuantityNumber', () {
    test('removes insignificant fractional zeroes and localizes the separator', () {
      expect(formatQuantityNumber(DecimalFixed.parse('1.000')), '1');
      expect(formatQuantityNumber(DecimalFixed.parse('1.250000')), '1.25');
      expect(
        formatQuantityNumber(
          DecimalFixed.parse('1.250000'),
          decimalSeparator: ',',
        ),
        '1,25',
      );
    });

    test('keeps every integer digit, including trailing zeroes', () {
      expect(formatQuantityNumber(DecimalFixed.parse('1000')), '1000');
      expect(
        formatQuantityNumber(DecimalFixed.parse('123456789012345')),
        '123456789012345',
      );
    });

    test('preserves small significant values and formats zero cleanly', () {
      expect(formatQuantityNumber(DecimalFixed.parse('0.000001')), '0.000001');
      expect(formatQuantityNumber(DecimalFixed.parse('0.000000')), '0');
    });
  });
}
