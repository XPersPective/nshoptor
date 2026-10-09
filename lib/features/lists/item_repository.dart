import 'package:drift/drift.dart';

import '../../core/calc/line_calc.dart';
import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/util/normalize_name.dart';
import '../../core/quantity/unit_code.dart';
import '../../data/db/app_database.dart';
import '../shopping_mode/shopping_repository.dart';
import 'starter_categories.dart';

/// Planlanan ürünler üzerinde işlemler (spec §6.2).
class ItemRepository {
  ItemRepository(this._db, {StarterCategories? starterCategories})
      : starterCategories = starterCategories ?? StarterCategories();

  final AppDatabase _db;
  final StarterCategories starterCategories;

  /// Ürünü ekler; [pricingInputMode]'a göre girilen taraf korunur, diğer
  /// taraf hesaplanır (spec §6.2: kullanıcının girdiği taraf kaybolmaz).
  Future<int> addItem({
    required int listId,
    required String name,
    String? brand,
    int? categoryId,
    required DecimalFixed quantity,
    required String unitCode,
    required bool priceIsUnitPrice,
    DecimalFixed? price,
    bool requiredFlag = false,
    String? note,
    DecimalFixed? maxAcceptablePrice,
    int? existingId,
  }) => _db.transaction(() async {
    if (name.trim().isEmpty || !quantity.isPositive || (price?.isNegative ?? false) ||
        (maxAcceptablePrice?.isNegative ?? false) ||
        !UnitCode.values.any((u) => u.dbCode == unitCode || u.name == unitCode)) {
      throw ArgumentError('Invalid planned item');
    }
    if (existingId != null) {
      final item = await (_db.select(_db.plannedItems)..where((t) => t.id.equals(existingId))).getSingle();
      if (item.listId != listId) throw ArgumentError('Item must belong to its list');
    }
    final normalizedName = normalizeName(name);
    final mode = priceIsUnitPrice ? 'unitPrice' : 'lineTotal';
    DecimalFixed? unitPrice;
    int? lineTotalMinor;
    final currencyCode = await _listCurrency(listId);
    final digits = Currency.fromCode(currencyCode).minorUnitDigits;
    if (price != null) {
      if (priceIsUnitPrice) {
        unitPrice = price;
        lineTotalMinor =
            LineCalc.plannedLineTotal(quantity, price).toMinorUnits(digits);
      } else {
        lineTotalMinor = price.toMinorUnits(digits);
        if (quantity.isPositive) {
          unitPrice = price.divide(quantity, scale: DecimalFixed.maxFractionDigits);
        }
      }
    }
    final values = PlannedItemsCompanion.insert(
            listId: listId,
            name: name,
            normalizedName: normalizedName,
            brand: Value(brand),
            categoryId: Value(categoryId),
            plannedQuantity: quantity.toDbString(),
            plannedUnitCode: unitCode,
            pricingInputMode: mode,
            plannedUnitPrice: Value(unitPrice?.toDbString()),
            plannedLineTotalMinorUnits: Value(lineTotalMinor),
            requiredFlag: Value(requiredFlag),
            note: Value(note),
            maxAcceptablePrice: Value(maxAcceptablePrice?.toDbString()),
            updatedAt: Value(DateTime.now()),
          );
    if (existingId == null) return _db.into(_db.plannedItems).insert(values);
    await (_db.update(_db.plannedItems)..where((t) => t.id.equals(existingId))).write(values);
    return existingId;
  });

  Stream<List<PlannedItem>> watchItems(int listId) =>
      (_db.select(_db.plannedItems)
            ..where((t) => t.listId.equals(listId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .watch();

  Future<List<PlannedItem>> getItems(int listId) =>
      (_db.select(_db.plannedItems)..where((t) => t.listId.equals(listId)))
          .get();

  Future<void> removeItem(int itemId) => _db.transaction(() async {
    await ShoppingRepository(_db).removePurchases(itemId);
    await (_db.delete(_db.plannedItems)..where((t) => t.id.equals(itemId))).go();
  });

  /// Planlanan toplam: satır değerlerinin minor-unit toplamı (spec §7.3).
  Future<int> plannedTotalMinor(int listId) async {
    final items = await getItems(listId);
    return items.fold<int>(
        0, (sum, item) => sum + (item.plannedLineTotalMinorUnits ?? 0));
  }

  Future<String> _listCurrency(int listId) async =>
      (await (_db.select(_db.shoppingLists)..where((t) => t.id.equals(listId))).getSingle()).currencyCode;

}
