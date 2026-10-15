import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/voice_input/dictation_mic_button.dart';
import 'package:nshoptor/features/voice_input/voice_input_service.dart';

void main() {
  Future<TextEditingController> pump(
    WidgetTester tester,
    FakeSpeechService service,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: TextField(
            key: const Key('field'),
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: DictationMicButton(
                key: const Key('mic'),
                controller: controller,
                speechService: service,
              ),
            ),
          ),
        ),
      ),
    );
    return controller;
  }

  testWidgets('partial and final transcripts fill the field live', (
    tester,
  ) async {
    final service = FakeSpeechService();
    final controller = await pump(tester, service);
    await tester.tap(find.byKey(const Key('mic')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.stop_circle), findsOneWidget);

    service.emitPartial('elma');
    await tester.pump();
    expect(controller.text, 'elma');

    service.emitFinal('elma armut');
    await tester.pump();
    expect(controller.text, 'elma armut');
    expect(find.byIcon(Icons.mic_none), findsOneWidget);

    await tester.tap(find.byKey(const Key('mic')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('mic')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.mic_none), findsOneWidget);
  });

  testWidgets('unavailable recognizer shows its reason on the button', (
    tester,
  ) async {
    final service = FakeSpeechService(available: false);
    await pump(tester, service);
    await tester.tap(find.byKey(const Key('mic')));
    await tester.pump();
    await tester.pump();
    expect(find.text('Ses tanıma kullanılamıyor; elle girin.'), findsOneWidget);
    expect(find.byIcon(Icons.mic_off_outlined), findsOneWidget);
  });

  testWidgets('missing language model triggers download message', (
    tester,
  ) async {
    final service = FakeSpeechService()
      ..modelDownloadable = true
      ..locales = ['en_US'];
    await pump(tester, service);
    await tester.tap(find.byKey(const Key('mic')));
    await tester.pump();
    await tester.pump();
    expect(find.textContaining('ses modeli indiriliyor'), findsOneWidget);
  });
}
