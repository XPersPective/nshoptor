import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/receipt_image_store.dart';
import 'package:nshoptor/features/receipts/receipt_repository.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

OcrScanResult _scan(List<String> rows) =>
    OcrScanResult(lines: [for (final text in rows) OcrLine(text: text)]);

ReceiptDocument _receipt({
  String number = '000123',
  List<String> rows = const ['ELMA 20,00', 'EKMEK 10,00'],
  String? total = '30,00',
}) => ReceiptDocument.fromScan(
  _scan([
    'A101 MARKET',
    'TARİH: 24.10.2026',
    'SAAT: 18:41:35',
    'FİŞ NO: $number',
    ...rows,
    if (total != null) 'TOPLAM $total TL',
  ]),
  currencyCode: 'TRY',
);

Future<int> _commit(
  AppDatabase db,
  ReceiptDocument document, {
  int? listId,
  Map<String, int> links = const {},
}) async {
  final controller = ReceiptReviewController(
    db: db,
    document: document,
    listId: listId,
    parseResult: ReceiptParser().parse(_scan(['X 1,00', 'TOPLAM 1,00'])),
  );
  addTearDown(controller.dispose);
  for (var i = 0; i < controller.lines.length; i++) {
    controller.accept(i);
    final link = links[controller.lines[i].name];
    if (link != null) controller.linkLine(i, link);
  }
  await controller.commit();
  return controller.listId!;
}

void main() {
  late AppDatabase db;
  late Directory media;
  late ReceiptImageStore images;
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    media = await Directory.systemTemp.createTemp('receipt_repo_');
    images = ReceiptImageStore(directoryOverride: media);
  });
  tearDown(() async {
    await db.close();
    if (await media.exists()) await media.delete(recursive: true);
  });

  Future<String> ownedImage(String name) async {
    final file = File('${media.path}/$name');
    await file.writeAsString('img');
    return file.path;
  }

  test('delete removes the receipt, its purchases and rows it created, '
      'keeps planned/manual data and allows re-import', () async {
    final doc = _receipt();
    final lists = ListRepository(db);
    final listId = await lists.createList(title: 'Market', currencyCode: 'TRY');
    final planned = await ItemRepository(db).addItem(
      listId: listId,
      name: 'Elma',
      quantity: DecimalFixed.fromInt(1),
      unitCode: 'piece',
      priceIsUnitPrice: false,
    );
    final milk = await ItemRepository(db).addItem(
      listId: listId,
      name: 'Süt',
      quantity: DecimalFixed.fromInt(1),
      unitCode: 'piece',
      priceIsUnitPrice: false,
    );
    await ShoppingRepository(db).recordPurchase(
      listId: listId,
      plannedItemId: milk,
      name: 'Süt',
      normalizedName: 'süt',
      quantity: DecimalFixed.fromInt(1),
      unitCode: 'piece',
      unitPrice: DecimalFixed.fromInt(5),
    );
    // The receipt row is created a second after the user's plan.
    await db.customStatement(
      'UPDATE planned_items SET created_at = created_at - 5',
    );
    await _commit(db, doc, listId: listId, links: {'ELMA': planned});

    final receipt = (await db.select(db.receipts).get()).single;
    final shared = await ownedImage('1730000000000-1.img');
    final own = await ownedImage('1730000000001-2.img');
    await (db.update(db.receipts)..where((t) => t.id.equals(receipt.id))).write(
      ReceiptsCompanion(imagePaths: Value([shared, own])),
    );
    // Another receipt references the shared photo; it must survive.
    await db
        .into(db.receipts)
        .insert(
          ReceiptsCompanion.insert(
            listId: Value(listId),
            imagePaths: Value([shared]),
            processingStatus: const Value('error'),
          ),
        );
    final created = (await db.select(db.plannedItems).get())
        .where((i) => i.name == 'EKMEK')
        .single;
    expect(await db.select(db.purchaseEntries).get(), hasLength(3));

    final listed = await ReceiptRepository(db).forList(listId);
    expect(listed.map((r) => r.state), [
      ListReceiptState.complete,
      ListReceiptState.failed,
    ]);
    expect(listed.first.totalMinor, 3000);
    expect(listed.first.printedAt, DateTime(2026, 10, 24, 18, 41, 35));

    expect(
      await ReceiptRepository(db, images: images).delete(receipt.id),
      isTrue,
    );
    final receipts = await db.select(db.receipts).get();
    expect(receipts.map((r) => r.id), isNot(contains(receipt.id)));
    expect(await db.select(db.receiptCandidateLines).get(), isEmpty);
    final entries = await db.select(db.purchaseEntries).get();
    expect(entries.single.plannedItemId, milk);
    final items = await db.select(db.plannedItems).get();
    expect(items.map((i) => i.id), containsAll([planned, milk]));
    expect(items.map((i) => i.id), isNot(contains(created.id)));
    expect(items.singleWhere((i) => i.id == planned).status, 'pending');
    expect(items.singleWhere((i) => i.id == milk).status, 'inCart');
    final observations = await db.select(db.priceObservations).get();
    expect(observations.single.purchaseEntryId, entries.single.id);
    expect(File(own).existsSync(), isFalse);
    expect(File(shared).existsSync(), isTrue);

    // The same receipt can be imported again.
    await _commit(db, doc, listId: listId, links: {'ELMA': planned});
    expect(await db.select(db.purchaseEntries).get(), hasLength(3));
    expect(
      (await db.select(db.receipts).get()).where(
        (r) => r.identityKey == doc.identity,
      ),
      hasLength(1),
    );
  });

  test(
    'a receipt that created its list can be deleted and imported again',
    () async {
      final doc = _receipt();
      final listId = await _commit(db, doc);
      final receipt = (await db.select(db.receipts).get()).single;
      await ReceiptRepository(db, images: images).delete(receipt.id);
      expect(await db.select(db.plannedItems).get(), isEmpty);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      expect(await db.select(db.receipts).get(), isEmpty);
      await _commit(db, doc, listId: listId);
      expect(await db.select(db.purchaseEntries).get(), hasLength(2));
      expect(await db.select(db.plannedItems).get(), hasLength(2));
    },
  );

  test(
    'incomplete drafts are listed and deleted with their owned photo',
    () async {
      final listId = await ListRepository(db)
          .createList(title: 'Market', currencyCode: 'TRY');
      final photo = await ownedImage('1730000000002-3.img');
      final draftId = await ReceiptDraftRepository(db).save(
        document: _receipt(total: null),
        listId: listId,
        imagePaths: [photo],
      );
      // A pending row without capture evidence is not offered.
      await db
          .into(db.receipts)
          .insert(ReceiptsCompanion.insert(listId: Value(listId)));
      final listed = await ReceiptRepository(db).forList(listId);
      expect(listed.single.id, draftId);
      expect(listed.single.state, ListReceiptState.incomplete);
      expect(listed.single.store, 'A101 MARKET');
      await ReceiptRepository(db, images: images).delete(draftId);
      expect(await ReceiptRepository(db).forList(listId), isEmpty);
      expect(File(photo).existsSync(), isFalse);
      expect(await ReceiptRepository(db).delete(draftId), isFalse);
    },
  );
}
