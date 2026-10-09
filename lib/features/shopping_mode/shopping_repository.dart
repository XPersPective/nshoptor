import 'package:drift/drift.dart';

import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/quantity/unit_code.dart';
import '../../core/util/normalize_name.dart';
import '../../core/util/combine_latest.dart';
import '../../data/db/app_database.dart';
import '../lists/suggestions/product_memory_repository.dart';
import 'item_status.dart';

/// Alışveriş modu üst şeridinin anlık özeti (spec §6.5). Tüm değerler
/// minor unit int; hesap ListeCalc/variance motorundan gelir.
class CartSummary {
  const CartSummary({
    required this.plannedTotalMinor,
    required this.cartActualMinor,
    required this.remainingPlanMinor,
    required this.projectedCheckoutMinor,
    required this.budgetRemainingMinor,
    required this.doneCount,
    required this.totalCount,
  });

  final int plannedTotalMinor;
  final int cartActualMinor;
  final int remainingPlanMinor;
  final int projectedCheckoutMinor;

  /// null = bütçe girilmemiş; negatif = aşım.
  final int? budgetRemainingMinor;
  final int doneCount;
  final int totalCount;

  bool get isOverBudget =>
      budgetRemainingMinor != null && budgetRemainingMinor! < 0;
}

/// Alışveriş oturumu işlemleri (spec §6.5-6.6).
class ShoppingRepository {
  ShoppingRepository(this._db) : _memory = ProductMemoryRepository(_db);

  final AppDatabase _db;
  AppDatabase get db => _db;
  final ProductMemoryRepository _memory;

  Future<ShoppingList> getList(int listId) => (_db.select(
    _db.shoppingLists,
  )..where((t) => t.id.equals(listId))).getSingle();

