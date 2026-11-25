import 'package:drift/drift.dart';

import '../../../core/money/decimal_fixed.dart';
import '../../../core/text/store_name.dart';
import '../../../data/db/app_database.dart';
import '../../shopping_mode/item_status.dart';
import '../insights/insights_repository.dart' show SpendAmount;
import 'report_period.dart';

typedef ReportQuantity = ({DecimalFixed quantity, String unitCode});
typedef ReportStoreSpend = ({String? store, SpendAmount spent});

/// Immutable, read-only report values. No purchase or list mutation is exposed.
final class ReportProduct {
  ReportProduct({
    required this.name,
    required this.plannedQuantity,
    required this.plannedUnitCode,
    required this.plannedMinor,
    required List<ReportQuantity> actualQuantities,
    required this.actual,
    required this.purchased,
    this.isDiscount = false,
  }) : actualQuantities = List.unmodifiable(actualQuantities);
  final String name;
  final DecimalFixed? plannedQuantity;
  final String? plannedUnitCode;
  final int? plannedMinor;
  final List<ReportQuantity> actualQuantities;
  final SpendAmount actual;
  final bool purchased;
  final bool isDiscount;
  int? get difference =>
      purchased && plannedMinor != null && actual.known && !actual.unknown
      ? actual.minor - plannedMinor!
      : null;
}

final class ShoppingReport {
  ShoppingReport({
    required this.list,
    required this.storeName,
    required List<ReportProduct> products,
    required List<Receipt> receipts,
    required this.spent,
    required this.plannedMinor,
    List<ReportStoreSpend>? storeSpend,
  }) : products = List.unmodifiable(products),
       receipts = List.unmodifiable(receipts),
       storeSpend = List.unmodifiable(
         storeSpend ??
             [
               (
                 store: storeName == null ? null : cleanStoreName(storeName),
                 spent: spent,
               ),
             ],
       );
  final ShoppingList list;

  /// Spend split by cleaned store name (null = unknown). One trip can span
  /// stores when its receipts come from different shops.
  final List<ReportStoreSpend> storeSpend;
  final String? storeName;
  final List<ReportProduct> products;
  final List<Receipt> receipts;
  final SpendAmount spent;
  final int? plannedMinor;
}

final class PeriodReport {
  PeriodReport({
    required this.period,
    required this.currencyCode,
    required List<ShoppingReport> shopping,
  }) : shopping = List.unmodifiable(shopping) {
    if (shopping.any((report) => report.list.currencyCode != currencyCode)) {
      throw ArgumentError('Report currencies must not be combined');
    }
  }
  final ReportPeriod period;
  final String currencyCode;
  final List<ShoppingReport> shopping;
  SpendAmount get spent => SpendAmount(
    shopping.fold(0, (sum, report) => sum + report.spent.minor),
    known: shopping.any((r) => r.spent.known),
    unknown: shopping.any((r) => r.spent.unknown),
  );
}

class ReportRepository {
  ReportRepository(this._db);
  final AppDatabase _db;

  Future<PeriodReport> period(ReportPeriod period, String currencyCode) =>
      _db.transaction(() async {
        final lists =
            await (_db.select(_db.shoppingLists)
                  ..where(
                    (t) =>
                        t.status.equals('completed') &
                        t.currencyCode.equals(currencyCode) &
                        t.completedAt.isBiggerOrEqualValue(period.from) &
                        t.completedAt.isSmallerThanValue(period.to),
                  )
                  ..orderBy([
                    (t) => OrderingTerm.desc(t.completedAt),
                    (t) => OrderingTerm.desc(t.id),
                  ]))
                .get();
        return PeriodReport(
          period: period,
          currencyCode: currencyCode,
          shopping: await _shoppingBatch(lists),
        );
      });

  Future<ShoppingReport> shopping(int id) => _db.transaction(() async {
    final list = await (_db.select(
      _db.shoppingLists,
    )..where((t) => t.id.equals(id))).getSingle();
    return (await _shoppingBatch([list])).single;
  });

  Future<List<ShoppingReport>> _shoppingBatch(List<ShoppingList> lists) async {
    final items = <int, List<PlannedItem>>{};
    final entries = <int, List<PurchaseEntry>>{};
    final receipts = <int, List<Receipt>>{};
    final stores = <int, String>{};
    // Bound SQL parameters and query count independently of shopping-list size.
    for (var start = 0; start < lists.length; start += 400) {
      final batch = lists.skip(start).take(400).toList();
      final ids = batch.map((list) => list.id).toList();
      final batchItems =
          await (_db.select(_db.plannedItems)
                ..where((t) => t.listId.isIn(ids))
                ..orderBy([
                  (t) => OrderingTerm.asc(t.sortOrder),
                  (t) => OrderingTerm.asc(t.id),
                ]))
              .get();
      for (final item in batchItems) {
        items.putIfAbsent(item.listId, () => []).add(item);
      }
      final batchEntries =
          await (_db.select(_db.purchaseEntries)
                ..where(
                  (t) => t.listId.isIn(ids) & t.userConfirmed.equals(true),
                )
                ..orderBy([(t) => OrderingTerm.asc(t.id)]))
              .get();
      for (final entry in batchEntries) {
        entries.putIfAbsent(entry.listId, () => []).add(entry);
      }
      final batchReceipts =
          await (_db.select(_db.receipts)
                ..where(
                  (t) =>
                      t.listId.isIn(ids) &
                      t.processingStatus.equals('reviewed'),
                )
                ..orderBy([(t) => OrderingTerm.asc(t.id)]))
              .get();
      for (final receipt in batchReceipts) {
        receipts.putIfAbsent(receipt.listId!, () => []).add(receipt);
      }
      final storeIds = batch.map((l) => l.storeId).whereType<int>().toSet();
      if (storeIds.isNotEmpty) {
        for (final store in await (_db.select(
          _db.stores,
        )..where((t) => t.id.isIn(storeIds))).get()) {
          stores[store.id] = store.name;
        }
      }
    }
    return [
      for (final list in lists)
        _shopping(
          list,
          items[list.id] ?? const [],
          entries[list.id] ?? const [],
          receipts[list.id] ?? const [],
          stores[list.storeId],
        ),
    ];
  }

