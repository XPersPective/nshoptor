import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:napp_core/napp_core.dart' show SettingsStore;
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/home/home_screen.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/lists_screen.dart';
import 'package:nshoptor/features/receipts/ai_receipt_reader.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/receipt_image_store.dart';
import 'package:nshoptor/features/receipts/receipt_queue_service.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_screen.dart';

Future<void> _loadUiReviewFonts() async {
  if (const String.fromEnvironment('CAPTURE_OUT').isEmpty) return;
  final fonts = FontLoader('Roboto');
  var loadedAny = false;
  for (final name in ['segoeui.ttf', 'segoeuib.ttf', 'tahoma.ttf', 'arial.ttf']) {
    final file = File('C:/Windows/Fonts/$name');
    if (file.existsSync()) {
      fonts.addFont(file.readAsBytes().then(ByteData.sublistView));
      loadedAny = true;
    }
  }
  if (loadedAny) await fonts.load();
  final root = Platform.environment['FLUTTER_ROOT'] ?? 'C:/flutter';
  final iconFont = File(
    '$root/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
  );
  if (iconFont.existsSync()) {
    await (FontLoader('MaterialIcons')
          ..addFont(iconFont.readAsBytes().then(ByteData.sublistView)))
        .load();
  }
}

Future<String> _createReceiptJpeg(
  ReceiptImageStore images, {
  int stripeSeed = 0,
}) async {
  final image = img.Image(width: 140, height: 180);
  img.fill(image, color: img.ColorRgb8(248, 246, 240));
  for (var y = 18; y < 160; y += 14) {
    final barWidth = 50 + ((y + stripeSeed * 17) % 60);
    for (var x = 16; x < 16 + barWidth && x < 126; x++) {
      for (var dy = 0; dy < 4; dy++) {
        image.setPixelRgb(x, y + dy, 40, 48, 44);
      }
    }
  }
  return images.keepBytes(Uint8List.fromList(img.encodeJpg(image, quality: 85)));
}

ReceiptDocument _doc({
  String store = 'MIGROS TICARET A.S.',
  String dateLine = 'TARIH: 13.11.2026 SAAT: 14:20',
  String docNo = '000214',
}) => ReceiptDocument.fromScan(
  OcrScanResult(
    lines: [
      OcrLine(text: store, boundingBoxTop: 10),
      OcrLine(text: dateLine, boundingBoxTop: 30),
      OcrLine(text: 'FIS NO: $docNo', boundingBoxTop: 50),
      const OcrLine(text: 'SUT 1L  32,90', boundingBoxTop: 80),
      const OcrLine(text: 'EKMEK  12,50', boundingBoxTop: 105),
      const OcrLine(text: 'TOPLAM 45,40 TL', boundingBoxTop: 135),
    ],
  ),
  currencyCode: 'TRY',
);

Widget _harness({
  required Widget child,
  Locale locale = const Locale('tr'),
  bool dark = false,
  double textScale = 1.0,
}) => MaterialApp(
  debugShowCheckedModeBanner: false,
  locale: locale,
  theme: dark
      ? AppTheme.dark(palette: AppPalette.forest)
      : AppTheme.light(palette: AppPalette.forest),
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  builder: (context, inner) => MediaQuery(
    data: MediaQuery.of(
      context,
    ).copyWith(textScaler: TextScaler.linear(textScale)),
    child: inner!,
  ),
  home: child,
);

