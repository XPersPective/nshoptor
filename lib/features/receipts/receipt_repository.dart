import 'package:drift/drift.dart';

import '../../data/db/app_database.dart';
import 'receipt_image_store.dart';

/// Where a receipt of a list stands (F13): approved, still being captured,
/// or stopped with an error.
enum ListReceiptState { complete, incomplete, failed }

/// One receipt as the list detail shows it.
final class ListReceipt {
  const ListReceipt({
    required this.id,
    required this.state,
    this.store,
    this.printedAt,
    this.totalMinor,
    this.currencyCode,
  });

  final int id;
  final ListReceiptState state;

  /// Raw store text as read or confirmed; callers clean it for display.
  final String? store;
  final DateTime? printedAt;
  final int? totalMinor;
  final String? currencyCode;
}

/// Receipts attached to shopping lists: listing and deletion (F13-F15).
class ReceiptRepository {
  ReceiptRepository(this._db, {ReceiptImageStore? images})
    : _images = images ?? ReceiptImageStore();

  final AppDatabase _db;
  final ReceiptImageStore _images;

  static ListReceipt _view(Receipt r) => ListReceipt(
    id: r.id,
    state: switch (r.processingStatus) {
      'pending' => ListReceiptState.incomplete,
      'error' => ListReceiptState.failed,
      _ => ListReceiptState.complete,
    },
    store: r.confirmedStore ?? r.detectedStore,
    printedAt: r.confirmedAt ?? r.detectedAt,
    totalMinor: r.confirmedTotalMinorUnits ?? r.detectedTotalMinorUnits,
    currencyCode: r.confirmedCurrency ?? r.detectedCurrency,
  );

  SimpleSelectStatement<$ReceiptsTable, Receipt> _forList(int listId) =>
      _db.select(_db.receipts)
        ..where(
          (t) =>
              t.listId.equals(listId) &
              // A pending row without capture evidence cannot be continued.
              (t.processingStatus.equals('pending').not() |
                  t.captureDataJson.isNotNull()),
        )
        ..orderBy([
          (t) => OrderingTerm.asc(t.createdAt),
          (t) => OrderingTerm.asc(t.id),
        ]);

  Stream<List<ListReceipt>> watchForList(int listId) =>
      _forList(listId).watch().map((rows) => rows.map(_view).toList());

  Future<List<ListReceipt>> forList(int listId) async =>
      (await _forList(listId).get()).map(_view).toList();

  /// Deletes a receipt with everything it added to its list, in one
  /// transaction: its purchases and their price observations, list rows the
  /// receipt itself created (when nothing else was bought on them) and its
  /// candidate lines. The identity is freed with the row, so the same receipt
  /// can be imported again. Owned photos no other receipt references are
  /// removed after the transaction commits.
  Future<bool> delete(int receiptId) async {
    final orphanImages = await _db.transaction(() async {
      final receipt = await (_db.select(
        _db.receipts,
      )..where((t) => t.id.equals(receiptId))).getSingleOrNull();
      if (receipt == null) return null;
      final entries = await (_db.select(
        _db.purchaseEntries,
      )..where((t) => t.receiptId.equals(receiptId))).get();
      final entryIds = entries.map((e) => e.id).toList();
      // Rows the user planned (or linked during review) existed before the
      // receipt; only rows created for unplanned receipt lines are removed.
      final linked = {
        for (final line in await (_db.select(
          _db.receiptCandidateLines,
        )..where((t) => t.receiptId.equals(receiptId))).get())
          if (line.linkedPlannedItemId != null) line.linkedPlannedItemId!,
      };
      final touched = entries.map((e) => e.plannedItemId).whereType<int>();

      if (entryIds.isNotEmpty) {
        final observations = await (_db.select(
          _db.priceObservations,
        )..where((t) => t.purchaseEntryId.isIn(entryIds))).get();
        for (final observation in observations) {
          if (observation.productId != null) {
            await _db.customUpdate(
              'UPDATE product_memory SET use_count = MAX(0, use_count - 1) '
              'WHERE id = ?',
              variables: [Variable<int>(observation.productId!)],
              updates: {_db.productMemory},
            );
          }
        }
        await (_db.delete(
          _db.priceObservations,
        )..where((t) => t.purchaseEntryId.isIn(entryIds))).go();
        await (_db.delete(
          _db.purchaseEntries,
        )..where((t) => t.id.isIn(entryIds))).go();
      }

      for (final itemId in touched.toSet()) {
        final item = await (_db.select(
          _db.plannedItems,
        )..where((t) => t.id.equals(itemId))).getSingleOrNull();
        if (item == null) continue;
        final others = await (_db.select(
          _db.purchaseEntries,
        )..where((t) => t.plannedItemId.equals(itemId))).get();
        if (others.isNotEmpty) continue;
        final createdByReceipt =
            !linked.contains(itemId) &&
            item.listId == receipt.listId &&
            !item.createdAt.isBefore(receipt.createdAt);
        if (createdByReceipt) {
          await (_db.delete(
            _db.plannedItems,
          )..where((t) => t.id.equals(itemId))).go();
        } else if (item.status == 'inCart' ||
            item.status == 'alternativeBought') {
          await (_db.update(
            _db.plannedItems,
          )..where((t) => t.id.equals(itemId))).write(
            PlannedItemsCompanion(
              status: const Value('pending'),
              updatedAt: Value(DateTime.now()),
            ),
          );
        }
      }

      await (_db.delete(
        _db.receiptCandidateLines,
      )..where((t) => t.receiptId.equals(receiptId))).go();
      await (_db.delete(
        _db.receipts,
      )..where((t) => t.id.equals(receiptId))).go();

      final stillUsed = <String>{
        for (final other in await _db.select(_db.receipts).get())
          ...other.imagePaths,
      };
      return [
        for (final path in receipt.imagePaths)
          if (!stillUsed.contains(path)) path,
      ];
    });
    if (orphanImages == null) return false;
    for (final path in orphanImages) {
      try {
        await _images.removeOwned(path);
      } catch (_) {
        // A leftover file is harmless; the receipt itself is gone.
      }
    }
    return true;
  }
}
