import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';

OcrScanResult _scan(List<String> lines) =>
    OcrScanResult(lines: [for (final line in lines) OcrLine(text: line)]);

void main() {
  test(
    'explicit invoice piece columns keep quantity out of the product name',
    () {
      final result = ReceiptParser().parse(
        _scan(['SÜT 2 ADET 20,00 40,00', 'TOPLAM 40,00']),
      );
      final line = result.lines.single;
      expect(line.name, 'SÜT');
      expect(line.quantity?.toDbString(), '2');
      expect(line.unitCode, UnitCode.adet);
      expect(line.unitPriceMinor, 2000);
      expect(line.lineTotalMinor, 4000);
      expect(result.withinReconciliationTolerance, isTrue);
    },
  );

  test(
    'wrapped fractional mass columns and currency tokens retain their basis',
    () {
      final result = ReceiptParser().parse(
        _scan(['DOMATES', '0,750 KG 40,00 TL 30,00 TL', 'TOPLAM 30,00 TL']),
      );
      final line = result.lines.single;
      expect(line.name, 'DOMATES');
      expect(line.quantity?.toDbString(), '0.750');
      expect(line.unitCode, UnitCode.kilogram);
      expect(line.unitPriceMinor, 4000);
      expect(line.lineTotalMinor, 3000);
    },
  );

  test('bare numeric columns and product numbers never invent a quantity', () {
    final result = ReceiptParser(currency: 'USD')
        .parse(_scan(['VITAMIN B12 2 20.00 40.00', 'TOTAL 40.00']));
    expect(result.lines.single.name, 'VITAMIN B12 2 20.00');
    expect(result.lines.single.quantity, isNull);
    expect(result.lines.single.unitCode, isNull);
  });

  test('printed multiplication mismatch never receives high confidence', () {
    for (final input in ['SÜT 2 ADET 20,00 38,00', 'SÜT 2X20,00 38,00']) {
      final line = ReceiptParser().parse(_scan([input])).lines.single;
      expect(line.quantity?.toDbString(), '2');
      expect(line.lineTotalMinor, 3800);
      expect(line.confidence, isNot('high'));
    }
  });

  test('unit-like suffix in a product code is not a quantity column', () {
    final line = ReceiptParser().parse(_scan([
      'VITAMIN B12ADET 20,00 40,00',
    ])).lines.single;
    expect(line.name, 'VITAMIN B12ADET 20,00');
    expect(line.quantity, isNull);
    expect(line.unitCode, isNull);
  });

  test(
    'review commits the printed quantity once without writing before approval',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final document = ReceiptDocument.fromScan(
        _scan([
          'ÖRNEK MARKET',
          'TARİH: 26.10.2026 SAAT: 12:30',
          'FATURA NO: ABC2026000158',
          'SÜT 2 ADET 20,00 TL 40,00 TL',
          'GENEL TOPLAM 40,00 TL',
        ]),
        currencyCode: 'TRY',
      );
      final controller = ReceiptReviewController(
        db: db,
        currencyCode: 'TRY',
        document: document,
        parseResult: document.toParseResult(),
      );
      addTearDown(controller.dispose);
      expect(controller.documentReady, isTrue);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      controller.acceptAll();
      await controller.commit();
      final entries = await db.select(db.purchaseEntries).get();
      expect(entries, hasLength(1));
      expect(
        DecimalFixed.parse(entries.single.actualQuantity)
            .compareTo(DecimalFixed.fromInt(2)),
        0,
      );
      expect(entries.single.actualUnitCode, 'piece');
      expect(entries.single.actualLineTotalMinorUnits, 4000);
      expect(await db.select(db.receipts).get(), hasLength(1));
    },
  );
}
