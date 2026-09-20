import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/quantity/packaging.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/core/quantity/unit_conversion.dart';

void main() {
  group('UnitCode', () {
    test('db kodu gidiş-dönüşü kararlıdır', () {
      for (final u in UnitCode.values) {
        expect(UnitCode.fromDbCode(u.dbCode), u);
      }
    });

    test('bilinmeyen db kodu reddedilir', () {
      expect(() => UnitCode.fromDbCode('fincan'), throwsArgumentError);
    });

    test('boyut aileleri', () {
      expect(UnitCode.gram.dimension, UnitDimension.mass);
      expect(UnitCode.mililitre.dimension, UnitDimension.volume);
      expect(UnitCode.paket.dimension, UnitDimension.unknown);
      expect(UnitCode.adet.dimension, UnitDimension.count);
    });
  });

  group('dönüşüm', () {
    test('500 g = 0,5 kg', () {
      expect(
        UnitConversion.convert(
            DecimalFixed.parse('500'), UnitCode.gram, UnitCode.kilogram),
        DecimalFixed.parse('0.5'),
      );
    });

    test('0,5 kg = 500 g', () {
      expect(
        UnitConversion.convert(
            DecimalFixed.parse('0.5'), UnitCode.kilogram, UnitCode.gram),
        DecimalFixed.parse('500'),
      );
    });

    test('litre/mililitre', () {
      expect(
        UnitConversion.convert(DecimalFixed.parse('2.75'),
            UnitCode.litre, UnitCode.mililitre),
        DecimalFixed.parse('2750'),
      );
      expect(
        UnitConversion.convert(DecimalFixed.parse('250'),
            UnitCode.mililitre, UnitCode.litre),
        DecimalFixed.parse('0.25'),
      );
    });

    test('adet↔düzine yalnız açık istekle', () {
      expect(
        () => UnitConversion.convert(
            DecimalFixed.fromInt(2), UnitCode.adet, UnitCode.duzine),
        throwsA(isA<UnsupportedConversionError>()),
      );
      expect(
        UnitConversion.convert(DecimalFixed.fromInt(24), UnitCode.adet,
            UnitCode.duzine,
            allowCount: true),
        DecimalFixed.fromInt(2),
      );
      expect(
        UnitConversion.convert(DecimalFixed.fromInt(3), UnitCode.duzine,
            UnitCode.adet,
            allowCount: true)
            .toDbString(),
        '36',
      );
    });

    test('paket↔kg gibi içerik bilinmeyen dönüşüm reddedilir', () {
      expect(
        () => UnitConversion.convert(
            DecimalFixed.fromInt(2), UnitCode.paket, UnitCode.kilogram),
        throwsA(isA<UnsupportedConversionError>()),
      );
      expect(
        () => UnitConversion.convert(
            DecimalFixed.fromInt(1), UnitCode.sise, UnitCode.adet),
        throwsA(isA<UnsupportedConversionError>()),
      );
      // Farklı aileler de reddedilir.
      expect(
        () => UnitConversion.convert(
            DecimalFixed.fromInt(1), UnitCode.kilogram, UnitCode.litre),
        throwsA(isA<UnsupportedConversionError>()),
      );
    });

    test('tryConvertToBase: karşılaştırılamayan birim null verir', () {
      expect(
        UnitConversion.tryConvertToBase(
            DecimalFixed.fromInt(3), UnitCode.paket),
        isNull,
      );
      expect(
        UnitConversion.tryConvertToBase(
            DecimalFixed.parse('750'), UnitCode.gram),
        DecimalFixed.parse('0.75'),
      );
      expect(
        UnitConversion.tryConvertToBase(
            DecimalFixed.fromInt(2), UnitCode.duzine),
        isNull,
      );
      expect(
        UnitConversion.tryConvertToBase(
            DecimalFixed.fromInt(2), UnitCode.duzine,
            allowCount: true),
        DecimalFixed.parse('24'),
      );
    });
  });

  group('PackagingContent', () {
    test('1 paket = 500 g tanımı içerik dönüşümü yapar', () {
      final content = PackagingContent(
        unit: UnitCode.paket,
        contentQuantity: DecimalFixed.parse('500'),
        contentUnit: UnitCode.gram,
      );
      expect(
        content.toContent(DecimalFixed.fromInt(3)),
        DecimalFixed.parse('1500'),
      );
      expect(
        content.toContent(DecimalFixed.parse('1.5')),
        DecimalFixed.parse('750'),
      );
    });

    test('geçersiz tanım StateError verir', () {
      final bad = PackagingContent(
        unit: UnitCode.paket,
        contentQuantity: DecimalFixed.parse('500'),
        contentUnit: UnitCode.kutu,
      );
      expect(bad.isValid, isFalse);
      expect(() => bad.toContent(DecimalFixed.fromInt(1)), throwsStateError);
    });

    test('negatif içerik tanımı kurulamaz', () {
      expect(
        () => PackagingContent(
          unit: UnitCode.kutu,
          contentQuantity: DecimalFixed.parse('-1'),
          contentUnit: UnitCode.kilogram,
        ),
        throwsArgumentError,
      );
    });
  });
}