void main() {
  late AppDatabase db;
  late Directory mediaDir;
  late ReceiptDraftRepository drafts;
  late ReceiptImageStore images;
  late ListRepository listRepository;

  setUpAll(_loadUiReviewFonts);

  setUp(() async {
    AppDefaults.attach(SettingsStore());
    db = AppDatabase(NativeDatabase.memory());
    mediaDir = await Directory.systemTemp.createTemp('pb214_ui_');
    drafts = ReceiptDraftRepository(db);
    images = ReceiptImageStore(directoryOverride: mediaDir);
    listRepository = ListRepository(db);
  });

  var dbClosed = false;

  Future<void> disposeTree(WidgetTester tester) async {
    ReceiptQueueService.activeInstance?.detachNativeWakeupHandler();
    ReceiptQueueService.activeInstance = null;
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 50));
    if (!dbClosed) {
      dbClosed = true;
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 5));
      await closing;
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
    dbClosed = false;
    try {
      if (await mediaDir.exists()) {
        await mediaDir.delete(recursive: true);
      }
    } catch (_) {
      // Windows flutter_tester image decoder threads can hold brief file locks.
    }
  });

  testWidgets(
    'Fişlerim (N) badge tracks pending receipts, retry works, delete always updates count',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(412, 860));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final paths = await tester.runAsync(() async {
        return <String>[
          await _createReceiptJpeg(images, stripeSeed: 1),
          await _createReceiptJpeg(images, stripeSeed: 2),
          await _createReceiptJpeg(images, stripeSeed: 3),
          await _createReceiptJpeg(images, stripeSeed: 4),
        ];
      });

      final existingListId = await listRepository.createList(
        title: 'Migros',
        currencyCode: 'TRY',
        plannedAt: DateTime(2026, 11, 13, 14, 25),
      );

      final readyId = await drafts.enqueueCaptured(
        imagePaths: [paths![0]],
        currencyCode: 'TRY',
      );
      await drafts.markReady(
        readyId,
        document: _doc(store: 'A101 MARKET', docNo: 'A-1'),
      );

      final dupId = await drafts.enqueueCaptured(
        imagePaths: [paths[1]],
        currencyCode: 'TRY',
      );
      await drafts.markReady(
        dupId,
        document: _doc(store: 'MIGROS TICARET A.S.', docNo: 'M-2'),
        duplicateOfListId: existingListId,
      );

      final processingId = await drafts.enqueueCaptured(
        imagePaths: [paths[2]],
        currencyCode: 'TRY',
      );
      await drafts.markProcessing(processingId);

      final failedId = await drafts.enqueueCaptured(
        imagePaths: [paths[3]],
        currencyCode: 'TRY',
      );
      await drafts.markFailed(failedId, 'unreadable');

      final removedPaths = <String>[];
      final service = ReceiptQueueService(
        db: db,
        imageStore: images,
        scheduleBackgroundHook: () async {},
        removeOwnedImage: (path) async {
          removedPaths.add(path);
          return true;
        },
        parseImages: (_, {required currencyCode, required localeCode}) async =>
            ReceiptParsedDocument(
              _doc(store: 'BIM BIRLESIK MAGAZALAR', docNo: 'B-9'),
              usedAi: true,
            ),
      );

      await tester.pumpWidget(
        _harness(
          child: ListsScreen(
            repository: listRepository,
            receiptQueueService: service,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 80));

      final receiptsTab = find.byKey(const Key('lists_tab_receipts'));
      expect(receiptsTab, findsOneWidget);
      expect(
        find.descendant(of: receiptsTab, matching: find.text('Fişlerim (4)')),
        findsOneWidget,
      );

      await tester.ensureVisible(receiptsTab);
      await tester.pumpAndSettle();
      await tester.tap(receiptsTab);
      await tester.pump(const Duration(milliseconds: 120));
      await tester.pump(const Duration(milliseconds: 250));

      final trayScrollable = find.descendant(
        of: find.byKey(const Key('receipt_tray_list')),
        matching: find.byType(Scrollable),
      );
      expect(find.byKey(const Key('receipt_tray_list')), findsOneWidget);

      // Capture 412px Turkish light visual golden of the Fişlerim (N) tray.
      final out = const String.fromEnvironment('CAPTURE_OUT');
      if (out.isNotEmpty) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
        await tester.pump();
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('$out/pb214_tray_tab_412_tr_darkfalse.png'),
        );
      }

      // Ready & duplicate have Convert; all cards have Delete; only Failed has Retry.
      await tester.scrollUntilVisible(
        find.byKey(Key('tray_convert_$dupId')),
        200,
        scrollable: trayScrollable,
      );
      expect(find.byKey(ValueKey('tray_receipt_$dupId')), findsOneWidget);
      expect(find.byKey(Key('tray_convert_$dupId')), findsOneWidget);

      await tester.scrollUntilVisible(
        find.byKey(Key('tray_delete_$readyId')),
        200,
        scrollable: trayScrollable,
      );
      expect(find.byKey(ValueKey('tray_receipt_$readyId')), findsOneWidget);
      expect(find.byKey(Key('tray_convert_$readyId')), findsOneWidget);
      expect(find.byKey(Key('tray_delete_$readyId')), findsOneWidget);

      await tester.scrollUntilVisible(
        find.byKey(Key('tray_retry_$failedId')),
        -200,
        scrollable: trayScrollable,
      );
      await tester.pump(const Duration(milliseconds: 60));
      expect(find.byKey(Key('tray_retry_$failedId')), findsOneWidget);
      expect(find.byKey(Key('tray_delete_$failedId')), findsOneWidget);

      // Retry the failed draft -> becomes ready and shows Convert button.
      await tester.tap(find.byKey(Key('tray_retry_$failedId')));
      for (var i = 0; i < 40; i++) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
        await tester.pump(const Duration(milliseconds: 50));
        if (find.byKey(Key('tray_convert_$failedId')).evaluate().isNotEmpty) {
          break;
        }
      }
      expect(find.byKey(Key('tray_convert_$failedId')), findsOneWidget);

      // Delete a draft -> badge decreases from (4) to (3) and image cleanup runs.
      await tester.scrollUntilVisible(
        find.byKey(Key('tray_delete_$failedId')),
        -200,
        scrollable: trayScrollable,
      );
      await tester.tap(find.byKey(Key('tray_delete_$failedId')));
      for (var i = 0; i < 40; i++) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
        await tester.pump(const Duration(milliseconds: 50));
        if (find.descendant(of: receiptsTab, matching: find.text('Fişlerim (3)')).evaluate().isNotEmpty) {
          break;
        }
      }
      expect(
        find.descendant(of: receiptsTab, matching: find.text('Fişlerim (3)')),
        findsOneWidget,
      );
      expect(await drafts.getById(failedId), isNull);
      expect(removedPaths, contains(paths[3]));

      // Delete remaining drafts -> badge returns to plain "Fişlerim" and empty view renders.
      tester.state<ScrollableState>(trayScrollable).position.jumpTo(0);
      await tester.pump();
      for (final remainingId in [processingId, dupId, readyId]) {
        final deleteBtn = find.byKey(Key('tray_delete_$remainingId'));
        if (deleteBtn.evaluate().isEmpty) {
          await tester.scrollUntilVisible(
            deleteBtn,
            200,
            scrollable: trayScrollable,
          );
        }
        await tester.ensureVisible(deleteBtn);
        await tester.tap(deleteBtn);
        for (var i = 0; i < 40; i++) {
          await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
          await tester.pump(const Duration(milliseconds: 50));
          if (find.byKey(ValueKey('tray_receipt_$remainingId')).evaluate().isEmpty) {
            break;
          }
        }
      }

      expect(
        find.descendant(of: receiptsTab, matching: find.text('Fişlerim')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('receipt_tray_empty')), findsOneWidget);
      expect(tester.takeException(), isNull);

      await disposeTree(tester);
    },
  );

  testWidgets(
    '320px Arabic dark theme at 2.0x text scale renders cleanly with >= 48dp hit targets & semantics',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 860));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final semantics = tester.ensureSemantics();
      try {
        final paths = await tester.runAsync(() async {
          return <String>[
            await _createReceiptJpeg(images, stripeSeed: 7),
            await _createReceiptJpeg(images, stripeSeed: 8),
          ];
        });

      final readyId = await drafts.enqueueCaptured(
        imagePaths: [paths![0]],
        currencyCode: 'SAR',
      );
      await drafts.markReady(
        readyId,
        document: _doc(store: 'TAMIMI MARKETS', docNo: 'SA-1'),
      );

      final failedId = await drafts.enqueueCaptured(
        imagePaths: [paths[1]],
        currencyCode: 'SAR',
      );
      await drafts.markFailed(failedId, 'unreadable');

      final service = ReceiptQueueService(
        db: db,
        imageStore: images,
        scheduleBackgroundHook: () async {},
      );

      await tester.pumpWidget(
        _harness(
          locale: const Locale('ar'),
          dark: true,
          textScale: 2.0,
          child: ListsScreen(
            repository: listRepository,
            receiptQueueService: service,
            requestedTab: 3,
            requestedTabNonce: 1,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 120));
      await tester.pump(const Duration(milliseconds: 250));

      expect(tester.takeException(), isNull);

      for (final key in [
        Key('tray_convert_$readyId'),
        Key('tray_delete_$readyId'),
        Key('tray_retry_$failedId'),
        Key('tray_receipt_thumb_$readyId'),
      ]) {
        final rect = tester.getRect(find.byKey(key));
        expect(rect.width, greaterThanOrEqualTo(48));
        expect(rect.height, greaterThanOrEqualTo(48));
      }

      final l10nAr = await AppLocalizations.delegate.load(const Locale('ar'));
      expect(
        find.bySemanticsLabel(RegExp(RegExp.escape(l10nAr.receiptOpenPhotoHint))),
        findsWidgets,
      );
      expect(
        find.bySemanticsLabel(RegExp(RegExp.escape(l10nAr.receiptStatusReady))),
        findsOneWidget,
      );

      final out = const String.fromEnvironment('CAPTURE_OUT');
      if (out.isNotEmpty) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
        await tester.pump();
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('$out/pb214_tray_tab_320_ar_darktrue.png'),
        );
      }

      await disposeTree(tester);
      } finally {
        semantics.dispose();
      }
    },
  );

  testWidgets(
    'Duplicate confirmation gates ReceiptReviewScreen, conversion opens ListDetailScreen with zoomable bottom photos',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(412, 860));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final photoPaths = await tester.runAsync(() async {
        return <String>[
          await _createReceiptJpeg(images, stripeSeed: 3),
          await _createReceiptJpeg(images, stripeSeed: 5),
          await _createReceiptJpeg(images, stripeSeed: 9),
        ];
      });

      // Seed existing converted Migros receipt at 14:25 so 14:20 triggers duplicate guard.
      final existingListId = await listRepository.createList(
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
              imagePaths: const Value(['old_migros.jpg']),
              processingStatus: const Value('reviewed'),
              queueState: const Value('converted'),
            ),
          );

      final doc = _doc(store: 'MIGROS TICARET A.S.', docNo: 'DUP-1');
      final draftId = await drafts.enqueueCaptured(
        imagePaths: [photoPaths![0], photoPaths[1]],
        currencyCode: 'TRY',
      );
      await drafts.markReady(draftId, document: doc, duplicateOfListId: existingListId);

      final dupToDeleteId = await drafts.enqueueCaptured(
        imagePaths: [photoPaths[2]],
        currencyCode: 'TRY',
      );
      await drafts.markReady(
        dupToDeleteId,
        document: _doc(store: 'MIGROS TICARET A.S.', docNo: 'DUP-2'),
        duplicateOfListId: existingListId,
      );

      final removedPaths = <String>[];
      final service = ReceiptQueueService(
        db: db,
        imageStore: images,
        scheduleBackgroundHook: () async {},
        removeOwnedImage: (path) async {
          removedPaths.add(path);
          return true;
        },
      );

      // Phase A (dark: true): duplicate confirmation warning dialog before ReviewScreen + delete path.
      await tester.pumpWidget(
        _harness(
          dark: true,
          child: ListsScreen(
            repository: listRepository,
            receiptQueueService: service,
            requestedTab: 3,
            requestedTabNonce: 1,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 120));
      await tester.pump(const Duration(milliseconds: 200));

      await tester.tap(find.byKey(Key('tray_convert_$dupToDeleteId')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('receipt_duplicate_warning_dialog')),
        findsOneWidget,
      );
      expect(find.byType(ReceiptReviewScreen), findsNothing);

      final out = const String.fromEnvironment('CAPTURE_OUT');
      if (out.isNotEmpty) {
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('$out/pb214_duplicate_dialog_412_tr_darktrue.png'),
        );
      }

      // Cancel keeps draft intact without opening ReviewScreen.
      await tester.tap(find.byKey(const Key('receipt_duplicate_cancel')));
      await tester.pumpAndSettle();
      expect(find.byType(ReceiptReviewScreen), findsNothing);
      expect((await drafts.getById(dupToDeleteId)), isNotNull);

      // Re-open and choose "Bu fişi sil" -> deletes duplicate draft from tray and disk.
      await tester.tap(find.byKey(Key('tray_convert_$dupToDeleteId')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('receipt_duplicate_delete')));
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 40)));
      await tester.pumpAndSettle();
      expect((await drafts.getById(dupToDeleteId)), isNull);
      expect(removedPaths, contains(photoPaths[2]));

      // Phase B (light: false): proceed with "Yine de ekle" -> commit review -> ListDetailScreen + bottom photos + viewer.
      await tester.pumpWidget(
        _harness(
          dark: false,
          child: ListsScreen(
            repository: listRepository,
            receiptQueueService: service,
            requestedTab: 3,
            requestedTabNonce: 2,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 120));
      await tester.pump(const Duration(milliseconds: 200));

      await tester.tap(find.byKey(Key('tray_convert_$draftId')));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const Key('receipt_duplicate_warning_dialog')),
        findsOneWidget,
      );
      await tester.tap(find.byKey(const Key('receipt_duplicate_proceed')));
      await tester.pumpAndSettle();

      expect(find.byType(ReceiptReviewScreen), findsOneWidget);
      final commitBtn = find.byKey(const Key('receipt_commit_button'));
      await tester.ensureVisible(commitBtn);
      await tester.tap(commitBtn);
      for (var i = 0; i < 40; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 25)),
        );
        await tester.pump(const Duration(milliseconds: 50));
        if (find.byType(ListDetailScreen).evaluate().isNotEmpty &&
            find
                .descendant(
                  of: find.byType(ListDetailScreen),
                  matching: find.byType(Scrollable),
                )
                .evaluate()
                .isNotEmpty) {
          break;
        }
      }
      await tester.pumpAndSettle();

      // ListDetailScreen opens with both compressed receipt photos at bottom of the list.
      expect(find.byType(ListDetailScreen), findsOneWidget);
      final convertedRow = (await drafts.getById(draftId))!;
      expect(convertedRow.queueState, 'converted');
      expect(convertedRow.convertedAt, isNotNull);
      expect(convertedRow.listId, isNotNull);

      final photosSection = find.byKey(const Key('list_receipt_photos_section'));
      await tester.scrollUntilVisible(
        photosSection,
        240,
        scrollable: find
            .descendant(
              of: find.byType(ListDetailScreen),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.pump(const Duration(milliseconds: 80));

      expect(photosSection, findsOneWidget);
      expect(
        find.byKey(Key('receipt_photo_thumb_${draftId}_0')),
        findsOneWidget,
      );
      expect(
        find.byKey(Key('receipt_photo_thumb_${draftId}_1')),
        findsOneWidget,
      );

      if (out.isNotEmpty) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
        await tester.pump();
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('$out/pb214_list_photo_bottom_412_tr_darkfalse.png'),
        );
      }

      // Tap photo thumbnail -> opens fullscreen pinch-zoom viewer and closes cleanly.
      await tester.tap(find.byKey(Key('receipt_photo_thumb_${draftId}_0')));
      await tester.pumpAndSettle();
      expect(
        find.byKey(Key('receipt_photo_viewer_$draftId')),
        findsOneWidget,
      );
      expect(find.byType(InteractiveViewer), findsOneWidget);
      await tester.tap(find.byKey(const Key('receipt_photo_viewer_close')));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('receipt_photo_viewer_$draftId')), findsNothing);
      expect(tester.takeException(), isNull);

      await disposeTree(tester);
    },
  );

  testWidgets(
    'Notification tap (receiptDraftTaps) routes HomeShell to Fişlerim and converts draft to ListDetailScreen',
    timeout: const Timeout(Duration(seconds: 20)),
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(412, 860));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final photoPath = await tester.runAsync(
        () => _createReceiptJpeg(images, stripeSeed: 12),
      );
      final draftId = await drafts.enqueueCaptured(
        imagePaths: [photoPath!],
        currencyCode: 'TRY',
      );
      await drafts.markReady(
        draftId,
        document: _doc(
          store: 'SOK MARKETLER TICARET',
          dateLine: 'TARIH: 13.11.2026 SAAT: 18:45',
          docNo: 'SOK-88',
        ),
      );

      final service = ReceiptQueueService(
        db: db,
        imageStore: images,
        scheduleBackgroundHook: () async {},
      );
      final taps = StreamController<int>.broadcast();
      addTearDown(taps.close);

      await tester.pumpWidget(
        _harness(
          child: HomeShell(
            db: db,
            listRepository: listRepository,
            receiptDraftTaps: taps.stream,
            initialReceiptDraftId: () async => null,
            receiptQueueService: service,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Deliver "receipt-draft:<id>" tap event while on Home tab.
      taps.add(draftId);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.byType(ReceiptReviewScreen), findsOneWidget);
      final commitBtn = find.byKey(const Key('receipt_commit_button'));
      await tester.ensureVisible(commitBtn);
      await tester.tap(commitBtn);
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 120)));
      await tester.pumpAndSettle();

      expect(find.byType(ListDetailScreen), findsOneWidget);
      final converted = (await drafts.getById(draftId))!;
      expect(converted.queueState, 'converted');
      final trays = await tester.runAsync(() => drafts.pendingQueueItems());
      expect(trays, isEmpty);
      expect(find.byKey(const Key('lists_tab_receipts')), findsNothing); // navigated into ListDetailScreen
      expect(tester.takeException(), isNull);

      await disposeTree(tester);
    },
  );
}
