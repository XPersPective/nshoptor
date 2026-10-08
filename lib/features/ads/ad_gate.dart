import 'package:napp_core/napp_core.dart';

/// Uygulamaya özgü reklam kapıları (PB-056, ADR-004 §8):
/// - kurulumdan sonraki ilk 7 gün hiç reklam yok;
/// - alışveriş modundayken tam ekran reklam yok (kullanıcı rafta).
class AdGate {
  AdGate._();

  static const graceDays = 7;
  static const firstOpenKey = 'first_open_at';

  /// Alışveriş modu ekranı açıkken true (ShoppingModeScreen yönetir).
  static bool shoppingModeActive = false;

  /// İlk açılış zamanı; yoksa şimdi olarak kaydedilir.
  static DateTime firstOpen(SettingsStore store, DateTime now) {
    final stored = store.getInt(firstOpenKey);
    if (stored != null) return DateTime.fromMillisecondsSinceEpoch(stored);
    store.setInt(firstOpenKey, now.millisecondsSinceEpoch);
    return now;
  }

  static bool inGrace(SettingsStore store, DateTime now) =>
      now.isBefore(firstOpen(store, now).add(const Duration(days: graceDays)));
}
