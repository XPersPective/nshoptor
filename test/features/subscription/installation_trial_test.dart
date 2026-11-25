import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/subscription/subscription_service.dart';

void main() {
  test('a fresh install receives seven days of local Pro access without a purchase', () {
    final store = SettingsStore();
    final now = DateTime.utc(2026, 10, 25, 12);
    final service = SubscriptionService(store: store)
      ..initializeTrial(now: () => now);
    addTearDown(service.dispose);

    expect(service.storeTier, Tier.free);
    expect(service.tier, Tier.pro);
    expect(service.trialRemaining, const Duration(days: 7));
    expect(service.monthlyAllowance, 100);
    expect(service.productId, isNull);
    expect(service.credential, isNull);
  });

  test('existing AdGate first-open anchor prevents a fresh trial week', () {
    final store = SettingsStore();
    final opened = DateTime.utc(2026, 10, 1);
    store.setInt('first_open_at', opened.millisecondsSinceEpoch);
    final now = opened.add(const Duration(days: 8));
    final service = SubscriptionService(store: store)
      ..initializeTrial(now: () => now);
    addTearDown(service.dispose);

    expect(service.storeTier, Tier.free);
    expect(service.promotionalTrial, isFalse);
    expect(service.trialRemaining, Duration.zero);
  });

  test('expiry survives clock rollback and a new service instance', () {
    final store = SettingsStore();
    final start = DateTime.utc(2026, 10, 1);
    var now = start;
    final service = SubscriptionService(store: store)
      ..initializeTrial(now: () => now);
    now = start.add(const Duration(days: 7));
    expect(service.trialRemaining, Duration.zero);
    expect(service.needsTrialExpiryNotice, isTrue);
    service.acknowledgeTrialExpiry();
    service.dispose();

    now = start.add(const Duration(days: 2));
    final reloaded = SubscriptionService(store: store)
      ..initializeTrial(now: () => now);
    addTearDown(reloaded.dispose);
    expect(reloaded.trialRemaining, Duration.zero);
    expect(reloaded.tier, Tier.free);
    expect(reloaded.needsTrialExpiryNotice, isFalse);
  });

  test(
    'server expiry can shorten but never extend the installation window',
    () {
      final store = SettingsStore();
      final start = DateTime.utc(2026, 10, 1);
      var now = start;
      final service = SubscriptionService(store: store)
        ..initializeTrial(now: () => now);
      addTearDown(service.dispose);

      final shortenedEnd = start.add(const Duration(days: 2));
      service.observeTrialServer(
        endsAt: shortenedEnd.millisecondsSinceEpoch,
        serverNow: start.millisecondsSinceEpoch,
      );
      now = start.add(const Duration(days: 3));
      expect(service.trialRemaining, Duration.zero);

      service.observeTrialServer(
        endsAt: start.add(const Duration(days: 30)).millisecondsSinceEpoch,
        serverNow: now.millisecondsSinceEpoch,
      );
      now = start.add(const Duration(days: 1));
      expect(service.trialRemaining, Duration.zero);
    },
  );

  test(
    'server remaining duration bounds a slow device clock across reload',
    () {
      final store = SettingsStore();
      final start = DateTime.utc(2026, 10, 1);
      var now = start;
      final service = SubscriptionService(store: store)
        ..initializeTrial(now: () => now);
      service.observeTrialServer(
        endsAt: start.add(const Duration(days: 7)).millisecondsSinceEpoch,
        serverNow: start.add(const Duration(days: 6)).millisecondsSinceEpoch,
      );
      expect(service.trialRemaining, const Duration(days: 1));
      service.dispose();
      final reloaded = SubscriptionService(store: store)
        ..initializeTrial(now: () => now);
      addTearDown(reloaded.dispose);
      expect(reloaded.trialRemaining, const Duration(days: 1));
      now = start.add(const Duration(days: 1));
      expect(reloaded.tier, Tier.free);
      now = start;
      expect(reloaded.tier, Tier.free);
    },
  );

  test(
    'fast device clock does not expire a fresh server trial on registration',
    () {
      final store = SettingsStore();
      final serverNow = DateTime.utc(2026, 10, 1);
      var deviceNow = serverNow.add(const Duration(days: 8));
      final service = SubscriptionService(store: store)
        ..initializeTrial(now: () => deviceNow);
      service.observeTrialServer(
        endsAt: serverNow.add(const Duration(days: 7)).millisecondsSinceEpoch,
        serverNow: serverNow.millisecondsSinceEpoch,
      );
      expect(service.trialRemaining, const Duration(days: 7));
      expect(service.promotionalTrial, isTrue);
      service.dispose();

      deviceNow = serverNow;
      final reloaded = SubscriptionService(store: store)
        ..initializeTrial(now: () => deviceNow);
      addTearDown(reloaded.dispose);
      expect(reloaded.trialRemaining, const Duration(days: 7));
      expect(reloaded.promotionalTrial, isTrue);

      // Registration on a new app launch observes another active server window.
      // The corrected raw clock is behind the persisted device observation.
      reloaded.observeTrialServer(
        endsAt: serverNow.add(const Duration(days: 7)).millisecondsSinceEpoch,
        serverNow: serverNow
            .add(const Duration(days: 1))
            .millisecondsSinceEpoch,
      );
      expect(reloaded.trialRemaining, const Duration(days: 6));
      expect(reloaded.promotionalTrial, isTrue);

      // A corrected device clock must not override actual server expiry.
      reloaded.observeTrialServer(
        endsAt: serverNow.add(const Duration(days: 7)).millisecondsSinceEpoch,
        serverNow: serverNow
            .add(const Duration(days: 7))
            .millisecondsSinceEpoch,
      );
      expect(reloaded.trialRemaining, Duration.zero);
      deviceNow = serverNow.subtract(const Duration(days: 1));
      expect(reloaded.promotionalTrial, isFalse);
    },
  );

  test('paid and legacy entitlements keep their allowance and credential', () {
    final store = SettingsStore()
      ..setString('sub_product', SubscriptionService.legacyMaxId)
      ..setString('sub_token', 'play-token');
    final service = SubscriptionService(store: store)..load();
    addTearDown(service.dispose);

    expect(service.storeTier, Tier.max);
    expect(service.tier, Tier.max);
    expect(service.monthlyAllowance, 1000);
    expect(service.credential, (
      token: 'play-token',
      productId: SubscriptionService.legacyMaxId,
    ));

    service.initializeTrial(now: () => DateTime.utc(2026, 10, 25));
    expect(service.storeTier, Tier.max);
    expect(service.promotionalTrial, isFalse);
    expect(service.monthlyAllowance, 1000);
    expect(service.credential?.token, 'play-token');
  });

  test(
    'a subsecond last refresh still notifies when trial actually expires',
    () {
      final start = DateTime.utc(2026, 10, 1);
      var now = start;
      final service = SubscriptionService(store: SettingsStore())
        ..initializeTrial(now: () => now);
      addTearDown(service.dispose);
      var changes = 0;
      service.addListener(() => changes++);
      now = start
          .add(const Duration(days: 7))
          .subtract(const Duration(milliseconds: 500));
      service.refreshTrial();
      expect(service.tier, Tier.pro);
      expect(changes, 1);
      now = now.add(const Duration(milliseconds: 500));
      service.refreshTrial();
      expect(service.tier, Tier.free);
      expect(changes, 2);
    },
  );
}
