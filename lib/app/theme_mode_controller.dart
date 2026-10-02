import 'package:flutter/material.dart';
import 'package:napp_core/napp_core.dart';

/// Ayarlar'daki tema tercihi: Sistem / Açık / Koyu (spec §6.15).
/// Değeri SettingsStore'da kalıcı tutar ve MaterialApp'e bildirir.
class AppThemeModeController extends ChangeNotifier {
  AppThemeModeController({this._store});


  /// SettingsStore anahtarı; değer `system|light|dark`.
  static const String storageKey = 'app.theme';

  final SettingsStore? _store;

  String _value = 'system';

  /// Kalıcı depodan okur; main'de runApp'ten önce çağrılır.
  void load() {
    final stored = _store?.getString(storageKey);
    if (stored != null &&
        (stored == 'light' || stored == 'dark' || stored == 'system')) {
      _value = stored;
    }
  }

  String get value => _value;

  ThemeMode get mode => switch (_value) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  void set(String value) {
    if (value == _value) return;
    _value = value;
    _store?.setString(storageKey, value);
    notifyListeners();
  }
}
