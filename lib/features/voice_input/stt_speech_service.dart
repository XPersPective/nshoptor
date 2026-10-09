import 'dart:async';
import 'package:flutter/services.dart';
import 'voice_input_service.dart';

/// One channel callback; each sheet owns its session and cannot cancel its successor.
/// ponytail: one instance per sheet; add explicit owner tokens if instances must be shared concurrently.
class SttSpeechService implements SpeechService {
  SttSpeechService() {
    if (!_handlerSet) {
      _handlerSet = true;
      channel.setMethodCallHandler((call) async => _active?._event(call));
    }
  }
  static const channel = MethodChannel('nshoptor/speech');
  static bool _handlerSet = false;
  static int _nextSession = 0;
  static SttSpeechService? _active;
  int _session = 0;
  bool _listening = false;
  final _results = StreamController<SpeechResult>.broadcast();
  final _errors = StreamController<String>.broadcast();
  final _statuses = StreamController<bool>.broadcast();

  void _event(MethodCall call) {
    final data = call.arguments;
    if (call.method != 'event' || data is! Map || data['sessionId'] != _session) return;
    switch (data['type']) {
      case 'result':
        if (data['text'] is String && data['final'] is bool) {
          _results.add(SpeechResult(transcript: data['text'] as String, finalResult: data['final'] as bool));
        }
      case 'error':
        _errors.add(data['code'] is String ? data['code'] as String : 'serviceUnavailable');
      case 'status':
        _listening = data['listening'] == true;
        _statuses.add(_listening);
    }
  }
  @override
  Future<bool> init() async {
    _session = ++_nextSession;
    _active = this;
    _listening = false;
    return await channel.invokeMethod<bool>('initialize', {'sessionId': _session}) ?? false;
  }
  @override
  Future<List<String>> availableLocales() async =>
    await channel.invokeListMethod<String>('locales', {'sessionId': _session}).timeout(const Duration(seconds: 15)) ?? [];
  @override
  Future<void> start(String locale) async {
    if (_active != this) throw StateError('inactive speech session');
    await channel.invokeMethod<void>('start', {'sessionId': _session, 'locale': locale});
  }
  @override
  Future<void> stop() async {
    if (_active == this) await channel.invokeMethod<void>('stop', {'sessionId': _session}).timeout(const Duration(seconds: 15));
    _listening = false;
  }
  @override
  Future<void> cancel() async {
    if (_active != this) return;
    _active = null;
    _listening = false;
    try { await channel.invokeMethod<void>('cancel', {'sessionId': _session}); } catch (_) { /* Unavailable platform: manual input remains usable. */ }
  }
  @override
  bool get isListening => _listening;
  @override
  Stream<SpeechResult> get results => _results.stream;
  @override
  Stream<String> get errors => _errors.stream;
  @override
  Stream<bool> get statuses => _statuses.stream;
}
