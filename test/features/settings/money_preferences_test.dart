import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';

class _Prefs implements PreferenceAdapter {
  final values = <String, Object>{};
  @override
  Map<String, Object> readAll() => Map.of(values);
  @override
  Object? read(String key) => values[key];
  @override
  Future<void> write(String key, Object value) async { values[key] = value; }
  @override
  Future<void> delete(String key) async { values.remove(key); }
}

void main() {
  test('legacy limit binds once; currency defaults and limits survive reload independently', () async {
    final prefs = _Prefs();
    prefs.values.addAll({SettingsRepository.currencyKey: 'TRY', AppDefaults.monthlyLimitKey: 12345});
    final store = SettingsStore(adapter: prefs);
    AppDefaults.attach(store);
    expect(AppDefaults.monthlyLimitMinor(), 12345);
    store.setString(SettingsRepository.currencyKey, 'USD');
    expect(AppDefaults.monthlyLimitMinor(), isNull);
    expect(AppDefaults.monthlyLimitMinor(currencyCode: 'TRY'), 12345);
    AppDefaults.setMonthlyLimitMinor(67890);
    AppDefaults.setMonthlyLimitMinor(4567, currencyCode: 'KWD');
    AppDefaults.setMonthlyLimitMinor(123, currencyCode: 'JPY');
    store.setString(SettingsRepository.localeKey, 'tr');
    await store.flush();
    final restarted = SettingsStore(adapter: prefs);
    AppDefaults.attach(restarted);
    expect(AppDefaults.defaultCurrency(), 'USD');
    expect(AppDefaults.monthlyLimitMinor(), 67890);
    expect(AppDefaults.monthlyLimitMinor(currencyCode: 'TRY'), 12345);
    expect(AppDefaults.monthlyLimitMinor(currencyCode: 'KWD'), 4567);
    expect(AppDefaults.monthlyLimitMinor(currencyCode: 'JPY'), 123);
    expect(restarted.getInt(AppDefaults.monthlyLimitKey), isNull);
    restarted.setString(SettingsRepository.currencyKey, 'JPY');
    AppDefaults.setMonthlyLimitMinor(null);
    expect(AppDefaults.monthlyLimitMinor(), isNull);
    expect(AppDefaults.monthlyLimitMinor(currencyCode: 'USD'), 67890);
    await restarted.flush();
  });

  test('legacy migration preserves a newer currency-specific limit and rejects nonpositive limits', () {
    final store = SettingsStore();
    store.setInt(AppDefaults.monthlyLimitKey, 12345);
    store.setInt('${AppDefaults.monthlyLimitKey}.TRY', 45678);
    AppDefaults.attach(store);
    expect(AppDefaults.monthlyLimitMinor(), 45678);
    AppDefaults.setMonthlyLimitMinor(0);
    expect(AppDefaults.monthlyLimitMinor(), isNull);
    store.setInt('${AppDefaults.monthlyLimitKey}.KWD', -1);
    expect(AppDefaults.monthlyLimitMinor(currencyCode: 'KWD'), isNull);
  });
}
