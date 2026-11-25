import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/features/receipts/shelf_label/price_candidates.dart';

OcrLine line(String text, {double top = 0}) =>
    OcrLine(text: text, boundingBoxTop: top);

OcrLine box(
  String text, {
  required double top,
  required double left,
  double height = 10,
  double width = 60,
  double scale = 1,
}) => OcrLine(
  text: text,
  boundingBoxTop: top * scale,
  boundingBoxLeft: left * scale,
  boundingBoxHeight: height * scale,
  boundingBoxWidth: width * scale,
);

void main() {
  test('whole numeric tokens are never truncated into invented prices', () {
    expect(
      ShelfPriceExtractor()
          .extract([line('1.234 TL')])
          .single
          .value
          .toDbString(),
      '1234',
    );
    expect(ShelfPriceExtractor().extract([line('12.3456 TL')]), isEmpty);
    expect(ShelfPriceExtractor().extract([line('12,3456 TL')]), isEmpty);
    expect(ShelfPriceExtractor().extract([line('1.23.45 TL')]), isEmpty);
  });
  test('merged OCR line keeps each amount associated with its own basis', () {
    final split = ShelfPriceExtractor().extract([
      line('KIYMA'),
      line('400 G 350,00 TL'),
    ]).single;
    expect(split.priceQuantity!.toDbString(), '400');
    expect(split.unitCode, UnitCode.gram);
    final c = ShelfPriceExtractor().extract([
      line('KIYMA 400 g'),
      line('350,00 TL 875,00 TL/kg'),
    ]);
    expect(c, hasLength(2));
    expect(c.first.isUnitPrice, isFalse);
    expect(c.first.priceQuantity!.toDbString(), '400');
    expect(c.last.isUnitPrice, isTrue);
    expect(c.last.unitCode, UnitCode.kilogram);
    expect(c.last.priceQuantity, isNull);
    final quotes = ShelfPriceExtractor().extract([
      line('350,00 TL/400g 875,00 TL/kg'),
    ]);
    expect(quotes.first.priceQuantity!.toDbString(), '400');
    expect(quotes.last.priceQuantity, isNull);
  });
  test(
    'package weight is price basis, not money; explicit basis scales safely',
    () {
      final c = ShelfPriceExtractor().extract([
        line('KIYMA 400 G'),
        line('350,00 TL'),
      ]).single;
      expect(c.value.toDbString(), '350.00');
      expect(c.priceQuantity!.toDbString(), '400');
      expect(c.unitCode, UnitCode.gram);
      expect(c.isUnitPrice, isFalse);
      final explicit = ShelfPriceExtractor().extract([
        line('350 TL / 400 g'),
      ]).single;
      expect(explicit.priceQuantity!.toDbString(), '400');
      expect(explicit.unitCode, UnitCode.gram);
      expect(explicit.isUnitPrice, isTrue);
      expect(
        ShelfPriceExtractor().extract([line('0,4 KG'), line('8691234567890')]),
        isEmpty,
      );
    },
  );
  test(
    'KWD three-digit decimal and explicitly free price remain exact candidates',
    () {
      expect(
        ShelfPriceExtractor(defaultCurrency: 'KWD')
            .extract([line('1٫234 KWD')])
            .single
            .value
            .toDbString(),
        '1.234',
      );
      expect(
        ShelfPriceExtractor().extract([line('0,00 TL')]).single.value.isZero,
        isTrue,
      );
    },
  );

  late ShelfPriceExtractor extractor;

  setUp(() => extractor = ShelfPriceExtractor());

  test('ana fiyat: para birimi + virgüllü değer high güven alır', () {
    final candidates = extractor.extract([line('SÜT 1 LT'), line('₺42,90')]);
    expect(candidates, hasLength(1));
    expect(candidates.single.value.toDbString(), '42.90');
    expect(candidates.single.confidence, 'high');
    expect(candidates.single.currencyCode, 'TRY');
    expect(candidates.single.isUnitPrice, isFalse);
    expect(candidates.single.productName, 'SÜT 1 LT');
    expect(candidates.single.unitCode, UnitCode.litre);
    expect(candidates.single.priceQuantity!.toDbString(), '1');
  });

  test('birim fiyat kalıbı işaretlenir (/kg)', () {
    final candidates = extractor.extract([
      line('KILOSYSTEM'),
      line('1.234,56 ₺/kg'),
    ]);
    expect(candidates, hasLength(1));
    expect(candidates.single.isUnitPrice, isTrue);
    expect(candidates.single.unitCode, UnitCode.kilogram);
    expect(candidates.single.value.toDbString(), '1234.56');
  });

  test('eski fiyat ve yeni fiyat birlikte adaydır; en büyük sayı SEÇİLMEZ', () {
    // Etikette eski fiyat 49,90 üstte, kampanyalı 29,90 altta olsun.
    final candidates = extractor.extract([
      line('49,90 ₺', top: 0),
      line('29,90 ₺', top: 10),
    ]);
    expect(candidates.map((c) => c.value.toDbString()).toList(), [
      '49.90',
      '29.90',
    ]); // her ikisi aday; konum sırası korunur
  });

  test('nokta/virgül binlik ayracı doğru ayrıştırılır', () {
    final candidates = extractor.extract([line('1.234,56 TL')]);
    expect(candidates.single.value.toDbString(), '1234.56');

    final candidates2 = extractor.extract([line('1,234.56 TL')]);
    expect(candidates2.single.value.toDbString(), '1234.56');
  });

  test('numarasız satırlar aday üretmez', () {
    expect(extractor.extract([line('MARKA'), line('1 LT SÜT')]), isEmpty);
  });

  test('yalnız sayı: düşük güven, kullanıcı doğrular', () {
    final candidates = extractor.extract([line('199')]);
    expect(candidates.single.confidence, 'low');
  });

  test(
    'nearby aligned unit labels attach consistently at every image scale',
    () {
      final cases = [
        (label: '/kg', unit: UnitCode.kilogram, quantity: null),
        (label: '/100 g', unit: UnitCode.gram, quantity: '100'),
        (label: '/L', unit: UnitCode.litre, quantity: null),
        (label: '/adet', unit: UnitCode.adet, quantity: null),
      ];

      for (final scale in [0.5, 1.0, 4.0]) {
        for (final testCase in cases) {
          final candidates = extractor.extract([
            // OCR often emits the lower unit row before the price block.
            box(testCase.label, top: 115, left: 110, width: 50, scale: scale),
            box('20,00 TL', top: 100, left: 100, width: 100, scale: scale),
          ]);

          expect(
            candidates,
            hasLength(1),
            reason: 'scale $scale ${testCase.label}',
          );
          expect(candidates.single.unitCode, testCase.unit);
          expect(candidates.single.isUnitPrice, isTrue);
          expect(
            candidates.single.priceQuantity?.toDbString(),
            testCase.quantity,
          );
        }
      }
    },
  );

  test('standalone package quantity is not a price or a unit-price label', () {
    expect(extractor.extract([line('400 g')]), isEmpty);

    final candidate = extractor.extract([
      box('400 g', top: 115, left: 105, width: 50),
      box('20,00 TL', top: 100, left: 100, width: 100),
    ]).single;
    expect(candidate.value.toDbString(), '20.00');
    expect(candidate.priceQuantity?.toDbString(), '400');
    expect(candidate.unitCode, UnitCode.gram);
    expect(candidate.isUnitPrice, isFalse);
  });

  test(
    'scrambled spatial columns attach each price to its nearest unit basis',
    () {
      final candidates = extractor.extract([
        box('/L', top: 115, left: 260, width: 35),
        box('30,00 TL', top: 100, left: 250, width: 80),
        box('20,00 TL', top: 100, left: 50, width: 80),
        box('/kg', top: 115, left: 60, width: 35),
      ]);

      expect(candidates, hasLength(2));
      expect(candidates[0].value.toDbString(), '20.00');
      expect(candidates[0].unitCode, UnitCode.kilogram);
      expect(candidates[0].isUnitPrice, isTrue);
      expect(candidates[1].value.toDbString(), '30.00');
      expect(candidates[1].unitCode, UnitCode.litre);
      expect(candidates[1].isUnitPrice, isTrue);
    },
  );

  test('equally near price columns leave a separate unit label ambiguous', () {
    final candidates = extractor.extract([
      box('20,00 TL', top: 100, left: 100, width: 40),
      box('/kg', top: 115, left: 115, width: 30),
      box('30,00 TL', top: 100, left: 120, width: 40),
    ]);

    expect(candidates, hasLength(2));
    expect(candidates.every((candidate) => candidate.unitCode == null), isTrue);
    expect(candidates.every((candidate) => !candidate.isUnitPrice), isTrue);
  });

  test('distant unit rows and rows without geometry do not infer a basis', () {
    final distant = extractor.extract([
      box('20,00 TL', top: 100, left: 100, width: 60),
      box('/kg', top: 300, left: 300, width: 40),
    ]).single;
    final unpositioned = extractor.extract([
      line('20,00 TL'),
      line('/kg'),
    ]).single;

    for (final candidate in [distant, unpositioned]) {
      expect(candidate.unitCode, isNull);
      expect(candidate.priceQuantity, isNull);
      expect(candidate.isUnitPrice, isFalse);
    }
  });

  test('an inline price basis overrides a nearby contradictory unit row', () {
    final candidate = extractor.extract([
      box('100 g', top: 115, left: 105, width: 50),
      box('20,00 TL/kg', top: 100, left: 100, width: 100),
    ]).single;

    expect(candidate.unitCode, UnitCode.kilogram);
    expect(candidate.priceQuantity, isNull);
    expect(candidate.isUnitPrice, isTrue);
  });

  test('a nearby unit label stays owned by its closest explicit-price row', () {
    final candidates = extractor.extract([
      box('20,00 TL/kg', top: 0, left: 0, width: 100, height: 30),
      box('/kg', top: 34, left: 0, width: 50, height: 12),
      box('40,00 TL', top: 70, left: 0, width: 100, height: 30),
    ]);

    expect(candidates, hasLength(2));
    final explicit = candidates.singleWhere(
      (candidate) => candidate.value == DecimalFixed.fromInt(20),
    );
    final unqualified = candidates.singleWhere(
      (candidate) => candidate.value == DecimalFixed.fromInt(40),
    );
    expect(explicit.unitCode, UnitCode.kilogram);
    expect(explicit.isUnitPrice, isTrue);
    expect(unqualified.unitCode, isNull);
    expect(unqualified.priceQuantity, isNull);
    expect(unqualified.isUnitPrice, isFalse);
  });

  test('package quantities stay with their own spatial product columns', () {
    final candidates = extractor.extract([
      box('UN 1KG', top: 0, left: 0, width: 100, height: 20),
      box('PEYNIR 400G', top: 0, left: 200, width: 100, height: 20),
      box('20,00 TL', top: 30, left: 0, width: 100, height: 32),
      box('40,00 TL', top: 30, left: 200, width: 100, height: 32),
    ]);

    expect(candidates, hasLength(2));
    final first = candidates.singleWhere(
      (candidate) => candidate.value == DecimalFixed.fromInt(20),
    );
    final second = candidates.singleWhere(
      (candidate) => candidate.value == DecimalFixed.fromInt(40),
    );
    expect(first.productName, 'UN 1KG');
    expect(first.priceQuantity, DecimalFixed.fromInt(1));
    expect(first.unitCode, UnitCode.kilogram);
    expect(first.isUnitPrice, isFalse);
    expect(second.productName, 'PEYNIR 400G');
    expect(second.priceQuantity, DecimalFixed.fromInt(400));
    expect(second.unitCode, UnitCode.gram);
    expect(second.isUnitPrice, isFalse);
  });

  test(
    'package quantities between merged OCR prices stay with each amount',
    () {
      final candidates = extractor.extract([
        line('400 g 350,00 TL 1 kg 875,00 TL'),
      ]);

      expect(candidates, hasLength(2));
      final first = candidates.singleWhere(
        (candidate) => candidate.value == DecimalFixed.fromInt(350),
      );
      final second = candidates.singleWhere(
        (candidate) => candidate.value == DecimalFixed.fromInt(875),
      );
      expect(first.priceQuantity, DecimalFixed.fromInt(400));
      expect(first.unitCode, UnitCode.gram);
      expect(first.isUnitPrice, isFalse);
      expect(second.priceQuantity, DecimalFixed.fromInt(1));
      expect(second.unitCode, UnitCode.kilogram);
      expect(second.isUnitPrice, isFalse);
    },
  );
}
