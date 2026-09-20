import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/shopping_mode/item_status.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  late AppDatabase db;
  late ShoppingRepository repo;
  late int listId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = ShoppingRepository(db);
    listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(
            title: const Value('Market'),
            currencyCode: 'TRY',
            budgetMinorUnits: const Value(20000),
          ),
        );
    await _addItem(db, listId, 'Domates', '1.5', 'kilogram', 6435);
    await _addItem(db, listId, 'Süt', '2', 'adet', 6400);
    await _addItem(db, listId, 'Ekmek', '1', 'adet', 1500);
  });

  tearDown(() => db.close());

  test('alışveriş başlatma: durum shopping olur', () async {
    await repo.startShopping(listId);
    final list = await repo.getList(listId);
    expect(list.status, 'shopping');
    expect(list.startedAt, isNotNull);
  });

  test('projeksiyon: sepet + kalan plan; bütçeden kalan', () async {
    // Domates sepete girildi: 1,5 kg × 45,00 = 6750 kuruş.
    final tomato = await _firstItem(db, 'Domates');
    await repo.recordPurchase(
      listId: listId,
      name: tomato.name,
      normalizedName: tomato.normalizedName,
      plannedItemId: tomato.id,
      quantity: DecimalFixed.parse('1.5'),
      unitCode: 'kilogram',
      unitPrice: DecimalFixed.parse('45.00'),
    );

    final summary = await repo.watchSummary(listId).first;
    // Planlanan toplam: 6435 + 6400 + 1500 = 14335
    expect(summary.plannedTotalMinor, 14335);
    expect(summary.cartActualMinor, 6750);
    // Kalan: Süt + Ekmek (6400 + 1500)
    expect(summary.remainingPlanMinor, 7900);
    expect(summary.projectedCheckoutMinor, 6750 + 7900);
    // Bütçe 20000 − 14650 = 5350
    expect(summary.budgetRemainingMinor, 5350);
    expect(summary.isOverBudget, isFalse);
    expect(summary.doneCount, 1);
    expect(summary.totalCount, 3);
  });

  test('bütçe aşımı negatif kalan olarak raporlanır', () async {
    final milk = await _firstItem(db, 'Süt');
    await repo.recordPurchase(
      listId: listId,
      name: milk.name,
      normalizedName: milk.normalizedName,
      plannedItemId: milk.id,
      quantity: DecimalFixed.parse('2'),
      unitCode: 'adet',
      unitPrice: DecimalFixed.parse('45.00'),
    );
    final summary = await repo.watchSummary(listId).first;
    // Sepet 9000; kalan 7935; projeksiyon 16935 < 20000 → aşım yok.
    expect(summary.isOverBudget, isFalse);

    // İkinci büyük alışveriş: Ekmek 3 adet yerine 12.000 kuruş.
    final bread = await _firstItem(db, 'Ekmek');
    await repo.recordPurchase(
      listId: listId,
      name: bread.name,
      normalizedName: bread.normalizedName,
      plannedItemId: bread.id,
      quantity: DecimalFixed.parse('1'),
      unitCode: 'adet',
      lineTotalMinor: 12000,
    );
    final over = await repo.watchSummary(listId).first;
    expect(over.projectedCheckoutMinor, greaterThan(20000));
    expect(over.isOverBudget, isTrue);
    expect(over.budgetRemainingMinor! < 0, isTrue);
  });

  test('indirim satır toplamından düşülür', () async {
    final milk = await _firstItem(db, 'Süt');
    await repo.recordPurchase(
      listId: listId,
      name: milk.name,
      normalizedName: milk.normalizedName,
      plannedItemId: milk.id,
      quantity: DecimalFixed.parse('2'),
      unitCode: 'adet',
      unitPrice: DecimalFixed.parse('32.00'),
      discountMinor: 500,
    );
    final entries = await db.select(db.purchaseEntries).get();
    expect(entries.single.grossTotalMinorUnits, 6400);
    expect(entries.single.discountMinorUnits, 500);
    expect(entries.single.actualLineTotalMinorUnits, 5900);
  });

  test('plansız ürün satın alıma girer; planlı ürüne bağlanmaz', () async {
    await repo.addUnplannedPurchase(
      listId: listId,
      name: 'Çöp torbası',
      quantity: DecimalFixed.parse('1'),
      unitCode: 'adet',
      unitPrice: DecimalFixed.parse('25.00'),
    );
    final entries = await db.select(db.purchaseEntries).get();
    expect(entries.single.plannedItemId, isNull);
    final summary = await repo.watchSummary(listId).first;
    expect(summary.cartActualMinor, 2500);
  });

  test('durum değişimleri: sepette geri alınca kayıt silinir', () async {
    final tomato = await _firstItem(db, 'Domates');
    await repo.recordPurchase(
      listId: listId,
      name: tomato.name,
      normalizedName: tomato.normalizedName,
      plannedItemId: tomato.id,
      quantity: DecimalFixed.parse('1.5'),
      unitCode: 'kilogram',
      unitPrice: DecimalFixed.parse('45.00'),
    );
    expect((await repo.watchSummary(listId).first).cartActualMinor, 6750);

    // Kullanıcı geri aldı: pending → kayıt silinir, alınmayan 0 yazılmaz.
    await repo.setItemStatus(tomato.id, ItemStatus.pending);
    expect((await repo.watchSummary(listId).first).cartActualMinor, 0);
    expect((await repo.watchSummary(listId).first).remainingPlanMinor, 14335);

    // Bulunamadı: kapanır, plandan düşer ama gerçeğe yazılmaz.
    await repo.setItemStatus(tomato.id, ItemStatus.notFound);
    final summary = await repo.watchSummary(listId).first;
    expect(summary.cartActualMinor, 0);
    expect(summary.remainingPlanMinor, 7900);
    expect(summary.doneCount, 1);
  });
}

Future<void> _addItem(
    AppDatabase db, int listId, String name, String qty, String unit,
    int lineTotalMinor) {
  return db.into(db.plannedItems).insert(
        PlannedItemsCompanion.insert(
          listId: listId,
          name: name,
          normalizedName: name.toLowerCase(),
          plannedQuantity: qty,
          plannedUnitCode: unit,
          pricingInputMode: 'lineTotal',
          plannedLineTotalMinorUnits: Value(lineTotalMinor),
        ),
      );
}

Future<PlannedItem> _firstItem(AppDatabase db, String name) async {
  final rows = await (db.select(db.plannedItems)
        ..where((t) => t.name.equals(name)))
      .get();
  return rows.single;
}
