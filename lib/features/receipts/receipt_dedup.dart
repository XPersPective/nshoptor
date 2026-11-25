import '../../core/util/normalize_name.dart';
import '../../data/db/app_database.dart';

/// Describes an existing shopping list or converted receipt that appears to
/// represent the same store and purchase date/time as a scanned receipt.
final class ReceiptDuplicateMatch {
  const ReceiptDuplicateMatch({
    required this.listId,
    required this.listTitle,
    required this.matchedAt,
    this.matchedReceiptId,
    this.matchedStore,
  });

  final int listId;
  final String listTitle;
  final DateTime matchedAt;
  final int? matchedReceiptId;
  final String? matchedStore;
}

const _storeNoiseTokens = {
  'as',
  'a',
  's',
  'ltd',
  'sti',
  'tic',
  'ticaret',
  'sanayi',
  'san',
  'magaza',
  'magazasi',
  'magazacilik',
  'magazalari',
  'birlesik',
  'market',
  'marketler',
  'marketleri',
  'supermarket',
  'hipermarket',
  'sube',
  'subesi',
  'gida',
  'perakende',
  'inc',
  'llc',
  'corp',
  'co',
  'gmbh',
  'oy',
  'ab',
};

/// Normalizes a merchant name or store title for duplicate comparison by
/// Turkish-folding and stripping legal/retail filler suffixes.
String normalizeStoreForDedup(String raw) {
  final folded = normalizeName(raw);
  if (folded.isEmpty) return '';
  final tokens = folded
      .split(' ')
      .where((token) => token.isNotEmpty && !_storeNoiseTokens.contains(token))
      .toList();
  if (tokens.isEmpty) return folded;
  return tokens.join(' ');
}

/// Returns whether two raw store/list names refer to the same merchant.
bool storesMatchForDedup(String a, String b) {
  final normA = normalizeStoreForDedup(a);
  final normB = normalizeStoreForDedup(b);
  if (normA.isEmpty || normB.isEmpty) return false;
  if (normA == normB) return true;
  final tokensA = normA.split(' ');
  final tokensB = normB.split(' ');
  final shorter = tokensA.length <= tokensB.length ? tokensA : tokensB;
  final longer = tokensA.length <= tokensB.length ? tokensB : tokensA;
  // Require every significant token of the shorter merchant label to appear at
  // the start or as the full brand key of the longer label (e.g. "a101" vs
  // "a101 yeni"), while avoiding substring false positives.
  if (shorter.length == 1 && shorter.first.length >= 2) {
    return longer.first == shorter.first;
  }
  for (var i = 0; i < shorter.length; i++) {
    if (longer[i] != shorter[i]) return false;
  }
  return true;
}

/// Returns true when [dt] carries a non-midnight clock component (or when
/// explicit time wasn't parsed out as midnight).
bool hasExplicitReceiptTime(DateTime dt) =>
    dt.hour != 0 || dt.minute != 0 || dt.second != 0;

/// Checks whether two timestamps match for duplicate detection: within ±15
/// minutes when both carry explicit clock times, or on the same calendar day
/// when either side lacks an explicit time.
bool timestampsMatchForDedup(
  DateTime a,
  DateTime b, {
  bool? aHasTime,
  bool? bHasTime,
}) {
  final timeA = aHasTime ?? hasExplicitReceiptTime(a);
  final timeB = bHasTime ?? hasExplicitReceiptTime(b);
  if (timeA && timeB) {
    return a.difference(b).abs() <= const Duration(minutes: 15);
  }
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Searches existing lists and converted receipts (without mutating the DB)
/// for a probable duplicate of the same shopping trip.
Future<ReceiptDuplicateMatch?> findDuplicateReceipt({
  required AppDatabase db,
  String? storeName,
  DateTime? purchaseAt,
  bool? hasExplicitTime,
  String? identityKey,
  int? excludeReceiptId,
}) async {
  final normalizedIdentity = identityKey?.trim();
  final store = storeName?.trim();
  if ((normalizedIdentity == null || normalizedIdentity.isEmpty) &&
      (store == null || store.isEmpty || purchaseAt == null)) {
    return null;
  }

  final lists = await db.select(db.shoppingLists).get();
  final listById = <int, ShoppingList>{for (final l in lists) l.id: l};
  final stores = await db.select(db.stores).get();
  final storeById = <int, String>{for (final s in stores) s.id: s.name};

  final receipts = await (db.select(db.receipts)
        ..where((t) => t.listId.isNotNull()))
      .get();

  // 1. Check converted/linked receipts first for highest timestamp & identity precision.
  for (final r in receipts) {
    if (excludeReceiptId != null && r.id == excludeReceiptId) continue;
    final listId = r.listId;
    if (listId == null) continue;
    final list = listById[listId];
    if (list == null) continue;

    if (normalizedIdentity != null &&
        normalizedIdentity.isNotEmpty &&
        r.identityKey == normalizedIdentity) {
      final resolvedStore =
          r.confirmedStore ?? r.detectedStore ?? storeById[list.storeId];
      return ReceiptDuplicateMatch(
        listId: list.id,
        listTitle: _displayListTitle(list, resolvedStore),
        matchedAt: r.confirmedAt ?? r.detectedAt ?? r.createdAt,
        matchedReceiptId: r.id,
        matchedStore: resolvedStore,
      );
    }

    if (store == null || store.isEmpty || purchaseAt == null) continue;
    final candidateAt = r.confirmedAt ?? r.detectedAt;
    if (candidateAt == null) continue;
    final candidateStore = r.confirmedStore ??
        r.detectedStore ??
        (list.storeId != null ? storeById[list.storeId] : null) ??
        list.title ??
        '';
    if (candidateStore.trim().isEmpty) continue;
    if (storesMatchForDedup(store, candidateStore) &&
        timestampsMatchForDedup(
          purchaseAt,
          candidateAt,
          aHasTime: hasExplicitTime,
        )) {
      return ReceiptDuplicateMatch(
        listId: list.id,
        listTitle: _displayListTitle(list, candidateStore),
        matchedAt: candidateAt,
        matchedReceiptId: r.id,
        matchedStore: candidateStore,
      );
    }
  }

  // 2. Fallback: check existing shopping lists created manually or from prior
  // sessions whose store/title and scheduled/completed time match this receipt.
  if (store == null || store.isEmpty || purchaseAt == null) return null;
  for (final list in lists) {
    final candidateAt = list.completedAt ?? list.plannedAt;
    if (candidateAt == null) continue;
    final candidateStore =
        (list.storeId != null ? storeById[list.storeId] : null) ??
            list.title ??
            '';
    if (candidateStore.trim().isEmpty) continue;
    if (storesMatchForDedup(store, candidateStore) &&
        timestampsMatchForDedup(
          purchaseAt,
          candidateAt,
          aHasTime: hasExplicitTime,
        )) {
      return ReceiptDuplicateMatch(
        listId: list.id,
        listTitle: _displayListTitle(list, candidateStore),
        matchedAt: candidateAt,
        matchedStore: candidateStore,
      );
    }
  }

  return null;
}

String _displayListTitle(ShoppingList list, String? fallbackStore) {
  final title = list.title?.trim();
  if (title != null && title.isNotEmpty) return title;
  final store = fallbackStore?.trim();
  if (store != null && store.isNotEmpty) return store;
  return '#${list.id}';
}
