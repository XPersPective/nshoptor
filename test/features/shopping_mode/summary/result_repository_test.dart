import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/shopping_mode/summary/result_repository.dart';

void main() {
  late AppDatabase db;
  late ResultRepository repo;
  late int listId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = ResultRepository(db);
    listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(
            title: const Value('Haftalık'),
            currencyCode: 'TRY',
            budgetMinorUnits: const Value(15000),
          ),
        );
  });

  tearDown(() => db.close());

  Future<PlannedItem> addItem(
    String name,
    String qty,
    String unit,
    int lineTotalMinor, {
    String? unitPrice,
  }) async {
    final id = await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: name,
            normalizedName: name.toLowerCase(),
            plannedQuantity: qty,
            plannedUnitCode: unit,
            pricingInputMode: 'unitPrice',
            plannedUnitPrice: Value(unitPrice),
            plannedLineTotalMinorUnits: Value(lineTotalMinor),
          ),
        );
    return (db.select(db.plannedItems)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<void> purchase(
    PlannedItem item, {
    required String qty,
    String? unitPrice,
    int? lineTotalMinor,
    int discountMinor = 0,
    bool confirmed = true,
  }) {
    return db.into(db.purchaseEntries).insert(
          PurchaseEntriesCompanion.insert(
            listId: listId,
            plannedItemId: Value(item.id),
            name: item.name,
            normalizedName: item.normalizedName,
            actualQuantity: qty,
            actualUnitCode: item.plannedUnitCode,
            actualUnitPrice: Value(unitPrice),
            grossTotalMinorUnits: Value(lineTotalMinor),
            discountMinorUnits: Value(discountMinor),
            actualLineTotalMinorUnits: (lineTotalMinor ?? 0) - discountMinor,
            userConfirmed: Value(confirmed),
          ),
        );
  }

  test('örnek senaryo: özet alanları ve ürün grupları', () async {
    // Plan: Domates 1,5 kg × 42,90 = 6435; Süt 2 × 32,00 = 6400; Ekmek 1500.
    // Toplam plan 14335.
    final tomato = await addItem('Domates', '1.5', 'kilogram', 6435,
        unitPrice: '42.90');
    final milk = await addItem('Süt', '2', 'adet', 6400, unitPrice: '32.00');
    final bread = await addItem('Ekmek', '1', 'adet', 1500);

    // Domates: 2 kg × 45 = 9000 → pahalı + miktar değişen.
    await purchase(tomato, qty: '2', unitPrice: '45.00', lineTotalMinor: 9000);
    // Süt: 2 × 28 = 5600 → ucuz.
    await purchase(milk, qty: '2', unitPrice: '28.00', lineTotalMinor: 5600);
    // Ekmek: plan 1500, gerçek 1550 → yakın (mutlak 50 < 200).
    await purchase(bread, qty: '1', lineTotalMinor: 1550);
    // Plansız: 2500.
    await db.into(db.purchaseEntries).insert(
          PurchaseEntriesCompanion.insert(
            listId: listId,
            name: 'Poşet',
            normalizedName: 'poset',
            actualQuantity: '1',
            actualUnitCode: 'adet',
            actualLineTotalMinorUnits: 2500,
            source: const Value('manual'),
            userConfirmed: const Value(true),
          ),
        );

    final result = await repo.compute(listId);

    expect(result.plannedTotalMinor, 14335);
    // Gerçek: 9000 + 5600 + 1550 + 2500 = 18650.
    expect(result.actualTotalMinor, 18650);
    expect(result.varianceMinor, 4315);
    expect(result.unplannedTotalMinor, 2500);
    expect(result.unpurchasedPlannedMinor, 0);
    expect(result.accuracy, isNotNull);

    final tomatoRow =
        result.rows.firstWhere((r) => r.name == 'Domates');
    expect(tomatoRow.groups, contains(ItemResultGroup.pricier));
    expect(tomatoRow.groups, contains(ItemResultGroup.quantityChanged));
    expect(tomatoRow.priceChanged, isTrue);

    final milkRow = result.rows.firstWhere((r) => r.name == 'Süt');
    expect(milkRow.groups, contains(ItemResultGroup.cheaper));

    final breadRow = result.rows.firstWhere((r) => r.name == 'Ekmek');
    expect(breadRow.groups, contains(ItemResultGroup.close));
    expect(breadRow.groups, isNot(contains(ItemResultGroup.pricier)));

    expect(result.presentGroups, contains(ItemResultGroup.unplanned));
  });

  test('birim fiyat aynı, miktar artmış → pahalı grubunda DEĞİL', () async {
    // Süt planı: 2 × 32 = 6400. Gerçek: 3 × 32 = 9600 (satır arttı ama
    // birim fiyat aynı → pahalandı denmez).
    final milk = await addItem('Süt', '2', 'adet', 6400, unitPrice: '32.00');
    await purchase(milk, qty: '3', unitPrice: '32.00', lineTotalMinor: 9600);

    final result = await repo.compute(listId);
    final row = result.rows.single;
    expect(row.priceChanged, isFalse);
    expect(row.groups, contains(ItemResultGroup.quantityChanged));
    expect(row.groups, isNot(contains(ItemResultGroup.pricier)));
    expect(row.groups, contains(ItemResultGroup.close));
  });

  test('alınmayan ürün: gerçeğe 0 yazılmaz, ayrı gruptır', () async {
    await addItem('Domates', '1.5', 'kilogram', 6435);
    final milk = await addItem('Süt', '2', 'adet', 6400, unitPrice: '32.00');
    await purchase(milk, qty: '2', unitPrice: '32.00', lineTotalMinor: 6400);

    final result = await repo.compute(listId);
    expect(result.actualTotalMinor, 6400); // yalnız Süt
    expect(result.unpurchasedPlannedMinor, 6435); // Domates planı ayrı
    final tomatoRow = result.rows.firstWhere((r) => r.name == 'Domates');
    expect(tomatoRow.groups, contains(ItemResultGroup.notTaken));
    expect(tomatoRow.notTaken, isTrue);
  });

  test('plan sıfırsa yüzde hesaplanamaz; indirim ayrı raporlanır', () async {
    final result = await repo.compute(listId);
    expect(result.plannedTotalMinor, 0);
    expect(result.variancePercent, isNull);
    expect(result.accuracy, isNull);
  });

  test('indirim etkisi ayrı toplanır', () async {
    final milk = await addItem('Süt', '2', 'adet', 6400, unitPrice: '32.00');
    await purchase(milk,
        qty: '2',
        unitPrice: '32.00',
        lineTotalMinor: 6400,
        discountMinor: 400);
    final result = await repo.compute(listId);
    expect(result.totalDiscountMinor, 400);
    expect(result.actualTotalMinor, 6000);
  });

  test('doğrulanmamış kayıt kendi grubuna düşer', () async {
    final milk = await addItem('Süt', '2', 'adet', 6400, unitPrice: '32.00');
    await purchase(milk,
        qty: '2',
        unitPrice: '32.00',
        lineTotalMinor: 6400,
        confirmed: false);
    final result = await repo.compute(listId);
    final row = result.rows.single;
    expect(row.groups, contains(ItemResultGroup.unverified));
    expect(row.userConfirmed, isFalse);
  });
}
