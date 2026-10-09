import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/features/receipts/shelf_label/price_candidates.dart';

OcrLine line(String text, {double top = 0}) =>
    OcrLine(text: text, boundingBoxTop: top);

void main() {
  test('KWD three-digit decimal and explicitly free price remain exact candidates', () {
    expect(ShelfPriceExtractor(defaultCurrency: 'KWD').extract([line('1.234 KWD')]).single.value.toDbString(), '1.234');
    expect(ShelfPriceExtractor().extract([line('0,00 TL')]).single.value.isZero, isTrue);
  });

  late ShelfPriceExtractor extractor;

  setUp(() => extractor = ShelfPriceExtractor());

  test('ana fiyat: para birimi + virgüllü değer high güven alır', () {
    final candidates = extractor.extract([
      line('SÜT 1 LT'),
      line('₺42,90'),
    ]);
    expect(candidates, hasLength(1));
    expect(candidates.single.value.toDbString(), '42.90');
    expect(candidates.single.confidence, 'high');
    expect(candidates.single.currencyCode, 'TRY');
    expect(candidates.single.isUnitPrice, isFalse);
    expect(candidates.single.productName, 'SÜT 1 LT'); expect(candidates.single.unitCode, UnitCode.adet);
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

  test('eski fiyat ve yeni fiyat birlikte adaydır; en büyük sayı SEÇİLMEZ',
      () {
    // Etikette eski fiyat 49,90 üstte, kampanyalı 29,90 altta olsun.
    final candidates = extractor.extract([
      line('49,90 ₺', top: 0),
      line('29,90 ₺', top: 10),
    ]);
    expect(candidates.map((c) => c.value.toDbString()).toList(),
        ['49.90', '29.90']); // her ikisi aday; konum sırası korunur
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
}
