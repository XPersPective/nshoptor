import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';

/// Kontrol et → düzelt → kaydet yolu (PB-207): kusursuz olmayan okuma,
/// kullanıcı düzeltmesi ve açık onayla kaydedilir; kimlik içerik anahtarından
/// türetilir ve aynı fiş ikinci kez içe aktarılamaz.
void main() {
  late AppDatabase db;
  late int listId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    listId = await db
        .into(db.shoppingLists)
        .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
  });
  tearDown(() => db.close());

  // No store, no date, no receipt number: state stays incompleteHeader while
  // both product rows and the total are perfectly readable.
  ReceiptDocument unreadHeader() => ReceiptDocument.fromScan(
        OcrScanResult(
          lines: [
            for (final text in ['ELMA 20,00', 'EKMEK 40,00', 'TOPLAM 60,00'])
              OcrLine(text: text),
          ],
        ),
        currencyCode: 'TRY',
      );

  ReceiptReviewController controllerFor(ReceiptDocument doc) =>
      ReceiptReviewController(
        db: db,
        listId: listId,
        currencyCode: 'TRY',
        parseResult: doc.toParseResult(),
        document: doc,
      );

  test('imperfect reading is not reviewable to save without confirmation',
      () async {
    final controller = controllerFor(unreadHeader());
    expect(controller.documentReady, isFalse);
    expect(controller.reviewable, isTrue);
    expect(controller.hasMinimumIdentity, isFalse);
    expect(
      controller.commit,
      throwsA(isA<ReceiptIncomplete>()),
    );
    expect(
      () => controller.commit(overrideIncomplete: true),
      throwsA(isA<ReceiptIncomplete>()),
      reason: 'store and date are still unknown',
    );
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
  });

  test('line edit changes the saved row, never the raw evidence', () async {
    final controller = controllerFor(unreadHeader());
    controller.editLine(
      0,
      name: 'Elma Kırmızı',
      quantity: DecimalFixed.fromInt(2),
      unitCode: UnitCode.adet,
      lineTotalMinor: 2500,
    );
    expect(controller.lines[0].name, 'Elma Kırmızı');
    expect(controller.lines[0].quantity?.toDbString(), '2');
    expect(controller.lines[0].lineTotalMinor, 2500);
    expect(controller.lines[0].userEdited, isTrue);
    // Kanıt satırı değişmedi.
    expect(controller.lines[0].rawText, contains('ELMA'));
    expect(controller.acceptedTotalMinor, 6500);
  });

  test('confirmed details let an imperfect reading save with the difference',
      () async {
    final controller = controllerFor(unreadHeader());
    controller.editLine(0, name: 'Elma Kırmızı',
        quantity: DecimalFixed.fromInt(2), unitCode: UnitCode.adet,
        lineTotalMinor: 2500);
    controller.setDetails(
      store: 'A101 MARKET',
      dateTime: DateTime(2026, 11, 1, 18, 41),
    );
    controller.setReportedTotal(6500);
    expect(controller.hasMinimumIdentity, isTrue);

    // The screen accepts pending lines before saving (F17) and confirms the
    // recorded difference (subset selection) on the corrected path.
    controller.acceptPending();
    await controller.commit(
      selection: ReceiptSelection.confirmedSubset,
      overrideIncomplete: true,
    );

    final entries = await db.select(db.purchaseEntries).get();
    expect(entries, hasLength(2));
    expect(entries.map((e) => e.name), containsAll(['Elma Kırmızı', 'EKMEK']));
    final receipt = (await db.select(db.receipts).get()).single;
    expect(receipt.processingStatus, 'reviewed');
    expect(receipt.confirmedStore, 'A101 MARKET');
    expect(receipt.confirmedAt, DateTime(2026, 11, 1, 18, 41));
    expect(receipt.confirmedTotalMinorUnits, 6500);
    // Identity came from the confirmed values plus a content key: no printed
    // number existed to use.
    expect(receipt.identityKey, contains('AUTO-'));
    expect(receipt.documentNumber, isNull);
  });

  test('the same corrected receipt cannot be imported twice', () async {
    Future<void> saveOnce() async {
      final controller = controllerFor(unreadHeader());
      controller.editLine(0, name: 'Elma Kırmızı',
          quantity: DecimalFixed.fromInt(2), unitCode: UnitCode.adet,
          lineTotalMinor: 2500);
      controller.setDetails(
        store: 'A101 MARKET',
        dateTime: DateTime(2026, 11, 1, 18, 41),
      );
      controller.setReportedTotal(6500);
      controller.acceptPending();
      await controller.commit(
        selection: ReceiptSelection.confirmedSubset,
        overrideIncomplete: true,
      );
    }

    await saveOnce();
    expect(saveOnce, throwsA(isA<ReceiptAlreadyImported>()));
    expect((await db.select(db.receipts).get()), hasLength(1));
    expect((await db.select(db.purchaseEntries).get()), hasLength(2));
  });
}
