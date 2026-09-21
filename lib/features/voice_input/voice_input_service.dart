import 'dart:async';

import 'package:flutter/foundation.dart';

/// Konuşma tanıma sonucu adayı (spec §6.7).
class SpeechResult {
  const SpeechResult({required this.transcript, required this.finalResult});

  final String transcript;
  final bool finalResult;
}

/// Konuşma tanıma durumları.
enum VoiceInputState { idle, listening, error }

/// Platform konuşma tanıma servisinin soyutlaması (spec §6.7).
///
/// Tercih edilen yaklaşım platformun kendi hizmetidir: Android
/// `SpeechRecognizer`, iOS Speech framework (speech_to_text paketi bunları
/// sarar). Kullanıcıdan AYRI bir model indirmesi istenmez. Hizmet
/// cihaz/dil/internet bağımlıdır; her başarısızlık hata akışıyla bildirilir
/// ve uygulamanın geri kalanı etkilenmez.
abstract class SpeechService {
  /// Servisi hazırlar; kullanılamıyorsa false döner (izin verilmemiş,
  /// tanıyıcı yok vb.).
  Future<bool> init();

  /// Cihazın desteklediği locale'ler (ör. `tr_TR`).
  Future<List<String>> availableLocales();

  /// Dinlemeyi başlatır; sonuçlar [results], hatalar [errors] akışıyla iletilir.
  Future<void> start(String locale);

  Future<void> stop();

  bool get isListening;

  Stream<SpeechResult> get results;

  Stream<String> get errors;
}

/// Platform servisi sözleşmesini uygulayan sahte/simüle bileşen: testler ve
/// tanıyıcı olmayan ortamlar için deterministik davranış.
class FakeSpeechService implements SpeechService {
  FakeSpeechService({this.available = true, this.permissionDenied = false});

  bool available;
  bool permissionDenied;
  final StreamController<SpeechResult> _results =
      StreamController<SpeechResult>.broadcast();
  final StreamController<String> _errors =
      StreamController<String>.broadcast();

  @override
  Stream<SpeechResult> get results => _results.stream;

  @override
  Stream<String> get errors => _errors.stream;

  final ValueNotifier<bool> listening = ValueNotifier(false);

  @override
  Future<bool> init() async => available && !permissionDenied;

  @override
  Future<List<String>> availableLocales() async => ['tr_TR', 'en_US'];

  @override
  Future<void> start(String locale) async {
    if (!available || permissionDenied) {
      listening.value = false;
      _errors.add('serviceUnavailable');
      return;
    }
    listening.value = true;
  }

  @override
  Future<void> stop() async {
    listening.value = false;
  }

  @override
  bool get isListening => listening.value;

  void emitPartial(String text) =>
      _results.add(SpeechResult(transcript: text, finalResult: false));

  void emitFinal(String text) =>
      _results.add(SpeechResult(transcript: text, finalResult: true));

  void emitError(String message) {
    listening.value = false;
    _errors.add(message);
  }
}

/// Sesli girişi yöneten denetleyici: durum makinesi + izin reddinde manuel
/// girişe dönüş sinyali (spec §6.7: izin reddinde manuel alternatif).
class VoiceInputController extends ChangeNotifier {
  VoiceInputController({required this._service}) {
    _resultSub = _service.results.listen(handleResult);
    _errorSub = _service.errors.listen(handleError);
  }

  final SpeechService _service;
  VoiceInputState state = VoiceInputState.idle;
  String transcript = '';
  String? errorMessage;

  /// true: servis kullanılamıyor/izin yok → UI manuel giriş formunu açar.
  bool get shouldFallbackToManual =>
      state == VoiceInputState.error &&
      (errorMessage?.startsWith('serviceUnavailable') ?? false);

  StreamSubscription<SpeechResult>? _resultSub;
  StreamSubscription<String>? _errorSub;

  Future<bool> initialize() async {
    final ok = await _service.init();
    if (!ok) {
      state = VoiceInputState.error;
      errorMessage = 'serviceUnavailable';
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<void> start({String locale = 'tr_TR'}) async {
    state = VoiceInputState.listening;
    errorMessage = null;
    transcript = '';
    notifyListeners();
    await _service.start(locale);
  }

  void handleResult(SpeechResult result) {
    transcript = result.transcript;
    if (result.finalResult) {
      state = VoiceInputState.idle;
    }
    notifyListeners();
  }

  void handleError(String message) {
    state = VoiceInputState.error;
    errorMessage = message;
    notifyListeners();
  }

  Future<void> stop() async {
    await _service.stop();
    state = VoiceInputState.idle;
    notifyListeners();
  }

  @override
  void dispose() {
    _resultSub?.cancel();
    _errorSub?.cancel();
    super.dispose();
  }
}
