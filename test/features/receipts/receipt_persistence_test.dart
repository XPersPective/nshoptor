import 'dart:io';
import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/receipt_image_store.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

OcrScanResult _scan(List<String> rows) =>
    OcrScanResult(lines: [for (final text in rows) OcrLine(text: text)]);

ReceiptDocument _receipt({
  String store = 'A101 MARKET',
  String number = '000123',
  List<String> rows = const ['ELMA 20,00'],
  String? total = '20,00',
}) => ReceiptDocument.fromScan(
  _scan([
    store,
    'TARİH: 24.10.2026',
    'SAAT: 18:41:35',
    'FİŞ NO: $number',
    ...rows,
    if (total != null) 'TOPLAM $total TL',
  ]),
  currencyCode: 'TRY',
);

ReceiptReviewController _review(
  AppDatabase db,
  ReceiptDocument document, {
  int? listId,
  int? draftId,
}) {
  final controller = ReceiptReviewController(
    db: db,
    document: document,
    listId: listId,
    draftId: draftId,
    // An independently supplied result must never replace document evidence.
    parseResult: ReceiptParser().parse(
      _scan(['OTHER PRODUCT 99,00', 'TOPLAM 99,00']),
    ),
  );
  for (var i = 0; i < controller.lines.length; i++) {
    controller.accept(i);
  }
  return controller;
}

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('complete document binds its own products and rejects concurrent/restarted approval', () async {
    final doc = _receipt();
    final first = _review(db, doc);
    final second = _review(db, doc);
    addTearDown(first.dispose);
    addTearDown(second.dispose);
    Future<bool> save(ReceiptReviewController c) async {
      try {
        await c.commit();
        return true;
      } on ReceiptAlreadyImported {
        return false;
      }
    }

    final outcomes = await Future.wait([save(first), save(second)]);
    expect(outcomes.where((ok) => ok), hasLength(1));
    expect(await db.select(db.shoppingLists).get(), hasLength(1));
    final entries = await db.select(db.purchaseEntries).get();
    expect(entries.single.name, 'ELMA');
    expect(entries.single.actualLineTotalMinorUnits, 2000);
    final receipt = (await db.select(db.receipts).get()).single;
    expect(receipt.identityKey, doc.identity);
    expect(receipt.processingStatus, 'reviewed');
    expect(entries.single.receiptId, receipt.id);
    final next = _review(db, doc);
    addTearDown(next.dispose);
    await expectLater(next.commit(), throwsA(isA<ReceiptAlreadyImported>()));
    expect(await db.select(db.purchaseEntries).get(), hasLength(1));
  });

  test('incomplete source cannot create a list or reserve a receipt', () async {
    final controller = _review(db, _receipt(total: null));
    addTearDown(controller.dispose);
    await expectLater(controller.commit(), throwsA(isA<ReceiptIncomplete>()));
    expect(await db.select(db.shoppingLists).get(), isEmpty);
    expect(await db.select(db.receipts).get(), isEmpty);
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
  });

  test(
    'seconds omitted by OCR still find a previously stored v1 claim',
    () async {
      final original = _receipt();
      final saved = _review(db, original);
      addTearDown(saved.dispose);
      await saved.commit();
      final oldIdentity = jsonEncode([
        'receipt-v1',
        'a101 market',
        '2026-10-24T18:41:35.000',
        '000123',
        'TRY',
      ]);
      await db.customStatement('UPDATE receipts SET identity_key = ?', [
        oldIdentity,
      ]);
      final minute = ReceiptDocument.fromScan(
        _scan([
          'A101 MARKET',
          'TARİH: 24.10.2026',
          'SAAT: 18:41',
          'FİŞ NO: 000123',
          'ELMA 20,00',
          'TOPLAM 20,00 TL',
        ]),
        currencyCode: 'TRY',
      );
      expect(minute.identity, original.identity);
      expect(original.metadata.dateTime!.second, 35);
      final duplicate = _review(db, minute);
      addTearDown(duplicate.dispose);
      await expectLater(
        duplicate.commit(),
        throwsA(isA<ReceiptAlreadyImported>()),
      );
      expect(await db.select(db.shoppingLists).get(), hasLength(1));
      expect(await db.select(db.purchaseEntries).get(), hasLength(1));
      expect(
        (await db.select(db.receipts).get()).single.identityKey,
        oldIdentity,
      );
    },
  );

  test('fresh receipts preserve previous/manual price and separate identical purchases', () async {
    final listId = await db
        .into(db.shoppingLists)
        .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
    final item = await ItemRepository(db).addItem(
      listId: listId,
      name: 'Elma',
      quantity: DecimalFixed.fromInt(1),
      unitCode: 'piece',
      priceIsUnitPrice: false,
    );
    await ShoppingRepository(db).recordPurchase(
      listId: listId,
      plannedItemId: item,
      name: 'Elma',
      normalizedName: 'elma',
      quantity: DecimalFixed.fromInt(1),
      unitCode: 'piece',
      lineTotalMinor: 800,
    );
    final original = (await db.select(db.purchaseEntries).get()).single;
    final first = _review(db, _receipt(), listId: listId)..linkLine(0, item);
    addTearDown(first.dispose);
    await first.commit();
    final second = _review(db, _receipt(store: 'BİM MARKET'), listId: listId)
      ..linkLine(0, item);
    addTearDown(second.dispose);
    await second.commit();
    final receipts = await (db.select(
      db.receipts,
    )..where((t) => t.listId.equals(listId))).get();
    expect(receipts, hasLength(2));
    expect(
      receipts.map((r) => r.confirmedStore),
      containsAll(['A101 MARKET', 'BİM MARKET']),
    );
    final entries = await db.select(db.purchaseEntries).get();
    expect(entries, hasLength(3));
    expect(
      entries.singleWhere((e) => e.id == original.id).toJson(),
      original.toJson(),
    );
    expect(entries.map((e) => e.plannedItemId).toSet(), hasLength(3));
    expect(
      entries.fold<int>(0, (sum, e) => sum + e.actualLineTotalMinorUnits),
      4800,
    );
    expect(
      (await db.select(db.plannedItems).get())
          .where((i) => i.id != item)
          .every((i) => i.plannedLineTotalMinorUnits == null),
      isTrue,
    );
  });

  test(
    'repeated receipt rows of one product stay on the same planned row',
    () async {
      final listId = await db
          .into(db.shoppingLists)
          .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
      final item = await ItemRepository(db).addItem(
        listId: listId,
        name: 'Elma',
        quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece',
        priceIsUnitPrice: false,
      );
      final controller =
          _review(
              db,
              _receipt(rows: ['ELMA 10,00', 'ELMA 10,00']),
              listId: listId,
            )
            ..linkLine(0, item)
            ..linkLine(1, item);
      addTearDown(controller.dispose);
      await controller.commit();
      final entries = await db.select(db.purchaseEntries).get();
      expect(entries, hasLength(2));
      // Repeated rows of one receipt never create a duplicate list row.
      expect(entries.map((e) => e.plannedItemId).toSet(), {item});
      expect(await db.select(db.plannedItems).get(), hasLength(1));
      expect(await db.select(db.receiptCandidateLines).get(), hasLength(2));
    },
  );

  test('an unplanned product scanned twice becomes one list row', () async {
    final controller = _review(
      db,
      _receipt(rows: ['OZMO FUN 13,50', 'OZMO FUN 13,50'], total: '27,00'),
    );
    addTearDown(controller.dispose);
    await controller.commit();
    final rows = await db.select(db.plannedItems).get();
    expect(rows, hasLength(1));
    expect(DecimalFixed.parse(rows.single.plannedQuantity).toDbString(), '2');
    final entries = await db.select(db.purchaseEntries).get();
    expect(entries, hasLength(2));
    expect(entries.map((e) => e.plannedItemId).toSet(), {rows.single.id});
  });

  test('storage failure rolls back receipt, list, candidates and observations, then retries once', () async {
    await db.customStatement(
      "CREATE TRIGGER fail_receipt BEFORE INSERT ON purchase_entries BEGIN SELECT RAISE(ABORT, 'test failure'); END",
    );
    final controller = _review(db, _receipt());
    addTearDown(controller.dispose);
    await expectLater(controller.commit(), throwsException);
    expect(await db.select(db.shoppingLists).get(), isEmpty);
    expect(await db.select(db.receipts).get(), isEmpty);
    expect(await db.select(db.receiptCandidateLines).get(), isEmpty);
    expect(await db.select(db.priceObservations).get(), isEmpty);
    await db.customStatement('DROP TRIGGER fail_receipt');
    await controller.commit();
    await controller.commit();
    expect(await db.select(db.purchaseEntries).get(), hasLength(1));
  });

  test('draft survives file database restart, resumes and reserves identity only at approval', () async {
    final dir = await Directory.systemTemp.createTemp('nshoptor-draft-');
    addTearDown(() => dir.delete(recursive: true));
    final file = File('${dir.path}/draft.sqlite');
    var persistent = AppDatabase(NativeDatabase(file));
    final partial = _receipt(rows: ['ELMA 20,00', 'EKMEK 40,00'], total: null);
    final id = await ReceiptDraftRepository(persistent)
        .save(document: partial, imagePaths: ['owned-image']);
    expect(
      (await persistent.select(persistent.receipts).get()).single.identityKey,
      isNull,
    );
    expect(await persistent.select(persistent.purchaseEntries).get(), isEmpty);
    await persistent.close();
    persistent = AppDatabase(NativeDatabase(file));
    final resumed = (await ReceiptDraftRepository(persistent).pending()).single;
    expect(resumed.id, id);
    final joined = resumed.document.append(
      _scan(['EKMEK 40,00', 'SÜT 30,00', 'TOPLAM 90,00 TL']),
    ) as ReceiptAppended;
    await ReceiptDraftRepository(persistent).save(
      document: joined.document,
      draftId: id,
      imagePaths: resumed.imagePaths,
    );
    final controller = _review(persistent, joined.document, draftId: id);
    await controller.commit();
    controller.dispose();
    expect(await ReceiptDraftRepository(persistent).pending(), isEmpty);
    expect(
      (await persistent.select(persistent.receipts).get()).single.imagePaths,
      ['owned-image'],
    );
    await persistent.close();
    persistent = AppDatabase(NativeDatabase(file));
    try {
      final duplicate = _review(persistent, joined.document);
      addTearDown(duplicate.dispose);
      await expectLater(
        duplicate.commit(),
        throwsA(isA<ReceiptAlreadyImported>()),
      );
      expect(
        await persistent.select(persistent.purchaseEntries).get(),
        hasLength(3),
      );
    } finally {
      await persistent.close();
    }
  });

  test(
    'image copies survive picker cache removal in owned local media',
    () async {
      final dir = await Directory.systemTemp.createTemp('nshoptor-image-');
      addTearDown(() => dir.delete(recursive: true));
      final source = await File('${dir.path}/picker.img')
          .writeAsBytes([1, 2, 3, 4]);
      final copy = await ReceiptImageStore(
        directoryOverride: Directory('${dir.path}/media'),
      ).keep(source.path);
      await source.delete();
      expect(await File(copy!).readAsBytes(), [1, 2, 3, 4]);
    },
  );
  test('owned cleanup preserves unrelated and outside files', () async {
    final dir = await Directory.systemTemp.createTemp('nshoptor-cleanup-');
    addTearDown(() => dir.delete(recursive: true));
    final outside = await File('${dir.path}/1790000000000000-1.img')
        .writeAsBytes([1]);
    final store = ReceiptImageStore(
      directoryOverride: Directory('${dir.path}/media'),
    );
    final owned = await store.keep(outside.path);
    expect(await store.removeOwned(outside.path), isFalse);
    expect(await outside.exists(), isTrue);
    expect(await store.removeOwned(owned!), isTrue);
    expect(await File(owned).exists(), isFalse);
    expect(await outside.exists(), isTrue);
  });

  test('unresolved rows cannot reserve an entire receipt; partial import is explicit', () async {
    final document = _receipt(rows: ['ELMA 10,00', 'EKMEK 10,00']);
    final controller = _review(db, document);
    addTearDown(controller.dispose);
    controller.lines[1].status = ReviewStatus.pending;
    await expectLater(
      controller.commit(),
      throwsA(isA<ReceiptUnresolvedLines>()),
    );
    expect(await db.select(db.receipts).get(), isEmpty);
    controller.ignore(1);
    await expectLater(
      controller.commit(),
      throwsA(isA<ReceiptPartialNeedsConfirmation>()),
    );
    expect(await db.select(db.receipts).get(), isEmpty);
    await controller.commit(selection: ReceiptSelection.confirmedSubset);
    expect(
      (await db.select(db.purchaseEntries).get())
          .single
          .actualLineTotalMinorUnits,
      1000,
    );
    expect(
      (await db.select(db.receipts).get()).single.identityKey,
      document.identity,
    );
    final candidates = await db.select(db.receiptCandidateLines).get();
    expect(candidates.map((line) => line.reviewStatus), [
      'accepted',
      'ignored',
    ]);
  });
}