  /// Alışverişi başlatır: planned → shopping (startedAt damgası).
  Future<void> startShopping(int listId) async {
    final list = await getList(listId);
    if (list.status == 'planned' || list.status == 'draft') {
      await (_db.update(
        _db.shoppingLists,
      )..where((t) => t.id.equals(listId))).write(
        ShoppingListsCompanion(
          status: const Value('shopping'),
          startedAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  Stream<List<PlannedItem>> watchItems(int listId) =>
      (_db.select(_db.plannedItems)
            ..where((t) => t.listId.equals(listId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .watch();

  Stream<List<PurchaseEntry>> watchEntries(int listId) => (_db.select(
    _db.purchaseEntries,
  )..where((t) => t.listId.equals(listId))).watch();

  /// Ürün durumunu değiştirir; sepette çıkışta (inCart → pending vb.)
  /// o ürüne bağlı satın alım kayıtları silinir (kullanıcı geri aldı).
  Future<void> setItemStatus(int itemId, ItemStatus next) async {
    await _db.transaction(() async {
      await (_db.update(
        _db.plannedItems,
      )..where((t) => t.id.equals(itemId))).write(
        PlannedItemsCompanion(
          status: Value(next.name),
          updatedAt: Value(DateTime.now()),
        ),
      );
      if (!next.isInCart) {
        await removePurchases(itemId);
      }
    });
  }

  /// Shared replacement/undo path; historical unlinked observations stay intact.
  Future<void> removePurchases(int itemId) => _db.transaction(() async {
    final entries = await (_db.select(
      _db.purchaseEntries,
    )..where((t) => t.plannedItemId.equals(itemId))).get();
    final ids = entries.map((e) => e.id).toList();
    final observations = await (_db.select(
      _db.priceObservations,
    )..where((t) => t.purchaseEntryId.isIn(ids))).get();
    for (final observation in observations) {
      if (observation.productId != null) {
        await _db.customUpdate(
          'UPDATE product_memory SET use_count = MAX(0, use_count - 1) WHERE id = ?',
          variables: [Variable<int>(observation.productId!)],
        );
      }
    }
    await (_db.delete(
      _db.priceObservations,
    )..where((t) => t.purchaseEntryId.isIn(ids))).go();
    await (_db.delete(
      _db.purchaseEntries,
    )..where((t) => t.plannedItemId.equals(itemId))).go();
  });

  /// Satın alım kaydı: gerçek miktar/fiyat/indirim; eksi satır (iade)
  /// [quantity] negatif verilerek kontrollü girilir (spec §6.5).
  /// [price] birim fiyat olarak yorumlanır; [lineTotal] verilirse onun
  /// minor değeri doğrudan kullanılır.
  Future<void> recordPurchase({
    required int listId,
    required String name,
    required String normalizedName,
    required DecimalFixed quantity,
    required String unitCode,
    DecimalFixed? unitPrice,
    int? lineTotalMinor,
    int discountMinor = 0,
    int? plannedItemId,
    String? alternativeName,
    String? note,
    String source = 'manual',
    bool replaceExisting = true,
  }) => _db.transaction(() async {
    if (name.trim().isEmpty ||
        normalizedName.trim().isEmpty ||
        (quantity.isZero &&
            !(source == 'receiptOcr' &&
                lineTotalMinor != null &&
                lineTotalMinor < 0)) ||
        (unitPrice?.isNegative ?? false) ||
        discountMinor < 0 ||
        (quantity.isPositive && lineTotalMinor != null && lineTotalMinor < 0) ||
        (quantity.isNegative && lineTotalMinor != null && lineTotalMinor > 0)) {
      throw ArgumentError('Invalid purchase');
    }
    if (!UnitCode.values.any(
      (u) => u.dbCode == unitCode || u.name == unitCode,
    )) {
      throw ArgumentError('Invalid unit: $unitCode');
    }
    final list = await getList(listId);
    if (plannedItemId != null) {
      final item = await (_db.select(
        _db.plannedItems,
      )..where((t) => t.id.equals(plannedItemId))).getSingleOrNull();
      if (item == null || item.listId != listId) {
        throw ArgumentError('Purchase item must belong to its list');
      }
    }
    final digits = _digitsFor(list.currencyCode);
    final gross =
        lineTotalMinor ??
        (unitPrice == null
            ? null
            : (quantity * unitPrice).toMinorUnits(digits));
    final lineTotal = (gross ?? 0) - discountMinor;
    if (gross == null && discountMinor != 0 ||
        gross != null && gross >= 0 && lineTotal < 0) {
      throw ArgumentError('Discount exceeds purchase');
    }
    // Aynı ürüne yeniden fiyat girmek öncekini değiştirir (çift sayılmaz).
    if (plannedItemId != null && replaceExisting) {
      await removePurchases(plannedItemId);
    }
    final purchaseId = await _db
        .into(_db.purchaseEntries)
        .insert(
          PurchaseEntriesCompanion.insert(
            listId: listId,
            plannedItemId: Value(plannedItemId),
            name: name,
            normalizedName: normalizedName,
            actualQuantity: quantity.toDbString(),
            actualUnitCode: unitCode,
            actualUnitPrice: Value(unitPrice?.toDbString()),
            grossTotalMinorUnits: Value(gross),
            discountMinorUnits: Value(discountMinor),
            actualLineTotalMinorUnits: lineTotal,
            source: Value(source),
            userConfirmed: const Value(true),
            alternativeFlag: Value(alternativeName != null),
            note: Value(note),
          ),
        );
    if (plannedItemId != null) {
      await setItemStatus(plannedItemId, ItemStatus.inCart);
    }
    // Doğrulanmış kayıt fiyat gözlemi üretir (spec §6.10); plansız alımlar
    // da hafızaya girer.
    if (gross != null && quantity.isPositive) {
      await _memory.recordObservation(
        name: name,
        normalizedName: normalizedName,
        listId: listId,
        quantity: quantity.toDbString(),
        unitCode: unitCode,
        unitPrice: unitPrice?.toDbString(),
        lineTotalMinor: lineTotal,
        discountMinor: discountMinor,
        currencyCode: list.currencyCode,
        purchaseEntryId: purchaseId,
        storeId: list.storeId,
        source: source,
      );
    }
  });

  /// Plansız ürün: satın alım kaydı olarak eklenir; planlı ürüne
  /// bağlanmaz, sonuç ekranında ayrı gösterilir (spec §6.6).
  Future<void> addUnplannedPurchase({
    required int listId,
    required String name,
    required DecimalFixed quantity,
    required String unitCode,
    DecimalFixed? unitPrice,
  }) {
    return recordPurchase(
      listId: listId,
      name: name,
      normalizedName: normalizeName(name),
      quantity: quantity,
      unitCode: unitCode,
      unitPrice: unitPrice,
    );
  }

  /// Özet akışı: planlananlar + satın alımlar birleşik hesaplanır.
  Stream<CartSummary> watchSummary(int listId) {
    final listFuture = getList(listId).asStream();
    final itemsStream = watchItems(listId);
    final entriesStream = watchEntries(listId);
    return combineLatest3(listFuture, itemsStream, entriesStream, (
      ShoppingList list,
      List<PlannedItem> items,
      List<PurchaseEntry> entries,
    ) {
      var plannedTotal = 0;
      var remainingPlan = 0;
      var doneCount = 0;
      for (final item in items) {
        final line = item.plannedLineTotalMinorUnits ?? 0;
        plannedTotal += line;
        final status = ItemStatus.tryFromDb(item.status) ?? ItemStatus.pending;
        if (status.isClosed) {
          doneCount++;
        } else {
          remainingPlan += line;
        }
      }

      var cartActual = 0;
      for (final entry in entries) {
        cartActual += entry.actualLineTotalMinorUnits;
      }

      final projected = cartActual + remainingPlan;
      final budget = list.budgetMinorUnits;

      return CartSummary(
        plannedTotalMinor: plannedTotal,
        cartActualMinor: cartActual,
        remainingPlanMinor: remainingPlan,
        projectedCheckoutMinor: projected,
        budgetRemainingMinor: budget == null ? null : budget - projected,
        doneCount: doneCount,
        totalCount: items.length,
      );
    });
  }

  static int _digitsFor(String code) => Currency.fromCode(code).minorUnitDigits;
}
