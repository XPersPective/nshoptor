import 'dart:convert';

import 'package:napp_ads/napp_ads.dart';
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

  /// Geçiş reklamı gösterici (main bağlar; testte/reklamsız ortamda null).
  static Future<void> Function()? showInterstitial;

  /// Doğal durak (alışveriş bitip sonuç kapandı): politika izin verirse
  /// geçiş reklamı. Alışveriş sürerken çağrılmaz.
  static Future<void> maybeShowInterstitial() async {
    final show = showInterstitial;
    if (show == null) return;
    try {
      await show();
    } catch (_) {
      // Reklam hatası akışı bozmaz.
    }
  }

  /// [AdPolicyPersistence.load] reads dates as ints but its `save` writes
  /// them as strings, so every launch looked like day 0. Accept both.
  // ponytail: app-side fix; drop when napp_ads persistence reads its own format.
  static AdPolicySnapshot? loadPolicy(PreferenceAdapter adapter) {
    final raw = adapter.read('napp_ads.policy_state');
    if (raw is! String || raw.isEmpty) return null;
    try {
      final map = jsonDecode(raw);
      if (map is! Map<String, dynamic>) return null;
      DateTime? date(Object? v) {
        final ms = v is int ? v : v is String ? int.tryParse(v) : null;
        return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
      }

      return AdPolicySnapshot(
        firstLaunchAt: date(map['firstLaunchAt']),
        sessionCount: map['sessionCount'] is int ? map['sessionCount'] as int : 0,
        lastAppOpenAt: date(map['lastAppOpenAt']),
        lastFullscreenAt: date(map['lastFullscreenAt']),
        lastRewardedDay: date(map['lastRewardedDay']),
      );
    } on FormatException {
      return null;
    }
  }

  static bool inGrace(SettingsStore store, DateTime now) =>
      now.isBefore(firstOpen(store, now).add(const Duration(days: graceDays)));
}
