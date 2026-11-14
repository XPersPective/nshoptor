import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/receipts/ai_receipt_reader.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/receipt_image_store.dart';
import 'package:nshoptor/features/receipts/receipt_queue_service.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';

ReceiptDocument _doc({
  String store = 'MIGROS TICARET A.S.',
  String dateLine = 'TARIH: 13.11.2026 SAAT: 14:20',
  String docNo = '000101',
}) => ReceiptDocument.fromScan(
  OcrScanResult(
    lines: [
      OcrLine(text: store, boundingBoxTop: 10),
      OcrLine(text: dateLine, boundingBoxTop: 30),
      OcrLine(text: 'FIS NO: $docNo', boundingBoxTop: 50),
      const OcrLine(text: 'SUT 1L  32,90', boundingBoxTop: 80),
      const OcrLine(text: 'TOPLAM 32,90 TL', boundingBoxTop: 110),
    ],
  ),
  currencyCode: 'TRY',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late Directory tempDir;
  late ReceiptDraftRepository drafts;
  late ReceiptImageStore images;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    tempDir = await Directory.systemTemp.createTemp('pb214_queue_');
    drafts = ReceiptDraftRepository(db);
    images = ReceiptImageStore(directoryOverride: tempDir);
  });

  tearDown(() async {
    ReceiptQueueService.activeInstance?.detachNativeWakeupHandler();
    ReceiptQueueService.activeInstance = null;
    await db.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('drains queued receipts sequentially, flags store+time duplicates, and notifies', () async {
    final notified = <({int id, bool isDuplicate})>[];
    final p1 = await images.keepBytes(Uint8List.fromList([1, 2, 3, 4]));
    final p2 = await images.keepBytes(Uint8List.fromList([5, 6, 7, 8]));

    // Seed an existing committed shopping list matching doc2 (Migros 14:25 vs 14:20).
    final lists = ListRepository(db);
    final existingListId = await lists.createList(
      title: 'Migros',
      currencyCode: 'TRY',
      plannedAt: DateTime(2026, 11, 13, 14, 25),
    );
    await db.into(db.receipts).insert(
          ReceiptsCompanion.insert(
            listId: Value(existingListId),
            detectedStore: const Value('MIGROS'),
            detectedAt: Value(DateTime(2026, 11, 13, 14, 25)),
            confirmedStore: const Value('MIGROS'),
            confirmedAt: Value(DateTime(2026, 11, 13, 14, 25)),
            detectedCurrency: const Value('TRY'),
            imagePaths: const Value(['old.img']),
            processingStatus: const Value('reviewed'),
            queueState: const Value('converted'),
          ),
        );

    final q1 = await drafts.enqueueCaptured(imagePaths: [p1], currencyCode: 'TRY');
    final q2 = await drafts.enqueueCaptured(imagePaths: [p2], currencyCode: 'TRY');

    final seenOrder = <String>[];
    final service = ReceiptQueueService(
      db: db,
      imageStore: images,
      parseImages: (paths, {required currencyCode, required localeCode}) async {
        seenOrder.add(paths.single);
        if (paths.single == p1) {
          return ReceiptParsedDocument(
            _doc(
              store: 'A101 YENI MAGAZACILIK',
              dateLine: 'TARIH: 12.11.2026 SAAT: 10:15',
              docNo: 'A101-1',
            ),
            usedAi: true,
          );
        }
        return ReceiptParsedDocument(
          _doc(
            store: 'MIGROS TICARET A.S.',
            dateLine: 'TARIH: 13.11.2026 SAAT: 14:20',
            docNo: 'MGR-2',
          ),
          usedAi: true,
        );
      },
      sendReadyNotification: ({
        required receiptId,
        storeName,
        totalMinorUnits,
        currencyCode,
        bool isDuplicate = false,
      }) async {
        notified.add((id: receiptId, isDuplicate: isDuplicate));
      },
    );

    await service.drain();

    expect(seenOrder, [p1, p2]);
    final r1 = (await drafts.getById(q1))!;
    final r2 = (await drafts.getById(q2))!;
    expect(r1.queueState, 'ready');
    expect(r1.duplicateOfListId, isNull);
    expect(r2.queueState, 'duplicate');
    expect(r2.duplicateOfListId, existingListId);
    expect(notified, [
      (id: q1, isDuplicate: false),
      (id: q2, isDuplicate: true),
    ]);
  });

  test('reconcileAndDrain recovers rows stranded in processing state', () async {
    final p1 = await images.keepBytes(Uint8List.fromList([11, 22, 33]));
    final q1 = await drafts.enqueueCaptured(imagePaths: [p1], currencyCode: 'TRY');
    await drafts.markProcessing(q1);
    expect((await drafts.getById(q1))!.queueState, 'processing');

    final service = ReceiptQueueService(
      db: db,
      imageStore: images,
      parseImages: (_, {required currencyCode, required localeCode}) async =>
          ReceiptParsedDocument(_doc(docNo: 'REC-1'), usedAi: true),
    );
    await service.reconcileAndDrain();

    final recovered = (await drafts.getById(q1))!;
    expect(recovered.queueState, 'ready');
    expect(recovered.processingStatus, 'parsed');
  });

  test('failed parse supports retry and deleteTrayReceipt cleans owned files', () async {
    final p1 = await images.keepBytes(Uint8List.fromList([9, 8, 7]));
    final file = File(p1);
    expect(await file.exists(), isTrue);

    final q1 = await drafts.enqueueCaptured(imagePaths: [p1], currencyCode: 'TRY');
    var shouldFail = true;

    final service = ReceiptQueueService(
      db: db,
      imageStore: images,
      scheduleBackgroundHook: () async {},
      parseImages: (_, {required currencyCode, required localeCode}) async =>
          shouldFail
              ? const ReceiptParseFailed()
              : ReceiptParsedDocument(_doc(docNo: 'RETRY-1'), usedAi: true),
    );

    await service.drain();
    expect((await drafts.getById(q1))!.queueState, 'failed');

    shouldFail = false;
    await service.retryReceipt(q1);
    // Allow unawaited drain to finish cleanly.
    await Future<void>.delayed(const Duration(milliseconds: 20));
    await service.drain();
    expect((await drafts.getById(q1))!.queueState, 'ready');

    await service.deleteTrayReceipt(q1);
    expect(await drafts.getById(q1), isNull);
    expect(await file.exists(), isFalse);
  });

  test('MethodChannel schedules OS work and handles native drainQueue wakeups', () async {
    final calls = <String>[];
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(ReceiptQueueService.channel, (call) async {
      calls.add(call.method);
      return null;
    });
    addTearDown(() => messenger.setMockMethodCallHandler(ReceiptQueueService.channel, null));

    final p1 = await images.keepBytes(Uint8List.fromList([1, 3, 5]));
    final q1 = await drafts.enqueueCaptured(imagePaths: [p1], currencyCode: 'TRY');

    final service = ReceiptQueueService(
      db: db,
      imageStore: images,
      parseImages: (_, {required currencyCode, required localeCode}) async =>
          ReceiptParsedDocument(_doc(docNo: 'WAKE-1'), usedAi: true),
    );
    ReceiptQueueService.activeInstance = service;
    service.attachNativeWakeupHandler();

    await service.scheduleBackgroundDrain();
    expect(calls, ['scheduleQueue']);

    // Simulate OS Worker waking up the attached foreground FlutterEngine.
    const codec = StandardMethodCodec();
    final response = await messenger.handlePlatformMessage(
      ReceiptQueueService.channel.name,
      codec.encodeMethodCall(const MethodCall('drainQueue')),
      (_) {},
    );
    expect(response, isNotNull);
    expect(codec.decodeEnvelope(response!), isTrue);
    expect((await drafts.getById(q1))!.queueState, 'ready');
    expect(calls, ['scheduleQueue', 'backgroundDrainFinished']);
  });

  test('ReceiptReviewController converts parsed queue draft to converted without self-collision', () async {
    final dupListId = await ListRepository(db).createList(
      title: 'Migros Eski',
      currencyCode: 'TRY',
    );
    final p1 = await images.keepBytes(Uint8List.fromList([4, 4, 4]));
    final q1 = await drafts.enqueueCaptured(imagePaths: [p1], currencyCode: 'TRY');
    final doc = _doc(docNo: 'CONV-01');
    await drafts.markReady(q1, document: doc, duplicateOfListId: dupListId);

    final reviewController = ReceiptReviewController(
      db: db,
      listId: null,
      title: 'Migros',
      currencyCode: 'TRY',
      document: doc,
      draftId: q1,
      parseResult: doc.toParseResult(),
      localeCode: 'tr',
    );
    addTearDown(reviewController.dispose);

    reviewController.acceptAll();
    await reviewController.commit();

    final converted = (await drafts.getById(q1))!;
    expect(converted.queueState, 'converted');
    expect(converted.convertedAt, isNotNull);
    expect(converted.duplicateOfListId, isNull);
    expect(converted.listId, isNotNull);
    expect(converted.processingStatus, 'reviewed');
    expect(await drafts.watchTrayCount().first, 0);
  });
}
