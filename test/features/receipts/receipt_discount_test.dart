import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';

OcrScanResult _receipt(
  String currency,
  String product,
  String discount,
  String? total,
) => OcrScanResult(
  lines: [
    const OcrLine(text: 'A101 MARKET'),
    const OcrLine(text: 'TARİH: 26.10.2026 SAAT: 12:30:00'),
    const OcrLine(text: 'FİŞ NO: DISCOUNT123'),
    OcrLine(text: 'PRODUCT $product $currency'),
    OcrLine(text: 'INDIRIM $discount $currency'),
    if (total != null) OcrLine(text: 'TOTAL $total $currency'),
  ],
);

ReceiptReviewController _review(
  AppDatabase db,
  ReceiptDocument document,
  String currency,
) => ReceiptReviewController(
  db: db,
  currencyCode: currency,
  document: document,
  parseResult: document.toParseResult(),
);

Future<void> _expectEmpty(AppDatabase db) async {
  expect(await db.select(db.purchaseEntries).get(), isEmpty);
  expect(await db.select(db.receipts).get(), isEmpty);
  expect(await db.select(db.shoppingLists).get(), isEmpty);
}

void main() {
  for (final currency in ['TRY', 'IDR']) {
    final net = currency == 'TRY' ? '20.00' : '17500';
    final gross = currency == 'TRY' ? '25.00' : '18500';
    final discount = currency == 'TRY' ? '5.00' : '1000';
    final netMinor = currency == 'TRY' ? 2000 : 1750000;
    final discountMinor = currency == 'TRY' ? 500 : 100000;
    for (final alreadyNet in [true, false]) {
      test(
        '$currency ${alreadyNet ? 'net summary' : 'gross deduction'} applies discount once through approved persistence',
        () async {
          final db = AppDatabase(NativeDatabase.memory());
          addTearDown(db.close);
          final scan = _receipt(
            currency,
            alreadyNet ? net : gross,
            discount,
            net,
          );
          final parser = ReceiptParser(currency: currency).parse(scan);
          expect(parser.discountMinor, discountMinor);
          expect(parser.computedTotalMinor, netMinor);
          expect(parser.withinReconciliationTolerance, isTrue);
          final document = ReceiptDocument.fromScan(
            scan,
            currencyCode: currency,
          );
          expect(document.state, ReceiptDocumentState.complete);
          expect(document.identity, isNotNull);
          final parsed = document.toParseResult();
          expect(parsed.discountMinor, discountMinor);
          expect(parsed.computedTotalMinor, netMinor);
          expect(parsed.reconciliationDifferenceMinor, 0);
          final review = _review(db, document, currency);
          addTearDown(review.dispose);
          expect(review.documentReady, isTrue);
          expect(
            review.lines.where((line) => line.isDiscount),
            hasLength(alreadyNet ? 0 : 1),
          );
          await _expectEmpty(db);
          await expectLater(
            review.commit(),
            throwsA(isA<ReceiptUnresolvedLines>()),
          );
          await _expectEmpty(db);
          review.acceptAll();
          expect(review.acceptedTotalMinor, netMinor);
          expect(review.reconciliationDifference, 0);
          await _expectEmpty(db);
          await review.commit();
          final entries = await db.select(db.purchaseEntries).get();
          expect(entries, hasLength(alreadyNet ? 1 : 2));
          expect(
            entries.fold<int>(
              0,
              (sum, line) => sum + line.actualLineTotalMinorUnits,
            ),
            netMinor,
          );
          expect(
            entries
                .where((line) => line.actualLineTotalMinorUnits < 0)
                .map((line) => line.actualLineTotalMinorUnits),
            alreadyNet ? isEmpty : [-discountMinor],
          );
          final receipt = (await db.select(db.receipts).get()).single;
          expect(receipt.detectedTotalMinorUnits, netMinor);
          expect(receipt.confirmedTotalMinorUnits, netMinor);
          // Replay retains the observed summary independently of its application.
          expect(
            ReceiptDocument.decode(receipt.captureDataJson!)
                .toParseResult()
                .discountMinor,
            discountMinor,
          );
          await review.commit(); // Same controller is idempotent.
          final duplicate = _review(db, document, currency)..acceptAll();
          addTearDown(duplicate.dispose);
          await expectLater(
            duplicate.commit(),
            throwsA(isA<ReceiptAlreadyImported>()),
          );
          expect(
            await db.select(db.purchaseEntries).get(),
            hasLength(entries.length),
          );
          expect(await db.select(db.receipts).get(), hasLength(1));
          expect(await db.select(db.shoppingLists).get(), hasLength(1));
        },
      );
    }

    for (final total in <String?>[
      null,
      currency == 'TRY' ? '19.99' : '17499.99',
    ]) {
      test(
        '$currency missing/near-mismatch total $total never infers a net summary',
        () async {
          final db = AppDatabase(NativeDatabase.memory());
          addTearDown(db.close);
          final scan = _receipt(currency, net, discount, total);
          final raw = ReceiptParser(currency: currency).parse(scan);
          expect(raw.discountMinor, discountMinor);
          expect(raw.computedTotalMinor, netMinor - discountMinor);
          final document = ReceiptDocument.fromScan(
            scan,
            currencyCode: currency,
          );
          final parsed = document.toParseResult();
          expect(parsed.discountMinor, discountMinor);
          expect(parsed.computedTotalMinor, netMinor - discountMinor);
          expect(parsed.withinReconciliationTolerance, isFalse);
          final review = _review(db, document, currency)..acceptAll();
          addTearDown(review.dispose);
          expect(review.documentReady, isFalse);
          expect(review.lines.where((line) => line.isDiscount), hasLength(1));
          await expectLater(review.commit(), throwsA(isA<ReceiptIncomplete>()));
          await _expectEmpty(db);
        },
      );
    }

    test(
      '$currency known zero total is distinct from an unknown total',
      () async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);
        final zero = currency == 'TRY' ? '0.00' : '0';
        for (final observed in [discount, zero]) {
          final scan = _receipt(currency, zero, observed, zero);
          final raw = ReceiptParser(currency: currency).parse(scan);
          expect(raw.computedTotalMinor, 0);
          expect(raw.withinReconciliationTolerance, isTrue);
          final document = ReceiptDocument.fromScan(
            scan,
            currencyCode: currency,
          );
          expect(document.toParseResult().computedTotalMinor, 0);
          final review = _review(db, document, currency)..acceptAll();
          addTearDown(review.dispose);
          expect(review.documentReady, isTrue);
          expect(review.lines.where((line) => line.isDiscount), isEmpty);
          expect(review.acceptedTotalMinor, 0);
          await _expectEmpty(db);
        }
      },
    );
  }
}
