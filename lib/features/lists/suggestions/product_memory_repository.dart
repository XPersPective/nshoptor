import 'package:drift/drift.dart';

import '../../../core/util/normalize_name.dart';
import '../../../data/db/app_database.dart';

/// Ürün hafızası ve fiyat gözlemleri (spec §6.2 öneriler, §6.10).
///
/// Doğrulanmış her satın alım bir PriceObservation üretir; ProductMemory
/// normalizedName başına tek satırdır (useCount/lastUsedAt güncellenir).
/// Farklı para birimleri hiçbir zaman karşılaştırılmaz.
class ProductMemoryRepository {
  ProductMemoryRepository(this._db);

  final AppDatabase _db;

  /// Doğrulanmış satın alımdan gözlem yazar ve ürün hafızasını günceller.
  Future<void> recordObservation({
    required String name,
    required String normalizedName,
    required int listId,
    required String quantity,
    required String unitCode,
    String? unitPrice,
    required int lineTotalMinor,
    int discountMinor = 0,
    required String currencyCode,
    int? storeId,
    String source = 'manual',
  }) async {
    final productId = await _upsertProduct(name, normalizedName);
    await _db.into(_db.priceObservations).insert(
          PriceObservationsCompanion.insert(
            productId: Value(productId),
            storeId: Value(storeId),
            quantity: quantity,
            unitCode: unitCode,
            unitPrice: unitPrice ?? '0',
            lineTotalMinorUnits: lineTotalMinor,
            discountMinorUnits: Value(discountMinor),
            currencyCode: currencyCode,
            source: source,
          ),
        );
  }

  Future<int> _upsertProduct(String name, String normalizedName) async {
    final existing = await (_db.select(_db.productMemory)
          ..where((t) => t.normalizedName.equals(normalizedName)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.productMemory)
            ..where((t) => t.id.equals(existing.id)))
          .write(ProductMemoryCompanion(
        useCount: Value(existing.useCount + 1),
        lastUsedAt: Value(DateTime.now()),
      ));
      return existing.id;
    }
    return _db.into(_db.productMemory).insert(
          ProductMemoryCompanion.insert(
            canonicalName: name,
            normalizedName: normalizedName,
            useCount: const Value(1),
            lastUsedAt: Value(DateTime.now()),
          ),
        );
  }

  /// Yazarken öneri: normalize önekiyle eşleşen hafıza kayıtları; en çok
  /// kullanılan ve en yeni kullanılanlar önce (spec §6.2).
  Future<List<ProductMemoryData>> suggestNames(String query,
      {int limit = 5}) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      return (_db.select(_db.productMemory)
            ..orderBy([
              (t) => OrderingTerm.desc(t.useCount),
              (t) => OrderingTerm.desc(t.lastUsedAt),
            ])
            ..limit(limit))
          .get();
    }
    final normalized = normalizeName(q);
    return (_db.select(_db.productMemory)
          ..where((t) => t.normalizedName.like('$normalized%'))
          ..orderBy([
            (t) => OrderingTerm.desc(t.useCount),
            (t) => OrderingTerm.desc(t.lastUsedAt),
          ])
          ..limit(limit))
        .get();
  }

  /// Son ödenen fiyat; [storeId] verilirse yalnız o mağazadan (spec §6.2).
  /// Fiyat gözlemi yoksa null.
  Future<PriceObservation?> lastObservation(int productId, {int? storeId}) {
    final query = _db.select(_db.priceObservations)
      ..where((t) => t.productId.equals(productId));
    if (storeId != null) {
      query.where((t) => t.storeId.equals(storeId));
    }
    query
      ..orderBy([(t) => OrderingTerm.desc(t.observedAt)])
      ..limit(1);
    return query.getSingleOrNull();
  }

  /// Favoriler (ana ekran/form hızlı erişimi).
  Future<List<ProductMemoryData>> favorites() =>
      (_db.select(_db.productMemory)
            ..where((t) => t.favorite.equals(true))
            ..orderBy([(t) => OrderingTerm.desc(t.useCount)]))
          .get();

  Future<void> setFavorite(int productId, bool favorite) =>
      (_db.update(_db.productMemory)..where((t) => t.id.equals(productId)))
          .write(ProductMemoryCompanion(favorite: Value(favorite)));

  /// Aynı listede aynı normalize ada sahip planlanan ürün (yinelenen uyarısı).
  Future<PlannedItem?> findDuplicateInList(int listId, String normalizedName) =>
      (_db.select(_db.plannedItems)
            ..where((t) => t.listId.equals(listId))
            ..where((t) => t.normalizedName.equals(normalizedName)))
          .getSingleOrNull();
}

