import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/receipts/ocr_number_view.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parse_result.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';

ReceiptParseResult parseLines(List<String> lines) => ReceiptParser(
  currency: 'TRY',
).parse(OcrScanResult(lines: [for (final t in lines) OcrLine(text: t)]));

void main() {
  group('quantity-only rows above an item are counts, not products', () {
    test('bare `2 X 6,25` merges into the following product', () {
      final result = parseLines([
        'MIGROS',
        '2 X 6,25',
        'EKMEK %01 *12,50',
        'SÜT 32,90',
        'TOPLAM 45,40',
      ]);
      expect(result.lines, hasLength(2));
      expect(result.lines[0].name.toUpperCase(), contains('EKMEK'));
      expect(result.lines[0].quantity?.toDbString(), '2');
      expect(result.lines[0].unitPriceMinor, 625);
      expect(result.lines[0].lineTotalMinor, 1250);
      expect(result.totalMinor, 4540);
      expect(result.withinReconciliationTolerance, isTrue);
    });

    test('`2 AD X 6,25` and `2 ADET X 6,25` merge as piece counts', () {
      for (final row in ['2 AD X 6,25', '2 ADET X 6,25', '2 x 6,25']) {
        final result = parseLines([
          'BIM',
          row,
          'YUMURTA 12,50',
          'SÜT 32,90',
          'TOPLAM 45,40',
        ]);
        expect(result.lines, hasLength(2), reason: row);
        expect(result.lines[0].quantity?.toDbString(), '2', reason: row);
        if (!row.startsWith('2 x')) {
          expect(result.lines[0].unitCode?.name, 'adet', reason: row);
        }
      }
    });

    test('inline `NAME 2 AD X 6,25 12,50` parses as one line', () {
      final result = parseLines([
        'SOK',
        'YUMURTA 2 AD X 6,25 12,50',
        'TOPLAM 12,50',
      ]);
      expect(result.lines, hasLength(1));
      expect(result.lines[0].name.toUpperCase(), contains('YUMURTA'));
      expect(result.lines[0].lineTotalMinor, 1250);
      expect(result.withinReconciliationTolerance, isTrue);
    });

    test('a lone count row never becomes a product', () {
      final result = parseLines([
        'BIM',
        'SÜT 32,90',
        '2 X 6,25',
        'TOPLAM 32,90',
      ]);
      expect(
        result.lines.map((l) => l.name.toUpperCase()),
        isNot(contains('2 X')),
      );
      expect(result.withinReconciliationTolerance, isTrue);
    });
  });

  group('OCR digit/letter confusions inside amounts', () {
    test('`*1O,50` reads as 10,50', () {
      final result = parseLines([
        'A101',
        'EKMEK *1O,50',
        'SÜT 32,90',
        'TOPLAM 43,40',
      ]);
      expect(result.lines.first.lineTotalMinor, 1050);
      expect(result.withinReconciliationTolerance, isTrue);
    });

    test('`T0PLAM 45,4O` is the total', () {
      final result = parseLines([
        'BIM',
        'EKMEK 12,50',
        'SÜT 32,90',
        'T0PLAM 45,4O',
      ]);
      expect(result.totalMinor, 4540);
      expect(result.withinReconciliationTolerance, isTrue);
    });

    test('names and separator-less tokens stay untouched', () {
      expect(repairConfusableAmounts('SÜT 1L'), 'SÜT 1L');
      expect(repairConfusableAmounts('330ML SU'), '330ML SU');
      expect(repairConfusableAmounts('Beko 8,99'), 'Beko 8,99');
      expect(repairConfusableAmounts('1.5LB TEREYAĞI'), '1.5LB TEREYAĞI');
      expect(repairConfusableAmounts('6x1,5l SU'), '6x1,5l SU');
      expect(repairConfusableAmounts('FİŞ NO.0012'), 'FİŞ NO.0012');
      // Repair targets the trailing amount only.
      expect(repairConfusableAmounts('l,50'), '1,50');
      expect(repairConfusableAmounts('TOPLAM 45,4O TL'), 'TOPLAM 45,40 TL');
    });
  });

  group('multilingual total labels', () {
    test('SUMME and SUBTOTAL are not products', () {
      final result = parseLines([
        'REWE',
        'MILCH 1,29',
        'SUBTOTAL 1,29',
        'SUMME EUR 1,29',
      ]);
      expect(result.totalMinor, 129);
      expect(result.subtotalMinor, 129);
      expect(result.lines, hasLength(1));
      expect(result.withinReconciliationTolerance, isTrue);
    });
  });
}
