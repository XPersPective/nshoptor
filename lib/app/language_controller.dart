import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart';
import 'package:napp_core/napp_core.dart';

/// Ayarlar'daki dil tercihi: Sistem / Türkçe / English (spec §3, §6.15).
enum AppLocaleSetting { system, tr, en }

/// Dil tercihini kalıcı tutar (SettingsStore) ve MaterialApp'e bağlar.
/// `system` iken locale null'dur: MaterialApp sistem dilini kullanır
/// (ilk açılış davranışı da budur).
class LanguageController extends ChangeNotifier {
  LanguageController({this._store});

  /// SettingsStore anahtarı; değer [AppLocaleSetting.name] olarak saklanır.
  static const String storageKey = 'app.locale';

  final SettingsStore? _store;

  AppLocaleSetting _value = AppLocaleSetting.system;

  AppLocaleSetting get value => _value;

  /// Kalıcı depodan okur; main'de runApp'ten önce çağrılır.
  void load() {
    final stored = _store?.getString(storageKey);
    if (stored == null) return;
    for (final v in AppLocaleSetting.values) {
      if (v.name == stored) {
        _value = v;
        return;
      }
    }
    _value = AppLocaleSetting.system;
  }

  void set(AppLocaleSetting setting) {
    if (setting == _value) return;
    _value = setting;
    _store?.setString(storageKey, setting.name);
    notifyListeners();
  }

  /// MaterialApp.locale değeri; `system` → null.
  Locale? get locale => switch (_value) {
        AppLocaleSetting.system => null,
        AppLocaleSetting.tr => const Locale('tr'),
        AppLocaleSetting.en => const Locale('en'),
      };
}
