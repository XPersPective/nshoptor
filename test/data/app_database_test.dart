import 'package:drift/drift.dart' show Value;

import 'dart:io';

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
      ShoppingListsCompanion.insert(currencyCode: currency);

  group('tablo oluşturma ve CRUD', () {
    test('liste eklenir ve okunur; varsayılanlar uygulanır', () async {
      final id = await db.into(db.shoppingLists).insert(listRow());
      final row = await (db.select(
        db.shoppingLists,
      )..where((t) => t.id.equals(id))).getSingle();
      expect(row.currencyCode, 'TRY');
      expect(row.status, 'draft');
      expect(row.budgetMinorUnits, isNull);
    });

    test('miktar/birim fiyat decimal dizesi gidiş-dönüşü kayıpsız', () async {
      final listId = await db.into(db.shoppingLists).insert(listRow());
      final itemId = await db
          .into(db.plannedItems)
          .insert(
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
      final item = await (db.select(
        db.plannedItems,
      )..where((t) => t.id.equals(itemId))).getSingle();
      expect(
        DecimalFixed.parse(item.plannedQuantity),
        DecimalFixed.parse('1.5'),
      );
      expect(
        DecimalFixed.parse(item.plannedUnitPrice!),
        DecimalFixed.parse('42.90'),
      );
      expect(item.plannedLineTotalMinorUnits, 6435);
    });

    test('uygulama ayarları anahtar-değer saklanır', () async {
      await db
          .into(db.appSettings)
          .insert(
            AppSettingsCompanion.insert(
              key: 'lastBackupAt',
              value: const Value('123'),
            ),
          );
      final row = await (db.select(
        db.appSettings,
      )..where((t) => t.key.equals('lastBackupAt'))).getSingle();
      expect(row.value, '123');
    });
  });

  group('migration', () {
    test('fresh database uses schema 4 and all tables exist', () async {
      final version = await db.customSelect('PRAGMA user_version').getSingle();
      expect(version.data['user_version'], 4);
      final tables = await db
          .customSelect("SELECT name FROM sqlite_master WHERE type='table'")
          .get();
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

    test(
      'v2 file migration preserves money and null legacy editor mode',
      () async {
        final dir = Directory.systemTemp.createTempSync('nshoptor-migration-');
        final file = File('${dir.path}/v2.sqlite');
        final previous = AppDatabase(NativeDatabase(file));
        await previous.into(previous.shoppingLists).insert(listRow());
        await previous
            .into(previous.purchaseEntries)
            .insert(
              PurchaseEntriesCompanion.insert(
                listId: 1,
                name: 'Kıyma',
                normalizedName: 'kiyma',
                actualQuantity: '400',
                actualUnitCode: 'gram',
                actualUnitPrice: const Value('0.875'),
                actualLineTotalMinorUnits: 35000,
              ),
            );
        // Reconstruct the actual v2 column shape, then reopen the same file.
        await _removeReceiptIdentitySchema(previous);
        await previous.customStatement(
          'ALTER TABLE purchase_entries DROP COLUMN pricing_input_mode',
        );
        await previous.customStatement('PRAGMA user_version = 2');
        await previous.close();
        final reopened = AppDatabase(NativeDatabase(file));
        addTearDown(() async {
          await reopened.close();
          dir.deleteSync(recursive: true);
        });
        final version = await reopened
            .customSelect('PRAGMA user_version')
            .getSingle();
        expect(version.data['user_version'], 4);
        final row =
            (await reopened.select(reopened.purchaseEntries).get()).single;
        expect(row.pricingInputMode, isNull);
        expect(row.actualUnitPrice, '0.875');
        expect(row.actualLineTotalMinorUnits, 35000);
        expect(row.actualQuantity, '400');
        final roundTrip = PurchaseEntry.fromJson(row.toJson());
        expect(roundTrip.pricingInputMode, isNull);
        await (reopened.update(
          reopened.purchaseEntries,
        )..where((t) => t.id.equals(row.id))).write(
          const PurchaseEntriesCompanion(pricingInputMode: Value('lineTotal')),
        );
        final totalRow =
            (await reopened.select(reopened.purchaseEntries).get()).single;
        expect(
          PurchaseEntry.fromJson(totalRow.toJson()).pricingInputMode,
          'lineTotal',
        );
      },
    );

    test(
      'nonempty v3 file preserves receipts and purchase relations',
      () async {
        final dir = Directory.systemTemp.createTempSync('nshoptor-receipt-v3-');
        final file = File('${dir.path}/v3.sqlite');
        final previous = AppDatabase(NativeDatabase(file));
        final listId = await previous
            .into(previous.shoppingLists)
            .insert(listRow());
        final receiptId = await previous
            .into(previous.receipts)
            .insert(
              ReceiptsCompanion.insert(
                listId: Value(listId),
                imagePaths: const Value(['legacy.jpg']),
                rawOcrText: const Value('MARKET\nSUT 32,90\nTOPLAM 32,90'),
                confirmedStore: const Value('Market'),
                confirmedTotalMinorUnits: const Value(3290),
                processingStatus: const Value('reviewed'),
              ),
            );
        final candidateId = await previous
            .into(previous.receiptCandidateLines)
            .insert(
              ReceiptCandidateLinesCompanion.insert(
                receiptId: receiptId,
                rawText: 'SUT 32,90',
                parsedName: const Value('Süt'),
                parsedLineTotalMinorUnits: const Value(3290),
                reviewStatus: const Value('accepted'),
              ),
            );
        final purchaseId = await previous
            .into(previous.purchaseEntries)
            .insert(
              PurchaseEntriesCompanion.insert(
                listId: listId,
                receiptId: Value(receiptId),
                name: 'Süt',
                normalizedName: 'sut',
                actualQuantity: '1',
                actualUnitCode: 'piece',
                actualUnitPrice: const Value('32.90'),
                actualLineTotalMinorUnits: 3290,
                pricingInputMode: const Value('lineTotal'),
                source: const Value('receiptOcr'),
              ),
            );
        final oldReceipt =
            (await previous.select(previous.receipts).get()).single.toJson()
              ..remove('documentNumber')
              ..remove('identityKey')
              ..remove('captureDataJson');
        final oldCandidate =
            (await previous.select(previous.receiptCandidateLines).get())
                .single;
        final oldPurchase =
            (await previous.select(previous.purchaseEntries).get()).single;
        await _removeReceiptIdentitySchema(previous);
        await previous.customStatement('PRAGMA user_version = 3');
        await previous.close();

        final reopened = AppDatabase(NativeDatabase(file));
        addTearDown(() async {
          await reopened.close();
          dir.deleteSync(recursive: true);
        });
        final migrated =
            (await reopened.select(reopened.receipts).get()).single;
        expect(migrated.id, receiptId);
        expect(migrated.documentNumber, isNull);
        expect(migrated.identityKey, isNull);
        expect(migrated.captureDataJson, isNull);
        final migratedJson = migrated.toJson()
          ..remove('documentNumber')
          ..remove('identityKey')
          ..remove('captureDataJson');
        expect(migratedJson, oldReceipt);
        expect(
          (await reopened.select(reopened.receiptCandidateLines).get()).single,
          oldCandidate,
        );
        expect(oldCandidate.id, candidateId);
        expect(
          (await reopened.select(reopened.purchaseEntries).get()).single,
          oldPurchase,
        );
        expect(oldPurchase.id, purchaseId);
        final version = await reopened
            .customSelect('PRAGMA user_version')
            .getSingle();
        expect(version.data['user_version'], 4);
        final foreignKeyErrors = await reopened
            .customSelect('PRAGMA foreign_key_check')
            .get();
        expect(foreignKeyErrors, isEmpty);
        await reopened
            .into(reopened.receipts)
            .insert(
              ReceiptsCompanion.insert(
                identityKey: const Value('migrated-document'),
              ),
            );
        await expectLater(
          reopened
              .into(reopened.receipts)
              .insert(
                ReceiptsCompanion.insert(
                  identityKey: const Value('migrated-document'),
                ),
              ),
          throwsException,
        );
      },
    );
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
        await db
            .into(db.plannedItems)
            .insert(
              PlannedItemsCompanion.insert(
                listId: listId,
                name: 'Süt',
                normalizedName: 'süt',
                plannedQuantity: '2',
                plannedUnitCode: 'adet',
                pricingInputMode: 'unitPrice',
              ),
            );
        await (db.update(db.shoppingLists)..where((t) => t.id.equals(listId)))
            .write(const ShoppingListsCompanion(status: Value('planned')));
      });
      final list = await (db.select(
        db.shoppingLists,
      )..where((t) => t.id.equals(listId))).getSingle();
      final items = await (db.select(
        db.plannedItems,
      )..where((t) => t.listId.equals(listId))).get();
      expect(list.status, 'planned');
      expect(items, hasLength(1));
    });
  });

  group('FK silme kuralları', () {
    test('liste silinince planlanan ürünler cascade silinir', () async {
      final listId = await db.into(db.shoppingLists).insert(listRow());
      await db
          .into(db.plannedItems)
          .insert(
            PlannedItemsCompanion.insert(
              listId: listId,
              name: 'Elma',
              normalizedName: 'elma',
              plannedQuantity: '0.5',
              plannedUnitCode: 'kilogram',
              pricingInputMode: 'unitPrice',
            ),
          );
      await (db.delete(
        db.shoppingLists,
      )..where((t) => t.id.equals(listId))).go();
      final items = await db.select(db.plannedItems).get();
      expect(items, isEmpty);
    });

    test('satın alım silinince fiyat gözlemi set null ile kalır', () async {
      final listId = await db.into(db.shoppingLists).insert(listRow());
      final entryId = await db
          .into(db.purchaseEntries)
          .insert(
            PurchaseEntriesCompanion.insert(
              listId: listId,
              name: 'Ekmek',
              normalizedName: 'ekmek',
              actualQuantity: '1',
              actualUnitCode: 'adet',
              actualLineTotalMinorUnits: 1500,
            ),
          );
      await db
          .into(db.priceObservations)
          .insert(
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
      await (db.delete(
        db.purchaseEntries,
      )..where((t) => t.id.equals(entryId))).go();
      final observations = await db.select(db.priceObservations).get();
      expect(observations, hasLength(1));
      expect(observations.single.purchaseEntryId, isNull);
    });

    test('fiş silinince aday satırlar cascade silinir', () async {
      final receiptId = await db
          .into(db.receipts)
          .insert(ReceiptsCompanion.insert());
      await db
          .into(db.receiptCandidateLines)
          .insert(
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

Future<void> _removeReceiptIdentitySchema(AppDatabase db) async {
  await db.customStatement('DROP INDEX receipts_identity_unique');
  for (final column in [
    'document_number',
    'identity_key',
    'capture_data_json',
  ]) {
    await db.customStatement('ALTER TABLE receipts DROP COLUMN $column');
  }
}
