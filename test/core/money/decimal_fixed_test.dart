import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/decimal_fixed.dart';

void main() {
  group('parse', () {
    test('kanonik ondalık ayracı ile ayrıştırır', () {
      expect(DecimalFixed.parse('1.5').toDbString(), '1.5');
      expect(DecimalFixed.parse('42.90').toDbString(), '42.90');
      expect(DecimalFixed.parse('-3.25').toDbString(), '-3.25');
      expect(DecimalFixed.parse('1234').toDbString(), '1234');
    });

    test('boş ve geçersiz girdiyi reddeder', () {
      expect(() => DecimalFixed.parse(''), throwsFormatException);
      expect(() => DecimalFixed.parse('   '), throwsFormatException);
      expect(() => DecimalFixed.parse('abc'), throwsFormatException);
      expect(() => DecimalFixed.parse('1,5'), throwsFormatException);
      expect(() => DecimalFixed.parse('1.'), throwsFormatException);
      expect(() => DecimalFixed.parse('.5'), throwsFormatException);
      expect(() => DecimalFixed.parse('1.2.3'), throwsFormatException);
      expect(() => DecimalFixed.parse('--1'), throwsFormatException);
    });

    test('aşırı büyük değer reddedilir', () {
      expect(() => DecimalFixed.parse('12345678901234567'), throwsFormatException);
      expect(DecimalFixed.parse('123456789012345').isPositive, isTrue);
    });

    test('ondalık basamak sınırı aşılamaz', () {
      expect(() => DecimalFixed.parse('1.1234567'), throwsFormatException);
      expect(DecimalFixed.parse('1.123456').toDbString(), '1.123456');
    });
  });

  group('aritmetik', () {
    test('toplama ve çıkarma ölçekleri hizalar', () {
      final a = DecimalFixed.parse('1.5');
      final b = DecimalFixed.parse('2.25');
      expect((a + b).toDbString(), '3.75');
      expect((b - a).toDbString(), '0.75');
      expect((a - b).toDbString(), '-0.75');
    });

    test('tam çarpım ara yuvarlama yapmaz', () {
      // 1,5 × 42,90 = 64,35
      expect(
        (DecimalFixed.parse('1.5') * DecimalFixed.parse('42.90'))
            .toDbString(),
        '64.350',
      );
      // 3 × 19,99 = 59,97
      expect(DecimalFixed.parse('3') * DecimalFixed.parse('19.99'),
          DecimalFixed.parse('59.97'));
    });

    test('bölme yarıdan uzağa yuvarlar', () {
      expect(
        DecimalFixed.parse('10').divide(DecimalFixed.parse('3'), scale: 2)
            .toDbString(),
        '3.33',
      );
      expect(
        DecimalFixed.parse('1').divide(DecimalFixed.parse('8'), scale: 2)
            .toDbString(),
        '0.13',
      );
      expect(
        DecimalFixed.parse('-1').divide(DecimalFixed.parse('8'), scale: 2)
            .toDbString(),
        '-0.13',
      );
      expect(
        () => DecimalFixed.parse('1').divide(DecimalFixed.zero(), scale: 2),
        throwsArgumentError,
      );
    });

    test('rescale yarıdan uzağa yuvarlar', () {
      expect(DecimalFixed.parse('2.5').rescale(0).toDbString(), '3');
      expect(DecimalFixed.parse('-2.5').rescale(0).toDbString(), '-3');
      expect(DecimalFixed.parse('0.125').rescale(2).toDbString(), '0.13');
      expect(DecimalFixed.parse('1.5').rescale(4).toDbString(), '1.5000');
    });
  });

  group('karşılaştırma', () {
    test('farklı ölçekler doğru karşılaştırılır', () {
      expect(DecimalFixed.parse('1.5'), DecimalFixed.parse('1.50'));
      expect(DecimalFixed.parse('1.5') > DecimalFixed.parse('1.45'), isTrue);
      expect(DecimalFixed.parse('0.001') < DecimalFixed.parse('0.01'), isTrue);
    });
  });

  group('minor units dönüşümü', () {
    test('native signed boundaries round-trip; overflowing products never clamp', () {
      const max = 9223372036854775807, min = -9223372036854775808;
      for (final value in [max, min]) {
        for (final digits in [0, 2, 3]) {
          expect(DecimalFixed.fromMinorUnits(value, digits).toMinorUnits(digits), value);
        }
      }
      final positive = DecimalFixed.fromMinorUnits(max, 0) + DecimalFixed.fromInt(1);
      final negative = DecimalFixed.fromMinorUnits(min, 0) - DecimalFixed.fromInt(1);
      expect(() => positive.toMinorUnits(0), throwsFormatException);
      expect(() => negative.toMinorUnits(0), throwsFormatException);
      final product = DecimalFixed.parse('999999999999999') * DecimalFixed.parse('999999999999999');
      expect(() => product.toMinorUnits(2), throwsFormatException);
      expect(() => product.negated().toMinorUnits(2), throwsFormatException);
    });
    test('toMinorUnits yarıdan uzağa yuvarlar', () {
      expect(DecimalFixed.parse('64.35').toMinorUnits(2), 6435);
      expect(DecimalFixed.parse('64.355').toMinorUnits(2), 6436);
      expect(DecimalFixed.parse('-64.355').toMinorUnits(2), -6436);
      expect(DecimalFixed.parse('1234').toMinorUnits(0), 1234);
      expect(DecimalFixed.parse('1.2345').toMinorUnits(3), 1235);
    });

    test('fromMinorUnits geri dönüşümü kayıpsızdır', () {
      final v = DecimalFixed.parse('64.35');
      expect(
        DecimalFixed.fromMinorUnits(v.toMinorUnits(2), 2),
        v,
      );
    });

    test('round-trip veritabanı dizgesiyle kararlıdır', () {
      const stored = '-0.250';
      expect(
        DecimalFixed.parse(stored).toDbString(),
        stored,
      );
    });
  });
}
