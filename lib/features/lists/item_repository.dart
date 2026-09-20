import 'package:drift/drift.dart';

import '../../core/calc/line_calc.dart';
import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../data/db/app_database.dart';
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
  }) async {
    final normalizedName = _normalize(name);
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
    return _db.into(_db.plannedItems).insert(
          PlannedItemsCompanion.insert(
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
          ),
        );
  }

  Stream<List<PlannedItem>> watchItems(int listId) =>
      (_db.select(_db.plannedItems)
            ..where((t) => t.listId.equals(listId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .watch();

  Future<List<PlannedItem>> getItems(int listId) =>
      (_db.select(_db.plannedItems)..where((t) => t.listId.equals(listId)))
          .get();

  Future<void> removeItem(int itemId) =>
      (_db.delete(_db.plannedItems)..where((t) => t.id.equals(itemId))).go();

  /// Planlanan toplam: satır değerlerinin minor-unit toplamı (spec §7.3).
  Future<int> plannedTotalMinor(int listId) async {
    final items = await getItems(listId);
    return items.fold<int>(
        0, (sum, item) => sum + (item.plannedLineTotalMinorUnits ?? 0));
  }

  Future<String> _listCurrency(int listId) async {
    final rows = await _db.select(_db.shoppingLists).get();
    for (final r in rows) {
      if (r.id == listId) return r.currencyCode;
    }
    return 'TRY';
  }

  /// Normalize edilmiş arama adı: küçük harf + Türkçe/aksan katlama +
  /// çoklu boşluk temizliği (alias eşleştirmeleri bu normalizasyonu kullanır).
  static String _normalize(String name) => name
      .toLowerCase()
      .replaceAll(RegExp(r'[çÇ]'), 'c')
      .replaceAll(RegExp(r'[ğĞ]'), 'g')
      .replaceAll(RegExp(r'[ıİ]'), 'i')
      .replaceAll(RegExp(r'[öÖ]'), 'o')
      .replaceAll(RegExp(r'[şŞ]'), 's')
      .replaceAll(RegExp(r'[üÜ]'), 'u')
      .replaceAll(RegExp(r'[^a-z0-9 ]'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
