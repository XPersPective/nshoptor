import 'dart:convert';

import 'package:drift/drift.dart';

import '../../data/db/app_database.dart';
import 'receipt_document.dart';

final class ReceiptDraft {
  const ReceiptDraft({
    required this.id,
    required this.listId,
    required this.document,
    required this.imagePaths,
  });

  final int id;
  final int? listId;
  final ReceiptDocument document;
  final List<String> imagePaths;
}

/// Draft evidence is durable, but creates no list, purchase or observation.
/// Identity is reserved only at final approval, inside the purchase transaction.
class ReceiptDraftRepository {
  ReceiptDraftRepository(this._db);
  final AppDatabase _db;

  Future<Set<String>> referencedImages() async => {
    for (final row
        in await _db.customSelect('SELECT image_paths FROM receipts').get())
      ...(jsonDecode(row.read<String>('image_paths')) as List).cast<String>(),
  };

  Future<int> save({
    required ReceiptDocument document,
    int? listId,
    int? draftId,
    List<String> imagePaths = const [],
  }) async {
    final evidence = document.encode();
    if (imagePaths.length > 25) {
      throw ArgumentError('Too many receipt images');
    }
    return _db.transaction(() async {
      if (listId != null) {
        final list = await (_db.select(
          _db.shoppingLists,
        )..where((t) => t.id.equals(listId))).getSingleOrNull();
        if (list == null ||
            list.status == 'completed' ||
            list.status == 'archived') {
          throw StateError('Receipt draft requires a compatible active list');
        }
      }
      final values = ReceiptsCompanion(
        listId: Value(listId),
        imagePaths: Value(List.unmodifiable(imagePaths)),
        rawOcrText: Value(
          document.fragments
              .map((f) => f.lines.map((l) => l.text).join('\n'))
              .join('\n\n'),
        ),
        detectedStore: Value(document.metadata.store),
        detectedAt: Value(document.metadata.dateTime),
        detectedCurrency: Value(document.metadata.currencyCode),
        detectedTotalMinorUnits: Value(document.metadata.totalMinor),
        documentNumber: Value(document.metadata.documentNumber),
        captureDataJson: Value(evidence),
        parserVersion: const Value('1'),
        processingStatus: const Value('pending'),
      );
      if (draftId == null) {
        return _db.into(_db.receipts).insert(values);
      }
      final existing = await (_db.select(
        _db.receipts,
      )..where((t) => t.id.equals(draftId))).getSingleOrNull();
      if (existing == null ||
          existing.processingStatus != 'pending' ||
          existing.listId != listId ||
          existing.identityKey != null) {
        throw StateError('Receipt draft is no longer editable');
      }
      await (_db.update(
        _db.receipts,
      )..where((t) => t.id.equals(draftId))).write(values);
      return draftId;
    });
  }

  Future<List<ReceiptDraft>> pending({int? listId}) async {
    final records =
        await (_db.select(_db.receipts)
              ..where(
                (t) =>
                    t.processingStatus.equals('pending') &
                    t.captureDataJson.isNotNull() &
                    (listId == null
                        ? t.listId.isNull()
                        : t.listId.equals(listId)),
              )
              ..orderBy([
                (t) => OrderingTerm.desc(t.createdAt),
                (t) => OrderingTerm.desc(t.id),
              ])
              ..limit(100))
            .get();
    return [
      for (final record in records)
        ReceiptDraft(
          id: record.id,
          listId: record.listId,
          document: ReceiptDocument.decode(record.captureDataJson!),
          imagePaths: List.unmodifiable(record.imagePaths),
        ),
    ];
  }

  Future<void> discard(int draftId) =>
      (_db.delete(_db.receipts)..where(
            (t) =>
                t.id.equals(draftId) &
                t.processingStatus.equals('pending') &
                t.identityKey.isNull(),
          ))
          .go();
}
