import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart';
import 'package:napp_core/napp_core.dart';

import '../core/l10n/language_names.dart';

/// Ayarlar'daki dil tercihi (spec §3, §6.15; PB-061 ile 71 dil).
/// Değer: `system` ya da [appLanguages] içindeki bir dil kodu.
class LanguageController extends ChangeNotifier {
  LanguageController({this._store});

  /// SettingsStore anahtarı; değer dil kodu olarak saklanır.
  static const String storageKey = 'app.locale';
  static const String system = 'system';

  final SettingsStore? _store;

  String _value = system;

  String get value => _value;

  /// Kalıcı depodan okur; main'de runApp'ten önce çağrılır. Bilinmeyen kod
  /// (eski sürüm/bozuk değer) `system`e düşer.
  void load() {
    final stored = _store?.getString(storageKey);
    _value = stored != null && appLanguages.containsKey(stored) ? stored : system;
  }

  void set(String code) {
    if (code == _value || (code != system && !appLanguages.containsKey(code))) return;
    _value = code;
    _store?.setString(storageKey, code);
    notifyListeners();
  }

  /// MaterialApp.locale değeri; `system` → null.
  Locale? get locale => _value == system ? null : Locale(_value);
}
