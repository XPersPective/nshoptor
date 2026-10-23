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
/// Android on-device SpeechRecognizer (API31+). Model indirmesi ve ağ fallback yok;
/// yalnız yüklü dil/izin/cihaz desteğiyle çalışır; her başarısızlık hata akışıyla bildirilir
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
  Future<void> cancel();
  Stream<bool> get statuses;

  /// Dil modeli kurulu değilse cihaz içi indirmeyi başlatır; başladıysa true.
  Future<bool> requestLanguageModel(String locale);

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
  final _statuses = StreamController<bool>.broadcast();
  @override
  Stream<bool> get statuses => _statuses.stream;

  @override
  Future<bool> init() async => available && !permissionDenied;

  @override
  Future<List<String>> availableLocales() async => locales;
  List<String> locales = ['tr_TR', 'en_US'];

  @override
  Future<void> start(String locale) async {
    if (!available || permissionDenied) {
      listening.value = false;
      _errors.add('serviceUnavailable');
      return;
    }
    listening.value = true;
    _statuses.add(true);
  }

  @override
  Future<void> stop() async {
    listening.value = false;
    _statuses.add(false);
  }

  @override
  Future<void> cancel() => stop();

  /// true: eksik dil modeli için indirme başlatılmış gibi davranır.
  bool modelDownloadable = false;

  @override
  Future<bool> requestLanguageModel(String locale) async => modelDownloadable;

  void emitStatus(bool active) { listening.value = active; _statuses.add(active); }

  @override
  bool get isListening => listening.value;

  void emitPartial(String text) =>
      _results.add(SpeechResult(transcript: text, finalResult: false));

  void emitFinal(String text) {
    _results.add(SpeechResult(transcript: text, finalResult: true));
  }

  void emitError(String message) {
    listening.value = false;
    _errors.add(message);
    _statuses.add(false);
  }
}

/// Sesli girişi yöneten denetleyici: durum makinesi + izin reddinde manuel
/// girişe dönüş sinyali (spec §6.7: izin reddinde manuel alternatif).
class VoiceInputController extends ChangeNotifier {
  VoiceInputController({required this._service}) {
    _resultSub = _service.results.listen(handleResult);
    _errorSub = _service.errors.listen(handleError);
    _statusSub = _service.statuses.listen((active) {
      if (!_disposed && !active && state == VoiceInputState.listening) {
        _sessionWatch.stop();
        state = VoiceInputState.idle; notifyListeners();
      }
    });
  }

  final SpeechService _service;
  bool _disposed = false;
  VoiceInputState state = VoiceInputState.idle;
  String transcript = '';
  String _finalized = '';
  bool _starting = false;
  final Stopwatch _sessionWatch = Stopwatch();
  Duration get recognitionDuration => _sessionWatch.elapsed;
  Duration? firstResultLatency;
  int finalizedSegments = 0;
  String? errorMessage;

  /// true: servis kullanılamıyor/izin yok → UI manuel giriş formunu açar.
  bool get shouldFallbackToManual =>
      state == VoiceInputState.error &&
      ((errorMessage?.startsWith('serviceUnavailable') ?? false) || (errorMessage == 'unsupportedLanguage' || errorMessage == 'modelDownloading'));

  StreamSubscription<SpeechResult>? _resultSub;
  StreamSubscription<String>? _errorSub;
  StreamSubscription<bool>? _statusSub;

  Future<bool> initialize() async {
    if (_disposed) return false;
    try {
      final ok = await _service.init();
      if (_disposed) return false;
      if (!ok) handleError('serviceUnavailable');
      return ok;
    } catch (_) {
      if (!_disposed) handleError('serviceUnavailable');
      await _service.cancel();
      return false;
    }
  }

  Future<void> start({String locale = 'tr_TR'}) async {
    if (_disposed || _starting || state == VoiceInputState.listening) return;
    _starting = true;
    _finalized = transcript.trim();
    try {
      final locales = await _service.availableLocales();
      if (_disposed) return;
      String tag(String s) => s.replaceAll('_', '-').toLowerCase();
      final requested = tag(locale);
      final exact = locales.where((s) => tag(s) == requested);
      final sameLanguage = locales.where((s) => tag(s).split('-').first == requested.split('-').first);
      final chosen = exact.isNotEmpty ? exact.first : sameLanguage.firstOrNull;
      if (chosen == null) {
        final downloading = await _service.requestLanguageModel(locale);
        if (!_disposed) handleError(downloading ? 'modelDownloading' : 'unsupportedLanguage');
        return;
      }
      _sessionWatch..reset()..start();
      firstResultLatency = null;
      finalizedSegments = 0;
      state = VoiceInputState.listening;
      errorMessage = null;
      notifyListeners();
      await _service.start(chosen);
    } catch (_) { if (!_disposed) handleError('serviceUnavailable'); }
    finally { _starting = false; }
  }

  void handleResult(SpeechResult result) {
    if (_disposed) return;
    if (result.transcript.isNotEmpty) firstResultLatency ??= _sessionWatch.elapsed;
    if (result.finalResult && result.transcript.isNotEmpty) {
      finalizedSegments++;
      _finalized = [_finalized, result.transcript.trim()].where((s) => s.isNotEmpty).join(' ');
      transcript = _finalized;
    } else if (result.transcript.isNotEmpty) {
      transcript = [_finalized, result.transcript.trim()].where((s) => s.isNotEmpty).join(' ');
    }
    notifyListeners();
  }

  void handleError(String message) {
    if (_disposed) return;
    _sessionWatch.stop();
    // Silence/no match is not a failure: the user just did not speak.
    if (const {'recognition_6', 'recognition_7', 'recognition_no_match'}.contains(message)) {
      state = VoiceInputState.idle;
      notifyListeners();
      return;
    }
    state = VoiceInputState.error;
    errorMessage = message;
    notifyListeners();
  }

  Future<void> stop() async {
    _sessionWatch.stop();
    try { await _service.stop(); }
    catch (_) {
      if (!_disposed) handleError('serviceUnavailable');
      try { await _service.cancel(); } catch (_) { /* The platform may already be gone. */ }
    }
    if (!_disposed && state != VoiceInputState.error) { state = VoiceInputState.idle; notifyListeners(); }
  }

  @override
  void dispose() {
    _disposed = true;
    _sessionWatch.stop();
    _statusSub?.cancel();
    unawaited(_service.cancel().catchError((Object _) {}));
    _resultSub?.cancel();
    _errorSub?.cancel();
    super.dispose();
  }
}
