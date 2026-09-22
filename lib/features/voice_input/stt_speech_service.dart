import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

import 'voice_input_service.dart';

/// Platform konuşma tanıma adaptörü (Android SpeechRecognizer / iOS Speech;
/// speech_to_text sarar). Model indirmesi yoktur (spec §6.7).
class SttSpeechService implements SpeechService {
  final SpeechToText _stt = SpeechToText();
  final _results = StreamController<SpeechResult>.broadcast();
  final _errors = StreamController<String>.broadcast();

  @override
  Future<bool> init() async {
    try {
      return await _stt.initialize(onError: (e) => _errors.add(e.errorMsg));
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<String>> availableLocales() async => [
    for (final l in await _stt.locales()) l.localeId,
  ];

  @override
  Future<void> start(String locale) => _stt.listen(
    onResult: (r) => _results.add(
      SpeechResult(transcript: r.recognizedWords, finalResult: r.finalResult),
    ),
    listenOptions: SpeechListenOptions(localeId: locale),
  );

  @override
  Future<void> stop() => _stt.stop();

  @override
  bool get isListening => _stt.isListening;

  @override
  Stream<SpeechResult> get results => _results.stream;

  @override
  Stream<String> get errors => _errors.stream;
}
