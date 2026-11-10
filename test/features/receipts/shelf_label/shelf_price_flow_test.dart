import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/shelf_label/price_candidates.dart';
import 'package:nshoptor/features/receipts/shelf_label/shelf_price_flow.dart';

OcrScanResult _scan(List<String> rows) =>
    OcrScanResult(lines: [for (final text in rows) OcrLine(text: text)]);

class _Frames implements OcrTextSource {
  _Frames(this.frames);
  final List<OcrScanResult> frames;
  @override
  Future<OcrScanResult> scan(String _) async => frames.removeAt(0);
}

void main() {
  // AiService.client is null in tests, so the flow runs on device OCR only.
  testWidgets('manual entry from the sheet returns the typed price', (
    tester,
  ) async {
    final frames = _Frames([_scan(['SÜT 1 LT', '24,95 TL'])]);
    var picks = 0;
    PriceCandidate? result;
    await tester.pumpWidget(_app((context) async {
      result = await readShelfCandidate(
        context,
        currencyCode: 'TRY',
        pickImage: () async => 'label-${picks++}.img',
        ocrSource: frames,
      );
    }));
    await tester.tap(find.byKey(const Key('open_flow')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('price_candidate_0')), findsOneWidget);
    await tester.tap(find.byKey(const Key('price_manual_entry')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('price_manual_entry_field')),
      '12,50',
    );
    await tester.tap(find.byKey(const Key('price_manual_entry_confirm')));
    await tester.pumpAndSettle();

    expect(result, isNotNull);
    expect(result!.value.toDbString(), '12.50');
    expect(result!.currencyCode, 'TRY');
    expect(result!.confidence, 'manual');
    expect(picks, 1);
  });

  testWidgets('retake loops back to capture and the second photo wins', (
    tester,
  ) async {
    final frames = _Frames([_scan(['24,95 TL']), _scan(['9,99 TL'])]);
    var picks = 0;
    PriceCandidate? result;
    await tester.pumpWidget(_app((context) async {
      result = await readShelfCandidate(
        context,
        currencyCode: 'TRY',
        pickImage: () async => 'label-${picks++}.img',
        ocrSource: frames,
      );
    }));
    await tester.tap(find.byKey(const Key('open_flow')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('price_retake')));
    await tester.pumpAndSettle();
    expect(picks, 2);
    await tester.tap(find.byKey(const Key('price_candidate_0')));
    await tester.pumpAndSettle();
    expect(result!.value.toDbString(), '9.99');
  });

  testWidgets('an empty reading opens the sheet with manual entry', (
    tester,
  ) async {
    // Text is present but no price: the sheet opens (manual entry reachable)
    // and an explicit retake recaptures (PB-208 review finding).
    final frames = _Frames([_scan(['YAPRAK ÇAYI 250 G']), _scan(['24,95 TL'])]);
    var picks = 0;
    PriceCandidate? result;
    await tester.pumpWidget(_app((context) async {
      result = await readShelfCandidate(
        context,
        currencyCode: 'TRY',
        pickImage: () async => 'label-${picks++}.img',
        ocrSource: frames,
      );
    }));
    await tester.tap(find.byKey(const Key('open_flow')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('no_price_candidates')), findsOneWidget);
    expect(find.byKey(const Key('price_manual_entry')), findsOneWidget);
    await tester.tap(find.byKey(const Key('price_retake')));
    await tester.pumpAndSettle();
    expect(picks, 2);
    await tester.tap(find.byKey(const Key('price_candidate_0')));
    await tester.pumpAndSettle();
    expect(result!.value.toDbString(), '24.95');
  });

  testWidgets('the last attempt keeps manual entry but not retake', (
    tester,
  ) async {
    final frames = _Frames([for (var i = 0; i < 3; i++) _scan(['YAPRAK ÇAYI 250 G'])]);
    var picks = 0;
    PriceCandidate? result;
    await tester.pumpWidget(_app((context) async {
      result = await readShelfCandidate(
        context,
        currencyCode: 'TRY',
        pickImage: () async => 'label-${picks++}.img',
        ocrSource: frames,
      );
    }));
    await tester.tap(find.byKey(const Key('open_flow')));
    await tester.pumpAndSettle();
    // Attempt 1: retake available.
    await tester.tap(find.byKey(const Key('price_retake')));
    await tester.pumpAndSettle();
    // Attempt 2: retake available.
    await tester.tap(find.byKey(const Key('price_retake')));
    await tester.pumpAndSettle();
    // Attempt 3: budget spent - manual entry stays, retake is gone.
    expect(find.byKey(const Key('price_manual_entry')), findsOneWidget);
    expect(find.byKey(const Key('price_retake')), findsNothing);
    expect(picks, 3);
    // Dismissing the sheet ends the flow quietly: the user decided.
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(result, isNull);
  });

  testWidgets('cancelling the capture returns null without recapture', (
    tester,
  ) async {
    final frames = _Frames([_scan(['24,95 TL'])]);
    var picks = 0;
    PriceCandidate? result;
    await tester.pumpWidget(_app((context) async {
      result = await readShelfCandidate(
        context,
        currencyCode: 'TRY',
        pickImage: () async => (picks++ == 0) ? 'label.img' : null,
        ocrSource: frames,
      );
    }));
    await tester.tap(find.byKey(const Key('open_flow')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('price_retake')));
    await tester.pumpAndSettle();
    expect(result, isNull);
    expect(picks, 2);
  });
}

Widget _app(Future<void> Function(BuildContext context) open) => MaterialApp(
  locale: const Locale('tr'),
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: Scaffold(
    body: Builder(
      builder: (context) => TextButton(
        key: const Key('open_flow'),
        onPressed: () => open(context),
        child: const Text('open'),
      ),
    ),
  ),
);