  ShoppingReport _shopping(
    ShoppingList list,
    List<PlannedItem> items,
    List<PurchaseEntry> entries,
    List<Receipt> receipts,
    String? storeName,
  ) {
    final linkedEntries = <int, List<PurchaseEntry>>{};
    for (final entry in entries) {
      if (entry.plannedItemId != null) {
        linkedEntries.putIfAbsent(entry.plannedItemId!, () => []).add(entry);
      }
    }
    final products = <ReportProduct>[];
    for (final item in items) {
      final linked = linkedEntries[item.id] ?? const <PurchaseEntry>[];
      final unknownLegacy =
          linked.isEmpty &&
          (ItemStatus.tryFromDb(item.status)?.isInCart ?? false);
      products.add(
        _product(
          item.name,
          linked,
          plannedQuantity: DecimalFixed.parse(item.plannedQuantity),
          plannedUnitCode: item.plannedUnitCode,
          plannedMinor: item.plannedLineTotalMinorUnits,
          unknownLegacy: unknownLegacy,
        ),
      );
    }
    final itemIds = items.map((i) => i.id).toSet();
    for (final entry in entries.where(
      (e) => !itemIds.contains(e.plannedItemId),
    )) {
      products.add(_product(entry.name, [entry]));
    }
    final knownPlan = products.where((p) => p.plannedMinor != null).toList();
    String? clean(String? raw) {
      final name = raw == null ? '' : cleanStoreName(raw);
      return name.isEmpty ? null : name;
    }

    final receiptStores = {
      for (final r in receipts)
        r.id: clean(r.confirmedStore ?? r.detectedStore),
    };
    final distinctReceiptStores = receiptStores.values
        .whereType<String>()
        .map((s) => s.toLowerCase())
        .toSet();
    final fallbackStore =
        clean(storeName) ??
        (distinctReceiptStores.length == 1
            ? receiptStores.values.whereType<String>().first
            : null);
    final byStore = <String?, ({String? store, List<PurchaseEntry> entries})>{};
    for (final entry in entries) {
      final store = receiptStores[entry.receiptId] ?? fallbackStore;
      byStore
          .putIfAbsent(store?.toLowerCase(), () => (store: store, entries: []))
          .entries
          .add(entry);
    }
    final legacyUnknown = products.any((p) => p.actual.unknown);
    final storeSpend = <ReportStoreSpend>[
      for (final (i, group) in byStore.values.indexed)
        (
          store: group.store,
          spent: SpendAmount(
            group.entries.fold(0, (s, e) => s + e.actualLineTotalMinorUnits),
            known: group.entries.any(hasMarketPrice),
            unknown:
                group.entries.any((e) => !hasMarketPrice(e)) ||
                (i == 0 && legacyUnknown),
          ),
        ),
    ];
    final spent = SpendAmount(
      entries.fold(0, (sum, entry) => sum + entry.actualLineTotalMinorUnits),
      known: entries.any(hasMarketPrice),
      unknown: legacyUnknown,
    );
    return ShoppingReport(
      list: list,
      storeName: storeName,
      storeSpend: storeSpend.isEmpty
          ? [(store: fallbackStore, spent: spent)]
          : storeSpend,
      products: products,
      receipts: receipts,
      plannedMinor: knownPlan.isEmpty
          ? null
          : knownPlan.fold<int>(
              0,
              (sum, product) => sum + product.plannedMinor!,
            ),
      spent: spent,
    );
  }

  ReportProduct _product(
    String name,
    List<PurchaseEntry> entries, {
    DecimalFixed? plannedQuantity,
    String? plannedUnitCode,
    int? plannedMinor,
    bool unknownLegacy = false,
  }) {
    final quantities = <String, DecimalFixed>{};
    for (final entry in entries) {
      final qty = DecimalFixed.parse(entry.actualQuantity);
      quantities.update(
        entry.actualUnitCode,
        (value) => value + qty,
        ifAbsent: () => qty,
      );
    }
    final actual = SpendAmount(
      entries.fold(0, (sum, entry) => sum + entry.actualLineTotalMinorUnits),
      known: entries.any(hasMarketPrice),
      unknown: unknownLegacy || entries.any((e) => !hasMarketPrice(e)),
    );
    return ReportProduct(
      name: name,
      plannedQuantity: plannedQuantity,
      plannedUnitCode: plannedUnitCode,
      plannedMinor: plannedMinor,
      actualQuantities: [
        for (final entry in quantities.entries)
          (quantity: entry.value, unitCode: entry.key),
      ],
      actual: actual,
      purchased: entries.any(hasMarketPrice),
      isDiscount:
          entries.isNotEmpty &&
          entries.every((e) => e.actualLineTotalMinorUnits < 0),
    );
  }
}
