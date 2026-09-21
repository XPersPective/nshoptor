import '../../../data/db/app_database.dart';

/// Liste sıralama modları (spec §6.3).
enum ItemSortMode { category, alphabetical, custom, storeAisle }

/// Planlanan ürün satırlarını seçili moda göre sıralar.
///
/// - [ItemSortMode.category]: kategori sortOrder → ürün sortOrder
/// - [ItemSortMode.alphabetical]: normalize ada göre
/// - [ItemSortMode.custom]: kullanıcının ürün sortOrder'u
/// - [ItemSortMode.storeAisle]: reyon sortOrder (reyonsuz ürünler en sona)
List<PlannedItem> sortItems(
  List<PlannedItem> items,
  ItemSortMode mode, {
  List<Category> categories = const [],
  List<Aisle> aisles = const [],
}) {
  final categoryRank = {
    for (final c in categories) c.id: c.sortOrder,
  };
  final aisleRank = {for (final a in aisles) a.id: a.sortOrder};

  int categoryOf(PlannedItem i) => categoryRank[i.categoryId] ?? 1 << 30;
  int aisleOf(PlannedItem i) => aisleRank[i.aisleId] ?? 1 << 30;
  int customOf(PlannedItem i) => i.sortOrder;

  /// İkincil anahtar ürün sortOrder'u ile iki anahtarlı karşılaştırma.
  List<PlannedItem> by2(int Function(PlannedItem) primary) {
    final sorted = List<PlannedItem>.of(items);
    sorted.sort((a, b) {
      final pa = primary(a);
      final pb = primary(b);
      if (pa != pb) return pa.compareTo(pb);
      return a.sortOrder.compareTo(b.sortOrder);
    });
    return sorted;
  }

  switch (mode) {
    case ItemSortMode.category:
      return by2(categoryOf);
    case ItemSortMode.alphabetical:
      return by2((i) => 0)
        ..sort((a, b) => a.normalizedName.compareTo(b.normalizedName));
    case ItemSortMode.custom:
      return by2(customOf);
    case ItemSortMode.storeAisle:
      return by2(aisleOf);
  }
}
