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

  /// Set when the lists tour is finished: the next opened list continues
  /// the tour with its own controls once (PB-201). Off without a store.
  static const _detailTourKey = 'guide.detail_pending';
  static bool detailTourPending() => _store?.getBool(_detailTourKey) ?? false;
  static void setDetailTourPending(bool value) =>
      _store?.setBool(_detailTourKey, value);

  /// Short receipt capture tips (F05/F06); "don't show again" turns them off
  /// and Settings can turn them back on. Without a store (tests) they stay off.
  static const captureTipsKey = 'capture_tips_enabled';
  static bool captureTipsEnabled() =>
      _store != null && (_store!.getBool(captureTipsKey) ?? true);
  static void setCaptureTipsEnabled(bool value) =>
      _store?.setBool(captureTipsKey, value);

  static bool keepScreenAwake() =>
      _store?.getBool(SettingsRepository.keepAwakeKey) ?? false;
  static void setKeepScreenAwake(bool value) =>
      _store?.setBool(SettingsRepository.keepAwakeKey, value);

  static const _listSortKey = 'lists.sort';
  static String listSort() {
    final value = _store?.getString(_listSortKey);
    return const {'date', 'title', 'manual'}.contains(value) ? value! : 'date';
  }

  static void setListSort(String value) => _store?.setString(
    _listSortKey,
    const {'date', 'title', 'manual'}.contains(value) ? value : 'date',
  );

  static const _datedReminderModeKey = 'reminders.dated_list_mode';

  /// Tarihli listeler için varsayılan hatırlatma tercihi ('none', 'same_day', '1h').
  static String datedReminderMode() {
    final value = _store?.getString(_datedReminderModeKey);
    return const {'none', 'same_day', '1h'}.contains(value) ? value! : 'none';
  }

  static void setDatedReminderMode(String value) => _store?.setString(
    _datedReminderModeKey,
    const {'none', 'same_day', '1h'}.contains(value) ? value : 'none',
  );

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

  static String monthPeriodKey(DateTime month) =>
      '${month.year}-${month.month.toString().padLeft(2, '0')}';

  static DateTime weekStart(DateTime date) {
    final local = date.toLocal();
    return DateTime(local.year, local.month, local.day - (local.weekday - 1));
  }

  static String weekPeriodKey(DateTime week) {
    final monday = weekStart(week);
    return '${monday.year}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}';
  }

  static int? monthlyLimitMinor({
    String? currencyCode,
    DateTime? month,
    bool explicitOnly = false,
  }) {
    final currency = currencyCode ?? defaultCurrency();
    if (month != null) {
      final specific = _limit(
        '$monthlyLimitKey.${monthPeriodKey(month)}',
        currency,
      );
      if (specific != null || explicitOnly) return specific;
    }
    return _limit(monthlyLimitKey, currency);
  }

  static void setMonthlyLimitMinor(
    int? value, {
    String? currencyCode,
    DateTime? month,
  }) {
    final currency = currencyCode ?? defaultCurrency();
    if (month != null) {
      _setLimit('$monthlyLimitKey.${monthPeriodKey(month)}', value, currency);
      return;
    }
    _setLimit(monthlyLimitKey, value, currency);
  }

  /// Haftalık harcama limiti ve alışveriş başına varsayılan bütçe (minor unit).
  static const weeklyLimitKey = 'weekly_limit_minor';
  static const shoppingLimitKey = 'shopping_limit_minor';

  static int? weeklyLimitMinor({
    String? currencyCode,
    DateTime? week,
    bool explicitOnly = false,
  }) {
    final currency = currencyCode ?? defaultCurrency();
    if (week != null) {
      final specific = _limit(
        '$weeklyLimitKey.${weekPeriodKey(week)}',
        currency,
      );
      if (specific != null || explicitOnly) return specific;
    }
    return _limit(weeklyLimitKey, currency);
  }

  static void setWeeklyLimitMinor(
    int? value, {
    String? currencyCode,
    DateTime? week,
  }) {
    final currency = currencyCode ?? defaultCurrency();
    if (week != null) {
      _setLimit('$weeklyLimitKey.${weekPeriodKey(week)}', value, currency);
      return;
    }
    _setLimit(weeklyLimitKey, value, currency);
  }

  /// Yeni listelerin varsayılan bütçesi; liste kendi bütçesini değiştirebilir.
  static int? shoppingLimitMinor({String? currencyCode}) =>
      _limit(shoppingLimitKey, currencyCode);

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
