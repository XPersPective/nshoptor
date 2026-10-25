import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';

OcrLine box(
  String text,
  double top,
  double left,
  double height,
  double scale,
) => OcrLine(
  text: text,
  boundingBoxTop: top * scale,
  boundingBoxLeft: left * scale,
  boundingBoxHeight: height * scale,
);

void main() {
  for (final scale in [0.5, 1.0, 4.0]) {
    test('shifted price boxes retain the correct product at scale $scale', () {
      // A fixed top tolerance incorrectly joins 20,00 to the next name.
      final result = ReceiptParser().parse(
        OcrScanResult(
          lines: [
            box('8,00', 132, 300, 10, scale),
            box('ELMA', 100, 10, 20, scale),
            box('EKMEK', 120, 10, 20, scale),
            box('20,00', 112, 300, 10, scale),
            box('TOPLAM 28,00', 160, 10, 20, scale),
          ],
        ),
      );
      expect(result.lines.map((l) => l.name), ['ELMA', 'EKMEK']);
      expect(result.lines.map((l) => l.lineTotalMinor), [2000, 800]);
      expect(result.totalMinor, 2800);
      expect(result.withinReconciliationTolerance, isTrue);
    });
  }

  test('close rows are not joined through a chain of overlapping boxes', () {
    final result = ReceiptParser().parse(
      OcrScanResult(
        lines: [
          box('ELMA', 100, 10, 20, 1),
          box('20,00', 108, 300, 20, 1),
          box('EKMEK', 116, 10, 20, 1),
          box('8,00', 116, 300, 20, 1),
          box('TOPLAM 28,00', 150, 10, 20, 1),
        ],
      ),
    );
    expect(result.lines.map((l) => l.name), ['ELMA', 'EKMEK']);
    expect(result.lines.map((l) => l.lineTotalMinor), [2000, 800]);
  });

  test(
    'legacy coordinates and plain text keep their existing interpretation',
    () {
      for (final positioned in [false, true]) {
        final result = ReceiptParser().parse(
          OcrScanResult(
            lines: [
              OcrLine(
                text: 'ELMA 20,00',
                boundingBoxTop: positioned ? 100 : null,
              ),
              OcrLine(
                text: 'EKMEK 8,00',
                boundingBoxTop: positioned ? 120 : null,
              ),
              OcrLine(
                text: 'TOPLAM 28,00',
                boundingBoxTop: positioned ? 140 : null,
              ),
            ],
          ),
        );
        expect(result.lines.map((l) => l.lineTotalMinor), [2000, 800]);
      }
    },
  );

  test('a wrapped name remains attached to its own price row', () {
    final result = ReceiptParser().parse(
      OcrScanResult(
        lines: [
          box('ORGANIK', 70, 10, 20, 1),
          box('DOMATES', 100, 10, 20, 1),
          box('12,00', 130, 300, 10, 1),
          box('TOPLAM 12,00', 150, 10, 20, 1),
        ],
      ),
    );
    expect(result.lines.single.lineTotalMinor, 1200);
    expect(result.lines.single.name, 'ORGANIK DOMATES');
    expect(result.totalMinor, 1200);
  });

  test(
    'bare quantity and unit-price continuation stays with the preceding name',
    () {
      final result = ReceiptParser().parse(
        OcrScanResult(
          lines: [
            // Deliberately scramble ML Kit block order. Each right-column
            // amount shares a baseline with the quantity × unit-price text.
            box('40,00 TL', 170, 300, 10, 1),
            box('SÜT', 200, 10, 20, 1),
            box('TOPLAM', 230, 10, 20, 1),
            box('1,000 KG X 20,00', 120, 10, 10, 1),
            box('30,00 TL', 200, 300, 10, 1),
            box('ELMA', 100, 10, 20, 1),
            box('90,00 TL', 230, 300, 10, 1),
            box('2 ADET X 20,00', 170, 10, 10, 1),
            box('20,00 TL', 120, 300, 10, 1),
            box('EKMEK', 150, 10, 20, 1),
          ],
        ),
      );

      expect(result.lines.map((line) => line.name), ['ELMA', 'EKMEK', 'SÜT']);
      expect(result.lines.map((line) => line.lineTotalMinor), [
        2000,
        4000,
        3000,
      ]);
      expect(result.lines[0].quantity, DecimalFixed.fromInt(1));
      expect(result.lines[0].unitCode?.dbCode, 'kilogram');
      expect(result.lines[0].unitPriceMinor, 2000);
      expect(result.lines[1].quantity?.toDbString(), '2');
      expect(result.lines[1].unitCode?.dbCode, 'piece');
      expect(result.lines[1].unitPriceMinor, 2000);
      expect(result.totalMinor, 9000);
      expect(result.withinReconciliationTolerance, isTrue);
    },
  );
}
