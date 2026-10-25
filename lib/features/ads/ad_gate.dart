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
  static const graceStateKey = 'ad_grace_state_v1';

  /// Alışveriş modu ekranı açıkken true (ShoppingModeScreen yönetir).
  static bool shoppingModeActive = false;

  /// Earliest known first launch. Surviving policy/grace records repair a
  /// missing legacy key, rather than awarding another seven days.
  static DateTime firstOpen(SettingsStore store, DateTime now) =>
      _observeGrace(store, now).firstOpen;

  static Map<String, dynamic>? _map(Object? raw) {
    if (raw is! String) return null;
    try {
      final value = jsonDecode(raw);
      return value is Map<String, dynamic> ? value : null;
    } on FormatException {
      return null;
    }
  }

  static DateTime? _date(Object? raw) {
    final ms = raw is int ? raw : raw is String ? int.tryParse(raw) : null;
    // Dart DateTime rejects values outside this inclusive range.
    if (ms == null || ms < -8640000000000000 || ms > 8640000000000000) return null;
    return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);
  }

  static ({DateTime firstOpen, bool expired}) _observeGrace(
    SettingsStore store, DateTime now,
  ) {
    final memory = store.memorySnapshot();
    final state = _map(memory[graceStateKey]);
    final policy = _map(memory['napp_ads.policy_state']);
    final legacyStart = _date(memory[firstOpenKey]);
    final stateStart = _date(state?['firstOpenAt']);
    final policyStart = _date(policy?['firstLaunchAt']);
    final starts = [legacyStart, stateStart, policyStart]
        .whereType<DateTime>().toList()..sort();
    // An isolated future legacy timestamp cannot prove any remaining grace.
    // Matching surviving state is retained during a legitimate clock rollback.
    final isolatedFuture = legacyStart != null && legacyStart.isAfter(now) &&
        stateStart == null && policyStart == null;
    final hadGraceRecord = memory.containsKey(firstOpenKey) ||
        memory.containsKey(graceStateKey);
    final duration = const Duration(days: graceDays);
    // A damaged existing record is not evidence of a fresh install. Recover
    // from another valid anchor when possible; otherwise never reset its trial.
    final first = starts.isNotEmpty && !isolatedFuture ? starts.first :
        (hadGraceRecord ? now.toUtc().subtract(duration) : now.toUtc());
    final observed = _date(state?['lastObservedAt']);
    final effectiveNow = observed != null && observed.isAfter(now)
        ? observed : now.toUtc();
    final expired = state?['expired'] == true ||
        effectiveNow.difference(first) >= duration;
    if (memory[firstOpenKey] != first.millisecondsSinceEpoch) {
      store.setInt(firstOpenKey, first.millisecondsSinceEpoch);
    }
    // Repeated policy checks must not continually reset SettingsStore's disk
    // debounce. Expiry/repairs are immediate; ordinary observations are bounded
    // to once per minute, and an expired record needs no further clock writes.
    final needsWrite = stateStart != first || observed == null ||
        state?['expired'] != expired ||
        (!expired && effectiveNow.difference(observed) >= const Duration(minutes: 1));
    if (needsWrite) {
      store.setString(graceStateKey, jsonEncode({
        'firstOpenAt': first.millisecondsSinceEpoch,
        'lastObservedAt': effectiveNow.millisecondsSinceEpoch,
        'expired': expired,
      }));
    }
    return (firstOpen: first, expired: expired);
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

      return AdPolicySnapshot(
        firstLaunchAt: _date(map['firstLaunchAt'])?.toLocal(),
        sessionCount: map['sessionCount'] is int ? map['sessionCount'] as int : 0,
        lastAppOpenAt: _date(map['lastAppOpenAt'])?.toLocal(),
        lastFullscreenAt: _date(map['lastFullscreenAt'])?.toLocal(),
        lastRewardedDay: _date(map['lastRewardedDay'])?.toLocal(),
      );
    } on FormatException {
      return null;
    }
  }

  /// Once observed expired, local clock rollback cannot reactivate grace.
  /// This protects surviving local state; clearing all app data/reinstalling
  /// still needs a server-verified eligibility record to enforce R66.
  static bool inGrace(SettingsStore store, DateTime now) =>
      !_observeGrace(store, now).expired;
}
