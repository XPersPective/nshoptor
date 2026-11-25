import 'package:napp_core/napp_core.dart';

import '../ads/ad_gate.dart';

/// Promotional access has no product ID and never manufactures a purchase.
/// The original ad grace anchor also protects upgrades from a fresh trial.
class InstallationTrial {
  InstallationTrial(this.store, {DateTime Function()? now})
    : _now = now ?? DateTime.now {
    AdGate.firstOpen(store, _now());
  }

  static const _endKey = 'install_trial_server_end';
  static const _localEndKey = 'install_trial_local_end';
  static const _expiredKey = 'install_trial_expired';
  static const noticeKey = 'install_trial_expiry_notice_seen';
  final SettingsStore store;
  final DateTime Function() _now;

  int get firstOpenedAt =>
      AdGate.firstOpen(store, _now()).millisecondsSinceEpoch;

  Duration get remaining {
    if (store.getBool(_expiredKey) == true) return Duration.zero;
    final now = _now();
    var left = AdGate.graceRemaining(store, now);
    // Compare deadlines in the same clock domain. The raw server timestamp is
    // metadata; only its remaining duration translated by observeServer can be
    // compared with the device's observed time.
    final localEnd = store.getInt(_localEndKey);
    if (localEnd != null) {
      final originalEnd = AdGate.firstOpen(
        store,
        now,
      ).add(const Duration(days: AdGate.graceDays));
      final observed = originalEnd.subtract(left);
      final serverLeft = Duration(
        milliseconds: localEnd - observed.millisecondsSinceEpoch,
      );
      if (serverLeft < left) left = serverLeft;
    }
    if (left <= Duration.zero) {
      store.setBool(_expiredKey, true);
      return Duration.zero;
    }
    return left;
  }

  bool get active => remaining > Duration.zero;

  void observeServer({required int endsAt, required int serverNow}) {
    final old = store.getInt(_endKey);
    if (old == null || endsAt < old) store.setInt(_endKey, endsAt);
    // Translate authoritative remaining duration onto the local clock. Keeping
    // only an absolute server deadline overstates access on a slow device clock.
    final deviceNow = _now();
    final graceLeft = AdGate.graceRemaining(store, deviceNow);
    final observedAt = AdGate.firstOpen(
      store,
      deviceNow,
    ).add(const Duration(days: AdGate.graceDays)).subtract(graceLeft);
    // A corrected clock can be behind the durable device high-water mark.
    // Repeated registration must use that same mark, as remaining does.
    final anchoredEnd =
        observedAt.millisecondsSinceEpoch + (endsAt - serverNow);
    final oldLocal = store.getInt(_localEndKey);
    if (oldLocal == null || anchoredEnd < oldLocal) {
      store.setInt(_localEndKey, anchoredEnd);
    }
    if (serverNow >= endsAt) store.setBool(_expiredKey, true);
  }

  bool get needsExpiryNotice => !active && store.getBool(noticeKey) != true;
  void acknowledgeExpiry() => store.setBool(noticeKey, true);
}
