import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:napp_ads/napp_ads.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/ads/ad_gate.dart';

void main() {
  tearDown(() => AdGate.showInterstitial = null);

  test('fresh installation keeps the complete seven-day grace including its boundary', () {
    final store = SettingsStore();
    final first = DateTime.utc(2026, 10, 1, 9);
    expect(AdGate.inGrace(store, first), isTrue);
    expect(AdGate.inGrace(store, first.add(const Duration(days: 7)).subtract(const Duration(milliseconds: 1))), isTrue);
    expect(AdGate.inGrace(store, first.add(const Duration(days: 7))), isFalse);
  });

  test('expired grace stays expired after rollback and persisted restart', () async {
    final adapter = _Memory();
    final store = SettingsStore(adapter: adapter);
    final first = DateTime.utc(2026, 10, 1);
    expect(AdGate.inGrace(store, first), isTrue);
    expect(AdGate.inGrace(store, first.add(const Duration(days: 8))), isFalse);
    await store.flush();
    final restarted = SettingsStore(adapter: adapter);
    expect(AdGate.inGrace(restarted, first.add(const Duration(days: 1))), isFalse);
    expect(AdGate.firstOpen(restarted, first), first);
    await restarted.flush();
  });

  test('clock correction during grace does not move its original start', () {
    final store = SettingsStore();
    final first = DateTime.utc(2026, 10, 1);
    AdGate.inGrace(store, first);
    expect(AdGate.inGrace(store, first.add(const Duration(days: 5))), isTrue);
    expect(AdGate.inGrace(store, first.add(const Duration(days: 2))), isTrue);
    expect(AdGate.firstOpen(store, first), first);
    expect(AdGate.inGrace(store, first.add(const Duration(days: 7))), isFalse);
  });

  test('isolated future first-open cannot postpone grace expiry until year2099', () {
    final now = DateTime.utc(2026, 10, 24);
    final store = SettingsStore()..setInt(AdGate.firstOpenKey,
      DateTime.utc(2099).millisecondsSinceEpoch);
    expect(AdGate.inGrace(store, now), isFalse);
    expect(AdGate.inGrace(store, now.subtract(const Duration(days: 1))), isFalse);
  });

  test('matching surviving grace record retains remaining days after clock rollback before first-open', () {
    final first = DateTime.utc(2026, 10, 24);
    final store = SettingsStore();
    expect(AdGate.inGrace(store, first), isTrue);
    expect(AdGate.inGrace(store, first.subtract(const Duration(days: 2))), isTrue);
    expect(AdGate.firstOpen(store, first.subtract(const Duration(days: 2))), first);
    expect(AdGate.inGrace(store, first.add(const Duration(days: 7))), isFalse);
  });

  test('frequent policy checks throttle disk observations but expiry latches immediately', () async {
    final first = DateTime.utc(2026, 10, 1);
    final adapter = _Memory();
    final store = SettingsStore(adapter: adapter);
    AdGate.inGrace(store, first);
    await store.flush();
    adapter.writeKeys.clear();
    for (var second = 1; second < 60; second++) {
      expect(AdGate.inGrace(store, first.add(Duration(seconds: second))), isTrue);
    }
    await store.flush();
    expect(adapter.writeKeys, isEmpty);
    expect(AdGate.inGrace(store, first.add(const Duration(minutes: 1))), isTrue);
    await store.flush();
    expect(adapter.writeKeys, [AdGate.graceStateKey]);
    adapter.writeKeys.clear();
    final justBeforeExpiry = first.add(const Duration(days: 7)).subtract(const Duration(seconds: 1));
    expect(AdGate.inGrace(store, justBeforeExpiry), isTrue);
    await store.flush();
    adapter.writeKeys.clear();
    // Expiry occurs one second after a persisted observation, not a minute.
    expect(AdGate.inGrace(store, first.add(const Duration(days: 7))), isFalse);
    await store.flush();
    expect(adapter.writeKeys, [AdGate.graceStateKey]);
    adapter.writeKeys.clear();
    expect(AdGate.inGrace(store, first.add(const Duration(days: 8))), isFalse);
    expect(AdGate.inGrace(store, first.add(const Duration(days: 1))), isFalse);
    await store.flush();
    expect(adapter.writeKeys, isEmpty);
  });

  test('surviving ad-policy timestamp recovers missing legacy first-open key', () {
    final store = SettingsStore();
    final first = DateTime.utc(2026, 10, 1);
    store.setString('napp_ads.policy_state', jsonEncode({
      'firstLaunchAt': first.millisecondsSinceEpoch.toString(), 'sessionCount': 6,
    }));
    expect(AdGate.inGrace(store, first.add(const Duration(days: 9))), isFalse);
    expect(AdGate.firstOpen(store, first.add(const Duration(days: 9))), first);
  });

  test('lost or edited first-open key cannot reset surviving grace state', () {
    final first = DateTime.utc(2026, 10, 1);
    final store = SettingsStore();
    AdGate.inGrace(store, first);
    store.remove(AdGate.firstOpenKey);
    expect(AdGate.firstOpen(store, first.add(const Duration(days: 5))), first);
    store.setInt(AdGate.firstOpenKey, first.add(const Duration(days: 100)).millisecondsSinceEpoch);
    expect(AdGate.inGrace(store, first.add(const Duration(days: 8))), isFalse);
    expect(AdGate.firstOpen(store, first.add(const Duration(days: 8))), first);
  });

  for (final damaged in ['broken', '99999999999999999999999999', 9223372036854775807, -9223372036854775808]) {
    test('damaged first-open $damaged does not crash or award a fresh grace', () async {
      final adapter = _Memory().._values[AdGate.firstOpenKey] = damaged;
      final store = SettingsStore(adapter: adapter);
      expect(AdGate.inGrace(store, DateTime.utc(2026, 10, 24)), isFalse);
      await store.flush();
    });
  }

  test('malformed grace state recovers from valid first-open rather than discarding remaining days', () {
    final first = DateTime.utc(2026, 10, 1);
    final store = SettingsStore();
    store.setInt(AdGate.firstOpenKey, first.millisecondsSinceEpoch);
    store.setString(AdGate.graceStateKey, '{broken');
    expect(AdGate.inGrace(store, first.add(const Duration(days: 2))), isTrue);
    expect(AdGate.inGrace(store, first.add(const Duration(days: 7))), isFalse);
  });

  test('all local state erased remains indistinguishable from a genuinely new install', () {
    // Deliberately document the remaining R66 boundary. This local fix cannot
    // authenticate reinstall eligibility without surviving platform/server state.
    final original = SettingsStore();
    final first = DateTime.utc(2026, 10, 1);
    AdGate.inGrace(original, first);
    expect(AdGate.inGrace(original, first.add(const Duration(days: 8))), isFalse);
    expect(AdGate.inGrace(SettingsStore(), first.add(const Duration(days: 9))), isTrue);
  });

  test('out-of-range saved policy timestamps are rejected without startup exceptions', () {
    final adapter = _Memory().._values['napp_ads.policy_state'] = jsonEncode({
      'firstLaunchAt': 9223372036854775807, 'sessionCount': 6,
      'lastFullscreenAt': '-9223372036854775808',
    });
    final snapshot = AdGate.loadPolicy(adapter)!;
    expect(snapshot.firstLaunchAt, isNull);
    expect(snapshot.lastFullscreenAt, isNull);
    expect(snapshot.sessionCount, 6);
  });

  test('no interstitial wiring is a no-op', () async {
    AdGate.showInterstitial = null;
    await AdGate.maybeShowInterstitial();
  });

  test('natural stop calls the wired interstitial; its failure is swallowed', () async {
    var calls = 0;
    AdGate.showInterstitial = () async {
      calls++;
      throw StateError('ad failed');
    };
    await AdGate.maybeShowInterstitial();
    expect(calls, 1);
  });

  test('ad policy dates survive a restart, old string and new int formats', () async {
    final store = _Memory();
    final first = DateTime(2026, 10, 1, 9);
    final policy = AdPolicy()..startSession(first);
    policy.recordRewarded(DateTime(2026, 10, 9, 12));
    await AdPolicyPersistence.save(store, policy); // ads-v1.0.1: int dates
    expect(AdGate.loadPolicy(store)!.firstLaunchAt, first);
    // ads-v1.0.0 wrote string dates; devices updated from it still load them.
    store._values['napp_ads.policy_state'] = (store.read('napp_ads.policy_state') as String)
        .replaceAllMapped(RegExp(r'":(\d{10,})'), (m) => '":"${m[1]}"');
    expect(store.read('napp_ads.policy_state'), contains('"firstLaunchAt":"'));
    final loaded = AdGate.loadPolicy(store)!;
    expect(loaded.firstLaunchAt, first);
    expect(loaded.sessionCount, 1);
    final restored = AdPolicy()
      ..restore(loaded)
      ..setSdkReady(true);
    // Day 9 already rewarded; day 10 may reward again.
    expect(restored.canShowRewarded(DateTime(2026, 10, 9, 18)), isFalse);
    expect(restored.canShowRewarded(DateTime(2026, 10, 10, 8)), isTrue);
  });
}

class _Memory implements PreferenceAdapter {
  final _values = <String, Object>{};
  final writeKeys = <String>[];
  @override
  Map<String, Object> readAll() => Map.of(_values);
  @override
  Object? read(String key) => _values[key];
  @override
  Future<void> write(String key, Object value) async {
    writeKeys.add(key);
    _values[key] = value;
  }
  @override
  Future<void> delete(String key) async => _values.remove(key);
}
