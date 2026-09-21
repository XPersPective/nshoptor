import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parse_result.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';

/// Anonimleştirilmiş fixture metinleri (spec §13 fiş test listesi).
OcrScanResult scan(List<String> lines) => OcrScanResult(
      lines: [for (var i = 0; i < lines.length; i++) OcrLine(text: lines[i])],
    );

void main() {
  late ReceiptParser parser;

  setUp(() => parser = ReceiptParser());

  group('spec §13 fiş fixture seti', () {
    test('ürün + fiyat satırı', () {
      final result = parser.parse(scan([
        'MERK MARKET',
        'EKMEK 15,00',
        'TOPLAM 15,00',
      ]));
      expect(result.lines, hasLength(1));
      expect(result.lines.single.name, 'EKMEK');
      expect(result.lines.single.lineTotalMinor, 1500);
      expect(result.lines.single.confidence, 'medium');
      expect(result.totalMinor, 1500);
      expect(result.computedTotalMinor, 1500);
      expect(result.reconciliationDifferenceMinor, 0);
      expect(result.withinReconciliationTolerance, isTrue);
    });

    test('ağırlıklı ürün: miktar × birim fiyat = satır toplamı', () {
      final result = parser.parse(scan([
        'DOMATES 1,5KG X42,90 64,35',
        'TOPLAM 64,35',
      ]));
      final line = result.lines.single;
      expect(line.name, 'DOMATES');
      expect(line.quantity!.toDbString(), '1.5');
      expect(line.unitPriceMinor, 4290);
      expect(line.lineTotalMinor, 6435);
      expect(line.confidence, 'high');
    });

    test('indirim satırı ayrı toplanır', () {
      final result = parser.parse(scan([
        'SUT 32,00',
        'INDIRIM -5,00',
        'TOPLAM 27,00',
      ]));
      expect(result.discountMinor, 500);
      expect(result.lines, hasLength(1)); // indirim ürün değildir
      expect(result.totalMinor, 2700);
    });

    test('vergi ve genel toplam', () {
      final result = parser.parse(scan([
        'EKMEK 15,00',
        'KDV 1,20',
        'TOPLAM 16,20',
      ]));
      expect(result.taxMinor, 120);
      expect(result.totalMinor, 1620);
    });

    test('ondalık virgül ve nokta karışık parasal değerler', () {
      final result = parser.parse(scan([
        'URUN 1.234,56',
        'TOPLAM 1.234,56',
      ]));
      expect(result.totalMinor, 123456);
    });

    test('tarih, telefon, kart maskesi, fiş no ürün sanılmaz', () {
      final result = parser.parse(scan([
        'MERK MARKET',
        'TARIH 20.09.2026 18:44',
        'TEL 0212 000 00 00',
        'KART ****1234',
        'FIS NO: 001234',
        'VD 1234567890',
        'EKMEK 15,00',
        'TOPLAM 15,00',
      ]));
      // Yalnız ürün satırı ve toplam kalır.
      expect(result.lines, hasLength(1));
      expect(result.dateCandidate, isNotNull);
    });

    test('çok satıra taşan ürün adı birleştirilir', () {
      final result = parser.parse(scan([
        'DANET KAHVALTILIK',
        '500 GR KARIŞIK',
        '89,90',
        'TOPLAM 89,90',
      ]));
      // Tek ürün: 2 isim satırı + fiyat satırı birleşmelidir.
      expect(result.lines, hasLength(1));
      expect(result.lines.single.name, contains('DANET'));
      expect(result.lines.single.lineTotalMinor, 8990);
    });

    test('birden fazla olası toplam: genel toplam seçilir', () async {
      final result = parser.parse(scan([
        'EKMEK 15,00',
        'ARA TOPLAM 15,00',
        'KDV 1,20',
        'GENEL TOPLAM 16,20',
      ]));
      expect(result.subtotalMinor, 1500);
      expect(result.taxMinor, 120);
      expect(result.totalMinor, 1620); // 'ara' değil genel toplam
      expect(ReceiptParseResult.parserVersion, 1);
    });

    test('fiş toplamı uzlaştırma farkı raporlanır (gizlice silinmez)',
        () async {
      final result = parser.parse(scan([
        'EKMEK 15,00',
        'SUT 32,00',
        'TOPLAM 48,00', // satırlar 47,00; fark 1,00 → tolerans dışı
      ]));
      expect(result.computedTotalMinor, 4700);
      expect(result.reconciliationDifferenceMinor, -100);
      expect(result.withinReconciliationTolerance, isFalse);
    });

    test('düşük güvenli satır otomatik kesinleşmeye uygun işaretlenmez',
        () async {
      // Belirsiz satır: tek harfli ad + fiyat → düşük güven.
      final result = parser.parse(scan([
        'X 9,99',
        'TOPLAM 9,99',
      ]));
      expect(result.lines.single.confidence, 'low');
    });
  });

  group('muhafazakâr eşleştirme (spec §6.9)', () {
    test('normalize birebir high, benzerlik medium, uzak low', () async {
      // AppDatabase gerektiren ReceiptMatcher testi ayrı dosyada:
      // matcher_test.dart
      expect(ReceiptMatcher.levenshtein('sut', 'sut'), 0);
      expect(ReceiptMatcher.levenshtein('sut', 'surt'), 1);
    });
  });
}
