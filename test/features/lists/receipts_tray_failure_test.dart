import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/receipts_tray_tab.dart';
import 'package:nshoptor/features/receipts/ai_receipt_reader.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/receipt_image_store.dart';
import 'package:nshoptor/features/receipts/receipt_queue_service.dart';

Widget _harness({required Widget child}) => MaterialApp(
  debugShowCheckedModeBanner: false,
  locale: const Locale('tr'),
  theme: AppTheme.light(palette: AppPalette.forest),
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late Directory tempDir;
  late ReceiptDraftRepository drafts;
  late ReceiptImageStore images;

  var dbClosed = false;

  setUp(() async {
    dbClosed = false;
    db = AppDatabase(NativeDatabase.memory());
    tempDir = await Directory.systemTemp.createTemp('pb222_tray_');
    drafts = ReceiptDraftRepository(db);
    images = ReceiptImageStore(directoryOverride: tempDir);
  });

  Future<void> disposeTree(WidgetTester tester) async {
    ReceiptQueueService.activeInstance?.detachNativeWakeupHandler();
    ReceiptQueueService.activeInstance = null;
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 50));
    if (!dbClosed) {
      dbClosed = true;
      await tester.runAsync(() => db.close());
    }
  }

  tearDown(() async {
    ReceiptQueueService.activeInstance?.detachNativeWakeupHandler();
    ReceiptQueueService.activeInstance = null;
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    if (!dbClosed) {
      dbClosed = true;
      try {
        await db.close();
      } catch (_) {}
    }
    try {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    } catch (_) {}
  });

  /// A real JPEG on disk, so compression has something to read.
  String writeReceiptJpeg(String name) {
    final picture = img.Image(width: 120, height: 160);
    img.fill(picture, color: img.ColorRgb8(246, 244, 238));
    for (var y = 12; y < 140; y += 12) {
      for (var x = 14; x < 100; x++) {
        picture.setPixelRgb(x, y, 40, 48, 44);
      }
    }
    final file = File('${tempDir.path}/$name.jpg');
    file.writeAsBytesSync(img.encodeJpg(picture, quality: 85));
    return file.path;
  }

  /// Lets the real event loop run so the off-isolate photo compression and
  /// the database writes behind it can finish, then settles the frame.
  ///
  /// The frame never settles on its own while that work is pending: the
  /// progress spinner animates until the photo is ready.
  Future<void> pumpAsync(WidgetTester tester, {int rounds = 40}) async {
    for (var i = 0; i < rounds; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 25)),
      );
      await tester.pump(const Duration(milliseconds: 25));
    }
  }

  testWidgets('a failed receipt says why it failed and can be completed', (
    tester,
  ) async {
    late String first;
    late int id;
    late List<Receipt> initialReceipts;
    await tester.runAsync(() async {
      first = await images.keepBytes(Uint8List.fromList([1, 2, 3]));
      id = await drafts.enqueueCaptured(
        imagePaths: [first],
        currencyCode: 'TRY',
      );
      await drafts.markFailed(id, 'missing_bottom');
      initialReceipts = await drafts.watchTrayReceipts().first;
    });

    final service = ReceiptQueueService(
      db: db,
      imageStore: images,
      scheduleBackgroundHook: () async {},
      parseImages: (_, {required currencyCode, required localeCode}) async =>
          const ReceiptParseNeedsMoreOrRetake(
            AiReceiptNeedsMore(AiReceiptGap.bottom),
          ),
    );

    final newPhoto = writeReceiptJpeg('extra');

    await tester.pumpWidget(
      _harness(
        child: ReceiptsTrayTab(
          repository: ListRepository(db),
          receipts: initialReceipts,
          loading: false,
          queueService: service,
          pickImage: () async => newPhoto,
          imageStore: images,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The card names the reason instead of a bare "Okunamadı".
    expect(find.text('Alt kısım eksik'), findsOneWidget);
    expect(find.text('Okunamadı'), findsNothing);

    // Tapping it opens the reason sheet with the guidance.
    await tester.tap(find.text('Alt kısım eksik'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('receipt_failure_sheet')), findsOneWidget);
    expect(find.byKey(const Key('receipt_failure_label')), findsOneWidget);
    expect(find.byKey(const Key('receipt_failure_guidance')), findsOneWidget);
    expect(find.text('Devamını çek'), findsOneWidget);

    // The one action shoots the missing part of the same receipt.
    await tester.tap(find.byKey(const Key('receipt_failure_action')));
    await pumpAsync(tester);

    final row = await tester.runAsync(() => drafts.getById(id));
    expect(row!.imagePaths.length, 2);
    expect(row.imagePaths.last, endsWith('.img'));
    expect(File(row.imagePaths.last).existsSync(), isTrue);
    // The direction of the missing part survives the retry.
    expect(row.queueError, 'missing_bottom');
    await disposeTree(tester);
  });

  testWidgets('an unreadable receipt offers a retake, not another photo', (
    tester,
  ) async {
    late List<Receipt> initialReceipts;
    await tester.runAsync(() async {
      final first = writeReceiptJpeg('unreadable_1');
      final id = await drafts.enqueueCaptured(
        imagePaths: [first],
        currencyCode: 'TRY',
      );
      await drafts.markFailed(id, 'unreadable');
      initialReceipts = await drafts.watchTrayReceipts().first;
    });

    final service = ReceiptQueueService(
      db: db,
      imageStore: images,
      scheduleBackgroundHook: () async {},
      parseImages: (_, {required currencyCode, required localeCode}) async =>
          const ReceiptParseNeedsMoreOrRetake(AiReceiptRetake('unreadable')),
    );

    await tester.pumpWidget(
      _harness(
        child: ReceiptsTrayTab(
          repository: ListRepository(db),
          receipts: initialReceipts,
          loading: false,
          queueService: service,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Okunaklı değil'), findsOneWidget);

    await tester.tap(find.text('Okunaklı değil'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('receipt_failure_sheet')), findsOneWidget);
    expect(find.text('Yeniden çek'), findsOneWidget);
    expect(find.text('Devamını çek'), findsNothing);
    await disposeTree(tester);
  });

  testWidgets('the failure sheet keeps the receipt and can delete it', (
    tester,
  ) async {
    late String first;
    late int id;
    late List<Receipt> initialReceipts;
    await tester.runAsync(() async {
      first = writeReceiptJpeg('delete_1');
      id = await drafts.enqueueCaptured(
        imagePaths: [first],
        currencyCode: 'TRY',
      );
      await drafts.markFailed(id, 'unreadable');
      initialReceipts = await drafts.watchTrayReceipts().first;
    });

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

    await tester.pumpWidget(
      _harness(
        child: ReceiptsTrayTab(
          repository: ListRepository(db),
          receipts: initialReceipts,
          loading: false,
          queueService: service,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Okunaklı değil'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('receipt_failure_delete')));
    await pumpAsync(tester);

    expect(await tester.runAsync(() => drafts.getById(id)), isNull);
    expect(removed, contains(first));
    await disposeTree(tester);
  });

  testWidgets('multi-photo session frame displays all pages, adds continuation, and removes single photo', (
    tester,
  ) async {
    late String p1;
    late String p2;
    late int id;
    late List<Receipt> initialReceipts;
    await tester.runAsync(() async {
      p1 = writeReceiptJpeg('p1');
      p2 = writeReceiptJpeg('p2');
      id = await drafts.enqueueCaptured(
        imagePaths: [p1, p2],
        currencyCode: 'TRY',
      );
      await drafts.markFailed(id, 'missing_bottom');
      initialReceipts = await drafts.watchTrayReceipts().first;
    });

    final removed = <String>[];
    final extra = writeReceiptJpeg('p3');
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

    await tester.pumpWidget(
      _harness(
        child: ReceiptsTrayTab(
          repository: ListRepository(db),
          receipts: initialReceipts,
          loading: false,
          queueService: service,
          pickImage: () async => extra,
          imageStore: images,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(Key('tray_receipt_frame_$id')), findsOneWidget);
    expect(find.byKey(Key('tray_receipt_thumb_$id')), findsOneWidget);
    expect(find.byKey(Key('tray_receipt_thumb_${id}_1')), findsOneWidget);
    expect(find.byKey(Key('tray_add_page_$id')), findsOneWidget);

    await tester.tap(find.byKey(Key('tray_add_page_$id')));
    await pumpAsync(tester);

    final afterAdd = await tester.runAsync(() => drafts.getById(id));
    expect(afterAdd!.imagePaths.length, 3);

    // Open second photo in fullscreen viewer and delete that individual photo.
    await tester.tap(find.byKey(Key('tray_receipt_thumb_${id}_1')));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('receipt_photo_viewer_$id')), findsOneWidget);
    await tester.tap(find.byKey(const Key('receipt_photo_viewer_delete')));
    await pumpAsync(tester);

    expect(removed, contains(p2));
    await disposeTree(tester);
  });
}
