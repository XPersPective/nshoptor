import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
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

class _NativeAddition extends Fake implements InAppPurchaseAndroidPlatformAddition {
  List<GooglePlayPurchaseDetails> owned = [];
  final pending = <Completer<QueryPurchaseDetailsResponse>>[];
  @override
  Future<QueryPurchaseDetailsResponse> queryPastPurchases({String? applicationUserName}) async => pending.isNotEmpty ? pending.removeAt(0).future : QueryPurchaseDetailsResponse(pastPurchases: owned);
}

class _NativeStore extends Fake implements InAppPurchase {
  final addition = _NativeAddition();
  final events = StreamController<List<PurchaseDetails>>.broadcast();
  final buys = <GooglePlayPurchaseParam>[];
  bool available = true;
  Completer<bool>? launch;
  Completer<void>? restoring;
  var restores = 0;
  Set<String>? queried;
  List<ProductDetails> products = [];
  @override
  Future<bool> isAvailable() async => available;
  @override
  Stream<List<PurchaseDetails>> get purchaseStream => events.stream;
  @override
  dynamic noSuchMethod(Invocation invocation) => invocation.memberName == #getPlatformAddition ? addition : super.noSuchMethod(invocation);
  @override
  Future<bool> buyNonConsumable({required PurchaseParam purchaseParam}) {
    buys.add(purchaseParam as GooglePlayPurchaseParam); return launch?.future ?? Future.value(false);
  }
  @override
  Future<void> restorePurchases({String? applicationUserName}) async { restores++; await restoring?.future; }
  @override
  Future<void> completePurchase(PurchaseDetails purchase) async {}
  @override
  Future<ProductDetailsResponse> queryProductDetails(Set<String> identifiers) async {
    queried = identifiers; return ProductDetailsResponse(productDetails: products, notFoundIDs: identifiers.toList());
  }
}

GooglePlayPurchaseDetails _native(String id, String token) => GooglePlayPurchaseDetails(
  productID: id, verificationData: PurchaseVerificationData(localVerificationData: '', serverVerificationData: token, source: 'test'),
  transactionDate: '0', status: PurchaseStatus.purchased,
  billingClientPurchase: PurchaseWrapper(orderId: 'synthetic', packageName: 'com.crazypenguin.nshoptor',
    purchaseTime: 0, purchaseToken: token, signature: '', products: [id], isAutoRenewing: true,
    originalJson: '', isAcknowledged: true, purchaseState: PurchaseStateWrapper.purchased));
SubscriptionOffer _offer(String id) => SubscriptionOffer(productId: id, basePlanId: 'monthly', price: 'store-price',
  billingPeriod: 'P1M', hasTrial: false, details: ProductDetails(id: id, title: id, description: '', price: 'store-price', rawPrice: 1, currencyCode: 'USD'));

List<GooglePlayProductDetails> _products(String id) {
  PricingPhaseWrapper phase(String period, String price, int micros, RecurrenceMode recurrence) => PricingPhaseWrapper(
    billingCycleCount: recurrence == RecurrenceMode.infiniteRecurring ? 0 : 1, billingPeriod: period,
    formattedPrice: price, priceAmountMicros: micros, priceCurrencyCode: 'TRY', recurrenceMode: recurrence);
  return GooglePlayProductDetails.fromProductDetails(ProductDetailsWrapper(description: 'synthetic', name: 'Pro',
    title: 'Pro', productId: id, productType: ProductType.subs, subscriptionOfferDetails: [
      SubscriptionOfferDetailsWrapper(basePlanId: 'monthly', offerTags: [], offerIdToken: 'monthly-token',
        pricingPhases: [phase('P1M', '57,99 ₺', 57990000, RecurrenceMode.infiniteRecurring)]),
      SubscriptionOfferDetailsWrapper(basePlanId: 'monthly', offerId: 'trial7', offerTags: [], offerIdToken: 'trial-token',
        pricingPhases: [phase('P7D', '0 ₺', 0, RecurrenceMode.finiteRecurring), phase('P1M', '57,99 ₺', 57990000, RecurrenceMode.infiniteRecurring)]),
      SubscriptionOfferDetailsWrapper(basePlanId: 'yearly', offerTags: [], offerIdToken: 'yearly-token',
        pricingPhases: [phase('P1Y', '469,99 ₺', 469990000, RecurrenceMode.infiniteRecurring)]),
    ]));
}

