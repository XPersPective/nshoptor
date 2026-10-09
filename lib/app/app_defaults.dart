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
  static void attach(SettingsStore store) {
    _store = store;
    final legacy = store.getInt(monthlyLimitKey);
    if (legacy != null) {
      // ponytail: legacy limits have no currency tag; bind once to the saved default.
      // Recovering an older intended currency requires an explicit user selection.
      final key = '$monthlyLimitKey.${defaultCurrency()}';
      if (legacy > 0 && store.getInt(key) == null) store.setInt(key, legacy);
      store.remove(monthlyLimitKey);
    }
  }

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

  /// Aylık harcama limiti (minor unit, varsayılan para biriminde); yoksa null.
  static const monthlyLimitKey = 'monthly_limit_minor';

  static int? monthlyLimitMinor({String? currencyCode}) {
    final value = _store?.getInt('$monthlyLimitKey.${currencyCode ?? defaultCurrency()}');
    return value != null && value > 0 ? value : null;
  }

  static void setMonthlyLimitMinor(int? value, {String? currencyCode}) {
    final store = _store;
    if (store == null) return;
    final key = '$monthlyLimitKey.${currencyCode ?? defaultCurrency()}';
    if (value == null || value <= 0) {
      store.remove(key);
    } else {
      store.setInt(key, value);
    }
  }
}
