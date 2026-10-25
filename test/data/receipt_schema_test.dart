import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';
import 'package:nshoptor/features/settings/backup/backup_repository.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

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

  test(
    'receipt identity is unique across lists and permits null drafts',
    () async {
      final otherList = await db
          .into(db.shoppingLists)
          .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
      final first = await db
          .into(db.receipts)
          .insert(
            ReceiptsCompanion.insert(
              listId: Value(listId),
              identityKey: const Value('store/date/document'),
            ),
          );
      await expectLater(
        db
            .into(db.receipts)
            .insert(
              ReceiptsCompanion.insert(
                listId: Value(otherList),
                identityKey: const Value('store/date/document'),
              ),
            ),
        throwsException,
      );
      final draft = await db
          .into(db.receipts)
          .insert(ReceiptsCompanion.insert(listId: Value(otherList)));
      await db.into(db.receipts).insert(ReceiptsCompanion.insert());
      await expectLater(
        (db.update(db.receipts)..where((t) => t.id.equals(draft))).write(
          const ReceiptsCompanion(identityKey: Value('store/date/document')),
        ),
        throwsException,
      );
      final rows = await db.select(db.receipts).get();
      expect(rows, hasLength(3));
      expect(
        rows.singleWhere((r) => r.id == first).identityKey,
        'store/date/document',
      );
      expect(rows.where((r) => r.identityKey == null), hasLength(2));
    },
  );

  test('receipt purchase keeps its document relation', () async {
    final receiptId = await db
        .into(db.receipts)
        .insert(ReceiptsCompanion.insert(listId: Value(listId)));
    await _recordPurchase(db, listId, receiptId: receiptId);
    final row = (await db.select(db.purchaseEntries).get()).single;
    expect(row.receiptId, receiptId);
    expect(row.source, 'receiptOcr');
    expect(await db.select(db.priceObservations).get(), hasLength(1));
  });

  test(
    'invalid receipt links fail before replacing an existing purchase',
    () async {
      final itemId = await db
          .into(db.plannedItems)
          .insert(
            PlannedItemsCompanion.insert(
              listId: listId,
              name: 'Milk',
              normalizedName: 'milk',
              plannedQuantity: '1',
              plannedUnitCode: 'piece',
              pricingInputMode: 'lineTotal',
            ),
          );
      await _recordPurchase(
        db,
        listId,
        plannedItemId: itemId,
        source: 'manual',
      );
      final initialPurchase =
          (await db.select(db.purchaseEntries).get()).single;
      final initialObservation =
          (await db.select(db.priceObservations).get()).single;
      final otherList = await db
          .into(db.shoppingLists)
          .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
      final foreignReceipt = await db
          .into(db.receipts)
          .insert(ReceiptsCompanion.insert(listId: Value(otherList)));
      final detachedReceipt = await db
          .into(db.receipts)
          .insert(ReceiptsCompanion.insert());
      final receiptId = await db
          .into(db.receipts)
          .insert(ReceiptsCompanion.insert(listId: Value(listId)));
      for (final (id, source) in [
        (99999, 'receiptOcr'),
        (foreignReceipt, 'receiptOcr'),
        (detachedReceipt, 'receiptOcr'),
        (receiptId, 'manual'),
        (receiptId, 'shelfOcr'),
      ]) {
        await expectLater(
          _recordPurchase(
            db,
            listId,
            receiptId: id,
            plannedItemId: itemId,
            source: source,
          ),
          throwsArgumentError,
        );
        expect(
          (await db.select(db.purchaseEntries).get()).single,
          initialPurchase,
        );
        expect(
          (await db.select(db.priceObservations).get()).single,
          initialObservation,
        );
        expect(
          (await db.select(db.plannedItems).get()).single.status,
          'inCart',
        );
      }
    },
  );

  test('legacy receipt backup restores with null new fields', () async {
    await db
        .into(db.receipts)
        .insert(
          ReceiptsCompanion.insert(
            listId: Value(listId),
            rawOcrText: const Value('legacy'),
          ),
        );
    final data = jsonDecode(
      await BackupRepository(db).exportBackup(),
    ) as Map<String, dynamic>;
    for (final row in data['receipts'] as List) {
      (row as Map)
        ..remove('documentNumber')
        ..remove('identityKey')
        ..remove('captureDataJson');
    }
    final target = AppDatabase(NativeDatabase.memory());
    addTearDown(target.close);
    await BackupRepository(target)
        .importBackup(jsonEncode(data), ImportMode.merge);
    final receipt = (await target.select(target.receipts).get()).single;
    expect(receipt.rawOcrText, 'legacy');
    expect(receipt.documentNumber, isNull);
    expect(receipt.identityKey, isNull);
    expect(receipt.captureDataJson, isNull);
  });

  test('new receipt backup fields roundtrip and duplicate copies reject atomically', () async {
    final receiptId = await db
        .into(db.receipts)
        .insert(
          ReceiptsCompanion.insert(
            listId: Value(listId),
            documentNumber: const Value('000123'),
            identityKey: const Value('receipt-identity'),
            captureDataJson: const Value(
              '{"version":1,"currency":"TRY","fragments":[[{"text":"ELMA 20,00"}]]}',
            ),
          ),
        );
    await _recordPurchase(db, listId, receiptId: receiptId);
    final backup = BackupRepository(db);
    final snapshot = await backup.exportBackup();
    final original = (await db.select(db.receipts).get()).single;
    final target = AppDatabase(NativeDatabase.memory());
    addTearDown(target.close);
    await BackupRepository(target).importBackup(snapshot, ImportMode.separate);
    expect(
      (await target.select(target.receipts).get()).single.toJson(),
      original.toJson(),
    );
    expect(
      (await target.select(target.purchaseEntries).get()).single.receiptId,
      receiptId,
    );
    await backup.importBackup(snapshot, ImportMode.merge);
    final stable = await _backupRows(backup);
    await expectLater(
      backup.importBackup(snapshot, ImportMode.separate),
      throwsA(isA<BackupReceiptIdentityConflict>()),
    );
    expect(await _backupRows(backup), stable);

    final conflicting = jsonDecode(snapshot) as Map<String, dynamic>;
    final copiedReceipt = Map<String, dynamic>.from(
      (conflicting['receipts'] as List).single,
    );
    copiedReceipt['id'] = 1000;
    (conflicting['receipts'] as List).add(copiedReceipt);
    expect(
      () => backup.validate(jsonEncode(conflicting)),
      throwsA(isA<BackupReceiptIdentityConflict>()),
    );
    expect(await _backupRows(backup), stable);
  });

  test(
    'stale pending receipt backup cannot downgrade an approved draft',
    () async {
      final document = ReceiptDocument.fromScan(
        OcrScanResult(
          lines: [
            OcrLine(text: 'A101 MARKET'),
            OcrLine(text: 'TARİH: 24.10.2026'),
            OcrLine(text: 'SAAT: 18:41:35'),
            OcrLine(text: 'FİŞ NO: 000123'),
            OcrLine(text: 'ELMA 20,00'),
            OcrLine(text: 'TOPLAM 20,00 TL'),
          ],
        ),
        currencyCode: 'TRY',
      );
      final drafts = ReceiptDraftRepository(db);
      final draftId = await drafts.save(
        document: document,
        listId: listId,
      );
      final stalePendingSnapshot = await BackupRepository(db).exportBackup();

      final review = ReceiptReviewController(
        db: db,
        document: document,
        listId: listId,
        draftId: draftId,
        parseResult: ReceiptParser().parse(
          OcrScanResult(lines: [OcrLine(text: 'ELMA 20,00')]),
        ),
      )..acceptAll();
      addTearDown(review.dispose);
      await review.commit();

      final backup = BackupRepository(db);
      final stable = await _backupRows(backup);
      await expectLater(
        backup.importBackup(stalePendingSnapshot, ImportMode.merge),
        throwsA(isA<BackupReceiptIdentityConflict>()),
      );
      expect(await _backupRows(backup), stable);

      final approvedSnapshot = await backup.exportBackup();
      await backup.importBackup(approvedSnapshot, ImportMode.merge);
      expect(await _backupRows(backup), stable);

      final withChangedIdentity =
          jsonDecode(approvedSnapshot) as Map<String, dynamic>;
      ((withChangedIdentity['receipts'] as List).single
              as Map<String, dynamic>)['identityKey'] =
          'another-document-identity';
      await expectLater(
        backup.importBackup(jsonEncode(withChangedIdentity), ImportMode.merge),
        throwsA(isA<BackupReceiptIdentityConflict>()),
      );
      expect(await _backupRows(backup), stable);

      final withChangedCapture =
          jsonDecode(approvedSnapshot) as Map<String, dynamic>;
      final incomingReceipt =
          (withChangedCapture['receipts'] as List).single
              as Map<String, dynamic>;
      final changedCapture =
          jsonDecode(incomingReceipt['captureDataJson'] as String)
              as Map<String, dynamic>;
      ((changedCapture['fragments'] as List).single as List).first['text'] =
          'ALTERED OCR EVIDENCE';
      incomingReceipt['captureDataJson'] = jsonEncode(changedCapture);
      await expectLater(
        backup.importBackup(jsonEncode(withChangedCapture), ImportMode.merge),
        throwsA(isA<BackupReceiptIdentityConflict>()),
      );
      expect(await _backupRows(backup), stable);
    },
  );

  test(
    'merge rejects identity already attached to another row before writes',
    () async {
      await db
          .into(db.receipts)
          .insert(
            ReceiptsCompanion.insert(
              listId: Value(listId),
              identityKey: const Value('same-document'),
            ),
          );
      final snapshot = await BackupRepository(db).exportBackup();
      final target = AppDatabase(NativeDatabase.memory());
      addTearDown(target.close);
      await target.into(target.receipts).insert(ReceiptsCompanion.insert());
      await target
          .into(target.receipts)
          .insert(
            ReceiptsCompanion.insert(identityKey: const Value('same-document')),
          );
      final backup = BackupRepository(target);
      final stable = await _backupRows(backup);
      await expectLater(
        backup.importBackup(snapshot, ImportMode.merge),
        throwsA(isA<BackupReceiptIdentityConflict>()),
      );
      expect(await _backupRows(backup), stable);
    },
  );

  test(
    'malformed capture evidence cannot enter a backup recovery transaction',
    () async {
      await db.into(db.receipts).insert(ReceiptsCompanion.insert());
      final repository = BackupRepository(db);
      final stable = await _backupRows(repository);
      for (final capture in ['{}', '{"version":999}', 'not-json']) {
        final data =
            jsonDecode(await repository.exportBackup()) as Map<String, dynamic>;
        (data['receipts'] as List).first['captureDataJson'] = capture;
        await expectLater(
          repository.importBackup(jsonEncode(data), ImportMode.merge),
          throwsFormatException,
        );
        expect(await _backupRows(repository), stable);
      }
    },
  );
}

Future<void> _recordPurchase(
  AppDatabase db,
  int listId, {
  int? receiptId,
  int? plannedItemId,
  String source = 'receiptOcr',
}) => ShoppingRepository(db).recordPurchase(
  listId: listId,
  receiptId: receiptId,
  plannedItemId: plannedItemId,
  name: 'Milk',
  normalizedName: 'milk',
  quantity: DecimalFixed.parse('1'),
  unitCode: 'piece',
  lineTotalMinor: 3290,
  source: source,
);

Future<Map<String, dynamic>> _backupRows(BackupRepository backup) async =>
    jsonDecode(await backup.exportBackup()) as Map<String, dynamic>
      ..remove('exportedAt');
