import 'package:drift/drift.dart';

import '../../core/calc/line_calc.dart';
import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/util/normalize_name.dart';
import '../../core/quantity/unit_code.dart';
import '../../data/db/app_database.dart';
import '../shopping_mode/shopping_repository.dart';
import 'starter_categories.dart';
import 'taxonomy/category_suggester.dart';
import '../voice_input/parser/parsed_item_candidate.dart';
import '../../app/app_defaults.dart';

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
    String? categoryName,
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
    final sortOrder = existingId == null
        ? ((await (_db.select(_db.plannedItems)
                      ..where((t) => t.listId.equals(listId))
                      ..orderBy([(t) => OrderingTerm.desc(t.sortOrder)])
                      ..limit(1))
                    .getSingleOrNull())
                ?.sortOrder ??
            -1) +
            1
        : (await (_db.select(_db.plannedItems)
                  ..where((t) => t.id.equals(existingId)))
                .getSingle())
            .sortOrder;
    if (categoryId == null && categoryName != null && categoryName.trim().isNotEmpty) {
      final categories = await _db.select(_db.categories).get();
      final normalized = normalizeName(categoryName);
      final matching = categories.where((c) => normalizeName(c.name) == normalized);
      categoryId = matching.isNotEmpty ? matching.first.id : await _db.into(_db.categories)
          .insert(CategoriesCompanion.insert(name: categoryName.trim()));
    }
    final normalizedName = normalizeName(name);
    // No category chosen: the product's remembered category fills it in.
    if (categoryId == null && (categoryName == null || categoryName.trim().isEmpty)) {
      categoryId = await CategorySuggester(_db).suggestCategory(normalizedName);
    }
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
            sortOrder: Value(sortOrder),
            updatedAt: Value(DateTime.now()),
          );
    final learned = categoryId;
    if (learned != null) {
      await CategorySuggester(_db).learnDefaultCategory(name, normalizedName, learned);
    }
    if (existingId == null) return _db.into(_db.plannedItems).insert(values);
    await (_db.update(_db.plannedItems)..where((t) => t.id.equals(existingId))).write(values);
    return existingId;
  });

  Future<void> addCandidates(int listId, List<ParsedItemCandidate> items) => _db.transaction(() async {
    for (final c in items) {
      await addItem(listId: listId, name: c.name, brand: c.brand, categoryName: c.category,
        quantity: c.quantity ?? DecimalFixed.fromInt(1),
        unitCode: (c.unitCode ?? AppDefaults.defaultUnit()).dbCode,
        priceIsUnitPrice: c.isUnitPrice ?? false, price: c.unitPrice);
    }
  });

  Stream<List<PlannedItem>> watchItems(int listId) =>
      (_db.select(_db.plannedItems)
            ..where((t) => t.listId.equals(listId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .watch();

  Future<void> reorderItems(int listId, List<int> itemIds) async {
    final items = await getItems(listId);
    final known = items.map((item) => item.id).toSet();
    if (itemIds.length != known.length || itemIds.toSet().length != known.length ||
        !itemIds.every(known.contains)) {
      throw ArgumentError('Items must belong to their list');
    }
    await _db.transaction(() async {
      for (var index = 0; index < itemIds.length; index++) {
        await (_db.update(_db.plannedItems)
              ..where((t) => t.id.equals(itemIds[index])))
            .write(PlannedItemsCompanion(
              sortOrder: Value(index),
              updatedAt: Value(DateTime.now()),
            ));
      }
    });
  }

  Future<List<PlannedItem>> getItems(int listId) =>
      (_db.select(_db.plannedItems)..where((t) => t.listId.equals(listId)))
          .get();

  Future<void> removeItem(int itemId) => _db.transaction(() async {
    await ShoppingRepository(_db).removePurchases(itemId);
    await (_db.delete(_db.plannedItems)..where((t) => t.id.equals(itemId))).go();
  });

  Future<DeletedItemSnapshot> deleteItem(int itemId) async {
    final item = await (_db.select(_db.plannedItems)
          ..where((t) => t.id.equals(itemId)))
        .getSingle();
    final entries = await (_db.select(_db.purchaseEntries)
          ..where((t) => t.plannedItemId.equals(itemId)))
        .get();
    final entryIds = entries.map((entry) => entry.id).toList();
    final observations = entryIds.isEmpty
        ? <PriceObservation>[]
        : await (_db.select(_db.priceObservations)
              ..where((t) => t.purchaseEntryId.isIn(entryIds)))
            .get();
    await _db.transaction(() async {
      for (final observation in observations) {
        if (observation.productId != null) {
          await _db.customUpdate(
            'UPDATE product_memory SET use_count = MAX(0, use_count - 1) WHERE id = ?',
            variables: [Variable<int>(observation.productId!)],
          );
        }
      }
      if (entryIds.isNotEmpty) {
        await (_db.delete(_db.priceObservations)
              ..where((t) => t.purchaseEntryId.isIn(entryIds)))
            .go();
        await (_db.delete(_db.purchaseEntries)
              ..where((t) => t.id.isIn(entryIds)))
            .go();
      }
      await (_db.delete(_db.plannedItems)..where((t) => t.id.equals(itemId))).go();
    });
    return DeletedItemSnapshot(
      item: item,
      entries: entries,
      observations: observations,
    );
  }

  Future<void> undoDelete(DeletedItemSnapshot snapshot) => _db.transaction(() async {
    await _db.into(_db.plannedItems).insert(snapshot.item, mode: InsertMode.insertOrReplace);
    for (final entry in snapshot.entries) {
      await _db.into(_db.purchaseEntries).insert(entry, mode: InsertMode.insertOrReplace);
    }
    for (final observation in snapshot.observations) {
      if (observation.productId != null) {
        await _db.customUpdate(
          'UPDATE product_memory SET use_count = use_count + 1 WHERE id = ?',
          variables: [Variable<int>(observation.productId!)],
        );
      }
      await _db.into(_db.priceObservations).insert(
            observation,
            mode: InsertMode.insertOrReplace,
          );
    }
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

class DeletedItemSnapshot {
  const DeletedItemSnapshot({
    required this.item,
    required this.entries,
    required this.observations,
  });

  final PlannedItem item;
  final List<PurchaseEntry> entries;
  final List<PriceObservation> observations;
}
