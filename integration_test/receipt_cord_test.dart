// Licensed, public CORDv2 test-row-1 native OCR regression.
// Prepare the private dart-define file with tool/qa/prepare_cord_fixture.py.
// Run on the existing iOS simulator/device using the native iOS CI path.
import 'dart:convert' show base64Decode, jsonDecode, jsonEncode;
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';
import 'package:nshoptor/features/receipts/shelf_label/mlkit_text_source.dart';

const _cordFixtureJson = String.fromEnvironment('CORD_RECEIPT_FIXTURE');
const _expectedLineTotalsMinor = <int>[1750000, 2750000, 4600000];
const _expectedTotalMinor = 9100000;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'native OCR preserves CORDv2 test-row-1 values and incomplete header',
    (tester) async {
      if (_cordFixtureJson.isEmpty) {
        fail('Missing CORD_RECEIPT_FIXTURE dart-define');
      }
      final fixture = jsonDecode(_cordFixtureJson) as Map<String, dynamic>;
      expect(fixture['revision'], '7f0115a4b758a71d6473b8d085751692da2fef98');
      final expected = fixture['expected'] as Map<String, dynamic>;
      expect(expected['currency'], 'IDR');
      expect(expected['lineTotalsMinor'], _expectedLineTotalsMinor);
      expect(expected['totalMinor'], _expectedTotalMinor);
      final imageBytes = base64Decode(fixture['imageBase64'] as String);
      expect(imageBytes, isNotEmpty);

      final image = File(
        '${Directory.systemTemp.path}${Platform.pathSeparator}'
        'cord_v2_test1_${DateTime.now().microsecondsSinceEpoch}.jpg',
      );
      final source = MlKitTextSource();
      AppDatabase? db;
      ReceiptReviewController? controller;
      OcrScanResult? scan;
      try {
        await image.writeAsBytes(imageBytes, flush: true);
        scan = await source.scan(image.path);
        expect(
          scan.lines,
          isNotEmpty,
          reason: 'ML Kit should read public CORDv2 text',
        );

        final document = ReceiptDocument.fromScan(scan, currencyCode: 'IDR');
        expect(document.productLines, hasLength(3));
        final lineTotals =
            document.productLines.map((line) => line.lineTotalMinor).toList()
              ..sort();
        expect(lineTotals, _expectedLineTotalsMinor);
        expect(document.metadata.totalMinor, _expectedTotalMinor);
        expect(document.metadata.currencyCode, 'IDR');
        expect(document.identity, isNull);
        expect(document.state, ReceiptDocumentState.incompleteHeader);

        db = AppDatabase(NativeDatabase.memory());
        controller = ReceiptReviewController(
          db: db,
          currencyCode: 'IDR',
          parseResult: document.toParseResult(),
          document: document,
        );
        expect(controller.documentReady, isFalse);
        controller.acceptAll();
        await expectLater(
          controller.commit(),
          throwsA(isA<ReceiptIncomplete>()),
        );
        expect(await db.select(db.shoppingLists).get(), isEmpty);
        expect(await db.select(db.purchaseEntries).get(), isEmpty);
        expect(await db.select(db.receipts).get(), isEmpty);
      } catch (_) {
        final failedScan = scan;
        try {
          if (failedScan != null) {
            final lines = failedScan.lines.take(40).map((line) {
              final text = line.text.length <= 160
                  ? line.text
                  : '${line.text.substring(0, 160)}…';
              return {
                'text': text,
                if (line.boundingBoxTop != null) 'top': line.boundingBoxTop,
                if (line.boundingBoxLeft != null) 'left': line.boundingBoxLeft,
              };
            });
            debugPrint('PUBLIC_CORD_TEST1_OCR=${jsonEncode(lines.toList())}');
          }
        } catch (_) {
          debugPrint('PUBLIC_CORD_TEST1_DIAGNOSTICS_UNAVAILABLE');
        }
        rethrow;
      } finally {
        controller?.dispose();
        await db?.close();
        await source.dispose();
        if (await image.exists()) await image.delete();
      }
    },
  );
}
