import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/voice_input/stt_speech_service.dart';
import 'package:nshoptor/features/voice_input/voice_input_service.dart';
import 'package:nshoptor/features/voice_input/voice_preview_sheet.dart';

class _French extends FakeSpeechService {
  String? locale;
  @override
  Future<List<String>> availableLocales() async => ['fr_FR'];
  @override
  Future<void> start(String locale) { this.locale = locale; return super.start(locale); }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  Future<void> event(int session, String type, Map<String, Object> data) async {
    await messenger.handlePlatformMessage(SttSpeechService.channel.name,
      const StandardMethodCodec().encodeMethodCall(MethodCall('event', {'sessionId': session, 'type': type, ...data})), null);
    await Future<void>.delayed(Duration.zero);
  }
  tearDown(() => messenger.setMockMethodCallHandler(SttSpeechService.channel, null));

  testWidgets('single voice preview scrolls at 320dp, 2x Arabic with keyboard', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(locale: const Locale('ar'),
      localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate], supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(2), viewInsets: const EdgeInsets.only(bottom: 260)), child: child!),
      home: Scaffold(body: VoicePreviewSheet(service: FakeSpeechService()))));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('voice_transcript_field')), '2 milk');
    await tester.ensureVisible(find.byKey(const Key('voice_parse_button')));
    await tester.tap(find.byKey(const Key('voice_parse_button'))); await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('voice_confirm_button')));
    expect(tester.getRect(find.byKey(const Key('voice_confirm_button'))).bottom, lessThanOrEqualTo(380));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  test('first/second sheet callbacks and owner cancellation never cross sessions', () async {
    final calls = <MethodCall>[];
    messenger.setMockMethodCallHandler(SttSpeechService.channel, (call) async {
      calls.add(call);
      return switch (call.method) { 'initialize' => true, 'locales' => ['fr-FR', 'en-US'], _ => null };
    });
    final firstService = SttSpeechService();
    final first = VoiceInputController(service: firstService);
    await first.initialize(); await first.start(locale: 'fr_CA');
    final old = (calls.first.arguments as Map)['sessionId'] as int;
    expect((calls.last.arguments as Map)['locale'], 'fr-FR');
    await event(old, 'result', {'text': 'tomates', 'final': false});
    expect(first.transcript, 'tomates');
    final secondService = SttSpeechService();
    final second = VoiceInputController(service: secondService)..transcript = 'manual';
    await second.initialize();
    final next = (calls.last.arguments as Map)['sessionId'] as int;
    first.dispose();
    await Future<void>.delayed(Duration.zero);
    expect(calls.where((c) => c.method == 'cancel'), isEmpty);
    await second.start(locale: 'fr-FR');
    await event(old, 'result', {'text': 'stale', 'final': true});
    expect(second.transcript, 'manual');
    await event(next, 'status', {'listening': true});
    expect(secondService.isListening, isTrue);
    await event(next, 'result', {'text': 'poires', 'final': false});
    await event(next, 'error', {'code': 'unsupportedLanguage'});
    await event(next, 'status', {'listening': false});
    expect(second.state, VoiceInputState.error);
    expect(second.transcript, 'poires');
    expect(second.shouldFallbackToManual, isTrue);
    second.dispose(); await Future<void>.delayed(Duration.zero);
    expect((calls.last.arguments as Map)['sessionId'], next);
    expect(calls.last.method, 'cancel');
  });

  test('unsupported language and thrown platform calls preserve manual transcript', () async {
    final service = SttSpeechService();
    final controller = VoiceInputController(service: service)..transcript = 'typed list';
    messenger.setMockMethodCallHandler(SttSpeechService.channel, (call) async =>
      switch (call.method) { 'initialize' => true, 'locales' => ['de-DE'], _ => null });
    await controller.initialize(); await controller.start(locale: 'ja-JP');
    expect(controller.errorMessage, 'unsupportedLanguage');
    expect(controller.transcript, 'typed list');
    messenger.setMockMethodCallHandler(SttSpeechService.channel, (call) async { throw PlatformException(code: 'unavailable'); });
    expect(await controller.initialize(), isFalse);
    expect(controller.transcript, 'typed list');
    controller.dispose(); await Future<void>.delayed(Duration.zero);
  });

  test('late init and status after disposal do not notify or start recognition', () async {
    final pending = Completer<bool>();
    final service = SttSpeechService();
    final controller = VoiceInputController(service: service);
    messenger.setMockMethodCallHandler(SttSpeechService.channel, (call) async =>
      call.method == 'initialize' ? pending.future : null);
    final initializing = controller.initialize();
    controller.dispose(); pending.complete(true);
    expect(await initializing, isFalse);
    expect(await controller.initialize(), isFalse);
    await controller.start();
    await Future<void>.delayed(Duration.zero);
  });

  testWidgets('French mic toggles stop; typing and platform error retain manual input', (tester) async {
    final service = _French();
    await tester.pumpWidget(MaterialApp(locale: const Locale('fr'), supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      home: Scaffold(body: VoicePreviewSheet(service: service))));
    await tester.enterText(find.byKey(const Key('voice_transcript_field')), 'tomates');
    await tester.tap(find.byKey(const Key('voice_mic_button'))); await tester.pumpAndSettle();
    expect(service.locale, 'fr_FR'); expect(service.isListening, isTrue);
    expect(find.byIcon(Icons.stop), findsOneWidget);
    await tester.tap(find.byKey(const Key('voice_mic_button'))); await tester.pumpAndSettle();
    expect(service.isListening, isFalse);
    service.emitError('no_match'); await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.byKey(const Key('voice_transcript_field'))).controller!.text, 'tomates');
    expect(find.byKey(const Key('voice_unavailable')), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
