import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/features/receipts/image_capture_service.dart';
import 'package:nshoptor/features/receipts/image_capture_sheet.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';

class _Source implements OcrTextSource {
  _Source(this.result);
  final Future<OcrScanResult> Function() result;
  @override
  Future<OcrScanResult> scan(String path) => result();
}

Widget _app(
  Widget child, {
  String locale = 'tr',
  bool dark = false,
  double scale = 1,
}) => MaterialApp(
  locale: Locale(locale),
  theme: dark ? AppTheme.dark() : AppTheme.light(),
  supportedLocales: AppLocalizations.supportedLocales,
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
  home: Scaffold(body: child),
);

void main() {
  setUpAll(() async {
    // Real glyphs are necessary for exported visual proof, including Arabic.
    if (const String.fromEnvironment('CAPTURE_OUT').isEmpty) return;
    final fonts = FontLoader('Roboto');
    for (final name in ['segoeui.ttf', 'segoeuib.ttf']) {
      final file = File('C:/Windows/Fonts/$name');
      fonts.addFont(file.readAsBytes().then(ByteData.sublistView));
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
  testWidgets('cancellation does not require a native OCR plugin', (
    tester,
  ) async {
    CaptureOutcome? result;
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => TextButton(
            onPressed: () async => result = await captureImageText(
              context,
              title: 'Scan',
              pickImage: () async => null,
            ),
            child: const Text('cancel'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('cancel'));
    await tester.pumpAndSettle();
    expect(result, isA<CaptureCancelled>());
    expect(tester.takeException(), isNull);
  });
  for (final config in [
    (width: 320.0, locale: 'ar', dark: true, scale: 2.0),
    (width: 412.0, locale: 'tr', dark: false, scale: 1.0),
    (width: 412.0, locale: 'tr', dark: true, scale: 1.0),
    (width: 1280.0, locale: 'en', dark: false, scale: 1.0),
  ]) {
    testWidgets(
      'camera and gallery at ${config.width} ${config.locale} ${config.dark}',
      (tester) async {
        final semantics = tester.ensureSemantics();
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = Size(config.width, 900);
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        ImageSource? selected;
        await tester.pumpWidget(
          _app(
            Builder(
              builder: (context) => TextButton(
                onPressed: () async => selected = await showImageSourceSheet(
                  context,
                  title: AppLocalizations.of(context).scanReceiptAction,
                ),
                child: const Text('open'),
              ),
            ),
            locale: config.locale,
            dark: config.dark,
            scale: config.scale,
          ),
        );
        await tester.tap(find.text('open'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final camera = find.byKey(const Key('image_source_camera'));
        final gallery = find.byKey(const Key('image_source_gallery'));
        expect(tester.getSize(camera).height, greaterThanOrEqualTo(48));
        expect(tester.getSize(gallery).height, greaterThanOrEqualTo(48));
        expect(tester.getSemantics(camera).label, isNotEmpty);
        expect(tester.getSemantics(gallery).label, isNotEmpty);
        const out = String.fromEnvironment('CAPTURE_OUT');
        if (out.isNotEmpty) {
          await expectLater(
            find.byType(MaterialApp),
            matchesGoldenFile(
              '$out/source-${config.locale}-${config.width.toInt()}-${config.dark}.png',
            ),
          );
        }
        await tester.tap(gallery);
        await tester.pumpAndSettle();
        expect(selected, ImageSource.gallery);
        await tester.tap(find.text('open'));
        await tester.pumpAndSettle();
        await tester.tap(camera);
        await tester.pumpAndSettle();
        expect(selected, ImageSource.camera);
        semantics.dispose();
      },
    );
  }

  testWidgets(
    'capture, recognition and empty text explain different failures',
    (tester) async {
      for (final stage in CaptureStage.values) {
        CaptureOutcome? outcome;
        await tester.pumpWidget(
          _app(
            Builder(
              builder: (context) => TextButton(
                onPressed: () async => outcome = await captureImageText(
                  context,
                  title: AppLocalizations.of(context).scanReceiptAction,
                  pickImage: () async {
                    if (stage == CaptureStage.capture) {
                      throw StateError('sensitive');
                    }
                    return 'fixture.png';
                  },
                  ocrSource: _Source(() async {
                    if (stage == CaptureStage.recognition) {
                      throw StateError('private');
                    }
                    return const OcrScanResult(lines: []);
                  }),
                ),
                child: const Text('scan'),
              ),
            ),
          ),
        );
        await tester.tap(find.text('scan'));
        await tester.pumpAndSettle();
        expect((outcome as CaptureFailed).stage, stage);
        final message = switch (stage) {
          CaptureStage.capture => 'Kamera veya fotoğraflar açılamadı.',
          CaptureStage.recognition => 'Fotoğraf işlenemedi.',
          CaptureStage.emptyText => 'Metin okunamadı;',
        };
        expect(find.textContaining(message), findsOneWidget);
        expect(find.textContaining('sensitive'), findsNothing);
        expect(find.textContaining('private'), findsNothing);
        await tester.pumpWidget(const SizedBox.shrink());
      }
    },
  );
}
