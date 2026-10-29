import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/receipts/receipt_repository.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/settings/backup/backup_repository.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<int> list() => ListRepository(db).createList(currencyCode: 'TRY');
  Future<int> receipt(int listId) => db
      .into(db.receipts)
      .insert(ReceiptsCompanion.insert(listId: Value(listId)));
  Future<int> item(int listId, {int? creator, String name = 'Milk'}) =>
      ItemRepository(db).addItem(
        listId: listId,
        name: name,
        quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece',
        priceIsUnitPrice: false,
        createdByReceiptId: creator,
      );
  Future<void> buy(int listId, int itemId, int receiptId) =>
      ShoppingRepository(db).recordPurchase(
        listId: listId,
        plannedItemId: itemId,
        receiptId: receiptId,
        name: 'Milk',
        normalizedName: 'milk',
        quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece',
        lineTotalMinor: 13000,
        source: 'receiptOcr',
        replaceExisting: false,
      );

  test(
    'delete preserves manual/unknown rows even created after the receipt',
    () async {
      final id = await list();
      final r = await receipt(id);
      final manual = await item(id);
      final own = await item(id, creator: r, name: 'Bread');
      await buy(id, manual, r);
      await buy(id, own, r);
      // Real timestamps can be equal to the second. The old heuristic deletes
      // this manual row if no retained candidate explicitly links it.
      await db.customStatement(
        'UPDATE planned_items SET created_at = created_at + 5',
      );
      await ReceiptRepository(db).delete(r);
      expect((await db.select(db.plannedItems).get()).single.id, manual);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
    },
  );

  test('delete includes unpriced partial rows, retains rows bought by another receipt', () async {
    final id = await list();
    final first = await receipt(id);
    final second = await receipt(id);
    final partial = await item(id, creator: first, name: 'Partial');
    final shared = await item(id, creator: first);
    final other = await item(id, creator: second, name: 'Other');
    await buy(id, shared, first);
    await buy(id, shared, second);
    await buy(id, other, second);
    await ReceiptRepository(db).delete(first);
    final remaining = await db.select(db.plannedItems).get();
    expect(remaining.map((r) => r.id), containsAll([shared, other]));
    expect(remaining.map((r) => r.id), isNot(contains(partial)));
    expect(
      remaining.singleWhere((r) => r.id == shared).createdByReceiptId,
      isNull,
    );
    expect((await db.select(db.receipts).get()).single.id, second);
    expect(
      (await db.select(db.purchaseEntries).get()).map((r) => r.receiptId),
      everyElement(second),
    );
    expect(await db.customSelect('PRAGMA foreign_key_check').get(), isEmpty);
  });

  test(
    'creator cannot be a foreign receipt, anonymous receipt or existing row',
    () async {
      final a = await list();
      final b = await list();
      final r = await receipt(a);
      final anonymous = await db
          .into(db.receipts)
          .insert(ReceiptsCompanion.insert());
      await expectLater(item(b, creator: r), throwsArgumentError);
      await expectLater(item(a, creator: anonymous), throwsArgumentError);
      final own = await item(a, creator: r);
      await expectLater(
        ItemRepository(db).addItem(
          listId: a,
          existingId: own,
          name: 'Changed',
          quantity: DecimalFixed.fromInt(1),
          unitCode: 'piece',
          priceIsUnitPrice: false,
          createdByReceiptId: r,
        ),
        throwsArgumentError,
      );
    },
  );

  for (final mode in ImportMode.values) {
    test(
      'ownership survives ${mode.name} backup with receipt IDs remapped',
      () async {
        final id = await list();
        final r = await receipt(id);
        await item(id, creator: r);
        final backup = BackupRepository(db);
        final snapshot = await backup.exportBackup();
        await backup.importBackup(snapshot, mode);
        final rows = await db.select(db.plannedItems).get();
        expect(rows.length, mode == ImportMode.merge ? 1 : 2);
        for (final row in rows) {
          final owner = await (db.select(
            db.receipts,
          )..where((t) => t.id.equals(row.createdByReceiptId!))).getSingle();
          expect(owner.listId, row.listId);
        }
        if (mode == ImportMode.separate) {
          expect(rows.last.createdByReceiptId, isNot(r));
          await ReceiptRepository(db).delete(rows.last.createdByReceiptId!);
          expect(
            (await db.select(db.plannedItems).get()).single.createdByReceiptId,
            r,
          );
        }
        expect(
          await db.customSelect('PRAGMA foreign_key_check').get(),
          isEmpty,
        );
      },
    );
  }

  test(
    'legacy merge preserves provenance; separate copy keeps unknown provenance',
    () async {
      final id = await list();
      final r = await receipt(id);
      await item(id, creator: r);
      final backup = BackupRepository(db);
      final legacy =
          jsonDecode(await backup.exportBackup()) as Map<String, dynamic>;
      for (final row in legacy['plannedItems'] as List) {
        (row as Map).remove('createdByReceiptId');
      }
      await backup.importBackup(jsonEncode(legacy), ImportMode.merge);
      expect(
        (await db.select(db.plannedItems).get()).single.createdByReceiptId,
        r,
      );
      await backup.importBackup(jsonEncode(legacy), ImportMode.separate);
      expect(
        (await db.select(db.plannedItems).get()).last.createdByReceiptId,
        isNull,
      );
    },
  );

  test('malformed/missing/cross-list/anonymous creator rejects before import writes', () async {
    final a = await list();
    final b = await list();
    final r = await receipt(a);
    final foreign = await receipt(b);
    final anonymous = await db
        .into(db.receipts)
        .insert(ReceiptsCompanion.insert());
    await item(a, creator: r);
    final backup = BackupRepository(db);
    final snapshot = await backup.exportBackup();
    for (final value in [foreign, anonymous, 999999, '1', -1]) {
      final bad = jsonDecode(snapshot) as Map<String, dynamic>;
      (bad['plannedItems'] as List).first['createdByReceiptId'] = value;
      await expectLater(
        backup.importBackup(jsonEncode(bad), ImportMode.separate),
        throwsFormatException,
      );
      expect(
        jsonDecode(await backup.exportBackup())..remove('exportedAt'),
        jsonDecode(snapshot)..remove('exportedAt'),
      );
    }
  });

  test(
    'merge rejects moving a creator with locally retained rows atomically',
    () async {
      final a = await list();
      final b = await list();
      final r = await receipt(a);
      await item(a, creator: r);
      final backup = BackupRepository(db);
      final before = await backup.exportBackup();
      final incoming = jsonDecode(before) as Map<String, dynamic>;
      incoming['plannedItems'] = [];
      (incoming['receipts'] as List).single['listId'] = b;
      backup.validate(jsonEncode(incoming));
      await expectLater(
        backup.importBackup(jsonEncode(incoming), ImportMode.merge),
        throwsFormatException,
      );
      expect(
        jsonDecode(await backup.exportBackup())..remove('exportedAt'),
        jsonDecode(before)..remove('exportedAt'),
      );
    },
  );

  test(
    'same-name partial rows of two drafts match only their own creator',
    () async {
      final id = await list();
      final first = await receipt(id);
      final second = await receipt(id);
      final firstItem = await item(id, creator: first);
      final secondItem = await item(id, creator: second);
      final lines = ReceiptParser()
          .parse(
            const OcrScanResult(
              lines: [
                OcrLine(text: 'Milk 10,00'),
                OcrLine(text: 'TOPLAM 10,00'),
              ],
            ),
          )
          .lines;
      final matches = await ReceiptMatcher(db)
          .match(lines, listId: id, receiptId: second);
      expect(matches.single.$2?.id, secondItem);
      await ReceiptRepository(db).delete(first);
      final rows = await db.select(db.plannedItems).get();
      expect(rows.single.id, secondItem);
      expect(rows.map((r) => r.id), isNot(contains(firstItem)));
    },
  );

  test('nonempty v4 migrates with unknown ownership and preserves money/relations on reopen', () async {
    final dir = await Directory.systemTemp.createTemp('receipt-v4-');
    final file = File('${dir.path}/old.sqlite');
    final old = AppDatabase(NativeDatabase(file));
    final id = await old
        .into(old.shoppingLists)
        .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
    final r = await old
        .into(old.receipts)
        .insert(ReceiptsCompanion.insert(listId: Value(id)));
    final row = await ItemRepository(old).addItem(
      listId: id,
      name: 'Milk',
      quantity: DecimalFixed.parse('1.5'),
      unitCode: 'litre',
      priceIsUnitPrice: false,
      price: DecimalFixed.parse('130.01'),
    );
    await ShoppingRepository(old).recordPurchase(
      listId: id,
      plannedItemId: row,
      receiptId: r,
      name: 'Milk',
      normalizedName: 'milk',
      quantity: DecimalFixed.parse('1.5'),
      unitCode: 'litre',
      lineTotalMinor: 13001,
      source: 'receiptOcr',
    );
    await old.customStatement(
      'ALTER TABLE planned_items DROP COLUMN created_by_receipt_id',
    );
    await old.customStatement('PRAGMA user_version = 4');
    await old.close();
    final migrated = AppDatabase(NativeDatabase(file));
    try {
      final item = (await migrated.select(migrated.plannedItems).get()).single;
      expect(item.createdByReceiptId, isNull);
      expect(item.plannedQuantity, '1.5');
      expect(item.plannedLineTotalMinorUnits, 13001);
      expect(
        (await migrated.select(migrated.purchaseEntries).get())
            .single
            .receiptId,
        r,
      );
      expect(
        await migrated.customSelect('PRAGMA foreign_key_check').get(),
        isEmpty,
      );
      await ReceiptRepository(migrated).delete(r);
      expect(
        (await migrated.select(migrated.plannedItems).get()).single.id,
        row,
      );
    } finally {
      await migrated.close();
      await dir.delete(recursive: true);
    }
  });
}
