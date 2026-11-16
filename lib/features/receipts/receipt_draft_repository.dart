import 'dart:convert';

import 'package:drift/drift.dart';

import '../../data/db/app_database.dart';
import 'receipt_document.dart';
import 'receipt_read_failure.dart';
import 'receipt_repository.dart';

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
        queueState: const Value('legacy'),
      );
      if (draftId == null) {
        return _db.into(_db.receipts).insert(values);
      }
      final existing = await (_db.select(
        _db.receipts,
      )..where((t) => t.id.equals(draftId))).getSingleOrNull();
      if (existing == null ||
          existing.processingStatus != 'pending' ||
          (existing.listId != null && existing.listId != listId) ||
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
                        ? (t.listId.isNull() & t.queueState.equals('legacy'))
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

  Future<bool> discard(int draftId) =>
      ReceiptRepository(_db).delete(draftId, pendingOnly: true);

  /// Queue states shown as actionable or in-progress receipts in "Fişlerim (N)".
  static const List<String> trayQueueStates = [
    'queued',
    'processing',
    'ready',
    'duplicate',
    'failed',
  ];

  /// Reactive count of unconverted receipts sitting in the "Fişlerim (N)" tray.
  Stream<int> watchTrayCount() => watchTrayReceipts().map((rows) => rows.length);

  /// Reactive list of unconverted queued/ready/duplicate/failed receipts
  /// ordered newest first for the "Fişlerim (N)" tab.
  Stream<List<Receipt>> watchTrayReceipts() => (_db.select(_db.receipts)
        ..where(
          (t) => t.listId.isNull() & t.queueState.isIn(trayQueueStates),
        )
        ..orderBy([
          (t) => OrderingTerm.desc(t.createdAt),
          (t) => OrderingTerm.desc(t.id),
        ]))
      .watch();

  /// Returns one receipt row by id, or null if deleted.
  Future<Receipt?> getById(int receiptId) =>
      (_db.select(_db.receipts)..where((t) => t.id.equals(receiptId)))
          .getSingleOrNull();

  /// Returns unconverted receipts waiting in the sequential background queue.
  Future<List<Receipt>> pendingQueueItems() => (_db.select(_db.receipts)
        ..where((t) => t.listId.isNull() & t.queueState.equals('queued'))
        ..orderBy([
          (t) => OrderingTerm.asc(t.createdAt),
          (t) => OrderingTerm.asc(t.id),
        ]))
      .get();

  /// Saves a freshly captured multi-page receipt session directly into the
  /// background queue without blocking on AI parsing.
  Future<int> enqueueCaptured({
    required List<String> imagePaths,
    String? currencyCode,
    ReceiptDocument? document,
  }) =>
      _db.transaction(() async {
        final evidence = document?.encode();
        final candidateIdentity = document?.identity;
        final identityTaken = candidateIdentity != null &&
            (await (_db.select(_db.receipts)
                      ..where((t) => t.identityKey.equals(candidateIdentity)))
                    .getSingleOrNull()) !=
                null;
        return _db.into(_db.receipts).insert(
              ReceiptsCompanion.insert(
                imagePaths: Value(List.unmodifiable(imagePaths)),
                detectedCurrency: Value(
                  document?.metadata.currencyCode ?? currencyCode,
                ),
                detectedStore: Value(document?.metadata.store),
                detectedAt: Value(document?.metadata.dateTime),
                detectedTotalMinorUnits: Value(document?.metadata.totalMinor),
                documentNumber: Value(document?.metadata.documentNumber),
                identityKey: Value(identityTaken ? null : candidateIdentity),
                captureDataJson: Value(evidence),
                parserVersion: const Value('2'),
                processingStatus: const Value('pending'),
                queueState: const Value('queued'),
              ),
            );
      });

  /// Marks a queued receipt as currently uploading/parsing.
  Future<void> markProcessing(int receiptId) =>
      (_db.update(_db.receipts)..where((t) => t.id.equals(receiptId))).write(
        const ReceiptsCompanion(
          queueState: Value('processing'),
          processingStatus: Value('parsing'),
          queueError: Value(null),
        ),
      );

  /// Persists parsed receipt data and candidate lines, transitioning the item
  /// into `ready` (or `duplicate` when [duplicateOfListId] matched).
  Future<void> markReady(
    int receiptId, {
    required ReceiptDocument document,
    int? duplicateOfListId,
    String? rawOcrText,
    List<ReceiptCandidateLinesCompanion> candidateLines = const [],
  }) =>
      _db.transaction(() async {
        final evidence = document.encode();
        final candidateIdentity = document.identity;
        var storeIdentity = candidateIdentity;
        if (storeIdentity != null) {
          final conflict = await (_db.select(_db.receipts)
                ..where(
                  (t) =>
                      t.identityKey.equals(storeIdentity!) &
                      t.id.equals(receiptId).not(),
                ))
              .getSingleOrNull();
          if (conflict != null) storeIdentity = null;
        }
        await (_db.update(_db.receipts)..where((t) => t.id.equals(receiptId)))
            .write(
              ReceiptsCompanion(
                detectedStore: Value(document.metadata.store),
                detectedAt: Value(document.metadata.dateTime),
                detectedCurrency: Value(document.metadata.currencyCode),
                detectedTotalMinorUnits: Value(document.metadata.totalMinor),
                documentNumber: Value(document.metadata.documentNumber),
                identityKey: Value(storeIdentity),
                captureDataJson: Value(evidence),
                rawOcrText: Value(rawOcrText),
                parserVersion: const Value('2'),
                processingStatus: const Value('parsed'),
                queueState: Value(
                  duplicateOfListId != null ? 'duplicate' : 'ready',
                ),
                duplicateOfListId: Value(duplicateOfListId),
                queueError: const Value(null),
              ),
            );
        await (_db.delete(_db.receiptCandidateLines)
              ..where((t) => t.receiptId.equals(receiptId)))
            .go();
        for (final line in candidateLines) {
          await _db.into(_db.receiptCandidateLines).insert(line);
        }
      });

  /// Marks a queued receipt as failed with a human-readable retry error.
  ///
  /// [error] is always a [ReceiptReadFailure] code: the tray turns it into a
  /// short label and one concrete next step, so no free text ever reaches
  /// the user.
  Future<void> markFailed(int receiptId, String error) =>
      (_db.update(_db.receipts)..where((t) => t.id.equals(receiptId))).write(
        ReceiptsCompanion(
          queueState: const Value('failed'),
          processingStatus: const Value('failed'),
          queueError: Value(error),
        ),
      );

  /// Marks a queued receipt as failed, storing the canonical reason code.
  Future<void> markFailedWith(int receiptId, ReceiptReadFailure failure) =>
      markFailed(receiptId, failure.code);

  /// Adds one more photo to a receipt and puts it back on the background
  /// queue.
  ///
  /// Used when the model says the receipt is incomplete (missing top,
  /// missing bottom, or a gap between pages): the new photo belongs to the
  /// same receipt, so the row keeps its identity and the next attempt reads
  /// the whole receipt again instead of starting a new one.
  ///
  /// Returns false when the receipt is gone or already holds the maximum
  /// number of photos, so the caller can tell the user instead of silently
  /// dropping the photo.
  Future<bool> appendPhotoAndRequeue(int receiptId, String imagePath) async {
    final row = await getById(receiptId);
    if (row == null) return false;
    final paths = List<String>.of(row.imagePaths);
    if (paths.length >= kMaxReceiptPhotos) return false;
    paths.add(imagePath);
    return _writePhotoPaths(receiptId, paths);
  }

  /// Replaces the photos of a receipt and puts it back on the background
  /// queue.
  ///
  /// Used when the receipt as a whole could not be read (blur, glare, wrong
  /// subject): the old photos are not usable evidence, so they are dropped.
  /// The caller removes their files.
  Future<bool> replacePhotosAndRequeue(
    int receiptId,
    List<String> imagePaths,
  ) async {
    if (imagePaths.isEmpty) return false;
    if (await getById(receiptId) == null) return false;
    return _writePhotoPaths(receiptId, imagePaths);
  }

  /// Removes one photo at [index] from a receipt session and resets the session
  /// back onto the queue if other photos remain. Returns the removed file path
  /// and whether that was the last photo (`emptied: true`), or `null` when
  /// [receiptId] / [index] is invalid.
  Future<({String removedPath, bool emptied})?> removePhotoAtAndRequeue(
    int receiptId,
    int index,
  ) async {
    final row = await getById(receiptId);
    if (row == null || index < 0 || index >= row.imagePaths.length) {
      return null;
    }
    final paths = List<String>.of(row.imagePaths);
    final removed = paths.removeAt(index);
    if (paths.isEmpty) {
      return (removedPath: removed, emptied: true);
    }
    await _writePhotoPaths(receiptId, paths);
    return (removedPath: removed, emptied: false);
  }

  Future<bool> _writePhotoPaths(int receiptId, List<String> paths) async {
    await (_db.update(_db.receipts)..where((t) => t.id.equals(receiptId))).write(
      ReceiptsCompanion(
        imagePaths: Value(List.unmodifiable(paths)),
        detectedStore: const Value(null),
        detectedAt: const Value(null),
        detectedTotalMinorUnits: const Value(null),
        documentNumber: const Value(null),
        identityKey: const Value(null),
        captureDataJson: const Value(null),
        rawOcrText: const Value(null),
        queueState: const Value('queued'),
        processingStatus: const Value('pending'),
        queueError: const Value(null),
        duplicateOfListId: const Value(null),
      ),
    );
    return true;
  }

  /// Moves a failed or interrupted receipt back onto the background queue.
  /// Resets standalone rows stranded in `processing` (for example after an OS
  /// termination mid-parse) back to `queued` so the next drain picks them up.
  Future<int> resetInterruptedProcessing() =>
      (_db.update(_db.receipts)..where(
            (t) => t.listId.isNull() & t.queueState.equals('processing'),
          ))
          .write(
            const ReceiptsCompanion(
              queueState: Value('queued'),
              processingStatus: Value('pending'),
            ),
          );

  Future<void> requeue(int receiptId) =>
      (_db.update(_db.receipts)..where((t) => t.id.equals(receiptId))).write(
        const ReceiptsCompanion(
          queueState: Value('queued'),
          processingStatus: Value('pending'),
          queueError: Value(null),
          duplicateOfListId: Value(null),
        ),
      );

  /// Links a tray receipt to its newly created/updated shopping list and sets
  /// `queueState` to `converted`, removing it from unread tray badge counts.
  Future<void> markConverted(int receiptId, {required int listId}) =>
      (_db.update(_db.receipts)..where((t) => t.id.equals(receiptId))).write(
        ReceiptsCompanion(
          listId: Value(listId),
          queueState: const Value('converted'),
          processingStatus: const Value('reviewed'),
          convertedAt: Value(DateTime.now()),
        ),
      );
}
