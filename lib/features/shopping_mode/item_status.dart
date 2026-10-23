import '../../data/db/app_database.dart';

/// A missing price differs from an explicitly entered zero. Receipt totals
/// may have no unit price; older receipt rows also have no gross value.
bool hasMarketPrice(PurchaseEntry entry) =>
    entry.actualUnitPrice != null ||
    entry.grossTotalMinorUnits != null ||
    entry.actualLineTotalMinorUnits != 0 ||
    entry.source == 'receiptOcr';

bool isItemPurchased(int itemId, Iterable<PurchaseEntry> entries) => entries
    .any((entry) => entry.plannedItemId == itemId && hasMarketPrice(entry));

/// Alışveriş modunda ürün durumları (spec §6.5).
///
/// `PlannedItems.status` sütununa db adlarıyla saklanır. `PlannedItems`
/// tablosunun draft durum kodu `pending`'tir; alışveriş modu bu enum'u
/// kullanır.
enum ItemStatus {
  pending,
  inCart,
  notFound,
  gaveUp,
  alternativeBought;

  static ItemStatus fromDb(String value) {
    for (final s in ItemStatus.values) {
      if (s.name == value) return s;
    }
    throw ArgumentError('bilinmeyen ürün durumu: $value');
  }

  static ItemStatus? tryFromDb(String value) {
    for (final s in ItemStatus.values) {
      if (s.name == value) return s;
    }
    return null;
  }

  /// Ürün sepette sayılır mı (gerçek toplama dahil mi)?
  bool get isInCart => this == inCart || this == alternativeBought;

  /// Ürün kapanmış mı (artık "alınacak" değil)?
  bool get isClosed => this != pending;
}

/// Alışveriş modu filtreleri (spec §6.5).
enum CartFilter { all, toBuy, inCart, notFound, required }
