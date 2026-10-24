import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_list_view.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  test('Turkish/Azeri case and repeated whitespace are normalized', () {
    expect(matchesItemSearch('İNCİR', 'incir', 'tr'), isTrue);
    expect(matchesItemSearch('ISPANAK', 'ıspanak', 'tr'), isTrue);
    expect(matchesItemSearch('Ispanak', 'ispanak', 'tr'), isFalse);
    expect(matchesItemSearch('İNCİR', 'incir', 'az'), isTrue);
    expect(matchesItemSearch('  MILK  powder ', ' milk powder ', 'en'), isTrue);
    expect(matchesItemSearch('Süt', '   ', 'tr'), isTrue);
  });
  test('partition and reorder preserve groups; zero is purchased; clearing restores', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = ItemRepository(db);
    final shopping = ShoppingRepository(db);
    final listId = await ListRepository(db)
        .createList(title: 'QA', currencyCode: 'TRY');
    final ids = <int>[];
    for (final name in ['A', 'B', 'C', 'D']) {
      ids.add(
        await repo.addItem(
          listId: listId,
          name: name,
          quantity: DecimalFixed.fromInt(1),
          unitCode: 'piece',
            priceIsUnitPrice: false,
        ),
      );
    }
    final original = await shopping.watchItems(listId).first;
    Future<List<PurchaseEntry>> entries() =>
        shopping.watchEntries(listId).first;
    for (final index in [0, 2]) {
      await shopping.recordPurchase(
        listId: listId,
        plannedItemId: ids[index],
        name: original[index].name,
        normalizedName: original[index].normalizedName,
        quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece',
        unitPrice: DecimalFixed.fromInt(0),
      );
    }
    final purchases = await entries();
    final ordered = purchasedItemsLast(original, purchases);
    expect(ordered.map((item) => item.name), ['B', 'D', 'A', 'C']);
    expect(
      reorderItemGroup(ordered, purchases, 0, 1)!.map((item) => item.name),
      ['D', 'B', 'A', 'C'],
    );
    expect(
      reorderItemGroup(ordered, purchases, 2, 3)!.map((item) => item.name),
      ['B', 'D', 'C', 'A'],
    );
    expect(reorderItemGroup(ordered, purchases, 0, 3), isNull);
    expect(reorderItemGroup(ordered, purchases, 3, 0), isNull);
    expect(reorderItemGroup(ordered, purchases, -1, 0), isNull);
    await shopping.removePurchases(ids[0]);
    expect(
      purchasedItemsLast(original, await entries()).map((item) => item.name),
      ['A', 'B', 'D', 'C'],
    );
    expect((await shopping.watchItems(listId).first).map((item) => item.name), [
      'A',
      'B',
      'C',
      'D',
    ]);
  });
}
