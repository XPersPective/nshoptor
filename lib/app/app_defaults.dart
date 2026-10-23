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

  static const _guideSeenKey = 'guide.seen';

  /// Ilk açılış rehberi bir kez gösterilir; store yoksa (testler) gösterilmez.
  static bool guideSeen() {
    final store = _store;
    return store == null || (store.getBool(_guideSeenKey) ?? false);
  }
  static void markGuideSeen() => _store?.setBool(_guideSeenKey, true);

  static bool keepScreenAwake() => _store?.getBool(SettingsRepository.keepAwakeKey) ?? false;
  static void setKeepScreenAwake(bool value) => _store?.setBool(SettingsRepository.keepAwakeKey, value);

  static const _listSortKey = 'lists.sort';
  static String listSort() {
    final value = _store?.getString(_listSortKey);
    return const {'date', 'title', 'manual'}.contains(value) ? value! : 'date';
  }
  static void setListSort(String value) =>
      _store?.setString(_listSortKey, const {'date', 'title', 'manual'}.contains(value) ? value : 'date');

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

  static int? monthlyLimitMinor({String? currencyCode}) => _limit(monthlyLimitKey, currencyCode);

  static void setMonthlyLimitMinor(int? value, {String? currencyCode}) =>
      _setLimit(monthlyLimitKey, value, currencyCode);

  /// Haftalık harcama limiti ve alışveriş başına varsayılan bütçe (minor unit).
  static const weeklyLimitKey = 'weekly_limit_minor';
  static const shoppingLimitKey = 'shopping_limit_minor';

  static int? weeklyLimitMinor({String? currencyCode}) => _limit(weeklyLimitKey, currencyCode);

  static void setWeeklyLimitMinor(int? value, {String? currencyCode}) =>
      _setLimit(weeklyLimitKey, value, currencyCode);

  /// Yeni listelerin varsayılan bütçesi; liste kendi bütçesini değiştirebilir.
  static int? shoppingLimitMinor({String? currencyCode}) => _limit(shoppingLimitKey, currencyCode);

  static void setShoppingLimitMinor(int? value, {String? currencyCode}) =>
      _setLimit(shoppingLimitKey, value, currencyCode);

  static int? _limit(String key, String? currencyCode) {
    final value = _store?.getInt('$key.${currencyCode ?? defaultCurrency()}');
    return value != null && value > 0 ? value : null;
  }

  static void _setLimit(String key, int? value, String? currencyCode) {
    final store = _store;
    if (store == null) return;
    final full = '$key.${currencyCode ?? defaultCurrency()}';
    if (value == null || value <= 0) {
      store.remove(full);
    } else {
      store.setInt(full, value);
    }
  }
}
