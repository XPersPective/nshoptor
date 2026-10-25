import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/text/list_title.dart';
import 'package:nshoptor/features/voice_input/dictation_mic_button.dart';
import 'package:nshoptor/features/voice_input/voice_input_service.dart';

void main() {
  Future<TextEditingController> pump(
    WidgetTester tester,
    FakeSpeechService service, {
    String Function(String)? initialTransform,
  }) async {
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
                initialTranscriptTransform: initialTransform,
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
    expect(find.byIcon(Icons.stop_circle), findsOneWidget);

    await tester.tap(find.byKey(const Key('mic')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.mic_none), findsOneWidget);
  });

  testWidgets(
    'dictation appends typed text; keyboard edits win over late speech',
    (tester) async {
      final service = FakeSpeechService();
      final controller = await pump(tester, service);
      controller.text = 'Mevcut';
      await tester.tap(find.byKey(const Key('mic')));
      await tester.pumpAndSettle();
      service.emitFinal('elma');
      await tester.pump();
      expect(controller.text, 'Mevcut elma');
      await tester.enterText(find.byKey(const Key('field')), 'Elle düzeltildi');
      service.emitPartial('armut');
      await tester.pump();
      expect(controller.text, 'Elle düzeltildi');
      expect(service.isListening, false);
    },
  );

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

  testWidgets(
    'initial empty dictation capitalizes every update; later lowercase edit wins',
    (tester) async {
      final service = FakeSpeechService();
      final controller = await pump(
        tester,
        service,
        initialTransform: (text) => capitalizeListTitle(text, localeCode: 'tr'),
      );
      await tester.tap(find.byKey(const Key('mic')));
      await tester.pumpAndSettle();
      service.emitPartial('inc');
      await tester.pump();
      expect(controller.text, 'İnc');
      service.emitFinal('incir reçeli');
      await tester.pump();
      expect(controller.text, 'İncir reçeli');
      expect(service.isListening, isTrue);
      await tester.enterText(find.byKey(const Key('field')), 'incir reçeli');
      service.emitPartial('başka ürün');
      await tester.pump();
      expect(controller.text, 'incir reçeli');
      expect(service.isListening, isFalse);
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    },
  );

  testWidgets('dictation preserves a preexisting lowercase prefix', (
    tester,
  ) async {
    final service = FakeSpeechService();
    final controller = await pump(
      tester,
      service,
      initialTransform: (text) => capitalizeListTitle(text, localeCode: 'tr'),
    );
    controller.text = 'incir';
    await tester.tap(find.byKey(const Key('mic')));
    await tester.pumpAndSettle();
    service.emitFinal('reçeli');
    await tester.pump();
    expect(controller.text, 'incir reçeli');
    await tester.pumpWidget(const SizedBox.shrink());
    controller.dispose();
  });
}
