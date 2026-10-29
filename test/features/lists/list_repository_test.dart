import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/list_status.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';

void main() {
  late AppDatabase db;
  late ListRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ListRepository(db);
  });

  tearDown(() async => db.close());

  Future<int> insertItem(int listId, String name, {int lineTotalMinor = 1000}) {
    return db
        .into(db.plannedItems)
        .insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: name,
            normalizedName: name.toLowerCase(),
            plannedQuantity: '1',
            plannedUnitCode: 'adet',
            pricingInputMode: 'lineTotal',
            plannedLineTotalMinorUnits: Value(lineTotalMinor),
          ),
        );
  }

  group('oluşturma ve güncelleme', () {
    test('başlık boşsa generatedTitle ile kurulur', () async {
      final id = await repo.createList(
        generatedTitle: '2026-09-20 alışverişi',
        currencyCode: 'TRY',
        budgetMinorUnits: 50000,
      );
      final list = await repo.getById(id);
      expect(list.title, isNull);
      expect(list.generatedTitle, '2026-09-20 alışverişi');
      expect(list.status, 'draft');
      expect(list.budgetMinorUnits, 50000);
    });

    test('durum geçişi kurala uyar; kural dışı StateError verir', () async {
      final id = await repo.createList(currencyCode: 'TRY');
      await repo.changeStatus(id, ListStatus.planned);
      final planned = await repo.getById(id);
      expect(planned.status, 'planned');

      expect(
        () => repo.changeStatus(id, ListStatus.completed),
        throwsStateError,
      );
    });

    test('tamamlama completedAt damgası basar; arşivleme archivedAt', () async {
      final id = await repo.createList(currencyCode: 'TRY');
      await repo.changeStatus(id, ListStatus.planned);
      await repo.changeStatus(id, ListStatus.shopping);
      await repo.changeStatus(id, ListStatus.completed);
      expect((await repo.getById(id)).completedAt, isNotNull);
      await repo.changeStatus(id, ListStatus.shopping);
      expect((await repo.getById(id)).status, 'shopping');
      expect((await repo.getById(id)).completedAt, isNull);
      await repo.changeStatus(id, ListStatus.archived);
      expect((await repo.getById(id)).archivedAt, isNotNull);
    });

    test('aynı durum tekrarında zaman damgaları değişmez', () async {
      final id = await repo.createList(currencyCode: 'TRY');
      final before = await repo.getById(id);
      await repo.changeStatus(id, ListStatus.draft);
      final after = await repo.getById(id);
      expect(after.updatedAt, before.updatedAt);
      expect(after.completedAt, before.completedAt);
    });
  });

  group('çoğaltma', () {
    test('kopya taslaktır; ürünler pending kopyalanır', () async {
      final id = await repo.createList(
        title: 'Haftalık',
        currencyCode: 'TRY',
        budgetMinorUnits: 10000,
      );
      await repo.changeStatus(id, ListStatus.planned);
      await repo.changeStatus(id, ListStatus.shopping);
      await insertItem(id, 'Süt');

      final copyId = await repo.duplicateList(id, generatedTitle: 'Kopya');
      final copy = await repo.getById(copyId);
      expect(copy.id, isNot(id));
      expect(copy.status, 'draft');
      expect(copy.completedAt, isNull);
      expect(copy.budgetMinorUnits, 10000);

      final copyItems = await (db.select(
        db.plannedItems,
      )..where((t) => t.listId.equals(copyId))).get();
      expect(copyItems, hasLength(1));
      expect(copyItems.single.status, 'pending');
      expect(copyItems.single.name, 'Süt');
    });
  });

  group('para birimi değişimi (spec §7.1)', () {
    test('rakamları koru: değerler aynı kalır', () async {
      final id = await repo.createList(
        currencyCode: 'TRY',
        budgetMinorUnits: 25000,
      );
      await insertItem(id, 'Ekmek', lineTotalMinor: 1500);

      await repo.changeCurrency(id, 'USD', resetAmounts: false);

      final list = await repo.getById(id);
      expect(list.currencyCode, 'USD');
      expect(list.budgetMinorUnits, 25000);
      final items = await db.select(db.plannedItems).get();
      expect(items.single.plannedLineTotalMinorUnits, 1500);
    });

    test('rakamları sıfırla: bütçe ve planlı tutarlar temizlenir', () async {
      final id = await repo.createList(
        currencyCode: 'TRY',
        budgetMinorUnits: 25000,
      );
      await insertItem(id, 'Ekmek', lineTotalMinor: 1500);

      await repo.changeCurrency(id, 'USD', resetAmounts: true);

      final list = await repo.getById(id);
      expect(list.currencyCode, 'USD');
      expect(list.budgetMinorUnits, isNull);
      final items = await db.select(db.plannedItems).get();
      expect(items.single.plannedLineTotalMinorUnits, isNull);
    });
  });

  group('silme ve geri alma', () {
    test('liste sırası veritabanında kalır', () async {
      final first = await repo.createList(title: 'Bir', currencyCode: 'TRY');
      final second = await repo.createList(title: 'İki', currencyCode: 'TRY');

      await repo.reorderLists([second, first]);

      final rows = await (db.select(
        db.shoppingLists,
      )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get();
      expect(rows.map((row) => row.id).toList(), [second, first]);
    });

    test(
      'silme çocuk ürünleri kaldırır; undo aynı kimlikle geri yükler',
      () async {
        final id = await repo.createList(
          title: 'Silinecek',
          currencyCode: 'TRY',
        );
        final itemId = await insertItem(id, 'Peynir');

        final snapshot = await repo.deleteList(id);
        expect(await db.select(db.shoppingLists).get(), isEmpty);
        expect(await db.select(db.plannedItems).get(), isEmpty);

        await repo.undoDelete(snapshot);
        final restored = await repo.getById(id);
        expect(restored.title, 'Silinecek');
        final items = await db.select(db.plannedItems).get();
        expect(items.single.id, itemId);
      },
    );

    test(
      'undo satın alım ve fiyat geçmişini de aynı kimlikle geri yükler',
      () async {
        final id = await repo.createList(title: 'Geçmiş', currencyCode: 'TRY');
        final itemId = await insertItem(id, 'Peynir');
        await ShoppingRepository(db).recordPurchase(
          listId: id,
          plannedItemId: itemId,
          name: 'Peynir',
          normalizedName: 'peynir',
          quantity: DecimalFixed.fromInt(1),
          unitCode: 'adet',
          unitPrice: DecimalFixed.fromInt(12),
        );
        final receiptId = await db
            .into(db.receipts)
            .insert(ReceiptsCompanion.insert(listId: Value(id)));
        final receiptLineId = await db
            .into(db.receiptCandidateLines)
            .insert(
              ReceiptCandidateLinesCompanion.insert(
                receiptId: receiptId,
                rawText: 'PEYNIR 12',
              ),
            );

        final beforePurchase =
            (await db.select(db.purchaseEntries).get()).single;
        final beforeObservation =
            (await db.select(db.priceObservations).get()).single;
        final snapshot = await repo.deleteList(id);
        expect(await db.select(db.purchaseEntries).get(), isEmpty);
        expect(await db.select(db.priceObservations).get(), isEmpty);
        expect(await db.select(db.receipts).get(), isEmpty);
        expect(await db.select(db.receiptCandidateLines).get(), isEmpty);

        await repo.undoDelete(snapshot);
        final purchase = (await db.select(db.purchaseEntries).get()).single;
        final observation =
            (await db.select(db.priceObservations).get()).single;
        expect(purchase.id, beforePurchase.id);
        expect(observation.id, beforeObservation.id);
        expect(observation.purchaseEntryId, purchase.id);
        expect((await db.select(db.receipts).get()).single.id, receiptId);
        expect(
          (await db.select(db.receiptCandidateLines).get()).single.id,
          receiptLineId,
        );
      },
    );
  });

  test('a list completed from receipts is dated by the latest receipt time', () async {
    final id = await repo.createList(title: 'ŞOK', currencyCode: 'TRY');
    await ShoppingRepository(db).startShopping(id);
    final printed = DateTime(2024, 2, 1, 20, 51, 41);
    await db.into(db.receipts).insert(
      ReceiptsCompanion.insert(
        listId: Value(id),
        identityKey: const Value('k1'),
        detectedAt: Value(printed),
        processingStatus: const Value('reviewed'),
      ),
    );
    // A pending draft never sets the shopping date.
    await db.into(db.receipts).insert(
      ReceiptsCompanion.insert(
        listId: Value(id),
        detectedAt: Value(DateTime(2025, 1, 1)),
      ),
    );
    await repo.changeStatus(id, ListStatus.completed);
    expect((await repo.getById(id)).completedAt, printed);

    final plain = await repo.createList(title: 'Plan', currencyCode: 'TRY');
    await ShoppingRepository(db).startShopping(plain);
    final before = DateTime.now().subtract(const Duration(seconds: 1));
    await repo.changeStatus(plain, ListStatus.completed);
    expect((await repo.getById(plain)).completedAt!.isAfter(before), isTrue);
  });
}
