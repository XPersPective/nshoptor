import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/money/money.dart';

void main() {
  group('Currency', () {
    test('minor basamakları ISO 4217 ile uyumludur', () {
      expect(Currency.fromCode('JPY').minorUnitDigits, 0);
      expect(Currency.fromCode('TRY').minorUnitDigits, 2);
      expect(Currency.fromCode('KWD').minorUnitDigits, 3);
    });

    test('bilinmeyen kod reddedilir', () {
      expect(() => Currency.fromCode('XXX'), throwsArgumentError);
      expect(() => Currency.fromCode('tl'), throwsArgumentError);
      expect(Currency.isKnownCode('try'), isTrue);
    });

    test('belirsiz sembolde ISO kodu gösterilir', () {
      expect(Currency.fromCode('TRY').displaySymbol, '₺');
      expect(Currency.fromCode('EUR').displaySymbol, '€');
      expect(Currency.fromCode('USD').displaySymbol, 'USD');
      expect(Currency.fromCode('JPY').displaySymbol, 'JPY');
    });

    test('eşitlik koda göreimidir', () {
      expect(Currency.fromCode('TRY'), Currency.try_);
      expect(Currency.all.map((c) => c.code), everyElement(isNotEmpty));
    });
  });

  group('Money aritmetiği', () {
    final tl = Currency.fromCode('TRY');
    final usd = Currency.fromCode('USD');

    test('aynı para biriminde toplama ve çıkarma', () {
      final a = Money.fromMinorUnits(6435, tl);
      final b = Money.fromMinorUnits(5997, tl);
      expect((a + b).minorUnits, 12432);
      expect((a - b).minorUnits, 438);
      expect(-a.minorUnits, -6435);
    });

    test('farklı para birimi aritmetiği ArgumentError verir', () {
      final a = Money.fromMinorUnits(100, tl);
      final b = Money.fromMinorUnits(100, usd);
      expect(() => a + b, throwsArgumentError);
      expect(() => a - b, throwsArgumentError);
    });

    test('farklı para birimi karşılaştırması reddedilir', () {
      final a = Money.fromMinorUnits(100, tl);
      final b = Money.fromMinorUnits(100, usd);
      expect(() => a < b, throwsArgumentError);
      expect(() => a.compareTo(b), throwsArgumentError);
    });

    test('aynı para biriminde karşılaştırma çalışır', () {
      final a = Money.fromMinorUnits(100, tl);
      final b = Money.fromMinorUnits(250, tl);
      expect(a < b, isTrue);
      expect(a >= Money.fromMinorUnits(100, tl), isTrue);
    });

    test('fromDecimal tek yuvarlama noktasıdır', () {
      // 1,5 kg × 42,90 TRY = 64,35 TRY
      final line = DecimalFixed.parse('1.5') * DecimalFixed.parse('42.90');
      final money = Money.fromDecimal(line, tl);
      expect(money.minorUnits, 6435);
      // 3 adet × 19,99 TRY = 59,97 TRY
      final line2 = DecimalFixed.parse('3') * DecimalFixed.parse('19.99');
      expect(Money.fromDecimal(line2, tl).minorUnits, 5997);
    });

    test('toDecimal geri dönüşümü minor basamakta kararlıdır', () {
      final m = Money.fromMinorUnits(12345, tl);
      expect(m.toDecimal().toDbString(), '123.45');
    });

    test('sıfır ve işaret yardımcıları', () {
      final z = Money.zero(tl);
      expect(z.isZero, isTrue);
      expect(Money.fromMinorUnits(-1, tl).isNegative, isTrue);
      expect(Money.fromMinorUnits(-5, tl).abs().minorUnits, 5);
    });
  });
}
