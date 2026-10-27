import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';

OcrScanResult _scan(List<String> rows) =>
    OcrScanResult(lines: [for (final row in rows) OcrLine(text: row)]);

void main() {
  test('CORD annotated whole-rupiah rows retain ISO two-digit accounting', () {
    // Immutable printed prices from licensed CORDv2 test-row-1, revision
    // 7f0115a4b758a71d6473b8d085751692da2fef98. Synthetic names deliberately
    // isolate printed-row parsing from native OCR/name/header recognition.
    const rows = [
      'ITEM A 17500',
      'ITEM B 46000',
      'ITEM C 27500',
      'TOTAL 91000',
    ];
    final result = ReceiptParser(currency: 'IDR').parse(_scan(rows));
    expect(result.lines.map((line) => line.lineTotalMinor), [
      1750000,
      4600000,
      2750000,
    ]);
    expect(result.totalMinor, 9100000);
    expect(result.computedTotalMinor, 9100000);
    expect(result.reconciliationDifferenceMinor, 0);
    expect(result.withinReconciliationTolerance, isTrue);
  });

  test('split TOTAL labels normalize only as complete strict amount rows', () {
    final parser = ReceiptParser(currency: 'IDR');
    for (final row in [
      'TOT AL 91000',
      'T O T A L: 91000',
      'TOT AL IDR 91000',
      'T O T A L: 91000 IDR',
    ]) {
      final scan = _scan([row]);
      final normalized = parser.readingRows(scan).single.text;
      expect(normalized, startsWith('TOTAL'), reason: row);
      expect(parser.parse(scan).totalMinor, 9100000, reason: row);
      expect(scan.lines.single.text, row, reason: 'raw OCR remains unchanged');
    }
    expect(
      parser.readingRows(_scan(['TOT AL IDR 91000'])).single.text,
      'TOTAL IDR 91000',
      reason: 'normalization preserves prefix currency evidence',
    );

    for (final row in [
      'TOTALITY 91000',
      'TOT AL CEREAL 91000',
      'SKU TOTAL91000',
      'TOTAL91000',
      'TOT AL -91000',
      'TOT AL +91000',
      'TOT AL 910O0',
      'TOT AL IDR 91000 IDR',
      'TOT\u200bAL 91000',
    ]) {
      final scan = _scan([row]);
      expect(parser.readingRows(scan).single.text, row, reason: row);
      expect(parser.parse(scan).totalMinor, isNull, reason: row);
      expect(scan.lines.single.text, row, reason: 'raw OCR remains unchanged');
    }
  });

  test('split TOTAL does not apply a printed discount twice', () {
    final result = ReceiptParser(currency: 'IDR')
        .parse(_scan(['PRODUCT 17500', 'INDIRIM -1000', 'TOT AL 17500']));
    expect(result.lines, hasLength(1));
    expect(result.discountMinor, 100000);
    expect(result.totalMinor, 1750000);
    expect(result.computedTotalMinor, 1750000);
    expect(result.withinReconciliationTolerance, isTrue);
  });

  test('split TOTAL uses only the selected currency amount grammar', () {
    expect(
      ReceiptParser(currency: 'TRY').parse(_scan(['TOT AL 20,00'])).totalMinor,
      2000,
    );
    expect(
      ReceiptParser(currency: 'TRY').parse(_scan(['TOT AL 20'])).totalMinor,
      isNull,
    );
    expect(
      ReceiptParser(currency: 'JPY').parse(_scan(['TOT AL 91000'])).totalMinor,
      91000,
    );
    expect(
      ReceiptParser(currency: 'KWD').parse(_scan(['TOT AL 20.123'])).totalMinor,
      20123,
    );
    expect(
      ReceiptParser(currency: 'KWD').parse(_scan(['TOT AL 20.12'])).totalMinor,
      isNull,
    );
  });

  for (final amount in ['17500', '17.500', '17,500']) {
    test('IDR whole/grouped token $amount is exactly 1750000 minor', () {
      final result = ReceiptParser(currency: 'IDR')
          .parse(_scan(['PRODUCT $amount', 'TOTAL $amount']));
      expect(result.lines.single.lineTotalMinor, 1750000);
      expect(result.totalMinor, 1750000);
    });
  }

  for (final entry in <String, int>{
    '17500.25': 1750025,
    '17500,25': 1750025,
    '17.500,25': 1750025,
    '17,500.25': 1750025,
    '1.234.567': 123456700,
    '1,234,567': 123456700,
    '0': 0,
    '0.00': 0,
  }.entries) {
    test('IDR exact fractional/grouped/zero token ${entry.key}', () {
      final result = ReceiptParser(currency: 'IDR')
          .parse(_scan(['PRODUCT ${entry.key}', 'TOTAL ${entry.key}']));
      expect(result.lines.single.lineTotalMinor, entry.value);
      expect(result.totalMinor, entry.value);
    });
  }

  for (final amount in [
    '17,50,000',
    '17.5000',
    '17,500,25',
    '17.500.25',
    '1,234.567',
    '17500.2',
    '17500,',
    'A17500',
    'CODEalpha123',
    '-17500',
    '−17500',
    '+17500',
    '- 17500',
    '− 17500',
    '+ 17500',
  ]) {
    test('IDR malformed/signed numeric token $amount is not truncated', () {
      final result = ReceiptParser(currency: 'IDR')
          .parse(_scan(['PRODUCT $amount', 'TOTAL $amount']));
      expect(result.lines, isEmpty);
      expect(result.totalMinor, isNull);
    });
  }

  test('IDR explicit currency evidence selects whole-rupiah grammar', () {
    final result = ReceiptParser().parse(
      _scan(['IDR', 'PRODUCT 17500', 'TOTAL 17500']),
    );
    expect(result.currencyCandidate, 'IDR');
    expect(result.lines.single.lineTotalMinor, 1750000);
  });

  for (final discount in <String, int>{
    '-1000': 100000,
    '−1000': 100000,
    '+1000': 100000,
    '- 1000': 100000,
    '− 1000.25': 100025,
    '+ 1000,25': 100025,
    '-1.000,25': 100025,
    '−1,000.25': 100025,
    '+1.000': 100000,
    '1000': 100000,
  }.entries) {
    test('IDR recognized discount ${discount.key} retains its magnitude', () {
      // The printed product price is already net. A separate receipt discount
      // summary must not become a purchase or be subtracted a second time.
      final result = ReceiptParser(currency: 'IDR').parse(
        _scan(['PRODUCT 17500', 'INDIRIM ${discount.key}', 'TOTAL 17500']),
      );
      expect(result.discountMinor, discount.value);
      expect(result.lines, hasLength(1));
      expect(result.lines.single.name, 'PRODUCT');
      expect(result.totalMinor, 1750000);
      expect(result.computedTotalMinor, 1750000);
      expect(result.reconciliationDifferenceMinor, 0);
      expect(result.withinReconciliationTolerance, isTrue);
    });
  }

  test('IDR metadata and payment rows do not manufacture purchases', () {
    final result = ReceiptParser(currency: 'IDR').parse(
      _scan([
        'DATE 26.10.2026',
        'NO: 17500',
        'KASA NO 17500',
        'CASH 91000',
        'PAID 91000',
        'CHANGE 0',
        'PRODUCT 17500',
        'TOTAL 17500',
      ]),
    );
    expect(result.lines, hasLength(1));
    expect(result.lines.single.name, 'PRODUCT');
    expect(result.totalMinor, 1750000);
  });

  test(
    'IDR explicit quantity remains exact; product codes do not invent it',
    () {
      final quantity = ReceiptParser(currency: 'IDR')
          .parse(_scan(['PRODUCT 2 PCS 17500 35000']))
          .lines
          .single;
      expect(quantity.quantity?.toDbString(), '2');
      expect(quantity.unitPriceMinor, 1750000);
      expect(quantity.lineTotalMinor, 3500000);
      expect(quantity.confidence, 'high');
      final multiplied = ReceiptParser(currency: 'IDR')
          .parse(_scan(['PRODUCT 2X17500 35000']))
          .lines
          .single;
      expect(multiplied.quantity?.toDbString(), '2');
      expect(multiplied.unitPriceMinor, 1750000);
      expect(multiplied.lineTotalMinor, 3500000);
      expect(multiplied.confidence, 'high');
      for (final row in [
        'PRODUCT B12PCS 17500 35000',
        'RETURN -2 PCS 17500 35000',
        'RETURN - 2 PCS 17500 35000',
        'RETURN −2X17500 35000',
      ]) {
        final line = ReceiptParser(currency: 'IDR')
            .parse(_scan([row]))
            .lines
            .single;
        expect(line.quantity, isNull, reason: row);
        expect(line.confidence, isNot('high'), reason: row);
      }
    },
  );

  test('other currencies retain their established fractional precision', () {
    for (final currency in ['TRY', 'USD']) {
      expect(
        ReceiptParser(currency: currency).parse(_scan(['PRODUCT 17500'])).lines,
        isEmpty,
      );
      expect(
        ReceiptParser(currency: currency)
            .parse(_scan(['PRODUCT 17.50']))
            .lines
            .single
            .lineTotalMinor,
        1750,
      );
    }
    expect(
      ReceiptParser(currency: 'JPY')
          .parse(_scan(['PRODUCT 17500']))
          .lines
          .single
          .lineTotalMinor,
      17500,
    );
    expect(
      ReceiptParser(currency: 'KWD')
          .parse(_scan(['PRODUCT 17.500']))
          .lines
          .single
          .lineTotalMinor,
      17500,
    );
  });
}
