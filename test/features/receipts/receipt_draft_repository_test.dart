import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';

ReceiptDocument _sampleDocument({String docNo = 'FIS-0042'}) {
  return ReceiptDocument.fromScan(
    OcrScanResult(
      lines: [
        const OcrLine(text: 'MIGROS TICARET A.S.', boundingBoxTop: 10),
        const OcrLine(text: 'TARIH: 13.11.2026 SAAT: 14:20', boundingBoxTop: 30),
        OcrLine(text: 'FIS NO: $docNo', boundingBoxTop: 50),
        const OcrLine(text: 'SUT 1L  32,90', boundingBoxTop: 80),
        const OcrLine(text: 'TOPLAM 32,90 TL', boundingBoxTop: 110),
      ],
    ),
    currencyCode: 'TRY',
  );
}

void main() {
  late AppDatabase db;
  late ReceiptDraftRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ReceiptDraftRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('tray queue lifecycle transitions queued -> ready -> converted and tracks count', () async {
    expect(await repo.watchTrayCount().first, 0);

    final firstId = await repo.enqueueCaptured(
      imagePaths: const ['/tmp/receipt_1_p1.jpg', '/tmp/receipt_1_p2.jpg'],
      currencyCode: 'TRY',
    );
    expect(await repo.watchTrayCount().first, 1);
    final pending = await repo.pendingQueueItems();
    expect(pending.map((r) => r.id), [firstId]);
    expect(pending.single.queueState, 'queued');

    await repo.markProcessing(firstId);
    expect((await repo.getById(firstId))?.queueState, 'processing');
    expect(await repo.pendingQueueItems(), isEmpty);

    final doc = _sampleDocument();
    await repo.markReady(
      firstId,
      document: doc,
      rawOcrText: 'MIGROS\nSUT 1L 32,90',
      candidateLines: [
        ReceiptCandidateLinesCompanion.insert(
          receiptId: firstId,
          rawText: 'SUT 1L 32,90',
          parsedName: const Value('Süt 1L'),
          parsedLineTotalMinorUnits: const Value(3290),
        ),
      ],
    );

    final readyRow = await repo.getById(firstId);
    expect(readyRow?.queueState, 'ready');
    expect(readyRow?.detectedStore, isNotNull);
    expect(readyRow?.identityKey, isNotNull);
    expect(await repo.watchTrayCount().first, 1);

    final listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(
            title: const Value('Migros'),
            currencyCode: 'TRY',
          ),
        );
    await repo.markConverted(firstId, listId: listId);

    final converted = await repo.getById(firstId);
    expect(converted?.queueState, 'converted');
    expect(converted?.listId, listId);
    expect(converted?.convertedAt, isNotNull);
    expect(await repo.watchTrayCount().first, 0);
  });

  test('duplicate receipts persist duplicate state without identityKey UNIQUE failure and requeue clears flags', () async {
    final existingListId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(
            title: const Value('Migros'),
            currencyCode: 'TRY',
          ),
        );
    final originalId = await repo.enqueueCaptured(
      imagePaths: const ['/tmp/orig.jpg'],
      currencyCode: 'TRY',
    );
    final dupCandidateId = await repo.enqueueCaptured(
      imagePaths: const ['/tmp/dup.jpg'],
      currencyCode: 'TRY',
    );

    final sharedDoc = _sampleDocument(docNo: 'SAME-101');
    await repo.markReady(originalId, document: sharedDoc);
    await repo.markConverted(originalId, listId: existingListId);

    // Same identityKey + duplicateOfListId should save cleanly with null identityKey.
    await repo.markReady(
      dupCandidateId,
      document: sharedDoc,
      duplicateOfListId: existingListId,
      candidateLines: [
        ReceiptCandidateLinesCompanion.insert(
          receiptId: dupCandidateId,
          rawText: 'OLD LINE',
        ),
      ],
    );

    final dupRow = await repo.getById(dupCandidateId);
    expect(dupRow?.queueState, 'duplicate');
    expect(dupRow?.duplicateOfListId, existingListId);
    expect(dupRow?.identityKey, isNull);
    expect(await repo.watchTrayCount().first, 1);

    await repo.markFailed(dupCandidateId, 'Timeout');
    expect((await repo.getById(dupCandidateId))?.queueState, 'failed');
    expect((await repo.getById(dupCandidateId))?.queueError, 'Timeout');

    await repo.requeue(dupCandidateId);
    final requeued = await repo.getById(dupCandidateId);
    expect(requeued?.queueState, 'queued');
    expect(requeued?.queueError, isNull);
    expect(requeued?.duplicateOfListId, isNull);

    // Replacing candidate lines on re-ready clears previous candidate rows cleanly.
    await repo.markReady(dupCandidateId, document: _sampleDocument(docNo: 'NEW-202'));
    final lines = await (db.select(db.receiptCandidateLines)
          ..where((t) => t.receiptId.equals(dupCandidateId)))
        .get();
    expect(lines, isEmpty);
  });
}
