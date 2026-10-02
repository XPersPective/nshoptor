import 'package:napp_core/napp_core.dart';

import '../core/money/currency.dart';
import '../core/quantity/unit_code.dart';
import '../features/settings/settings_repository.dart';

/// Ayarlar'daki varsayılanların okuma tarafı (boot'ta bağlanır).
///
/// Yazma tarafı SettingsRepository'dir; anahtar sabitleri oradan gelir.
/// Bağlanmadığında (testler) ürünün sabit varsayılanları geçerlidir.
class AppDefaults {
  AppDefaults._();

  static SettingsStore? _store;

  /// main'de runApp'ten önce bir kez çağrılır.
  static void attach(SettingsStore store) => _store = store;

  /// Ayarlar'dan varsayılan para birimi; geçersizse TRY.
  static String defaultCurrency() {
    final code = _store?.getString(SettingsRepository.currencyKey);
    if (code == null) return 'TRY';
    for (final c in Currency.all) {
      if (c.code == code) return code;
    }
    return 'TRY';
  }

  /// Ayarlar'dan varsayılan birim; geçersizse adet.
  static UnitCode defaultUnit() {
    final stored = _store?.getString(SettingsRepository.unitKey);
    if (stored == null) return UnitCode.adet;
    for (final u in UnitCode.values) {
      if (u.name == stored) return u;
    }
    return UnitCode.adet;
  }
}
