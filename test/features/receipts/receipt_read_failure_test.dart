import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/receipts/ai_receipt_reader.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/receipt_image_store.dart';
import 'package:nshoptor/features/receipts/receipt_queue_service.dart';
import 'package:nshoptor/features/receipts/receipt_read_failure.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('receipt read failure taxonomy', () {
    test('maps every protocol status onto a canonical failure', () {
      expect(
        ReceiptReadFailure.fromAiStatus('top_missing'),
        ReceiptReadFailure.missingTop,
      );
      expect(
        ReceiptReadFailure.fromAiStatus('bottom_missing'),
        ReceiptReadFailure.missingBottom,
      );
      expect(
        ReceiptReadFailure.fromAiStatus('middle_gap'),
        ReceiptReadFailure.missingMiddle,
      );
      expect(
        ReceiptReadFailure.fromAiStatus('not_receipt'),
        ReceiptReadFailure.notReceipt,
      );
      expect(
        ReceiptReadFailure.fromAiStatus('unreadable'),
        ReceiptReadFailure.unreadable,
      );
    });

    test('never turns an unknown status or stored value into free text', () {
      expect(
        ReceiptReadFailure.fromAiStatus('please try again'),
        ReceiptReadFailure.unknown,
      );
      expect(ReceiptReadFailure.fromAiStatus(null), ReceiptReadFailure.unknown);
      expect(
        ReceiptReadFailure.fromCode('the model rambled'),
        ReceiptReadFailure.unknown,
      );
      expect(ReceiptReadFailure.fromCode(null), ReceiptReadFailure.unknown);
    });

    test('keeps the direction of the missing part', () {
      expect(
        ReceiptReadFailure.fromGap(AiReceiptGap.top),
        ReceiptReadFailure.missingTop,
      );
      expect(
        ReceiptReadFailure.fromGap(AiReceiptGap.bottom),
        ReceiptReadFailure.missingBottom,
      );
      expect(
        ReceiptReadFailure.fromGap(AiReceiptGap.middle),
        ReceiptReadFailure.missingMiddle,
      );

      expect(ReceiptReadFailure.missingTop.gap, AiReceiptGap.top);
      expect(ReceiptReadFailure.missingBottom.gap, AiReceiptGap.bottom);
      expect(ReceiptReadFailure.missingMiddle.gap, AiReceiptGap.middle);
      expect(ReceiptReadFailure.unreadable.gap, isNull);
    });

    test('an incomplete receipt is fixed by shooting more of it', () {
      expect(ReceiptReadFailure.missingTop.needsMorePhotos, isTrue);
      expect(ReceiptReadFailure.missingBottom.needsMorePhotos, isTrue);
      expect(ReceiptReadFailure.missingMiddle.needsMorePhotos, isTrue);
      expect(ReceiptReadFailure.unreadable.needsMorePhotos, isFalse);
      expect(ReceiptReadFailure.notReceipt.needsMorePhotos, isFalse);
    });

    test('every failure has a stable, unique storage code', () {
      final codes = ReceiptReadFailure.values.map((f) => f.code).toSet();
      expect(codes.length, ReceiptReadFailure.values.length);
      for (final failure in ReceiptReadFailure.values) {
        expect(codes, contains(failure.code));
        expect(ReceiptReadFailure.fromCode(failure.code), failure);
      }
    });

    test('the AI reader answers a status the protocol does not name with a code', () {
      final read = AiReceiptReader.interpret(
        {'schema': 2, 'status': 'the sky is falling', 'items': <dynamic>[]},
        currencyCode: 'TRY',
      );

      expect(read, isA<AiReceiptRetake>());
      final retake = read as AiReceiptRetake;
      expect(retake.reason, ReceiptReadFailure.unknown.code);
      expect(retake.failure, ReceiptReadFailure.unknown);
      expect(retake.reason, isNot(contains('sky')));
    });

    test('the AI reader keeps the missing part it reports', () {
      final read = AiReceiptReader.interpret(
        {'schema': 2, 'status': 'bottom_missing', 'items': <dynamic>[]},
        currencyCode: 'TRY',
      );

      expect(read, isA<AiReceiptNeedsMore>());
      final needsMore = read as AiReceiptNeedsMore;
      expect(needsMore.gap, AiReceiptGap.bottom);
      expect(ReceiptReadFailure.fromGap(needsMore.gap).code, 'missing_bottom');
    });
  });

  group('receipt queue failure reasons', () {
    late AppDatabase db;
    late Directory tempDir;
    late ReceiptDraftRepository drafts;
    late ReceiptImageStore images;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      tempDir = await Directory.systemTemp.createTemp('pb222_queue_');
      drafts = ReceiptDraftRepository(db);
      images = ReceiptImageStore(directoryOverride: tempDir);
    });

    tearDown(() async {
      await db.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    Future<ReceiptQueueService> serviceReturning(
      ReceiptParseOutcome outcome,
    ) async {
      return ReceiptQueueService(
        db: db,
        imageStore: images,
        scheduleBackgroundHook: () async {},
        parseImages: (_, {required currencyCode, required localeCode}) async =>
            outcome,
      );
    }

    test('stores the exact missing part instead of a generic "needs more"', () async {
      final path = await images.keepBytes(Uint8List.fromList([1, 2, 3]));
      final id = await drafts.enqueueCaptured(
        imagePaths: [path],
        currencyCode: 'TRY',
      );

      final service = await serviceReturning(
        const ReceiptParseNeedsMoreOrRetake(
          AiReceiptNeedsMore(AiReceiptGap.bottom),
        ),
      );
      await service.drain();

      final row = await drafts.getById(id);
      expect(row!.queueState, 'failed');
      expect(row.queueError, 'missing_bottom');
      expect(
        ReceiptReadFailure.fromCode(row.queueError),
        ReceiptReadFailure.missingBottom,
      );
    });

    test('stores a canonical code for a retake', () async {
      final path = await images.keepBytes(Uint8List.fromList([4, 5, 6]));
      final id = await drafts.enqueueCaptured(
        imagePaths: [path],
        currencyCode: 'TRY',
      );

      final service = await serviceReturning(
        const ReceiptParseNeedsMoreOrRetake(AiReceiptRetake('not_receipt')),
      );
      await service.drain();

      final row = await drafts.getById(id);
      expect(row!.queueError, 'not_receipt');
    });

    test('an unavailable service is a retry, not a broken photo', () async {
      final path = await images.keepBytes(Uint8List.fromList([7, 8, 9]));
      final id = await drafts.enqueueCaptured(
        imagePaths: [path],
        currencyCode: 'TRY',
      );

      final service = await serviceReturning(
        const ReceiptParseFailed(unavailableResult: AiOffline()),
      );
      await service.drain();

      final row = await drafts.getById(id);
      expect(row!.queueError, 'service_unavailable');
      expect(
        ReceiptReadFailure.fromCode(row.queueError).nextStep,
        ReceiptReadNextStep.retry,
      );
    });
  });

  group('completing an incomplete receipt', () {
    late AppDatabase db;
    late Directory tempDir;
    late ReceiptDraftRepository drafts;
    late ReceiptImageStore images;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      tempDir = await Directory.systemTemp.createTemp('pb222_drafts_');
      drafts = ReceiptDraftRepository(db);
      images = ReceiptImageStore(directoryOverride: tempDir);
    });

    tearDown(() async {
      await db.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('a new photo joins the same receipt and puts it back on the queue', () async {
      final first = await images.keepBytes(Uint8List.fromList([1]));
      final second = await images.keepBytes(Uint8List.fromList([2]));
      final id = await drafts.enqueueCaptured(
        imagePaths: [first],
        currencyCode: 'TRY',
      );
      await drafts.markFailed(id, 'missing_bottom');

      final added = await drafts.appendPhotoAndRequeue(id, second);

      expect(added, isTrue);
      final row = await drafts.getById(id);
      expect(row!.imagePaths, [first, second]);
      expect(row.queueState, 'queued');
      expect(row.processingStatus, 'pending');
      expect(row.queueError, isNull);
    });

    test('a receipt session never holds more than the maximum photos', () async {
      final paths = <String>[
        for (var i = 0; i < 4; i++)
          await images.keepBytes(Uint8List.fromList([i])),
      ];
      final extra = await images.keepBytes(Uint8List.fromList([9]));
      final id = await drafts.enqueueCaptured(
        imagePaths: paths,
        currencyCode: 'TRY',
      );

      final added = await drafts.appendPhotoAndRequeue(id, extra);

      expect(added, isFalse);
      final row = await drafts.getById(id);
      expect(row!.imagePaths.length, 4);
    });

    test('a retake replaces the unusable photos of the receipt', () async {
      final old = await images.keepBytes(Uint8List.fromList([1]));
      final fresh = await images.keepBytes(Uint8List.fromList([2]));
      final id = await drafts.enqueueCaptured(
        imagePaths: [old],
        currencyCode: 'TRY',
      );
      await drafts.markFailed(id, 'unreadable');

      final replaced = await drafts.replacePhotosAndRequeue(id, [fresh]);

      expect(replaced, isTrue);
      final row = await drafts.getById(id);
      expect(row!.imagePaths, [fresh]);
      expect(row.queueState, 'queued');
      expect(row.queueError, isNull);
    });

    test('the service removes the photos a retake dropped', () async {
      final old = await images.keepBytes(Uint8List.fromList([1]));
      final fresh = await images.keepBytes(Uint8List.fromList([2]));
      final id = await drafts.enqueueCaptured(
        imagePaths: [old],
        currencyCode: 'TRY',
      );
      await drafts.markFailed(id, 'unreadable');
      final removed = <String>[];

      final service = ReceiptQueueService(
        db: db,
        imageStore: images,
        scheduleBackgroundHook: () async {},
        removeOwnedImage: (path) async {
          removed.add(path);
          return true;
        },
        parseImages: (_, {required currencyCode, required localeCode}) async =>
            const ReceiptParseNeedsMoreOrRetake(
              AiReceiptRetake('unreadable'),
            ),
      );

      final ok = await service.replacePhotosAndRequeue(id, [fresh]);

      expect(ok, isTrue);
      expect(removed, contains(old));
      expect(removed, isNot(contains(fresh)));
    });

    test('the service refuses a photo when the receipt is already full', () async {
      final paths = <String>[
        for (var i = 0; i < 4; i++)
          await images.keepBytes(Uint8List.fromList([i])),
      ];
      final extra = await images.keepBytes(Uint8List.fromList([9]));
      final id = await drafts.enqueueCaptured(
        imagePaths: paths,
        currencyCode: 'TRY',
      );
      await drafts.markFailed(id, 'missing_bottom');

      final service = ReceiptQueueService(
        db: db,
        imageStore: images,
        scheduleBackgroundHook: () async {},
      );

      expect(await service.addPhotoAndRequeue(id, extra), isFalse);
      final row = await drafts.getById(id);
      expect(row!.imagePaths.length, 4);
    });

    test('the service reports the canonical failure of a receipt', () async {
      final path = await images.keepBytes(Uint8List.fromList([1]));
      final id = await drafts.enqueueCaptured(
        imagePaths: [path],
        currencyCode: 'TRY',
      );
      await drafts.markFailed(id, 'missing_middle');

      final service = ReceiptQueueService(
        db: db,
        imageStore: images,
        scheduleBackgroundHook: () async {},
      );

      expect(await service.failureOf(id), ReceiptReadFailure.missingMiddle);
      expect(await service.failureOf(id + 999), isNull);
    });

    test('removing one photo requeues the rest and cleans up its file', () async {
      final first = await images.keepBytes(Uint8List.fromList([1]));
      final second = await images.keepBytes(Uint8List.fromList([2]));
      final id = await drafts.enqueueCaptured(
        imagePaths: [first, second],
        currencyCode: 'TRY',
      );
      await drafts.markFailed(id, 'missing_bottom');
      final removed = <String>[];

      final service = ReceiptQueueService(
        db: db,
        imageStore: images,
        scheduleBackgroundHook: () async {},
        removeOwnedImage: (path) async {
          removed.add(path);
          return true;
        },
        parseImages: (_, {required currencyCode, required localeCode}) async =>
            const ReceiptParseNeedsMoreOrRetake(
              AiReceiptNeedsMore(AiReceiptGap.bottom),
            ),
      );

      final ok = await service.removePhotoAndRequeue(id, 0);
      await service.drain();

      expect(ok, isTrue);
      expect(removed, [first]);
      final row = await drafts.getById(id);
      expect(row, isNotNull);
      expect(row!.imagePaths, [second]);
    });

    test('removing the last photo deletes the draft receipt', () async {
      final only = await images.keepBytes(Uint8List.fromList([7]));
      final id = await drafts.enqueueCaptured(
        imagePaths: [only],
        currencyCode: 'TRY',
      );
      final removed = <String>[];

      final service = ReceiptQueueService(
        db: db,
        imageStore: images,
        scheduleBackgroundHook: () async {},
        removeOwnedImage: (path) async {
          removed.add(path);
          return true;
        },
      );

      final ok = await service.removePhotoAndRequeue(id, 0);

      expect(ok, isTrue);
      expect(removed, [only]);
      expect(await drafts.getById(id), isNull);
    });
  });
}
