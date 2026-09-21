import 'package:drift/drift.dart';

import '../../../data/db/app_database.dart';

/// Ürün geçmişine göre kategori önerisi (spec §6.3): normalize ada göre
/// ürün hafızası eşleşir; hafızada varsayılan kategori varsa önerilir.
/// Öneri kesin kabul edilmez — kullanıcı kolayca değiştirir.
class CategorySuggester {
  CategorySuggester(this._db);

  final AppDatabase _db;

  Future<int?> suggestCategory(String normalizedName) async {
    final product = await (_db.select(_db.productMemory)
          ..where((t) => t.normalizedName.equals(normalizedName)))
        .getSingleOrNull();
    return product?.defaultCategoryId;
  }

  /// Hafızadaki ürünün varsayılan kategorisini güncelleyen yardımcı
  /// (kullanıcı kategoriyi onayladığında öğrenilir).
  Future<void> learnDefaultCategory(
      String name, String normalizedName, int categoryId) async {
    final product = await (_db.select(_db.productMemory)
          ..where((t) => t.normalizedName.equals(normalizedName)))
        .getSingleOrNull();
    if (product == null) {
      await _db.into(_db.productMemory).insert(
            ProductMemoryCompanion.insert(
              canonicalName: name,
              normalizedName: normalizedName,
              defaultCategoryId: Value(categoryId),
            ),
          );
    } else {
      await (_db.update(_db.productMemory)
            ..where((t) => t.id.equals(product.id)))
          .write(ProductMemoryCompanion(
        defaultCategoryId: Value(categoryId),
      ));
    }
  }
}
