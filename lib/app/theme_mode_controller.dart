import 'package:flutter/material.dart';
import 'package:napp_core/napp_core.dart' hide AppTheme;

import '../core/theme/app_theme.dart';

/// Ayarlar'daki tema tercihi: Sistem / Açık / Koyu (spec §6.15).
/// Değeri SettingsStore'da kalıcı tutar ve MaterialApp'e bildirir.
class AppThemeModeController extends ChangeNotifier {
  AppThemeModeController({this._store});


  /// SettingsStore anahtarı; değer `system|light|dark` (varsayılan
  /// [AppTheme.defaultModeName]).
  static const String storageKey = 'app.theme';

  final SettingsStore? _store;

  // Fresh installs start on the brand dark-green theme (F36).
  String _value = AppTheme.defaultModeName;

  /// Kalıcı depodan okur; main'de runApp'ten önce çağrılır.
  void load() {
    final stored = _store?.getString(storageKey);
    if (stored != null &&
        (stored == 'light' || stored == 'dark' || stored == 'system')) {
      _value = stored;
    }
    loadStyle();
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

  /// Renk teması ve koyu temada tam siyah tercihi.
  static const String paletteKey = 'app.palette';
  static const String blackKey = 'app.darkBlack';

  AppPalette _palette = AppPalette.forest;
  bool _black = false;

  AppPalette get palette => _palette;
  bool get black => _black;

  void loadStyle() {
    _palette = AppPalette.fromName(_store?.getString(paletteKey));
    _black = _store?.getBool(blackKey) ?? false;
  }

  void setPalette(AppPalette palette) {
    if (palette == _palette) return;
    _palette = palette;
    _store?.setString(paletteKey, palette.name);
    notifyListeners();
  }

  void setBlack(bool value) {
    if (value == _black) return;
    _black = value;
    _store?.setBool(blackKey, value);
    notifyListeners();
  }
}
