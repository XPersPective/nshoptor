import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:image/image.dart' as img;
import 'package:napp_core/napp_core.dart' show SettingsStore;
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_capture_flow.dart';
import 'package:nshoptor/features/receipts/receipt_draft_repository.dart';
import 'package:nshoptor/features/receipts/receipt_image_store.dart';

class _ThrowingOcr implements OcrTextSource {
  @override
  Future<OcrScanResult> scan(String _) async =>
      throw StateError('Capture-first must not block on device ML Kit');
}

void main() {
  late AppDatabase db;
  late Directory mediaDir;
  late ReceiptImageStore images;
  final queuedEvents = <int>[];

  setUpAll(() async {
    if (const String.fromEnvironment('CAPTURE_OUT').isEmpty) return;
    final fonts = FontLoader('Roboto');
    for (final name in ['segoeui.ttf', 'segoeuib.ttf']) {
      fonts.addFont(
        File('C:/Windows/Fonts/$name').readAsBytes().then(ByteData.sublistView),
      );
    }
    await fonts.load();
    final root = Platform.environment['FLUTTER_ROOT'] ?? 'C:/flutter';
    await (FontLoader('MaterialIcons')..addFont(
          File(
            '$root/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
          ).readAsBytes().then(ByteData.sublistView),
        ))
        .load();
  });

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    mediaDir = Directory.systemTemp.createTempSync('nshoptor-batch-media-');
    images = ReceiptImageStore(directoryOverride: mediaDir);
    queuedEvents.clear();
  });

  tearDown(() async {
    await db.close();
    if (mediaDir.existsSync()) mediaDir.deleteSync(recursive: true);
  });

  File writeLargeJpeg(Directory dir, String name, {int width = 1320, int height = 1320}) {
    final image = img.Image(width: width, height: height);
    for (var y = 0; y < height; y += 8) {
      for (var x = 0; x < width; x += 8) {
        final v = ((x * 7 + y * 13) % 256);
        image.setPixelRgb(x, y, v, (v * 3) % 256, 255 - v);
      }
    }
    final bytes = img.encodeJpg(image, quality: 92);
    final file = File('${dir.path}/$name');
    file.writeAsBytesSync(bytes);
    return file;
  }

  Widget harness({
    required Future<String?> Function() pickImage,
    AiClient? ai,
    String locale = 'tr',
    bool dark = false,
    double scale = 1.0,
    void Function(int?)? onResult,
    Future<Uint8List?> Function(String path)? compressImage,
  }) => MaterialApp(
    locale: Locale(locale),
    supportedLocales: AppLocalizations.supportedLocales,
    theme: dark ? AppTheme.dark() : AppTheme.light(),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
      child: child!,
    ),
    home: Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: FilledButton(
            key: const Key('start_batch_capture'),
            onPressed: () async {
              final result = await openReceiptCaptureFlow(
                context,
                db: db,
                currencyCode: 'TRY',
                ai: ai,
                pickImage: pickImage,
                ocrSource: _ThrowingOcr(),
                imageStore: images,
                onEnqueued: queuedEvents.add,
                compressImage: compressImage,
              );
              onResult?.call(result);
            },
            child: const Text('scan'),
          ),
        ),
      ),
    ),
  );

  testWidgets(
    'capture-first offers ONLY continue-same or done, compresses JPEGs, queues two independent sessions cleanly',
    (tester) async {
      final srcDir = Directory.systemTemp.createTempSync('nshoptor-src-');
      addTearDown(() {
        if (srcDir.existsSync()) srcDir.deleteSync(recursive: true);
      });
      final p1 = writeLargeJpeg(srcDir, 'p1.jpg');
      final p2 = writeLargeJpeg(srcDir, 'p2.jpg');
      final p3 = writeLargeJpeg(srcDir, 'p3.jpg');
      final paths = [p1.path, p2.path, p3.path];
      var aiCalled = false;
      final ai = AiClient(
        store: SettingsStore(),
        baseUrl: 'https://x',
        httpClient: MockClient((_) async {
          aiCalled = true;
          return http.Response(jsonEncode({}), 200);
        }),
      );
      int? returned = -1;
      await tester.pumpWidget(
        harness(
          pickImage: () async => paths.removeAt(0),
          ai: ai,
          onResult: (v) => returned = v,
        ),
      );

      Future<void> pumpForAsync([Finder? waitFor]) async {
        for (var i = 0; i < 120; i++) {
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 50)),
          );
          await tester.pump(const Duration(milliseconds: 50));
          if (waitFor != null && waitFor.evaluate().isNotEmpty) break;
        }
        await tester.pumpAndSettle();
      }

      final repo = ReceiptDraftRepository(db);
      final trayCounts = <int>[];
      final sub = repo.watchTrayCount().listen(trayCounts.add);
      addTearDown(sub.cancel);

      // Session 1: snap page 1 -> sheet has ONLY "Aynı fişe devam" and "Tamam".
      await tester.tap(find.byKey(const Key('start_batch_capture')));
      await pumpForAsync(find.byKey(const Key('receipt_batch_sheet')));

      expect(find.byKey(const Key('receipt_batch_sheet')), findsOneWidget);
      expect(find.byKey(const Key('receipt_capture_continue_same')), findsOneWidget);
      expect(find.byKey(const Key('receipt_capture_done')), findsOneWidget);
      expect(find.byKey(const Key('receipt_new_capture')), findsNothing);
      expect(find.byKey(const Key('receipt_reading_progress')), findsNothing);
      expect(aiCalled, isFalse);

      // Snap page 2 into SAME session.
      await tester.tap(find.byKey(const Key('receipt_capture_continue_same')));
      await pumpForAsync(find.textContaining('2'));
      expect(find.textContaining('2'), findsWidgets);

      // Tap "Tamam" -> closes capture immediately and saves session 1 as queued.
      await tester.tap(find.byKey(const Key('receipt_capture_done')));
      await pumpForAsync();

      expect(returned, isNull);
      expect(aiCalled, isFalse);
      final afterFirst = await tester.runAsync(
        () => db.select(db.receipts).get(),
      );
      expect(afterFirst, hasLength(1));
      expect(afterFirst!.single.queueState, 'queued');
      expect(afterFirst.single.imagePaths, hasLength(2));
      for (final storedPath in afterFirst.single.imagePaths) {
        final storedFile = File(storedPath);
        expect(storedFile.existsSync(), isTrue);
        expect(storedFile.lengthSync(), lessThanOrEqualTo(350 * 1024));
        final decoded = img.decodeJpg(storedFile.readAsBytesSync())!;
        expect(decoded.width <= 1280 && decoded.height <= 1280, isTrue);
      }
      expect(queuedEvents, [afterFirst.single.id]);
      await tester.pump();
      expect(trayCounts.last, 1);

      // Session 2 immediately creates a SECOND independent queued row without erasing session 1.
      await tester.tap(find.byKey(const Key('start_batch_capture')));
      await pumpForAsync(find.byKey(const Key('receipt_batch_sheet')));
      await tester.tap(find.byKey(const Key('receipt_capture_done')));
      await pumpForAsync();

      final afterSecond = await tester.runAsync(
        () => db.select(db.receipts).get(),
      );
      expect(afterSecond, hasLength(2));
      expect(afterSecond!.map((r) => r.queueState), ['queued', 'queued']);
      expect(afterSecond.map((r) => r.imagePaths.length), [2, 1]);
      await tester.pump();
      expect(trayCounts.last, 2);
      expect(queuedEvents, [afterFirst.single.id, afterSecond.last.id]);
    },
  );

  testWidgets('cancelling sheet cleans only unqueued files and keeps existing queue untouched', (tester) async {
    final repo = ReceiptDraftRepository(db);
    final existingId = await repo.enqueueCaptured(
      imagePaths: const ['already-queued.img'],
      currencyCode: 'TRY',
    );
    var picks = 0;
    await tester.pumpWidget(
      harness(pickImage: () async => 'temp-${picks++}.img'),
    );
    await tester.tap(find.byKey(const Key('start_batch_capture')));
    for (var i = 0; i < 20; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
      await tester.pump(const Duration(milliseconds: 50));
      if (find.byKey(const Key('receipt_batch_sheet')).evaluate().isNotEmpty) {
        break;
      }
    }
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('receipt_batch_sheet')), findsOneWidget);

    // Dismiss sheet by tapping outside scrim.
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    final rows = await db.select(db.receipts).get();
    expect(rows.map((r) => r.id), [existingId]);
    expect(queuedEvents, isEmpty);
  });

  for (final config in [
    (width: 320.0, locale: 'ar', dark: true, scale: 2.0),
    (width: 412.0, locale: 'tr', dark: false, scale: 1.0),
    (width: 412.0, locale: 'tr', dark: true, scale: 1.0),
  ]) {
    testWidgets(
      'batch session sheet layout fits ${config.width} ${config.locale} dark=${config.dark} scale=${config.scale}',
      (tester) async {
        final semantics = tester.ensureSemantics();
        try {
          tester.view.devicePixelRatio = 1;
          tester.view.physicalSize = Size(config.width, 800);
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          await tester.pumpWidget(
            MaterialApp(
              locale: Locale(config.locale),
              supportedLocales: AppLocalizations.supportedLocales,
              theme: config.dark ? AppTheme.dark() : AppTheme.light(),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(config.scale)),
                child: child!,
              ),
              home: const Scaffold(
                body: Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    child: ReceiptBatchSessionSheet(pageCount: 2, maxPages: 4),
                  ),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);

          for (final key in [
            'receipt_capture_continue_same',
            'receipt_capture_done',
          ]) {
            final finder = find.byKey(Key(key));
            expect(finder, findsOneWidget);
            expect(tester.getSize(finder).height, greaterThanOrEqualTo(48));
            expect(tester.getSemantics(finder).label, isNotEmpty);
          }

          final output = const String.fromEnvironment('CAPTURE_OUT');
          if (output.isNotEmpty) {
            final variant = '${config.width.toInt()}_${config.locale}_dark${config.dark}';
            await expectLater(
              find.byType(MaterialApp),
              matchesGoldenFile('$output/pb213_batch_sheet_$variant.png'),
            );
          }
        } finally {
          semantics.dispose();
        }
      },
    );
  }

  testWidgets('photo compression displays animated loading dialog and Done shows styled SnackBar', (tester) async {
    final photo = writeLargeJpeg(mediaDir, 'raw_receipt.jpg', width: 640, height: 640);
    final photoBytes = photo.readAsBytesSync();
    final compressionCompleter = Completer<Uint8List?>();
    await tester.pumpWidget(
      harness(
        locale: 'tr',
        pickImage: () async => photo.path,
        compressImage: (_) => compressionCompleter.future,
      ),
    );
    await tester.tap(find.byKey(const Key('start_batch_capture')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byKey(const Key('receipt_photo_preparing')), findsOneWidget);
    expect(find.text('Fiş fotoğrafı hazırlanıyor…'), findsOneWidget);
    expect(find.byIcon(Icons.document_scanner_outlined), findsOneWidget);

    final captureOut = const String.fromEnvironment('CAPTURE_OUT');
    if (captureOut.isNotEmpty) {
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('$captureOut/pb217_photo_preparing.png'),
      );
    }

    compressionCompleter.complete(Uint8List.fromList(photoBytes));
    for (var i = 0; i < 20; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
      await tester.pump(const Duration(milliseconds: 20));
      if (find.byKey(const Key('receipt_batch_sheet')).evaluate().isNotEmpty) {
        break;
      }
    }
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('receipt_photo_preparing')), findsNothing);
    expect(find.byKey(const Key('receipt_batch_sheet')), findsOneWidget);

    await tester.tap(find.byKey(const Key('receipt_capture_done')));
    for (var i = 0; i < 20; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
      await tester.pump(const Duration(milliseconds: 20));
      if (find.byKey(const Key('receipt_queued_snackbar')).evaluate().isNotEmpty) {
        break;
      }
    }

    expect(find.byKey(const Key('receipt_queued_snackbar')), findsOneWidget);
    expect(find.byIcon(Icons.hourglass_top_rounded), findsOneWidget);
    expect(
      find.text('Fiş sıraya alındı — arka planda hazırlanıyor.'),
      findsOneWidget,
    );
    if (captureOut.isNotEmpty) {
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('$captureOut/pb217_done_snackbar.png'),
      );
    }
  });

  testWidgets('fast synchronous photo compression removes only dialog route and keeps batch sheet open', (tester) async {
    final photo = writeLargeJpeg(mediaDir, 'fast_receipt.jpg', width: 640, height: 640);
    final photoBytes = photo.readAsBytesSync();
    await tester.pumpWidget(
      harness(
        locale: 'tr',
        pickImage: () async => photo.path,
        compressImage: (_) async => photoBytes,
      ),
    );
    await tester.tap(find.byKey(const Key('start_batch_capture')));
    for (var i = 0; i < 40; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
      await tester.pump(const Duration(milliseconds: 20));
      if (find.byKey(const Key('receipt_batch_sheet')).evaluate().isNotEmpty) {
        break;
      }
    }
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('receipt_photo_preparing')), findsNothing);
    expect(find.byKey(const Key('receipt_batch_sheet')), findsOneWidget);

    await tester.tap(find.byKey(const Key('receipt_capture_done')));
    for (var i = 0; i < 20; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
      await tester.pump(const Duration(milliseconds: 20));
      if (find.byKey(const Key('receipt_queued_snackbar')).evaluate().isNotEmpty) {
        break;
      }
    }
    expect(find.byKey(const Key('receipt_queued_snackbar')), findsOneWidget);
  });
}
