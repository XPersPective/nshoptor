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

  tearDown(() async {
    // round-trip testi close sonrası da doğrulama yapabilir.
  });

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
      expect(text, contains('Gercek: ₺0.00'));
    });
  });
}
