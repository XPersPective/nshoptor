import 'package:drift/drift.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/quantity/unit_code.dart';
import '../../core/util/normalize_name.dart';
import '../../data/db/app_database.dart';

/// Örnek veriler: Geçmiş, grafikler ve ürün fiyat geçmişini denemek için
/// son 12 ayda tamamlanmış alışverişler. Tüm listeler [marker] notuyla
/// işaretlenir; [remove] yalnız bunları (ve fiyat gözlemlerini) siler.
class DemoData {
  DemoData(this._db);

  final AppDatabase _db;

  static const marker = 'nshoptor-demo';

  Future<bool> present() async =>
      (await (_db.select(_db.shoppingLists)
                ..where((t) => t.note.equals(marker))
                ..limit(1))
              .get())
          .isNotEmpty;

  Future<int> insert(AppLocalizations l10n, {required String currencyCode, DateTime? now}) =>
      _db.transaction(() async {
        await _removeRows();
        final today = now ?? DateTime.now();
        final digits = Currency.fromCode(currencyCode).minorUnitDigits;
        var scale = 1;
        for (var i = 0; i < digits; i++) {
          scale *= 10;
        }
        // (ad, birim, miktar, birim fiyat)
        final products = [
          (l10n.demoProductApple, UnitCode.kilogram, '1.5', 42.0),
          (l10n.demoProductBread, UnitCode.adet, '2', 15.0),
          (l10n.demoProductMilk, UnitCode.litre, '2', 38.0),
          (l10n.demoProductCheese, UnitCode.kilogram, '0.5', 320.0),
          (l10n.demoProductTomato, UnitCode.kilogram, '1', 35.0),
          (l10n.demoProductEggs, UnitCode.adet, '10', 6.5),
          (l10n.demoProductCoffee, UnitCode.adet, '1', 180.0),
          (l10n.demoProductDetergent, UnitCode.adet, '1', 210.0),
        ];
        final productIds = <int>[];
        for (final (name, unit, _, _) in products) {
          final normalized = normalizeName(name);
          final existing = await (_db.select(_db.productMemory)..where((t) => t.normalizedName.equals(normalized)))
              .getSingleOrNull();
          productIds.add(existing?.id ??
              await _db.into(_db.productMemory).insert(ProductMemoryCompanion.insert(
                    canonicalName: name,
                    normalizedName: normalized,
                    defaultUnitCode: Value(unit.dbCode),
                  )));
        }

        var count = 0;
        for (var m = 11; m >= 0; m--) {
          final shoppings = m % 3 == 0 ? 3 : 2;
          for (var s = 0; s < shoppings; s++) {
            final date = DateTime(today.year, today.month - m, 3 + s * 9, 11);
            if (date.isAfter(today)) continue;
            final listId = await _db.into(_db.shoppingLists).insert(ShoppingListsCompanion.insert(
                  currencyCode: currencyCode,
                  title: Value('${l10n.demoDataTitle} ${date.day}.${date.month}.${date.year}'),
                  status: const Value('completed'),
                  createdAt: Value(date),
                  completedAt: Value(date),
                  note: const Value(marker),
                ));
            count++;
            final itemCount = 4 + (s + m) % 3;
            for (var k = 0; k < itemCount; k++) {
              final index = (m + s * 3 + k) % products.length;
              final (name, unit, quantity, base) = products[index];
              final trend = 1 + 0.015 * (11 - m);
              final wobble = const [-0.04, 0.0, 0.05][(m + s + k) % 3];
              final actualUnit = (base * trend * (1 + wobble) * scale).round();
              final plannedUnit = (base * (1 + 0.012 * (11 - m)) * scale).round();
              final qty = DecimalFixed.parse(quantity);
              final actualLine = (DecimalFixed.fromMinorUnits(actualUnit, digits) * qty).toMinorUnits(digits);
              final plannedLine = (DecimalFixed.fromMinorUnits(plannedUnit, digits) * qty).toMinorUnits(digits);
              final actualPrice = DecimalFixed.fromMinorUnits(actualUnit, digits).toDbString();
              final itemId = await _db.into(_db.plannedItems).insert(PlannedItemsCompanion.insert(
                    listId: listId,
                    productId: Value(productIds[index]),
                    name: name,
                    normalizedName: normalizeName(name),
                    plannedQuantity: quantity,
                    plannedUnitCode: unit.dbCode,
                    pricingInputMode: 'unitPrice',
                    plannedUnitPrice: Value(DecimalFixed.fromMinorUnits(plannedUnit, digits).toDbString()),
                    plannedLineTotalMinorUnits: Value(plannedLine),
                    status: const Value('inCart'),
                    sortOrder: Value(k),
                    createdAt: Value(date),
                  ));
              final entryId = await _db.into(_db.purchaseEntries).insert(PurchaseEntriesCompanion.insert(
                    listId: listId,
                    plannedItemId: Value(itemId),
                    name: name,
                    normalizedName: normalizeName(name),
                    actualQuantity: quantity,
                    actualUnitCode: unit.dbCode,
                    actualUnitPrice: Value(actualPrice),
                    actualLineTotalMinorUnits: actualLine,
                    userConfirmed: const Value(true),
                    note: const Value(marker),
                    createdAt: Value(date),
                  ));
              await _db.into(_db.priceObservations).insert(PriceObservationsCompanion.insert(
                    productId: Value(productIds[index]),
                    purchaseEntryId: Value(entryId),
                    observedAt: Value(date),
                    quantity: quantity,
                    unitCode: unit.dbCode,
                    normalizedBaseQuantity: Value(quantity),
                    unitPrice: actualPrice,
                    lineTotalMinorUnits: actualLine,
                    currencyCode: currencyCode,
                    source: 'manual',
                  ));
            }
          }
        }
        return count;
      });

  /// Yalnız örnek listeleri ve onlara bağlı kayıtları siler.
  Future<void> remove() => _db.transaction(_removeRows);

  Future<void> _removeRows() async {
    final lists = await (_db.select(_db.shoppingLists)..where((t) => t.note.equals(marker))).get();
    if (lists.isEmpty) return;
    final ids = [for (final l in lists) l.id];
    final entries = await (_db.select(_db.purchaseEntries)..where((t) => t.listId.isIn(ids))).get();
    final entryIds = [for (final e in entries) e.id];
    if (entryIds.isNotEmpty) {
      await (_db.delete(_db.priceObservations)..where((t) => t.purchaseEntryId.isIn(entryIds))).go();
    }
    await (_db.delete(_db.purchaseEntries)..where((t) => t.listId.isIn(ids))).go();
    await (_db.delete(_db.plannedItems)..where((t) => t.listId.isIn(ids))).go();
    await (_db.delete(_db.shoppingLists)..where((t) => t.id.isIn(ids))).go();
  }
}
