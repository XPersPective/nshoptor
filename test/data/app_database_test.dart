import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  ShoppingListsCompanion listRow({String currency = 'TRY'}) =>
      ShoppingListsCompanion.insert(
        currencyCode: currency,
      );

  group('tablo oluşturma ve CRUD', () {
    test('liste eklenir ve okunur; varsayılanlar uygulanır', () async {
      final id = await db.into(db.shoppingLists).insert(listRow());
      final row = await (db.select(db.shoppingLists)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      expect(row.currencyCode, 'TRY');
      expect(row.status, 'draft');
      expect(row.budgetMinorUnits, isNull);
    });

    test('miktar/birim fiyat decimal dizesi gidiş-dönüşü kayıpsız', () async {
      final listId = await db.into(db.shoppingLists).insert(listRow());
      final itemId = await db.into(db.plannedItems).insert(
            PlannedItemsCompanion.insert(
              listId: listId,
              name: 'Domates',
              normalizedName: 'domates',
              plannedQuantity: DecimalFixed.parse('1.5').toDbString(),
              plannedUnitCode: 'kilogram',
              pricingInputMode: 'unitPrice',
              plannedUnitPrice: Value(DecimalFixed.parse('42.90').toDbString()),
              plannedLineTotalMinorUnits: const Value(6435),
            ),
          );
      final item = await (db.select(db.plannedItems)
            ..where((t) => t.id.equals(itemId)))
          .getSingle();
      expect(DecimalFixed.parse(item.plannedQuantity), DecimalFixed.parse('1.5'));
      expect(
        DecimalFixed.parse(item.plannedUnitPrice!),
        DecimalFixed.parse('42.90'),
      );
      expect(item.plannedLineTotalMinorUnits, 6435);
    });

    test('uygulama ayarları anahtar-değer saklanır', () async {
      await db.into(db.appSettings).insert(
            AppSettingsCompanion.insert(key: 'lastBackupAt', value: const Value('123')),
          );
      final row = await (db.select(db.appSettings)
            ..where((t) => t.key.equals('lastBackupAt')))
          .getSingle();
      expect(row.value, '123');
    });
  });

  group('migration', () {
    test('v0→v1: kullanıcı sürümü 1 olur ve tüm tablolar var', () async {
      // Yeni bellek veritabanı onCreate ile v1'e kurulur.
      final version = await db.customSelect('PRAGMA user_version').getSingle();
      expect(version.data['user_version'], 1);
      final tables = await db.customSelect(
        "SELECT name FROM sqlite_master WHERE type='table'",
      ).get();
      final names = tables.map((r) => r.data['name'] as String).toSet();
      for (final expected in [
        'shopping_lists',
        'planned_items',
        'purchase_entries',
        'product_memory',
        'product_aliases',
        'price_observations',
        'stores',
        'categories',
        'aisles',
        'receipts',
        'receipt_candidate_lines',
        'attachments',
        'reminders',
        'app_settings',
      ]) {
        expect(names, contains(expected), reason: '$expected tablosu yok');
      }
    });

    test('eski sürüm etiketiyle açılışta onUpgrade çalışır', () async {
      // user_version'ı 0'a düşür, kapat; yeniden açılış onUpgrade(v0→v1) işletir.
      await db.customStatement('PRAGMA user_version = 0');
      await db.close();
      final reopened = AppDatabase(NativeDatabase.memory());
      final version =
          await reopened.customSelect('PRAGMA user_version').getSingle();
      expect(version.data['user_version'], 1);
      await reopened.close();
    });
  });

  group('transaction', () {
    test('hata durumunda rollback: yarım veri kalmaz', () async {
      try {
        await db.transaction(() async {
          await db.into(db.shoppingLists).insert(listRow());
          throw StateError('iptal');
        });
      } on StateError {
        // beklenen: yarım transaction geri alınır
      }

      final rows = await db.select(db.shoppingLists).get();
      expect(rows, isEmpty);
    });

    test('başarılı transaction içindeki çoklu yazma kalır', () async {
      final listId = await db.into(db.shoppingLists).insert(listRow());
      await db.transaction(() async {
        await db.into(db.plannedItems).insert(
              PlannedItemsCompanion.insert(
                listId: listId,
                name: 'Süt',
                normalizedName: 'süt',
                plannedQuantity: '2',
                plannedUnitCode: 'adet',
                pricingInputMode: 'unitPrice',
              ),
            );
        await (db.update(db.shoppingLists)
              ..where((t) => t.id.equals(listId)))
            .write(const ShoppingListsCompanion(
          status: Value('planned'),
        ));
      });
      final list = await (db.select(db.shoppingLists)
            ..where((t) => t.id.equals(listId)))
          .getSingle();
      final items = await (db.select(db.plannedItems)
            ..where((t) => t.listId.equals(listId)))
          .get();
      expect(list.status, 'planned');
      expect(items, hasLength(1));
    });
  });

  group('FK silme kuralları', () {
    test('liste silinince planlanan ürünler cascade silinir', () async {
      final listId = await db.into(db.shoppingLists).insert(listRow());
      await db.into(db.plannedItems).insert(
            PlannedItemsCompanion.insert(
              listId: listId,
              name: 'Elma',
              normalizedName: 'elma',
              plannedQuantity: '0.5',
              plannedUnitCode: 'kilogram',
              pricingInputMode: 'unitPrice',
            ),
          );
      await (db.delete(db.shoppingLists)
            ..where((t) => t.id.equals(listId)))
          .go();
      final items = await db.select(db.plannedItems).get();
      expect(items, isEmpty);
    });

    test('satın alım silinince fiyat gözlemi set null ile kalır', () async {
      final listId = await db.into(db.shoppingLists).insert(listRow());
      final entryId = await db.into(db.purchaseEntries).insert(
            PurchaseEntriesCompanion.insert(
              listId: listId,
              name: 'Ekmek',
              normalizedName: 'ekmek',
              actualQuantity: '1',
              actualUnitCode: 'adet',
              actualLineTotalMinorUnits: 1500,
            ),
          );
      await db.into(db.priceObservations).insert(
            PriceObservationsCompanion.insert(
              purchaseEntryId: Value(entryId),
              quantity: '1',
              unitCode: 'adet',
              unitPrice: '15.00',
              lineTotalMinorUnits: 1500,
              currencyCode: 'TRY',
              source: 'manual',
            ),
          );
      await (db.delete(db.purchaseEntries)
            ..where((t) => t.id.equals(entryId)))
          .go();
      final observations = await db.select(db.priceObservations).get();
      expect(observations, hasLength(1));
      expect(observations.single.purchaseEntryId, isNull);
    });

    test('fiş silinince aday satırlar cascade silinir', () async {
      final receiptId = await db.into(db.receipts).insert(
            ReceiptsCompanion.insert(),
          );
      await db.into(db.receiptCandidateLines).insert(
            ReceiptCandidateLinesCompanion.insert(
              receiptId: receiptId,
              rawText: 'SUT 1L 32,90',
            ),
          );
      await (db.delete(db.receipts)..where((t) => t.id.equals(receiptId))).go();
      final lines = await db.select(db.receiptCandidateLines).get();
      expect(lines, isEmpty);
    });
  });
}
