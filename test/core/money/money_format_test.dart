import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/money/money.dart';
import 'package:nshoptor/core/money/money_format.dart';

void main() {
  group('formatMoney', () {
    test('TRY tr locale: sonek sembol, tr ayraçlar', () {
      final m = Money.fromMinorUnits(123456, Currency.try_);
      expect(formatMoney(m, locale: 'tr'), '1.234,56 ₺');
    });

    test('TRY en locale: önek sembol, en ayraçlar', () {
      final m = Money.fromMinorUnits(123456, Currency.try_);
      expect(formatMoney(m, locale: 'en'), '₺1,234.56');
    });

    test('JPY 0 basamak gösterir', () {
      final m = Money.fromMinorUnits(1234, Currency.jpy);
      expect(formatMoney(m, locale: 'tr'), '1.234 JPY');
      expect(formatMoney(m, locale: 'en'), 'JPY 1,234');
    });

    test('KWD 3 basamak gösterir', () {
      final m = Money.fromMinorUnits(1234, Currency.kwd);
      expect(formatMoney(m, locale: 'tr'), '1,234 KWD');
    });

    test('negatif değer - önekiyle gösterilir', () {
      final m = Money.fromMinorUnits(-123456, Currency.try_);
      expect(formatMoney(m, locale: 'tr'), '-1.234,56 ₺');
    });

    test('sıfır değer', () {
      expect(formatMoney(Money.zero(Currency.try_), locale: 'tr'), '0,00 ₺');
    });

    test('binlik ayraçlı büyük değerler', () {
      final m = Money.fromMinorUnits(123456789, Currency.try_);
      expect(formatMoney(m, locale: 'tr'), '1.234.567,89 ₺');
    });
  });
}
