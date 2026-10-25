import 'package:drift/drift.dart';

import '../../../data/db/app_database.dart';

/// Liste sıralama modları (spec §6.3).
enum ItemSortMode { category, alphabetical, custom, storeAisle }

/// View preference only: switching back to manual never rewrites item ranks.
class ItemSortPreferences {
  ItemSortPreferences(this.db);

  final AppDatabase db;

  String _key(int listId) => 'list.$listId.item_sort';

  Future<ItemSortMode> read(int listId) async {
    final saved = await (db.select(
      db.appSettings,
    )..where((row) => row.key.equals(_key(listId)))).getSingleOrNull();
    return saved?.value == ItemSortMode.alphabetical.name
        ? ItemSortMode.alphabetical
        : ItemSortMode.custom;
  }

  Future<void> write(int listId, ItemSortMode mode) async {
    await db
        .into(db.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            key: _key(listId),
            value: Value(
              mode == ItemSortMode.alphabetical
                  ? ItemSortMode.alphabetical.name
                  : ItemSortMode.custom.name,
            ),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }
}

String _foldName(String value, String localeCode) {
  final turkic = localeCode.startsWith('tr') || localeCode.startsWith('az');
  value = value.replaceAll('I\u0307', 'İ');
  value =
      (turkic
              ? value.replaceAll('I', 'ı').replaceAll('İ', 'i')
              : value.replaceAll('İ', 'i'))
          .toLowerCase()
          .trim();
  // Common decomposed Turkish/Azeri letters compare like their composed forms.
  for (final pair in const {
    'c\u0327': 'ç',
    'g\u0306': 'ğ',
    'o\u0308': 'ö',
    's\u0327': 'ş',
    'u\u0308': 'ü',
    'i\u0307': 'i',
  }.entries) {
    value = value.replaceAll(pair.key, pair.value);
  }
  return value;
}

int compareItemNames(String a, String b, String localeCode) {
  a = _foldName(a, localeCode);
  b = _foldName(b, localeCode);
  final alphabet = localeCode.startsWith('az')
      ? 'abcçdeəfgğhxıijkqlmnoöprsştuüvyz'
      : localeCode.startsWith('tr')
      ? 'abcçdefgğhıijklmnoöprsştuüvyz'
      : null;
  if (alphabet == null) return a.compareTo(b);
  final ar = a.runes.toList(), br = b.runes.toList();
  int rank(int rune) {
    final index = alphabet.indexOf(String.fromCharCode(rune));
    // Spaces/numbers/punctuation retain their normal ordering before letters.
    return index >= 0
        ? 0x100 + index
        : rune < 0x61
        ? rune
        : 0x200 + rune;
  }

  for (var i = 0; i < ar.length && i < br.length; i++) {
    final difference = rank(ar[i]).compareTo(rank(br[i]));
    if (difference != 0) return difference;
  }
  return ar.length.compareTo(br.length);
}

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
  String localeCode = 'en',
}) {
  final categoryRank = {for (final c in categories) c.id: c.sortOrder};
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
      final order = a.sortOrder.compareTo(b.sortOrder);
      return order != 0 ? order : a.id.compareTo(b.id);
    });
    return sorted;
  }

  switch (mode) {
    case ItemSortMode.category:
      return by2(categoryOf);
    case ItemSortMode.alphabetical:
      return List<PlannedItem>.of(items)..sort((a, b) {
        final name = compareItemNames(a.name, b.name, localeCode);
        if (name != 0) return name;
        final order = a.sortOrder.compareTo(b.sortOrder);
        return order != 0 ? order : a.id.compareTo(b.id);
      });
    case ItemSortMode.custom:
      return by2(customOf);
    case ItemSortMode.storeAisle:
      return by2(aisleOf);
  }
}
