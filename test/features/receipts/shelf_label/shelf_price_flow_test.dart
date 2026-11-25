import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart' show SettingsStore;

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/shelf_label/price_candidates.dart';
import 'package:nshoptor/features/receipts/shelf_label/shelf_price_flow.dart';

class _CountingOcr implements OcrTextSource {
  _CountingOcr(this.result);
  final OcrScanResult result;
  int calls = 0;

  @override
  Future<OcrScanResult> scan(String _) async {
    calls++;
    return result;
  }
}

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

  testWidgets('Server Vision AI is primary for shelf labels and skips ML Kit', (
    tester,
  ) async {
    final countingOcr = _CountingOcr(_scan(['99,00 TL']));
    final ai = AiClient(
      store: SettingsStore(),
      baseUrl: 'https://x',
      httpClient: MockClient((request) async {
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['task'], 'read_label_image');
        return http.Response(
          jsonEncode({
            'tier': 'pro',
            'used': 1,
            'limit': 100,
            'result': {
              'schema': 1,
              'status': 'ok',
              'productName': 'Çay 500 g',
              'price': '49.90',
              'currency': 'TRY',
            },
          }),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );
      }),
    );

    PriceCandidate? picked;
    await tester.pumpWidget(_app((context) async {
      picked = await readShelfCandidate(
        context,
        currencyCode: 'TRY',
        ai: ai,
        pickImage: () async => 'label-ai.img',
        ocrSource: countingOcr,
        encodeAiImage: (p) async => '/9j/$p',
      );
    }));
    await tester.tap(find.byKey(const Key('open_flow')));
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 50));
      await tester.runAsync(() async {});
    }
    await tester.pumpAndSettle();

    expect(countingOcr.calls, 0);
    await tester.tap(find.byKey(const Key('price_candidate_0')));
    await tester.pumpAndSettle();
    expect(picked?.value.toDbString(), '49.90');
    expect(picked?.productName, 'Çay 500 g');
  });

  testWidgets('unavailable AI falls back cleanly to local OCR once', (
    tester,
  ) async {
    final countingOcr = _CountingOcr(_scan(['KAHVE 18,50 TL']));
    final ai = AiClient(
      store: SettingsStore(),
      baseUrl: 'https://x',
      httpClient: MockClient(
        (_) async => http.Response('{"error":"offline"}', 503),
      ),
    );

    PriceCandidate? picked;
    await tester.pumpWidget(_app((context) async {
      picked = await readShelfCandidate(
        context,
        currencyCode: 'TRY',
        ai: ai,
        pickImage: () async => 'label-off.img',
        ocrSource: countingOcr,
        encodeAiImage: (p) async => '/9j/$p',
      );
    }));
    await tester.tap(find.byKey(const Key('open_flow')));
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 50));
      await tester.runAsync(() async {});
    }
    await tester.pumpAndSettle();

    expect(countingOcr.calls, 1);
    await tester.tap(find.byKey(const Key('price_candidate_0')));
    await tester.pumpAndSettle();
    expect(picked?.value.toDbString(), '18.50');
  });

  testWidgets('non-blocking shelf label capture lets user move to next item before AI finishes', (
    tester,
  ) async {
    final pendingAi = Completer<http.Response>();
    final ai = AiClient(
      store: SettingsStore(),
      baseUrl: 'https://x',
      httpClient: MockClient((_) => pendingAi.future),
    );
    final resolved = <List<PriceCandidate>>[];
    var picks = 0;

    await tester.pumpWidget(_app((context) async {
      await readShelfCandidate(
        context,
        currencyCode: 'TRY',
        ai: ai,
        pickImage: () async => 'label-${picks++}.img',
        ocrSource: _CountingOcr(_scan(const [])),
        encodeAiImage: (p) async => '/9j/$p',
        onBackgroundResolved: resolved.add,
      );
    }));

    await tester.tap(find.byKey(const Key('open_flow')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byKey(const Key('shelf_label_reading_progress')), findsOneWidget);
    await tester.tap(find.byKey(const Key('shelf_label_continue_other')));
    await tester.pumpAndSettle();

    // Caller unblocked immediately and can open next capture right away.
    expect(find.byKey(const Key('open_flow')), findsOneWidget);
    expect(resolved, isEmpty);

    pendingAi.complete(
      http.Response(
        jsonEncode({
          'tier': 'pro',
          'used': 1,
          'limit': 100,
          'result': {
            'schema': 1,
            'status': 'ok',
            'productName': 'Peynir',
            'price': '79.50',
            'currency': 'TRY',
          },
        }),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
    await tester.runAsync(() async {});
    await tester.pumpAndSettle();
    expect(resolved, hasLength(1));
    expect(resolved.single.single.value.toDbString(), '79.50');
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
