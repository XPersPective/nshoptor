import '../../data/db/app_database.dart';
import '../shopping_mode/item_status.dart';
import 'taxonomy/item_sort.dart';

List<PlannedItem> sortedItemsForView(
  List<PlannedItem> items,
  List<PurchaseEntry> entries, {
  required ItemSortMode mode,
  required String localeCode,
}) =>
    purchasedItemsLast(sortItems(items, mode, localeCode: localeCode), entries);

/// A row keeps its real identity: unplanned purchases never receive a made-up
/// planned-item ID or participate in saving manual item ranks.
class ItemViewRow {
  const ItemViewRow.planned(this.item) : entry = null;
  const ItemViewRow.unplanned(this.entry) : item = null;

  final PlannedItem? item;
  final PurchaseEntry? entry;
  String get name => item?.name ?? entry!.name;
}

/// Pending rows come first; all purchased rows share the same A–Z order,
/// including purchases added directly at the store or from a receipt.
List<ItemViewRow> alphabeticalItemRows(
  List<PlannedItem> items,
  List<PurchaseEntry> entries, {
  required String localeCode,
}) {
  final purchased = entries
      .where(hasMarketPrice)
      .map((e) => e.plannedItemId)
      .toSet();
  bool bought(ItemViewRow row) => row.item == null
      ? hasMarketPrice(row.entry!)
      : purchased.contains(row.item!.id);
  final rows = [
    for (final item in items) ItemViewRow.planned(item),
    for (final entry in entries)
      if (entry.plannedItemId == null) ItemViewRow.unplanned(entry),
  ];
  rows.sort((a, b) {
    final group = (bought(a) ? 1 : 0).compareTo(bought(b) ? 1 : 0);
    if (group != 0) return group;
    final name = compareItemNames(a.name, b.name, localeCode);
    if (name != 0) return name;
    if (a.item != null && b.item != null) {
      final rank = a.item!.sortOrder.compareTo(b.item!.sortOrder);
      return rank != 0 ? rank : a.item!.id.compareTo(b.item!.id);
    }
    if (a.item != null) return -1;
    if (b.item != null) return 1;
    return a.entry!.id.compareTo(b.entry!.id);
  });
  return rows;
}

bool canReorderItemView(ItemSortMode mode, String query) =>
    mode == ItemSortMode.custom && query.trim().isEmpty;

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

/// Returns the 0-based index of the pending item row after which the single
/// sparse list banner should be rendered, or null when no pending items exist.
/// Never places a banner in an empty list or inside the purchased/checked group (N057).
int? selectListBannerSlot({
  required int pendingCount,
  required int totalCount,
  required int seed,
}) {
  if (totalCount <= 0 || pendingCount <= 0) return null;
  if (pendingCount == 1) return 0;
  if (pendingCount == 2) return 1;
  if (pendingCount == 3) return 2;
  return 2 + (seed.abs() % 2);
}
