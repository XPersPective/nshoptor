import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_2_wrappers.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/subscription/apple_subscription_store.dart';
import 'package:nshoptor/features/subscription/subscription_service.dart';

class _AppleStore extends AppleSubscriptionStore {
  List<AppleSubscription> owned = [];
  bool fail = false;
  int calls = 0;
  final pending = <Completer<List<AppleSubscription>>>[];
  final recovered = <List<AppleSubscription>>[];
  void Function(List<AppleSubscription>)? onRecovery;
  bool failRecovery = false;
  @override
  Future<void> finishDeliveredTransactions(
    List<AppleSubscription> delivered,
  ) async {
    if (delivered.isEmpty) return;
    onRecovery?.call(delivered);
    if (failRecovery) throw StateError('recovery_failed');
    recovered.add(delivered);
  }

  Set<String> eligible = {SubscriptionService.proId};
  @override
  Future<Set<String>> eligibleAnnualProductIds(Set<String> ids) async {
    if (fail) throw StateError('offline');
    return eligible.intersection(ids);
  }

  @override
  Future<List<AppleSubscription>> currentEntitlements() async {
    calls++;
    if (fail) throw StateError('offline');
    if (pending.isNotEmpty) return pending.removeAt(0).future;
    return owned;
  }
}

class _Iap extends Fake implements InAppPurchase {
  final events = StreamController<List<PurchaseDetails>>.broadcast();
  List<ProductDetails> products = [];
  final buys = <PurchaseParam>[];
  final completed = <PurchaseDetails>[];
  void Function()? onComplete;
  int restores = 0;
  @override
  Stream<List<PurchaseDetails>> get purchaseStream => events.stream;
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<ProductDetailsResponse> queryProductDetails(
    Set<String> identifiers,
  ) async => ProductDetailsResponse(productDetails: products, notFoundIDs: []);
  @override
  Future<bool> buyNonConsumable({required PurchaseParam purchaseParam}) async {
    buys.add(purchaseParam);
    return true;
  }

  @override
  Future<void> completePurchase(PurchaseDetails purchase) async {
    onComplete?.call();
    completed.add(purchase);
  }

  @override
  Future<void> restorePurchases({String? applicationUserName}) async {
    restores++;
  }
}

AppStoreProduct2Details _product({
  String id = SubscriptionService.proId,
  SK2SubscriptionPeriodUnit unit = SK2SubscriptionPeriodUnit.year,
  int value = 1,
  SK2ProductType type = SK2ProductType.autoRenewable,
}) => AppStoreProduct2Details.fromSK2Product(
  SK2Product(
    id: id,
    displayName: 'Pro',
    displayPrice: r'$1.00',
    description: 'Annual',
    price: 1,
    type: type,
    priceLocale: SK2PriceLocale(currencyCode: 'USD', currencySymbol: r'$'),
    subscription: SK2SubscriptionInfo(
      subscriptionGroupID: 'test',
      promotionalOffers: [],
      subscriptionPeriod: SK2SubscriptionPeriod(value: value, unit: unit),
    ),
  ),
);

AppleSubscription _owned({
  String id = SubscriptionService.proId,
  bool expired = false,
}) => AppleSubscription(
  productId: id,
  originalTransactionId: '123',
  signedTransaction: 'header.payload.signature',
  expiresAt: DateTime.now().add(Duration(days: expired ? -1 : 2)),
);

