import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/insights/insights_repository.dart';

void main() {
  late AppDatabase db;
  late InsightsRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = InsightsRepository(db);
  });

  Future<int> taxonomyCategory() =>
      db.into(db.categories).insert(CategoriesCompanion.insert(name: 'manav'));

  Future<void> memoryRecord(String name, String normalizedName,
      {int useCount = 1}) =>
      db.into(db.productMemory).insert(
            ProductMemoryCompanion.insert(
              canonicalName: name,
              normalizedName: normalizedName,
              useCount: Value(useCount),
            ),
          );

  Future<int> addItem(int listId, String name, int plannedMinor,
      {int? categoryId}) async {
    final id = await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: name,
            normalizedName: name.toLowerCase(),
            plannedQuantity: '1',
            plannedUnitCode: 'adet',
            pricingInputMode: 'lineTotal',
            plannedLineTotalMinorUnits: Value(plannedMinor),
            categoryId: Value(categoryId),
          ),
        );
    return id;
  }


  tearDown(() => db.close());

  Future<int> makeCompletedList({
    String title = 'Pazar',
    String currency = 'TRY',
    int? storeId,
    DateTime? completedAt,
  }) async {
    final id = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(
            title: Value(title),
            currencyCode: currency,
            storeId: Value(storeId),
          ),
        );
    // completedAt'i doğrudan yaz (drift default'u güncel zaman; test sabitliği
    // için ay bilgisini garantilemek üzere güncel ay kullanılıyor).
    assert(completedAt == null, 'test güncel ayı kullanır');
    await (db.update(db.shoppingLists)..where((t) => t.id.equals(id))).write(
      ShoppingListsCompanion(
        status: const Value('completed'),
        completedAt: Value(DateTime.now()),
      ),
    );
    return id;
  }

  Future<void> addPlanned(int listId, String name, int plannedMinor,
      {int? categoryId}) async {
    await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: name,
            normalizedName: name.toLowerCase(),
            plannedQuantity: '1',
            plannedUnitCode: 'adet',
            pricingInputMode: 'lineTotal',
            plannedLineTotalMinorUnits: Value(plannedMinor),
            categoryId: Value(categoryId),
          ),
        );
  }

  Future<void> addEntry(
    int listId,
    String name,
    int actualMinor, {
    int? plannedItemId,
  }) async {
    await db.into(db.purchaseEntries).insert(
          PurchaseEntriesCompanion.insert(
            listId: listId,
            plannedItemId: Value(plannedItemId),
            name: name,
            normalizedName: name.toLowerCase(),
            actualQuantity: '1',
            actualUnitCode: 'adet',
            actualLineTotalMinorUnits: actualMinor,
            source: const Value('manual'),
            userConfirmed: const Value(true),
          ),
        );
  }

  test('yetersiz veri: tamamlanan alışveriş yoksa tüm listeler boş', () async {
    expect(await repo.watchCompleted().first, isEmpty);
    expect(await repo.monthlyTotals(), isEmpty);
    expect(await repo.spendingByCategory(), isEmpty);
    expect(await repo.spendingByStore(), isEmpty);
    expect(await repo.mostFrequentProducts(), isEmpty);
    expect(await repo.biggestVariances(), isEmpty);
    expect(await repo.unplannedTotal(), 0);
  });

  test('aylık toplamlar ay+para birimi bazında gruplanır', () async {
    final catId = await taxonomyCategory();
    final l1 = await makeCompletedList(title: 'Pazar 1');
    await addPlanned(l1, 'Ekmek', 1500, categoryId: catId);
    await addEntry(l1, 'Ekmek', 1600);

    final l2 = await makeCompletedList(title: 'Pazar 2');
    await addPlanned(l2, 'Süt', 6400, categoryId: catId);
    await addEntry(l2, 'Süt', 6200);

    // USD listesi ayrı para birimi: asla TRY ile birleştirilmez.
    final l3 = await makeCompletedList(title: 'USD Mall', currency: 'USD');
    await addPlanned(l3, 'Bread', 300);
    await addEntry(l3, 'Bread', 350);

    final buckets = await repo.monthlyTotals();
    final tryBucket = buckets
        .where((b) => b.currencyCode == 'TRY')
        .fold<int>(0, (s, b) => s + b.actualMinor);
    final usdBuckets = buckets.where((b) => b.currencyCode == 'USD').toList();

    expect(tryBucket, 1600 + 6200);
    expect(usdBuckets, hasLength(1));
    expect(usdBuckets.single.plannedMinor, 300);
    expect(usdBuckets.single.actualMinor, 350);
    // completedCount = 3 liste; her biri kendi ay+para anahtarında
    expect(buckets.map((b) => b.currencyCode).toSet(), {'TRY', 'USD'});
  });

  test('kategori bazında harcama; plansız alım diğer olarak ayrılır',
      () async {
    final manav = await db
        .into(db.categories)
        .insert(CategoriesCompanion.insert(name: 'manav'));
    final l = await makeCompletedList();
    final domates = await addItem(l, 'Domates', 5000, categoryId: manav);
    await addEntry(l, 'Domates', 5200, plannedItemId: domates);
    await addEntry(l, 'Poşet', 250); // plansız: kategori yok

    final slices = await repo.spendingByCategory();
    final manavSlice = slices.firstWhere((s) => s.label == 'manav');
    expect(manavSlice.actualMinor, 5200);
  });

  test('mağaza bazında harcama', () async {
    final store = await db
        .into(db.stores)
        .insert(StoresCompanion.insert(name: 'Market A', sortOrder: const Value(0)));
    final l = await makeCompletedList(storeId: store);
    await addEntry(l, 'Ekmek', 1500);
    final l2 = await makeCompletedList(title: 'Mağazasız');
    await addEntry(l2, 'Süt', 3200);

    final slices = await repo.spendingByStore();
    final marketA = slices.firstWhere((s) => s.label == 'Market A');
    expect(marketA.actualMinor, 1500);
    final nullStore = slices.where((s) => s.label == null).fold<int>(0, (s, x) => s + x.actualMinor);
    expect(nullStore, 3200);
  });

  test('en sık ürünler useCount sırasıyla', () async {
    await memoryRecord('süt', 'süt', useCount: 3);
    await memoryRecord('ekmek', 'ekmek', useCount: 5);
    final frequent = await repo.mostFrequentProducts();
    expect(frequent.first.name, 'ekmek');
    expect(frequent.first.useCount, 5);
  });

  test('en büyük tahmin sapmaları mutlak fark sırasıyla', () async {
    final l = await makeCompletedList();
    final domates = await addItem(l, 'Domates', 5000);
    final ekmek = await addItem(l, 'Ekmek', 1500);
    final sut = await addItem(l, 'Süt', 3200);
    await addEntry(l, 'Domates', 6800, plannedItemId: domates); // sapma 1800
    await addEntry(l, 'Ekmek', 1600, plannedItemId: ekmek); // sapma 100
    await addEntry(l, 'Süt', 3200, plannedItemId: sut); // sapma 0

    final variances = await repo.biggestVariances();
    expect(variances.first.name, 'Domates');
    expect(variances.first.varianceAbs, 1800);
    // sapması 0 olanlar da listede ama sonlarda
    expect(variances.last.name, 'Süt');
  });

  test('plan dışı harcama toplamı', () async {
    final l = await makeCompletedList();
    final ekmek = await addItem(l, 'Ekmek', 1500);
    await addEntry(l, 'Ekmek', 1500, plannedItemId: ekmek);
    await addEntry(l, 'Poşet', 250);
    await addEntry(l, 'Kibrit', 75);

    expect(await repo.unplannedTotal(), 325);
  });
}
