import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/engagement/review_moments.dart';

void main() {
  test('native prompt waits for three completed journeys and fourteen days; cooldown survives restart', () async {
    final store = SettingsStore();
    var now = DateTime(2030);
    var nativeCalls = 0;
    Future<bool> request(RatePromptPolicy policy, DateTime at) async {
      if (!policy.shouldPrompt(at)) return false;
      nativeCalls++;
      return true;
    }
    var moments = ReviewMoments(store: store, now: () => now, request: request);
    expect(await moments.afterShopping(), isFalse);
    expect(await moments.afterShopping(), isFalse);
    expect(await moments.afterShopping(), isFalse);
    expect(nativeCalls, 0);
    now = now.add(const Duration(days: 14));
    expect(await moments.afterShopping(), isTrue);
    expect(nativeCalls, 1);
    moments = ReviewMoments(store: store, now: () => now, request: request);
    expect(await moments.afterShopping(), isFalse);
    expect(nativeCalls, 1);
    now = now.add(const Duration(days: 90));
    expect(await moments.afterShopping(), isTrue);
    expect(nativeCalls, 2);
    moments.manualRequest();
    now = now.add(const Duration(days: 100));
    moments = ReviewMoments(store: store, now: () => now, request: request);
    expect(await moments.afterShopping(), isFalse);
    expect(nativeCalls, 2);
  });

  test('review SDK failure never blocks shopping or causes repeated requests', () async {
    final store = SettingsStore();
    var now = DateTime(2030);
    var calls = 0;
    final moments = ReviewMoments(store: store, now: () => now, request: (policy, at) async {
      if (!policy.shouldPrompt(at)) return false;
      calls++;
      throw StateError('store_not_available');
    });
    await moments.afterShopping();
    await moments.afterShopping();
    now = now.add(const Duration(days: 15));
    expect(await moments.afterShopping(), isTrue);
    expect(await moments.afterShopping(), isFalse);
    expect(calls, 1);
  });

  test('invalid saved preferences do not break application boot', () {
    for (final data in ['{broken', '[99999999999999999,"bad",-1]', '{}']) {
      final store = SettingsStore()
        ..setString('review.prompts', data)
        ..setInt('review.first_seen', 99999999999999999)
        ..setInt('review.completed_shoppings', -1);
      expect(() => ReviewMoments(store: store), returnsNormally);
    }
  });
}