SK2PurchaseDetails _purchase({
  PurchaseStatus status = PurchaseStatus.purchased,
}) => SK2PurchaseDetails(
  productID: SubscriptionService.proId,
  purchaseID: '1',
  verificationData: PurchaseVerificationData(
    localVerificationData: '',
    serverVerificationData: 'untrusted.stream.payload',
    source: 'app_store',
  ),
  transactionDate: '0',
  status: status,
);

Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('native boundary accepts only verified non-revoked compact signed transactions', () async {
    final map = <String, Object>{
      'verified': true,
      'revoked': false,
      'productId': SubscriptionService.proId,
      'originalTransactionId': '123',
      'signedTransaction': 'abc.def.ghi',
      'expiresAt': DateTime.now()
          .add(const Duration(days: 1))
          .millisecondsSinceEpoch,
    };
    expect(AppleSubscription.fromNative(map)?.signedTransaction, 'abc.def.ghi');
    for (final change in [
      {'verified': false},
      {'revoked': true},
      {'signedTransaction': 'base64-app-receipt'},
      {'signedTransaction': 'a.b.'},
      {'expiresAt': 'tomorrow'},
      {'expiresAt': 8640000000000001},
      {'expiresAt': -1},
      {'originalTransactionId': 'unverified-lineage'},
      {'signedTransaction': 'a.${'b' * 8192}.c'},
    ]) {
      expect(AppleSubscription.fromNative({...map, ...change}), isNull);
    }
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(AppleSubscriptionStore.channel, (
      call,
    ) async {
      expect(call.method, 'currentEntitlements');
      return [
        map,
        {...map, 'revoked': true},
      ];
    });
    addTearDown(
      () => messenger.setMockMethodCallHandler(
        AppleSubscriptionStore.channel,
        null,
      ),
    );
    expect(
      await const AppleSubscriptionStore().currentEntitlements(),
      hasLength(1),
    );
  });

  test(
    'only native StoreKit annual Pro auto-renewable product is offered',
    () async {
      final iap = _Iap()
        ..products = [
          _product(),
          _product(unit: SK2SubscriptionPeriodUnit.month),
          _product(value: 2),
          _product(id: SubscriptionService.maxId),
          _product(type: SK2ProductType.nonConsumable),
        ];
      final service = SubscriptionService(
        store: SettingsStore(),
        iap: iap,
        applePlatform: true,
        appleStore: _AppleStore(),
      );
      addTearDown(service.dispose);
      final offers = await service.loadOffers();
      expect(offers, hasLength(1));
      expect(offers.single.billingPeriod, 'P1Y');
      expect(offers.single.price, r'$1.00');
      await service.buy(offers.single);
      expect(iap.buys.single.productDetails, same(offers.single.details));
    },
  );

  test('Apple reload cannot adopt a persisted Play token; only current native ownership grants access', () async {
    final store = SettingsStore()
      ..setString('sub_product', SubscriptionService.maxId)
      ..setString('sub_token', 'play-token');
    final apple = _AppleStore();
    final service = SubscriptionService(
      store: store,
      iap: _Iap(),
      applePlatform: true,
      appleStore: apple,
    )..load();
    addTearDown(service.dispose);
    expect(service.storeTier, Tier.free);
    expect(service.credential, isNull);
    apple.owned = [_owned()];
    await service.refresh();
    expect(service.storeTier, Tier.pro);
    expect(service.appleTransaction, 'header.payload.signature');
    expect(service.credential, isNull);
    expect(store.getString('sub_token'), 'play-token');
    apple.owned = [_owned(expired: true)];
    await service.refresh();
    expect(service.storeTier, Tier.free);
    expect(service.appleTransaction, isNull);
    expect(service.monthlyAllowance, 10);
    apple.owned = []; // Refund/revocation is absent from current entitlements.
    await service.refresh();
    expect(service.productId, isNull);
  });

  test('purchase callback delivers verified ownership before finish and never trusts stream JWS', () async {
    final apple = _AppleStore();
    final iap = _Iap();
    final service = SubscriptionService(
      store: SettingsStore(),
      iap: iap,
      applePlatform: true,
      appleStore: apple,
    )..start();
    addTearDown(service.dispose);
    addTearDown(iap.events.close);
    await _settle();
    iap.events.add([_purchase()]);
    await _settle();
    expect(iap.completed, isEmpty);
    expect(service.appleTransaction, isNull);
    apple.owned = [_owned()];
    iap.onComplete = () {
      expect(service.storeTier, Tier.pro);
      expect(service.appleTransaction, 'header.payload.signature');
      expect(service.credential, isNull);
    };
    iap.events.add([_purchase()]);
    await _settle();
    expect(iap.completed, hasLength(1));
    apple.owned = [];
    await service.refresh();
    expect(service.storeTier, Tier.free);
    expect(
      iap.restores,
      0,
    ); // Automatic refresh never invokes interactive restore.
    await service.restore();
    expect(iap.restores, 1);
  });

  test('failed native refresh blocks new purchase and cannot complete an unverified callback', () async {
    final apple = _AppleStore();
    final iap = _Iap()..products = [_product()];
    final service = SubscriptionService(
      store: SettingsStore(),
      iap: iap,
      applePlatform: true,
      appleStore: apple,
    )..start();
    addTearDown(service.dispose);
    addTearDown(iap.events.close);
    final offer = (await service.loadOffers()).single;
    apple.fail = true;
    await service.buy(offer);
    expect(iap.buys, isEmpty);
    iap.events.add([_purchase()]);
    await _settle();
    expect(iap.completed, isEmpty);
    expect(service.storeTier, Tier.free);
    expect(service.lastError, 'error');
  });

  test('native catalog rejects introductory or unverifiable annual product and rechecks before buy', () async {
    final apple = _AppleStore();
    final iap = _Iap()..products = [_product()];
    final service = SubscriptionService(
      store: SettingsStore(),
      iap: iap,
      applePlatform: true,
      appleStore: apple,
    );
    addTearDown(service.dispose);
    final offer = (await service.loadOffers()).single;
    apple.eligible =
        {}; // Native catalog found introductory offer / ineligible product.
    expect(await service.loadOffers(), isEmpty);
    await service.buy(offer);
    expect(iap.buys, isEmpty);
    apple.fail = true;
    await expectLater(service.loadOffers(), throwsStateError);
    expect(service.appleTransaction, isNull);
  });

  test(
    'newer ownership refresh wins over delayed old active entitlement',
    () async {
      final apple = _AppleStore();
      final service = SubscriptionService(
        store: SettingsStore(),
        iap: _Iap(),
        applePlatform: true,
        appleStore: apple,
      );
      addTearDown(service.dispose);
      final old = Completer<List<AppleSubscription>>();
      final current = Completer<List<AppleSubscription>>();
      apple.pending.addAll([old, current]);
      final first = service.refresh();
      await _settle();
      final second = service.refresh();
      await _settle();
      current.complete([]);
      await second;
      old.complete([_owned()]);
      await first;
      expect(service.storeTier, Tier.free);
      expect(service.appleTransaction, isNull);
      expect(apple.recovered, isEmpty);
    },
  );

  test('unfinished recovery follows delivery and excludes expired or unrelated ownership', () async {
    final apple = _AppleStore()
      ..owned = [
        _owned(),
        _owned(id: 'unrelated_product'),
        _owned(id: SubscriptionService.maxId, expired: true),
      ];
    final service = SubscriptionService(
      store: SettingsStore(),
      iap: _Iap(),
      applePlatform: true,
      appleStore: apple,
    );
    addTearDown(service.dispose);
    apple.onRecovery = (delivered) {
      expect(service.storeTier, Tier.pro);
      expect(service.appleTransaction, 'header.payload.signature');
      expect(delivered, hasLength(1));
      expect(delivered.single.originalTransactionId, '123');
    };
    await service.refresh();
    expect(apple.recovered, hasLength(1));
    apple.failRecovery = true;
    await service.refresh();
    expect(service.storeTier, Tier.pro);
    apple.failRecovery = false;
    await service.refresh();
    expect(apple.recovered, hasLength(2));
  });

  test('native recovery transport binds product lineage and exact signed entitlement', () async {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    var calls = 0;
    messenger.setMockMethodCallHandler(AppleSubscriptionStore.channel, (
      call,
    ) async {
      calls++;
      expect(call.method, 'finishDeliveredTransactions');
      expect(call.arguments, [
        {
          'productId': SubscriptionService.proId,
          'originalTransactionId': '123',
          'signedTransaction': 'header.payload.signature',
        },
      ]);
      return 1;
    });
    addTearDown(
      () => messenger.setMockMethodCallHandler(
        AppleSubscriptionStore.channel,
        null,
      ),
    );
    await const AppleSubscriptionStore().finishDeliveredTransactions([]);
    expect(calls, 0);
    await const AppleSubscriptionStore().finishDeliveredTransactions([
      _owned(),
    ]);
    expect(calls, 1);
  });
}
