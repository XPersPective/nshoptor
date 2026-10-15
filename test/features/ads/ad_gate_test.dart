import 'package:flutter_test/flutter_test.dart';
import 'package:napp_ads/napp_ads.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/ads/ad_gate.dart';

void main() {
  tearDown(() => AdGate.showInterstitial = null);

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

  test('ad policy dates survive a restart (napp_ads saves them as strings)', () {
    final store = _Memory();
    final first = DateTime(2026, 10, 1, 9);
    final policy = AdPolicy()..startSession(first);
    policy.recordRewarded(DateTime(2026, 10, 9, 12));
    AdPolicyPersistence.save(store, policy);
    // The package's own loader drops the dates: the bug this guards.
    expect(AdPolicyPersistence.load(store)!.firstLaunchAt, isNull);
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
  @override
  Map<String, Object> readAll() => Map.of(_values);
  @override
  Object? read(String key) => _values[key];
  @override
  Future<void> write(String key, Object value) async => _values[key] = value;
  @override
  Future<void> delete(String key) async => _values.remove(key);
}
