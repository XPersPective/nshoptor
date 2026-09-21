import 'package:drift/drift.dart';


import '../../../data/db/app_database.dart';

/// Mağaza/kategori/reyon CRUD ve sıralama (spec §6.3).
///
/// Reyonlar mağaza bazlıdır: `Aisles.storeId` + `sortOrder` kombinasyonu
/// "hangi mağazada hangi sıra" bilisini kalıcı tutar. Kategoriler globaldir.
class TaxonomyRepository {
  TaxonomyRepository(this._db);

  final AppDatabase _db;

  // ---- Mağazalar ----

  Future<int> createStore(String name, {int sortOrder = 0}) =>
      _db.into(_db.stores).insert(
            StoresCompanion.insert(name: name, sortOrder: Value(sortOrder)),
          );

  Future<void> renameStore(int id, String name) =>
      (_db.update(_db.stores)..where((t) => t.id.equals(id)))
          .write(StoresCompanion(name: Value(name)));

  Future<void> deleteStore(int id) =>
      (_db.delete(_db.stores)..where((t) => t.id.equals(id))).go();

  Future<List<Store>> getStores() =>
      (_db.select(_db.stores)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();

  /// Sırayı yeniden yazar: verilen kimlik sırası sortOrder olur.
  Future<void> reorderStores(List<int> orderedIds) async {
    await _db.transaction(() async {
      for (var i = 0; i < orderedIds.length; i++) {
        await (_db.update(_db.stores)
              ..where((t) => t.id.equals(orderedIds[i])))
            .write(StoresCompanion(sortOrder: Value(i)));
      }
    });
  }

  // ---- Kategoriler ----

  Future<int> createCategory(String name, {int sortOrder = 0}) =>
      _db.into(_db.categories).insert(
            CategoriesCompanion.insert(name: name, sortOrder: Value(sortOrder)),
          );

  Future<void> renameCategory(int id, String name) =>
      (_db.update(_db.categories)..where((t) => t.id.equals(id)))
          .write(CategoriesCompanion(name: Value(name)));

  Future<void> deleteCategory(int id) =>
      (_db.delete(_db.categories)..where((t) => t.id.equals(id))).go();

  Future<List<Category>> getCategories() =>
      (_db.select(_db.categories)
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();

  Future<void> reorderCategories(List<int> orderedIds) async {
    await _db.transaction(() async {
      for (var i = 0; i < orderedIds.length; i++) {
        await (_db.update(_db.categories)
              ..where((t) => t.id.equals(orderedIds[i])))
            .write(CategoriesCompanion(sortOrder: Value(i)));
      }
    });
  }

  // ---- Reyonlar (mağaza bazlı) ----

  Future<int> createAisle(String name, {int? storeId, int sortOrder = 0}) =>
      _db.into(_db.aisles).insert(
            AislesCompanion.insert(
              name: name,
              storeId: Value(storeId),
              sortOrder: Value(sortOrder),
            ),
          );

  Future<void> deleteAisle(int id) =>
      (_db.delete(_db.aisles)..where((t) => t.id.equals(id))).go();

  Future<List<Aisle>> getAisles({int? storeId}) {
    final query = _db.select(_db.aisles);
    if (storeId != null) {
      query.where((t) => t.storeId.equals(storeId));
    }
    query.orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
    return query.get();
  }

  /// Mağaza bazlı reyon sırası: her mağazanın kendi sırası kalıcıdır.
  Future<void> reorderAisles(int storeId, List<int> orderedIds) {
    return _db.transaction(() async {
      for (var i = 0; i < orderedIds.length; i++) {
        await (_db.update(_db.aisles)
              ..where((t) => t.id.equals(orderedIds[i])))
            .write(AislesCompanion(
          sortOrder: Value(i),
          storeId: Value(storeId),
        ));
      }
    });
  }

}
