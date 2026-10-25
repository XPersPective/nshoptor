// Native, on-device OCR regression for the realistic Turkish receipt fixture.
// Run on the shared Android device with:
// flutter test integration_test/receipt_realistic_test.dart -d <device>
import 'dart:convert' show base64Decode, jsonEncode;
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';
import 'package:nshoptor/features/receipts/shelf_label/mlkit_text_source.dart';

import 'receipt_realistic_fixture_bytes.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('native OCR imports a realistic Turkish receipt exactly once', (
    tester,
  ) async {
    final image = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}'
      'receipt_realistic_${DateTime.now().microsecondsSinceEpoch}.png',
    );
    final source = MlKitTextSource();
    AppDatabase? db;
    ReceiptReviewController? controller;
    try {
      await image.writeAsBytes(base64Decode(receiptRealisticBase64));
      final OcrScanResult scan = await source.scan(image.path);
      expect(scan.lines, isNotEmpty, reason: 'ML Kit should read receipt text');
      final rawText = scan.lines.map((line) => line.text).join('\n');
      debugPrint(
        'REALISTIC_RECEIPT_OCR=${jsonEncode([
          for (final line in scan.lines) {'text': line.text, 'top': line.boundingBoxTop, 'left': line.boundingBoxLeft, 'height': line.boundingBoxHeight},
        ])}',
      );
      expect(rawText, contains('MARKET'));
      expect(rawText, contains('2026000123'));
      expect(rawText, contains('90'));

      final document = ReceiptDocument.fromScan(scan, currencyCode: 'TRY');
      expect(document.metadata.store, 'ÖRNEK MARKET');
      expect(document.metadata.documentNumber, '2026000123');
      expect(document.metadata.dateTime, DateTime(2026, 10, 25, 10, 15, 32));
      expect(document.metadata.currencyCode, 'TRY');
      expect(document.metadata.totalMinor, 9000);
      expect(document.state, ReceiptDocumentState.complete);
      expect(document.identity, isNotNull);

      final products = document.productLines;
      expect(products, hasLength(3));
      final apple = products.singleWhere(
        (line) => line.normalizedName == 'elma',
      );
      expect(apple.quantity, DecimalFixed.fromInt(1));
      expect(apple.unitCode?.dbCode, 'kilogram');
      expect(apple.unitPriceMinor, 2000);
      expect(apple.lineTotalMinor, 2000);
      final bread = products.singleWhere(
        (line) => line.normalizedName == 'ekmek',
      );
      expect(bread.quantity?.toDbString(), '2');
      expect(bread.unitCode?.dbCode, 'piece');
      expect(bread.unitPriceMinor, 2000);
      expect(bread.lineTotalMinor, 4000);
      final milk = products.singleWhere((line) => line.normalizedName == 'sut');
      expect(milk.lineTotalMinor, 3000);
      expect(document.toParseResult().withinReconciliationTolerance, isTrue);

      db = AppDatabase(NativeDatabase.memory());
      controller = ReceiptReviewController(
        db: db,
        currencyCode: 'TRY',
        parseResult: document.toParseResult(),
        document: document,
      );
      expect(controller.documentReady, isTrue);
      controller.acceptAll();
      await controller.commit();

      final purchases = await db.select(db.purchaseEntries).get();
      expect(purchases, hasLength(3));
      expect(
        purchases.fold<int>(
          0,
          (sum, purchase) => sum + purchase.actualLineTotalMinorUnits,
        ),
        9000,
      );
      final receipts = await db.select(db.receipts).get();
      expect(receipts, hasLength(1));
      final savedReceipt = receipts.single;
      expect(savedReceipt.identityKey, document.identity);
      expect(savedReceipt.documentNumber, '2026000123');
      expect(savedReceipt.detectedStore, 'ÖRNEK MARKET');
      expect(savedReceipt.detectedAt, DateTime(2026, 10, 25, 10, 15, 32));
      expect(savedReceipt.detectedTotalMinorUnits, 9000);
      expect(savedReceipt.listId, controller.listId);
      expect(
        purchases.every((purchase) => purchase.receiptId == savedReceipt.id),
        isTrue,
      );

      final duplicate = ReceiptReviewController(
        db: db,
        currencyCode: 'TRY',
        parseResult: document.toParseResult(),
        document: document,
      );
      try {
        duplicate.acceptAll();
        await expectLater(
          duplicate.commit(),
          throwsA(isA<ReceiptAlreadyImported>()),
        );
      } finally {
        duplicate.dispose();
      }
      expect(await db.select(db.purchaseEntries).get(), hasLength(3));
      expect(await db.select(db.receipts).get(), hasLength(1));
    } finally {
      controller?.dispose();
      await db?.close();
      await source.dispose();
      if (await image.exists()) await image.delete();
    }
  });
}
