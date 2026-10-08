import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/subscription/lifetime_only_adapter.dart';
import 'package:nshoptor/features/subscription/subscription_paywall.dart';
import 'package:nshoptor/features/subscription/subscription_service.dart';

class _FakeAdapter implements StoreAdapter {
  final controller = StreamController<List<StorePurchaseUpdate>>.broadcast();
  @override
  Stream<List<StorePurchaseUpdate>> get updates => controller.stream;
  @override
  Future<List<StoreProduct>> queryProducts(Set<String> productIds) async => const [];
  @override
  Future<void> buy(StoreProduct product) async {}
  @override
  Future<void> restore() async {}
}

class _NoStoreService extends SubscriptionService {
  _NoStoreService(SettingsStore store) : super(store: store);
  @override
  Future<List<SubscriptionOffer>> loadOffers() async => const [];
}

StorePurchaseUpdate _update(String productId) => StorePurchaseUpdate(
      purchase: StorePurchase(productId: productId, status: StorePurchaseStatus.purchased),
      complete: () async {},
    );

void main() {
  test('max, pro\'dan önce gelir; hiçbiri yoksa ücretsiz; kalıcı saklanır', () {
    final store = SettingsStore();
    final s = SubscriptionService(store: store)
      ..applyOwned([
        (productId: SubscriptionService.proId, token: 'p' * 30),
        (productId: SubscriptionService.maxId, token: 'm' * 30),
      ]);
    expect(s.tier, Tier.max);
    expect(s.credential?.productId, SubscriptionService.maxId);
    final reloaded = SubscriptionService(store: store)..load();
    expect(reloaded.tier, Tier.max);
    s.applyOwned(const []);
    expect(s.tier, Tier.free);
    expect(s.credential, isNull);
    expect((SubscriptionService(store: store)..load()).tier, Tier.free);
  });

  test('ömür boyu + ücretsiz = reklamsız ama AI ücretsiz (jeton yok)', () {
    final s = SubscriptionService(store: SettingsStore());
    expect(SubscriptionService.adFree(lifetimeOrTemp: true, tier: s.tier), isTrue);
    expect(s.credential, isNull);
    expect(SubscriptionService.adFree(lifetimeOrTemp: false, tier: Tier.free), isFalse);
    expect(SubscriptionService.adFree(lifetimeOrTemp: false, tier: Tier.pro), isTrue);
  });

  test('abonelik olayı ömür boyu Pro yapmaz (akış süzülür)', () async {
    final inner = _FakeAdapter();
    final adapter = LifetimeOnlyAdapter(inner, productId: 'lifetime');
    final seen = <String>[];
    final sub = adapter.updates.listen((l) => seen.addAll(l.map((u) => u.purchase.productId)));
    inner.controller.add([_update(SubscriptionService.proId)]);
    inner.controller.add([_update('lifetime'), _update(SubscriptionService.maxId)]);
    await Future<void>.delayed(Duration.zero);
    expect(seen, ['lifetime']);
    await sub.cancel();
  });

  testWidgets('paywall: ücretsiz mevcut, mağaza yoksa bilgi, geri yükleme ve yasal metin', (tester) async {
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('tr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: SubscriptionPaywall(service: _NoStoreService(SettingsStore())),
    ));
    await tester.pumpAndSettle();
    expect(find.descendant(of: find.byKey(const Key('plan_free')), matching: find.text('Mevcut')), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Mağazaya şu an ulaşılamıyor.'), 200);
    expect(find.text('Mağazaya şu an ulaşılamıyor.'), findsOneWidget);
    await tester.scrollUntilVisible(find.byKey(const Key('plans_restore')), 200);
    expect(find.byKey(const Key('plans_restore')), findsOneWidget);
    expect(find.textContaining('otomatik yenilenir'), findsOneWidget);
  });
}