StorePurchaseUpdate _update(String productId) => StorePurchaseUpdate(
      purchase: StorePurchase(productId: productId, status: StorePurchaseStatus.purchased),
      complete: () async {},
    );

void main() {
  test('legacy same-tier allowance wins in either order and only new IDs are offered', () async {
    final native = _NativeStore(); final service = SubscriptionService(store: SettingsStore(), iap: native);
    for (final pair in [
      (SubscriptionService.proId, SubscriptionService.legacyProId, 200),
      (SubscriptionService.maxId, SubscriptionService.legacyMaxId, 1000),
    ]) {
      final records = [(productId: pair.$1, token: 'new'), (productId: pair.$2, token: 'old')];
      for (final order in [records, records.reversed.toList()]) {
        service.applyOwned(order); expect(service.monthlyAllowance, pair.$3); expect(service.legacy, isTrue);
      }
    }
    expect(SubscriptionService.allowanceOf(SubscriptionService.proId), 100);
    expect(SubscriptionService.allowanceOf(SubscriptionService.maxId), 300);
    expect(SubscriptionService.allowanceOf(null), 10);
    await service.loadOffers(); expect(native.queried, SubscriptionService.offerIds);
    final loaded = SubscriptionService(store: SettingsStore()..setString('sub_product', SubscriptionService.legacyProId)..setString('sub_token', 'old'))..load();
    expect(loaded.monthlyAllowance, 200); expect(loaded.credential!.productId, SubscriptionService.legacyProId);
    service.applyOwned([(productId: SubscriptionService.maxId, token: '')]); expect(service.credential, isNull);
    service.dispose(); loaded.dispose(); await native.events.close();
  });

  test('native highest owner is used for replacement; duplicate, failed launch and retry safe', () async {
    final native = _NativeStore(); final service = SubscriptionService(store: SettingsStore(), iap: native);
    native.addition.owned = [_native(SubscriptionService.legacyProId, 'pro-token'), _native(SubscriptionService.legacyMaxId, 'max-token')];
    native.launch = Completer<bool>();
    final first = service.buy(_offer(SubscriptionService.proId));
    await Future<void>.delayed(Duration.zero);
    await service.buy(_offer(SubscriptionService.maxId)); expect(native.buys, hasLength(1));
    expect(native.buys.single.changeSubscriptionParam!.oldPurchaseDetails.productID, SubscriptionService.legacyMaxId);
    expect(native.buys.single.changeSubscriptionParam!.oldPurchaseDetails.verificationData.serverVerificationData, 'max-token');
    native.launch!.complete(false); await first;
    expect(service.busy, isFalse); expect(service.lastError, isNotNull);
    native.available = false; await service.buy(_offer(SubscriptionService.proId));
    expect(native.buys, hasLength(1)); expect(service.tier, Tier.max);
    native.available = true; native.launch = Completer<bool>();
    final retry = service.buy(_offer(SubscriptionService.proId)); await Future<void>.delayed(Duration.zero);
    expect(native.buys, hasLength(2)); native.launch!.complete(false); await retry;
    service.dispose(); await native.events.close();
  });

  test('restore repeat and failure keep cached rights and allow retry', () async {
    final native = _NativeStore(); final service = SubscriptionService(store: SettingsStore(), iap: native)
      ..applyOwned([(productId: SubscriptionService.legacyProId, token: 'old')]);
    native.restoring = Completer<void>(); final first = service.restore();
    await service.restore(); expect(native.restores, 1);
    native.restoring!.completeError(StateError('store unavailable')); await first;
    expect(service.busy, isFalse); expect(service.monthlyAllowance, 200); expect(service.lastError, isNotNull);
    native.restoring = null; native.addition.owned = [_native(SubscriptionService.proId, 'new')];
    await service.restore(); expect(service.monthlyAllowance, 100); expect(service.lastError, isNull);
    service.dispose(); await native.events.close();
  });

  test('late native queries cannot replace newer owner or mutate disposed cache', () async {
    final native = _NativeStore(), store = SettingsStore();
    final service = SubscriptionService(store: store, iap: native);
    final old = Completer<QueryPurchaseDetailsResponse>(), newer = Completer<QueryPurchaseDetailsResponse>();
    native.addition.pending.addAll([old, newer]);
    final first = service.refresh(); await Future<void>.delayed(Duration.zero);
    final second = service.refresh(); await Future<void>.delayed(Duration.zero);
    newer.complete(QueryPurchaseDetailsResponse(pastPurchases: [_native(SubscriptionService.maxId, 'new')])); await second;
    old.complete(QueryPurchaseDetailsResponse(pastPurchases: [_native(SubscriptionService.legacyProId, 'old')])); await first;
    expect(service.productId, SubscriptionService.maxId);
    final late = Completer<QueryPurchaseDetailsResponse>(); native.addition.pending.add(late);
    final loading = service.refresh(); await Future<void>.delayed(Duration.zero); service.dispose();
    late.complete(QueryPurchaseDetailsResponse(pastPurchases: [])); await loading;
    expect(store.getString('sub_product'), SubscriptionService.maxId);
    await native.events.close();
  });

  test('monthly trial uses recurring native price; annual same quota and old offers filtered', () async {
    final native = _NativeStore()..products = [..._products(SubscriptionService.proId), ..._products(SubscriptionService.legacyProId)];
    final service = SubscriptionService(store: SettingsStore(), iap: native);
    final offers = await service.loadOffers(); expect(offers, hasLength(2));
    final month = offers.singleWhere((o) => !o.yearly), year = offers.singleWhere((o) => o.yearly);
    expect(month.price, '57,99 ₺'); expect(month.hasTrial, isTrue); expect(month.billingPeriod, 'P1M');
    expect(year.price, '469,99 ₺'); expect(year.hasTrial, isFalse);
    expect(SubscriptionService.allowanceOf(month.productId), SubscriptionService.allowanceOf(year.productId));
    service.dispose(); await native.events.close();
  });

  test('launched purchase stays busy until cancellation event; late refresh after dispose safe', () async {
    final native = _NativeStore(), service = SubscriptionService(store: SettingsStore());
    service.dispose(); await service.refresh(); // no disposal notification
    final s = SubscriptionService(store: SettingsStore(), iap: native)..start();
    await Future<void>.delayed(Duration.zero);
    native.launch = Completer<bool>(); final launch = s.buy(_offer(SubscriptionService.proId));
    await Future<void>.delayed(Duration.zero); native.launch!.complete(true); await launch;
    expect(s.busy, isTrue); await s.restore(); expect(native.restores, 0);
    final cancel = _native(SubscriptionService.proId, 'synthetic')..status = PurchaseStatus.canceled;
    native.events.add([cancel]); await Future<void>.delayed(Duration.zero); expect(s.busy, isFalse);
    s.dispose(); await native.events.close();
  });

  testWidgets('legacy note, period and retry controls fit320dp2x Arabic', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640)); addTearDown(() => tester.binding.setSurfaceSize(null));
    final service = _NoStoreService(SettingsStore())..applyOwned([(productId: SubscriptionService.legacyProId, token: 'old')]);
    await tester.pumpWidget(MaterialApp(locale: const Locale('ar'), supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(2)), child: child!),
      home: SubscriptionPaywall(service: service)));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.textContaining('Pro: 200'), 200);
    await tester.pumpAndSettle(); expect(find.textContaining('Pro: 200'), findsOneWidget);
    final l10n = AppLocalizations.of(tester.element(find.byType(SubscriptionPaywall)));
    await tester.scrollUntilVisible(find.text(l10n.plansYearly), 200); await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.plansYearly)); await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.byKey(const Key('plan_max')), 400); await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.scrollUntilVisible(find.byKey(const Key('plans_restore')), 400); await tester.pumpAndSettle();
    expect(tester.takeException(), isNull); await tester.pumpWidget(const SizedBox.shrink()); service.dispose();
  });

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
    expect(s.monthlyAllowance, 10);
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
