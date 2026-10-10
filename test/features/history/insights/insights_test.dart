import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/insights/insights_repository.dart';
import 'package:nshoptor/features/home/home_repository.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';

void main() {
  late AppDatabase db;
  late InsightsRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = InsightsRepository(db);
  });

  Future<int> taxonomyCategory() =>
      db.into(db.categories).insert(CategoriesCompanion.insert(name: 'manav'));

  Future<int> addItem(int listId, String name, int? plannedMinor,
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
    await (db.update(db.shoppingLists)..where((t) => t.id.equals(id))).write(
      ShoppingListsCompanion(
        status: const Value('completed'),
        completedAt: Value(completedAt ?? DateTime.now()),
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
    int? gross,
    String source = 'manual',
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
            source: Value(source),
            grossTotalMinorUnits: Value(gross),
            userConfirmed: const Value(true),
          ),
        );
  }

  test('yetersiz veri: tamamlanan alışveriş yoksa tüm listeler boş', () async {
    expect(await repo.watchCompleted().first, isEmpty);
    expect(await repo.monthlyTotals(), isEmpty);
    expect(await repo.spendingByCategory('TRY'), isEmpty);
    expect(await repo.spendingByStore('TRY'), isEmpty);
    expect(await repo.purchaseStats('TRY'), isEmpty);
    expect(await repo.biggestVariances(), isEmpty);
    expect(await repo.unplannedTotal('TRY'), 0);
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

  test('monthly comparison excludes skipped, unplanned and unknown; shared Home totals', () async {
    final l = await makeCompletedList();
    await addItem(l, 'Skipped', 10000);
    final bought = await addItem(l, 'Bought', 2000);
    await addEntry(l, 'Bought', 1000, plannedItemId: bought);
    await addEntry(l, 'Bought', 1500, plannedItemId: bought); // estimate counted once
    final unknown = await addItem(l, 'Unknown', 500);
    await addEntry(l, 'Unknown', 0, plannedItemId: unknown);
    await addEntry(l, 'Extra', 3000);
    final noEstimate = await addItem(l, 'No estimate', null);
    await addEntry(l, 'No estimate', 0, plannedItemId: noEstimate, source: 'receiptOcr');
    final b = (await repo.monthlyTotals()).single;
    expect(b.plannedMinor, 12500); expect(b.actualMinor, 5500);
    expect(b.comparedCount, 1); expect(b.varianceMinor, 500);
    final home = (await HomeRepository(db).watchMonthlyTotals().first).single;
    expect(home.actualMinor, b.actualMinor); expect(home.varianceMinor, b.varianceMinor);
    // One unknown row excludes the whole item's comparison, not its spending.
    await addEntry(l, 'Bought unknown', 0, plannedItemId: bought);
    expect((await repo.monthlyTotals()).single.varianceMinor, isNull);
    expect((await repo.monthlyTotals()).single.actualMinor, 5500);
  });

  test('known zero, separate month/currency, and purchase-only bucket', () async {
    final old = await makeCompletedList(completedAt: DateTime(2025, 1, 15));
    final free = await addItem(old, 'Free', 2000);
    await addEntry(old, 'Free', 0, plannedItemId: free, gross: 0);
    final receipt = await addItem(old, 'Receipt free', 500);
    await addEntry(old, 'Receipt free', 0, plannedItemId: receipt, source: 'receiptOcr');
    final usd = await makeCompletedList(currency: 'USD');
    await addEntry(usd, 'Unplanned', 3000);
    final buckets = await repo.monthlyTotals();
    expect(buckets, hasLength(2));
    final past = buckets.singleWhere((b) => b.month == '2025-01');
    expect(past.comparedCount, 2); expect(past.varianceMinor, -2500);
    final current = buckets.singleWhere((b) => b.currencyCode == 'USD');
    expect(current.plannedMinor, 0); expect(current.actualMinor, 3000);
    expect(current.varianceMinor, isNull);
    final home = await HomeRepository(db).watchMonthlyTotals().first;
    expect(home, hasLength(1)); expect(home.single.currencyCode, 'USD');
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

    final slices = await repo.spendingByCategory('TRY');
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

    final slices = await repo.spendingByStore('TRY');
    final marketA = slices.firstWhere((s) => s.label == 'Market A');
    expect(marketA.actualMinor, 1500);
    final nullStore = slices.where((s) => s.label == null).fold<int>(0, (s, x) => s + x.actualMinor);
    expect(nullStore, 3200);
  });

  test('quantity and visits use actual completed confirmed purchases; returns and groups stay separate', () async {
    final first = await makeCompletedList(completedAt: DateTime(2026, 1, 1));
    final second = await makeCompletedList(completedAt: DateTime(2026, 1, 11));
    final returned = await makeCompletedList(completedAt: DateTime(2026, 1, 21));
    Future<void> entry(int list, String qty, String unit, int amount, {bool confirmed = true}) =>
      db.into(db.purchaseEntries).insert(PurchaseEntriesCompanion.insert(listId: list,
        name: 'Tomatoes', normalizedName: 'tomatoes', actualQuantity: qty, actualUnitCode: unit,
        actualLineTotalMinorUnits: amount, grossTotalMinorUnits: Value(amount), userConfirmed: Value(confirmed)));
    await entry(first, '1.5', 'kilogram', 1500); await entry(first, '0.5', 'kilogram', 500);
    await entry(second, '3', 'kilogram', 3000);
    await entry(returned, '-1', 'kilogram', -1000);
    await entry(first, '1', 'adet', 0); // free purchase counts a visit, old enum alias normalizes
    await entry(first, '100', 'kilogram', 99999, confirmed: false);
    final usd = await makeCompletedList(currency: 'USD'); await entry(usd, '9', 'kilogram', 900);
    final active = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
    await entry(active, '100', 'kilogram', 99999);
    final groups = await repo.purchaseStats('TRY'); expect(groups, hasLength(2));
    final kg = groups.singleWhere((p) => p.unitCode == 'kilogram');
    expect(kg.quantity.toDbString(), '4.0'); expect(kg.actualMinor, 4000);
    expect(kg.visits, hasLength(2)); expect(kg.intervalDays!.toDbString(), '10.00');
    expect(kg.firstAt, DateTime(2026, 1, 1)); expect(kg.lastAt, DateTime(2026, 1, 11));
    final piece = groups.singleWhere((p) => p.unitCode == 'piece');
    expect(piece.quantity.toDbString(), '1'); expect(piece.visits, hasLength(1)); expect(piece.intervalDays, isNull);
    expect((await repo.purchaseStats('USD')).single.quantity.toDbString(), '9');
    final categories = await repo.purchaseStats('TRY', byCategory: true);
    expect(categories.singleWhere((p) => p.unitCode == 'kilogram').quantity, kg.quantity);
    expect((await repo.spendingByCategory('TRY')).fold<int>(0, (sum, s) => sum + s.actualMinor), 4000);
    expect((await repo.spendingByStore('TRY')).single.actualMinor, 4000);
  });

  test('replacement does not inflate purchases; receipt discount stays in category spend only', () async {
    final list = await makeCompletedList();
    final category = await taxonomyCategory();
    final item = await addItem(list, 'Milk', 2000, categoryId: category);
    final shop = ShoppingRepository(db);
    for (final qty in [2, 3]) {
      await shop.recordPurchase(listId: list, plannedItemId: item, name: 'Milk', normalizedName: 'milk',
        quantity: DecimalFixed.fromInt(qty), unitCode: 'kilogram', unitPrice: DecimalFixed.fromInt(10));
    }
    await shop.recordPurchase(listId: list, name: 'Discount', normalizedName: 'discount',
      quantity: DecimalFixed.zero(), unitCode: 'piece', lineTotalMinor: -100, source: 'receiptOcr');
    final stats = (await repo.purchaseStats('TRY')).single;
    expect(stats.quantity.toDbString(), '3'); expect(stats.actualMinor, 3000);
    expect(stats.visits, hasLength(1)); expect(stats.productId, isNotNull);
    final categories = await repo.spendingByCategory('TRY');
    expect(categories.singleWhere((s) => s.label == 'manav').actualMinor, 3000);
    expect(categories.singleWhere((s) => s.label == 'other').actualMinor, -100);
    expect(categories.fold<int>(0, (s, v) => s + v.actualMinor),
      (await repo.completedSpend('TRY')).single.actualMinor);
    expect((await repo.purchaseStats('TRY', byCategory: true)).single.quantity.toDbString(), '3');
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
    await addItem(l, 'Skipped', 99999);
    await addEntry(l, 'Unknown part', 0, plannedItemId: domates);
    final honest = await repo.biggestVariances();
    expect(honest.map((v) => v.name), ['Ekmek', 'Süt']);
  });

  test('plan dışı harcama toplamı', () async {
    final l = await makeCompletedList();
    final ekmek = await addItem(l, 'Ekmek', 1500);
    await addEntry(l, 'Ekmek', 1500, plannedItemId: ekmek);
    await addEntry(l, 'Poşet', 250);
    await addEntry(l, 'Kibrit', 75);

    expect(await repo.unplannedTotal('TRY'), 325);
  });
}
