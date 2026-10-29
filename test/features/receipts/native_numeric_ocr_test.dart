import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/features/receipts/ocr_number_view.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/shelf_label/price_candidates.dart';

String native(
  String text,
  int zero, {
  bool arabicMarks = false,
  bool fullwidth = false,
}) => String.fromCharCodes(
  text.runes.map((rune) {
    if (rune >= 0x30 && rune <= 0x39) return zero + rune - 0x30;
    if (arabicMarks && rune == 0x2e) return 0x066b;
    if (arabicMarks && rune == 0x2c) return 0x066c;
    if (fullwidth && rune == 0x2e) return 0xff0e;
    if (fullwidth && rune == 0x2c) return 0xff0c;
    if (fullwidth && rune == 0x3a) return 0xff1a;
    return rune;
  }),
);

OcrScanResult scan(Iterable<String> lines) =>
    OcrScanResult(lines: lines.map((text) => OcrLine(text: text)).toList());

void main() {
  for (final token in ['1,234', '1.234']) {
    test('ambiguous KWD $token never gains a guessed monetary value', () {
      final original = [
        'STORE: Market',
        'DATE: 29.10.2026',
        'TIME: 18:41',
        'RECEIPT NO: 123',
        'ITEM $token',
        'TOTAL $token KWD',
      ];
      final doc = ReceiptDocument.fromScan(scan(original), currencyCode: 'KWD');
      expect(doc.metadata.totalMinor, isNull);
      expect(doc.productLines, isEmpty);
      expect(doc.state, isNot(ReceiptDocumentState.complete));
      expect(ReceiptDocument.decode(doc.encode()).metadata.totalMinor, isNull);
      expect(
        ShelfPriceExtractor(defaultCurrency: 'KWD')
            .extract([OcrLine(text: '$token KWD')]),
        isEmpty,
      );
      expect(doc.fragments.single.lines.map((l) => l.text), original);
    });
  }
  test('explicit Arabic KWD decimal remains exact through replay', () {
    final doc = ReceiptDocument.fromScan(
      scan([
        'STORE: Market',
        'DATE: 29.10.2026',
        'TIME: 18:41',
        'RECEIPT NO: 123',
        'ITEM ١٫٢٣٤',
        'TOTAL ١٫٢٣٤ KWD',
      ]),
      currencyCode: 'KWD',
    );
    expect(doc.metadata.totalMinor, 1234);
    expect(doc.productLines.single.lineTotalMinor, 1234);
    expect(
      ReceiptDocument.decode(doc.encode()).toParseResult().totalMinor,
      1234,
    );
    expect(
      ShelfPriceExtractor(defaultCurrency: 'KWD')
          .extract([OcrLine(text: '١٫٢٣٤ KWD')])
          .single
          .value
          .toMinorUnits(3),
      1234,
    );
  });
  for (final (name, zero, marks, wide) in [
    ('Arabic', 0x660, true, false),
    ('Persian', 0x6f0, true, false),
    ('Bengali', 0x9e6, false, false),
    ('Devanagari', 0x966, false, false),
    ('Myanmar', 0x1040, false, false),
    ('fullwidth', 0xff10, false, true),
    ('Osmanya supplementary', 0x104a0, false, false),
  ]) {
    String shape(String text) =>
        native(text, zero, arabicMarks: marks, fullwidth: wide);
    test(
      '$name receipt amounts, quantities, date and evidence survive replay',
      () {
        final original = [
          'STORE: Example Market',
          shape('DATE: 29.10.2026'),
          shape('TIME: 18:41:35'),
          shape('RECEIPT NO: 000123'),
          shape('MILK2 2 pcs 10.00 20.00'),
          shape('BREAD 1 pcs 5.00 5.00'),
          shape('TOTAL 25.00 TRY'),
        ];
        final doc = ReceiptDocument.fromScan(
          scan(original),
          currencyCode: 'TRY',
        );
        expect(doc.state, ReceiptDocumentState.complete);
        expect(doc.metadata.store, 'Example Market');
        expect(doc.metadata.dateTime, DateTime(2026, 10, 29, 18, 41, 35));
        expect(doc.metadata.totalMinor, 2500);
        expect(doc.metadata.documentNumber, '000123');
        expect(doc.productLines.map((l) => l.name), [shape('MILK2'), 'BREAD']);
        expect(doc.productLines.first.quantity, DecimalFixed.fromInt(2));
        expect(doc.productLines.first.unitPriceMinor, 1000);
        expect(doc.toParseResult().withinReconciliationTolerance, isTrue);
        expect(doc.fragments.single.lines.map((l) => l.text), original);
        final replay = ReceiptDocument.decode(doc.encode());
        expect(replay.metadata.totalMinor, 2500);
        expect(replay.productLines.first.name, shape('MILK2'));
        expect(
          replay.productLines.first.rawText,
          shape('MILK2 2 pcs 10.00 20.00'),
        );
        expect(replay.fragments.single.lines.map((l) => l.text), original);
      },
    );

    test('$name shelf price keeps raw text and package quantity', () {
      final text = shape('350.00 TRY / 400 g');
      final result = ShelfPriceExtractor().extract([OcrLine(text: text)]);
      expect(result, hasLength(1));
      expect(result.single.value.toMinorUnits(2), 35000);
      expect(result.single.priceQuantity, DecimalFixed.fromInt(400));
      expect(result.single.sourceLine, text);
    });
  }

  test('JPY whole-price grouping does not turn 1,234 yen into 1 yen', () {
    final original = [
      'STORE: Example Market',
      'DATE: 29.10.2026',
      'TIME: 18:41:35',
      'RECEIPT NO: 000123',
      'MILK2 1,234',
      'TOTAL 1,234 JPY',
    ].map((s) => native(s, 0xff10, fullwidth: true)).toList();
    final doc = ReceiptDocument.fromScan(scan(original), currencyCode: 'JPY');
    expect(doc.metadata.store, 'Example Market');
    expect(doc.metadata.totalMinor, 1234);
    expect(doc.productLines.single.lineTotalMinor, 1234);
    expect(doc.productLines.single.name, 'MILK２');
    expect(doc.toParseResult().withinReconciliationTolerance, isTrue);
    final shelf = ShelfPriceExtractor(defaultCurrency: 'JPY')
        .extract([const OcrLine(text: '１，２３４ JPY')]);
    expect(shelf.single.value.toMinorUnits(0), 1234);
  });

  test(
    'malformed native grouping/bidi controls never concatenate or re-scale',
    () {
      for (final text in [
        '١٬٢٣ TRY',
        '١\u200f٢٫٣٤ TRY',
        '۱\u061c۲٫۳۴ TRY',
        '1\u202f23 EUR',
      ]) {
        expect(OcrNumberView(text).valid, isFalse);
        expect(ShelfPriceExtractor().extract([OcrLine(text: text)]), isEmpty);
      }
      final view = OcrNumberView('MILK𐒢 𐒡𐒢.𐒣𐒤');
      expect(view.text, 'MILK2 12.34');
      expect(view.originalSlice(0, 5), 'MILK𐒢');
    },
  );

  test('French narrow-space and Indian grouping preserve complete amounts', () {
    for (final (currency, price, expected) in [
      ('EUR', '12\u202f345,67', 1234567),
      ('EUR', '12\u00a0345,67', 1234567),
      ('INR', '१,२३,४५६.७८', 12345678),
    ]) {
      final rawProduct = 'MILK2 $price';
      final doc = ReceiptDocument.fromScan(
        scan([
          'STORE: Example Market',
          'DATE: 29.10.2026',
          'TIME: 18:41:35',
          'RECEIPT NO: 000123',
          rawProduct,
          'TOTAL $price $currency',
        ]),
        currencyCode: currency,
      );
      expect(doc.metadata.totalMinor, expected, reason: '$currency $price');
      expect(doc.productLines.single.lineTotalMinor, expected);
      expect(doc.productLines.single.name, 'MILK2');
      expect(doc.productLines.single.rawText, rawProduct);
      expect(doc.toParseResult().withinReconciliationTolerance, isTrue);
      final shelf = ShelfPriceExtractor(defaultCurrency: currency)
          .extract([OcrLine(text: '$price $currency')]);
      expect(shelf.single.value.toMinorUnits(2), expected);
    }
  });

  test(
    'explicit Arabic grouping retains its role with three-minor-digit currency',
    () {
      final shelf = ShelfPriceExtractor(defaultCurrency: 'KWD')
          .extract([const OcrLine(text: '١٬٢٣٤ KWD')]);
      expect(shelf.single.value.toMinorUnits(3), 1234000);
      expect(shelf.single.sourceLine, '١٬٢٣٤ KWD');
      expect(wholeOcrAmount('1,234.567'), isNull);
      expect(wholeOcrAmount('1.50'), isNull);
      expect(wholeOcrAmount('1,234.00'), 1234);
    },
  );
}
