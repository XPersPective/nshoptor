import '../../data/db/app_database.dart';
import '../shopping_mode/item_status.dart';

String foldItemSearch(String value, String localeCode) {
  final turkic = localeCode.startsWith('tr') || localeCode.startsWith('az');
  return (turkic
          ? value.replaceAll('I', 'ı').replaceAll('İ', 'i')
          : value.replaceAll('İ', 'i'))
      .toLowerCase()
      .trim()
      .replaceAll(RegExp(r'\s+'), ' ');
}

bool matchesItemSearch(String name, String query, String localeCode) =>
    foldItemSearch(
      name,
      localeCode,
    ).contains(foldItemSearch(query, localeCode));

/// View-only partition: clearing a market price restores the saved order.
/// Never infer purchase from the estimate or an out-of-date status column.
List<PlannedItem> purchasedItemsLast(
  List<PlannedItem> items,
  List<PurchaseEntry> entries,
) {
  final purchasedIds = entries
      .where(hasMarketPrice)
      .map((entry) => entry.plannedItemId)
      .toSet();
  return [
    ...items.where((item) => !purchasedIds.contains(item.id)),
    ...items.where((item) => purchasedIds.contains(item.id)),
  ];
}

/// Flutter onReorderItem supplies the destination after removal.
/// Crossing the pending/purchased boundary is not a valid manual reorder.
List<PlannedItem>? reorderItemGroup(
  List<PlannedItem> displayed,
  List<PurchaseEntry> entries,
  int oldIndex,
  int newIndex,
) {
  if (oldIndex < 0 ||
      oldIndex >= displayed.length ||
      newIndex < 0 ||
      newIndex >= displayed.length) {
    return null;
  }
  final ordered = [...displayed];
  ordered.insert(newIndex, ordered.removeAt(oldIndex));
  final partitioned = purchasedItemsLast(ordered, entries);
  for (var i = 0; i < ordered.length; i++) {
    if (ordered[i].id != partitioned[i].id) return null;
  }
  return ordered;
}
