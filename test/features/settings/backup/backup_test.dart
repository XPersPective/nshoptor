import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/settings/backup/backup_repository.dart';
import 'package:nshoptor/features/settings/backup/csv_export.dart';
import 'package:nshoptor/features/shopping_mode/summary/result_repository.dart';

void main() {
  late AppDatabase db;
  late BackupRepository backup;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    backup = BackupRepository(db);
  });

  tearDown(() => db.close());

  Future<int> seedOneList() async {
    final listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(
            title: const Value('Pazar'),
            currencyCode: 'TRY',
            budgetMinorUnits: const Value(10000),
          ),
        );
    final tomatoId = await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: 'Domates',
            normalizedName: 'domates',
            plannedQuantity: '1.5',
            plannedUnitCode: 'kilogram',
            pricingInputMode: 'unitPrice',
            plannedUnitPrice: const Value('42.90'),
            plannedLineTotalMinorUnits: const Value(6435),
          ),
        );
    await db.into(db.purchaseEntries).insert(
          PurchaseEntriesCompanion.insert(
            listId: listId,
            plannedItemId: Value(tomatoId),
            name: 'Domates',
            normalizedName: 'domates',
            actualQuantity: '2',
            actualUnitCode: 'kilogram',
            actualLineTotalMinorUnits: 9000,
            source: const Value('manual'),
            userConfirmed: const Value(true),
          ),
        );
    return listId;
  }

  group('round-trip (merge)', () {
    test('full linked snapshot preserves newer rows and every copied relation', () async {
      final listId = await seedOneList();
      final item = (await db.select(db.plannedItems).get()).single;
      final entry = (await db.select(db.purchaseEntries).get()).single;
      final store = await db.into(db.stores).insert(StoresCompanion.insert(name: 'Store'));
      final category = await db.into(db.categories).insert(CategoriesCompanion.insert(name: 'Category'));
      final aisle = await db.into(db.aisles).insert(AislesCompanion.insert(name: 'Aisle', storeId: Value(store)));
      final product = await db.into(db.productMemory).insert(ProductMemoryCompanion.insert(
        canonicalName: 'Domates', normalizedName: 'domates', defaultCategoryId: Value(category)));
      await (db.update(db.shoppingLists)..where((r) => r.id.equals(listId))).write(ShoppingListsCompanion(storeId: Value(store)));
      await (db.update(db.plannedItems)..where((r) => r.id.equals(item.id))).write(PlannedItemsCompanion(
        productId: Value(product), categoryId: Value(category), aisleId: Value(aisle)));
      final receipt = await db.into(db.receipts).insert(ReceiptsCompanion.insert(
        listId: Value(listId), imagePaths: const Value(['owned-receipt.jpg'])));
      await (db.update(db.purchaseEntries)..where((r) => r.id.equals(entry.id))).write(PurchaseEntriesCompanion(receiptId: Value(receipt)));
      await db.into(db.productAliases).insert(ProductAliasesCompanion.insert(
        productId: product, alias: 'Tomato', normalizedAlias: 'tomato', storeId: Value(store)));
      await db.into(db.priceObservations).insert(PriceObservationsCompanion.insert(
        quantity: '2', unitCode: 'kilogram', unitPrice: '45', lineTotalMinorUnits: 9000,
        currencyCode: 'TRY', source: 'manual', productId: Value(product),
        purchaseEntryId: Value(entry.id), storeId: Value(store)));
      await db.into(db.receiptCandidateLines).insert(ReceiptCandidateLinesCompanion.insert(
        receiptId: receipt, rawText: 'Tomato', linkedPlannedItemId: Value(item.id)));
      for (final (type, owner) in [('list', listId), ('plannedItem', item.id), ('purchaseEntry', entry.id), ('receipt', receipt)]) {
        await db.into(db.attachments).insert(AttachmentsCompanion.insert(
          ownerType: type, ownerId: owner, filePath: 'record-only-$type.jpg'));
      }
      await db.into(db.reminders).insert(RemindersCompanion.insert(listId: listId, scheduledAt: DateTime(2030)));
      final snapshot = await backup.exportBackup();
      await db.into(db.plannedItems).insert(PlannedItemsCompanion.insert(
        listId: listId, name: 'Newer', normalizedName: 'newer', plannedQuantity: '1',
        plannedUnitCode: 'piece', pricingInputMode: 'unitPrice'));
      await db.into(db.priceObservations).insert(PriceObservationsCompanion.insert(
        quantity: '1', unitCode: 'piece', unitPrice: '1', lineTotalMinorUnits: 100,
        currencyCode: 'TRY', source: 'manual', purchaseEntryId: Value(entry.id)));
      await backup.importBackup(snapshot, ImportMode.merge);
      expect((await db.select(db.plannedItems).get()).where((r) => r.name == 'Newer'), hasLength(1));
      expect(await db.select(db.priceObservations).get(), hasLength(2));
      expect((await db.select(db.priceObservations).get()).last.purchaseEntryId, entry.id);

      final other = AppDatabase(NativeDatabase.memory());
      try {
        await BackupRepository(other).importBackup(snapshot, ImportMode.merge);
        expect((await other.select(other.purchaseEntries).get()).single.receiptId, receipt);
      } finally { await other.close(); }

      final before = jsonDecode(await backup.exportBackup()) as Map<String, dynamic>;
      final saved = jsonDecode(snapshot) as Map<String, dynamic>;
      await backup.importBackup(snapshot, ImportMode.separate);
      final after = jsonDecode(await backup.exportBackup()) as Map<String, dynamic>;
      for (final key in saved.keys.where((k) => saved[k] is List)) {
        final rows = after[key] as List;
        expect(rows.length, (before[key] as List).length + (saved[key] as List).length, reason: key);
        expect(rows.map((r) => r['id']).toSet().length, rows.length, reason: '$key IDs');
      }
      final copiedList = (await db.select(db.shoppingLists).get()).last;
      final copiedItem = (await db.select(db.plannedItems).get()).last;
      final copiedEntry = (await db.select(db.purchaseEntries).get()).last;
      final copiedReceipt = (await db.select(db.receipts).get()).last;
      final copiedProduct = (await db.select(db.productMemory).get()).last;
      final copiedStore = (await db.select(db.stores).get()).last;
      final copiedCategory = (await db.select(db.categories).get()).last;
      final copiedAisle = (await db.select(db.aisles).get()).last;
      expect(copiedList.storeId, copiedStore.id);
      expect(copiedAisle.storeId, copiedStore.id);
      expect(copiedProduct.defaultCategoryId, copiedCategory.id);
      expect((copiedItem.listId, copiedItem.productId, copiedItem.categoryId, copiedItem.aisleId),
        (copiedList.id, copiedProduct.id, copiedCategory.id, copiedAisle.id));
      expect((copiedEntry.listId, copiedEntry.plannedItemId, copiedEntry.receiptId),
        (copiedList.id, copiedItem.id, copiedReceipt.id));
      expect(copiedReceipt.listId, copiedList.id);
      expect(copiedReceipt.imagePaths, ['owned-receipt.jpg']);
      final alias = (await db.select(db.productAliases).get()).last;
      expect((alias.productId, alias.storeId), (copiedProduct.id, copiedStore.id));
      final observation = (await db.select(db.priceObservations).get()).last;
      expect((observation.productId, observation.purchaseEntryId, observation.storeId),
        (copiedProduct.id, copiedEntry.id, copiedStore.id));
      final candidate = (await db.select(db.receiptCandidateLines).get()).last;
      expect((candidate.receiptId, candidate.linkedPlannedItemId), (copiedReceipt.id, copiedItem.id));
      final owners = {'list': copiedList.id, 'plannedItem': copiedItem.id,
        'purchaseEntry': copiedEntry.id, 'receipt': copiedReceipt.id};
      for (final attachment in (await db.select(db.attachments).get()).skip(4)) {
        expect(attachment.ownerId, owners[attachment.ownerType]);
      }
      expect((await db.select(db.reminders).get()).last.listId, copiedList.id);

      final broken = jsonDecode(snapshot) as Map<String, dynamic>;
      (broken['plannedItems'] as List).first['productId'] = 9999;
      final stable = await backup.exportBackup();
      await expectLater(backup.importBackup(jsonEncode(broken), ImportMode.separate), throwsFormatException);
      // exportedAt changes, compare records rather than clock metadata.
      final stableRows = jsonDecode(stable) as Map<String, dynamic>..remove('exportedAt');
      final currentRows = jsonDecode(await backup.exportBackup()) as Map<String, dynamic>..remove('exportedAt');
      expect(currentRows, stableRows);
    });
    test('dışa aktar → içe aktar: aynı kayıtlar gelir', () async {
      await seedOneList();
      final json = await backup.exportBackup();
      final preview = backup.validate(json);
      expect(preview.listCount, 1);
      expect(preview.itemCount, 1);
      expect(preview.entryCount, 1);

      await backup.importBackup(json, ImportMode.merge);

      final lists = await db.select(db.shoppingLists).get();
      expect(lists, hasLength(1)); // aynı id → üzerine yazıldı
      expect(lists.single.title, 'Pazar');
      final items = await db.select(db.plannedItems).get();
      expect(items.single.plannedQuantity, '1.5');
    });

    test('farklı veritabanına merge: kayıtlar eklenir', () async {
      await seedOneList();
      final json = await backup.exportBackup();

      final db2 = AppDatabase(NativeDatabase.memory());
      await BackupRepository(db2).importBackup(json, ImportMode.merge);
      expect(await db2.select(db.shoppingLists).get(), hasLength(1));
      expect(await db2.select(db.purchaseEntries).get(), hasLength(1));
      await db2.close();
    });
  });

  group('bozuk dosya reddi (spec §6.14)', () {
    test('malformed rows, IDs, references and arithmetic fail before mutation', () async {
      final firstList = await seedOneList();
      await seedOneList();
      final firstItem = (await db.select(db.plannedItems).get()).first.id;
      final receipt = await db.into(db.receipts).insert(ReceiptsCompanion.insert(listId: Value(firstList)));
      await db.into(db.receiptCandidateLines).insert(ReceiptCandidateLinesCompanion.insert(
        receiptId: receipt, rawText: 'QA', linkedPlannedItemId: Value(firstItem),
        parsedQuantity: const Value('1'), parsedUnitPrice: const Value('1')));
      await db.into(db.attachments).insert(AttachmentsCompanion.insert(ownerType: 'list', ownerId: firstList, filePath: 'record-only.jpg'));
      final snapshot = await backup.exportBackup();
      final stable = jsonDecode(snapshot) as Map<String, dynamic>..remove('exportedAt');
      for (final mutate in <void Function(Map<String, dynamic>)>[
        (d) => d['version'] = 0,
        (d) => d['version'] = 1.0,
        (d) => d['stores'] = 'not an array',
        (d) => (d['plannedItems'] as List).first['name'] = null,
        (d) => (d['plannedItems'] as List).first['plannedQuantity'] = 'NaN',
        (d) => (d['plannedItems'] as List).first['id'] = -1,
        (d) => (d['plannedItems'] as List).add(Map<String, dynamic>.from((d['plannedItems'] as List).first)),
        (d) => (d['plannedItems'] as List).first['productId'] = 99999,
        (d) => (d['purchaseEntries'] as List).first['plannedItemId'] = (d['plannedItems'] as List).last['id'],
        (d) => (d['lists'] as List).first['currencyCode'] = 'ZZZ',
        (d) => (d['receipts'] as List).first['imagePaths'] = [42],
        (d) => (d['receiptCandidateLines'] as List).first['parsedQuantity'] = 'NaN',
        (d) => (d['receiptCandidateLines'] as List).first['linkedPlannedItemId'] = (d['plannedItems'] as List).last['id'],
        (d) => (d['attachments'] as List).first['ownerType'] = 'unsupported',
        (d) => (d['attachments'] as List).first['ownerId'] = 99999,
        (d) { final item = (d['receiptCandidateLines'] as List).first;
          item['parsedQuantity'] = '999999999999999'; item['parsedUnitPrice'] = '999999999999999'; },
        (d) { final item = (d['plannedItems'] as List).first;
          item['plannedQuantity'] = '999999999999999'; item['plannedUnitPrice'] = '999999999999999'; },
      ]) {
        final data = jsonDecode(snapshot) as Map<String, dynamic>;
        mutate(data);
        final invalid = jsonEncode(data);
        expect(() => backup.validate(invalid), throwsFormatException);
        await expectLater(backup.importBackup(invalid, ImportMode.merge), throwsFormatException);
        final current = jsonDecode(await backup.exportBackup()) as Map<String, dynamic>..remove('exportedAt');
        expect(current, stable);
      }
    });

    test('JPY/KWD genuine zero and signed returns remain valid', () async {
      for (final (code, price, minor) in [('JPY', '0', 0), ('KWD', '0.001', -1)]) {
        final id = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: code));
        await db.into(db.purchaseEntries).insert(PurchaseEntriesCompanion.insert(
          listId: id, name: 'Return', normalizedName: 'return', actualQuantity: '-1',
          actualUnitCode: 'piece', actualUnitPrice: Value(price), actualLineTotalMinorUnits: minor));
      }
      final snapshot = await backup.exportBackup();
      await backup.importBackup(snapshot, ImportMode.merge);
      expect((await db.select(db.purchaseEntries).get()).map((r) => r.actualLineTotalMinorUnits), [0, -1]);
    });
    test('geçersiz JSON: mevcut veri değişmez', () async {
      await seedOneList();
      final before = await db.select(db.shoppingLists).get();

      const broken = '{"format": "nshoptor-backup", "version": 1, "lists": [';
      expect(
        () => backup.validate(broken),
        throwsFormatException,
      );
      expect(
        () => backup.importBackup(broken, ImportMode.merge),
        throwsException,
      );

      final after = await db.select(db.shoppingLists).get();
      expect(after.length, before.length);
    });

    test('yanlış format işareti reddedilir', () async {
      const wrong =
          '{"format": "other-app", "version": 1, "lists": [], '
          '"plannedItems": [], "purchaseEntries": []}';
      expect(() => backup.validate(wrong), throwsFormatException);
    });

    test('daha yüksek sürüm reddedilir', () async {
      const future =
          '{"format": "nshoptor-backup", "version": 99, "lists": [], '
          '"plannedItems": [], "purchaseEntries": []}';
      expect(() => backup.validate(future), throwsFormatException);
    });
  });

  group('ayrı içe aktarma (separate)', () {
    test('yeni kimliklerle kopyalanır; mevcut veri korunur', () async {
      final originalId = await seedOneList();
      final json = await backup.exportBackup();

      final preview = await backup.importBackup(json, ImportMode.separate);
      expect(preview.listCount, 1);

      final lists = await db.select(db.shoppingLists).get();
      expect(lists.length, 2); // orijinal + kopya
      final copy = lists.firstWhere((l) => l.id != originalId);
      expect(copy.title, 'Pazar');
      expect(copy.status, lists.firstWhere((l) => l.id == originalId).status);

      // zincir: kopyanın ürünleri de yeni kimlikle geldi
      final items = await db.select(db.plannedItems).get();
      expect(items.length, 2);
      final copyItem = items.firstWhere((i) => i.listId == copy.id);
      expect(copyItem.name, 'Domates');
      expect(copyItem.plannedLineTotalMinorUnits, 6435);
      // FK zinciri bozuk değil: kopya ürünün kaydı da kopyaya bağlı
      final entries = await db.select(db.purchaseEntries).get();
      expect(entries.length, 2);
      final copyEntry =
          entries.firstWhere((e) => e.listId == copy.id);
      expect(copyEntry.plannedItemId, copyItem.id);
    });
  });

  group('CSV ve paylaşım metni (spec §6.14)', () {
    test('CSV preserves signed minor units and quotes formula-like text', () {
      for (final (currency, minor, expected) in [
        ('TRY', -50, '-0.50'), ('TRY', -123, '-1.23'),
        ('KWD', -1, '-0.001'), ('JPY', -1, '-1'),
        ('TRY', -9223372036854775808, '-92233720368547758.08'),
      ]) {
        final result = ListResult(currencyCode: currency, plannedTotalMinor: 0,
          actualTotalMinor: minor, unplannedTotalMinor: 0, unpurchasedPlannedMinor: 0,
          totalDiscountMinor: 0, variancePercent: null, accuracy: null, rows: [
            ItemResultRow(name: '=1+2,"quoted"\r\nline', plannedQuantity: null,
              actualQuantity: null, plannedUnitPrice: null, actualUnitPrice: null,
              plannedLineTotalMinor: 0, actualLineTotalMinor: minor,
              lineVarianceMinor: minor, variancePercent: null, discountMinor: 0,
              groups: {}, notTaken: false, isUnplanned: false, userConfirmed: true),
          ]);
        final csv = listResultToCsv(result);
        expect(csv, contains(',$expected,$expected,'));
        expect(csv, contains('"\t=1+2,""quoted""\r\nline"'));
      }
    });

    test('CSV distinguishes absent actual/comparison from genuine zero', () {
      for (final (known, notTaken, unplanned, expected) in [
        (false, false, false, ',,,""'), (true, true, false, ',,,""'),
        (true, false, true, ',,0.00,,""'), (true, false, false, ',,0.00,0.00,""'),
      ]) {
        final result = ListResult(currencyCode: 'TRY', plannedTotalMinor: 0,
          actualTotalMinor: 0, unplannedTotalMinor: 0, unpurchasedPlannedMinor: 0,
          totalDiscountMinor: 0, variancePercent: null, accuracy: null, rows: [
            ItemResultRow(name: 'sample', plannedQuantity: null, actualQuantity: null,
              plannedUnitPrice: null, actualUnitPrice: null, plannedLineTotalMinor: 0,
              actualLineTotalMinor: 0, lineVarianceMinor: 0, variancePercent: null,
              discountMinor: 0, groups: {}, notTaken: notTaken, isUnplanned: unplanned,
              userConfirmed: true, actualKnown: known),
          ]);
        expect(listResultToCsv(result), contains(expected));
      }
    });

    test('CSV başlık + satır üretir; virgüllü ad tırnaklanır', () async {
      final listId = await db.into(db.shoppingLists).insert(
            ShoppingListsCompanion.insert(currencyCode: 'TRY'),
          );
      await db.into(db.plannedItems).insert(
            PlannedItemsCompanion.insert(
              listId: listId,
              name: 'Domates, çalı',
              normalizedName: 'domates cali',
              plannedQuantity: '1.5',
              plannedUnitCode: 'kilogram',
              pricingInputMode: 'unitPrice',
              plannedUnitPrice: const Value('42.90'),
              plannedLineTotalMinorUnits: const Value(6435),
            ),
          );
      final result = await ResultRepository(db).compute(listId);
      final csv = listResultToCsv(result);
      final lines = csv.trim().split('\n');

      expect(lines.first, contains('Urun'));
      expect(lines, hasLength(2));
      expect(lines.last, contains('"Domates, çalı"'));
      expect(lines.last, contains('1.5'));
      expect(lines.last, contains('42.90'));
    });

    test('paylaşılabilir özet metni temel satırları içerir', () async {
      final listId = await db.into(db.shoppingLists).insert(
            ShoppingListsCompanion.insert(currencyCode: 'TRY'),
          );
      await db.into(db.plannedItems).insert(
            PlannedItemsCompanion.insert(
              listId: listId,
              name: 'Ekmek',
              normalizedName: 'ekmek',
              plannedQuantity: '1',
              plannedUnitCode: 'adet',
              pricingInputMode: 'lineTotal',
              plannedLineTotalMinorUnits: const Value(1500),
            ),
          );
      final result = await ResultRepository(db).compute(listId);
      final text = summaryToShareText(result);
      expect(text, contains('NShoptor'));
      expect(text, contains('Planlanan: ₺15.00'));
      expect(text, contains('Gercek: —'));
      expect(text, contains('Fark: —'));
      expect(text, contains('Alinmayan plan: ₺15.00'));
    });
  });
}
