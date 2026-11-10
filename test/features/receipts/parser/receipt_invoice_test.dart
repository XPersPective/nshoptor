import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';

void main() {
  group('Fatura and Invoice parsing', () {
    test('e-Arşiv Fatura with ÖDENECEK TUTAR and FATURA NO parses cleanly', () {
      final scan = OcrScanResult(
        lines: [
          OcrLine(text: 'ÖRNEK TİCARET A.Ş.'),
          OcrLine(text: 'E-ARŞİV FATURA'),
          OcrLine(text: 'FATURA NO: GIB2026000001234'),
          OcrLine(text: 'TARİH: 10.11.2026 14:30'),
          OcrLine(text: 'ZEYTİNYAĞI 1 LT 185,00 TL'),
          OcrLine(text: 'SÜT 1 LT 35,50 TL'),
          OcrLine(text: 'KDV %1 2,20 TL'),
          OcrLine(text: 'ÖDENECEK TUTAR: 220,50 TL'),
        ],
      );

      final doc = ReceiptDocument.fromScan(scan, currencyCode: 'TRY');
      expect(doc.metadata.store, contains('ÖRNEK TİCARET'));
      expect(doc.metadata.documentNumber, equals('GIB2026000001234'));
      expect(doc.metadata.totalMinor, equals(22050));
      expect(doc.productLines.length, equals(2));
      expect(doc.productLines.first.name, equals('ZEYTİNYAĞI 1 LT'));
      expect(doc.productLines.first.lineTotalMinor, equals(18500));
      expect(doc.productLines.last.name, equals('SÜT 1 LT'));
      expect(doc.productLines.last.lineTotalMinor, equals(3550));
    });

    test('Invoice with FATURA TUTARI and invoice skip line does not treat header as product', () {
      final parser = ReceiptParser(currency: 'TRY');
      final scan = OcrScanResult(
        lines: [
          OcrLine(text: 'METRO GROSSMARKET'),
          OcrLine(text: 'FATURA BİLGİLERİ'),
          OcrLine(text: 'MAKARNA 500G 22,50'),
          OcrLine(text: 'PİRİNÇ 1KG 65,00'),
          OcrLine(text: 'FATURA TUTARI 87,50'),
        ],
      );

      final res = parser.parse(scan);
      expect(res.totalMinor, equals(8750));
      expect(res.lines.map((l) => l.name), containsAll(['MAKARNA 500G', 'PİRİNÇ 1KG']));
      expect(res.lines.any((l) => l.name.contains('FATURA')), isFalse);
    });

    test('Invoice with AMOUNT DUE and INVOICE # parses total', () {
      final parser = ReceiptParser(currency: 'USD');
      final scan = OcrScanResult(
        lines: [
          OcrLine(text: 'WHOLE FOODS MARKET'),
          OcrLine(text: 'INVOICE # 98765'),
          OcrLine(text: 'ORGANIC APPLES 12.50'),
          OcrLine(text: 'ALMOND MILK 4.50'),
          OcrLine(text: 'AMOUNT DUE 17.00'),
        ],
      );

      final res = parser.parse(scan);
      expect(res.totalMinor, equals(1700));
      expect(res.lines.length, equals(2));
      expect(res.lines.any((l) => l.name.contains('INVOICE')), isFalse);
    });

    test('Wrinkled/creased receipt with skewed lines and continuation stitches properly', () {
      // Part 1: Top of wrinkled receipt
      final part1 = OcrScanResult(
        lines: [
          OcrLine(text: 'MİGROS TİCARET A.Ş.', boundingBoxLeft: 10, boundingBoxTop: 20),
          OcrLine(text: 'FİŞ NO: 0042', boundingBoxLeft: 10, boundingBoxTop: 40),
          OcrLine(text: 'TARİH: 10.11.2026', boundingBoxLeft: 10, boundingBoxTop: 60),
          OcrLine(text: 'TAM YAĞLI SÜT 1LT 39,90', boundingBoxLeft: 12, boundingBoxTop: 95),
          OcrLine(text: 'YUMURTA 15LI 74,50', boundingBoxLeft: 14, boundingBoxTop: 125),
        ],
      );

      // Part 2: Bottom continuation overlapping on YUMURTA
      final part2 = OcrScanResult(
        lines: [
          OcrLine(text: 'YUMURTA 15LI 74,50', boundingBoxLeft: 14, boundingBoxTop: 30),
          OcrLine(text: 'TEREYAĞI 250G 115,00', boundingBoxLeft: 11, boundingBoxTop: 60),
          OcrLine(text: 'TOPLAM 229,40', boundingBoxLeft: 10, boundingBoxTop: 90),
        ],
      );

      final doc1 = ReceiptDocument.fromScan(part1, currencyCode: 'TRY');
      final appendResult = doc1.append(part2);

      expect(appendResult, isA<ReceiptAppended>());
      final mergedDoc = (appendResult as ReceiptAppended).document;

      expect(mergedDoc.metadata.store, contains('MİGROS'));
      expect(mergedDoc.metadata.totalMinor, equals(22940));
      expect(mergedDoc.productLines.length, equals(3));
      expect(mergedDoc.productLines[0].name, equals('TAM YAĞLI SÜT 1LT'));
      expect(mergedDoc.productLines[0].lineTotalMinor, equals(3990));
      expect(mergedDoc.productLines[1].name, equals('YUMURTA 15LI'));
      expect(mergedDoc.productLines[1].lineTotalMinor, equals(7450));
      expect(mergedDoc.productLines[2].name, equals('TEREYAĞI 250G'));
      expect(mergedDoc.productLines[2].lineTotalMinor, equals(11500));
    });
  });
}
