import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart' hide AppTheme;
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/features/subscription/subscription_purchase_adapter.dart';
import 'package:nshoptor/features/subscription/subscription_paywall.dart';
import 'package:nshoptor/features/subscription/subscription_service.dart';

class _NoStoreService extends SubscriptionService {
  _NoStoreService(SettingsStore store) : super(store: store);
  @override
  Future<List<SubscriptionOffer>> loadOffers() async => const [];
}

class _NativeAddition extends Fake
    implements InAppPurchaseAndroidPlatformAddition {
  List<GooglePlayPurchaseDetails> owned = [];
  final pending = <Completer<QueryPurchaseDetailsResponse>>[];
  @override
  Future<QueryPurchaseDetailsResponse> queryPastPurchases({
    String? applicationUserName,
  }) async => pending.isNotEmpty
      ? pending.removeAt(0).future
      : QueryPurchaseDetailsResponse(pastPurchases: owned);
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
  dynamic noSuchMethod(Invocation invocation) =>
      invocation.memberName == #getPlatformAddition
      ? addition
      : super.noSuchMethod(invocation);
  @override
  Future<bool> buyNonConsumable({required PurchaseParam purchaseParam}) {
    buys.add(purchaseParam as GooglePlayPurchaseParam);
    return launch?.future ?? Future.value(false);
  }

  @override
  Future<void> restorePurchases({String? applicationUserName}) async {
    restores++;
    await restoring?.future;
  }

  @override
  Future<void> completePurchase(PurchaseDetails purchase) async {}
  @override
  Future<ProductDetailsResponse> queryProductDetails(
    Set<String> identifiers,
  ) async {
    queried = identifiers;
    return ProductDetailsResponse(
      productDetails: products,
      notFoundIDs: identifiers.toList(),
    );
  }
}

GooglePlayPurchaseDetails _native(String id, String token) =>
    GooglePlayPurchaseDetails(
      productID: id,
      verificationData: PurchaseVerificationData(
        localVerificationData: '',
        serverVerificationData: token,
        source: 'test',
      ),
      transactionDate: '0',
      status: PurchaseStatus.purchased,
      billingClientPurchase: PurchaseWrapper(
        orderId: 'synthetic',
        packageName: 'com.crazypenguin.nshoptor',
        purchaseTime: 0,
        purchaseToken: token,
        signature: '',
        products: [id],
        isAutoRenewing: true,
        originalJson: '',
        isAcknowledged: true,
        purchaseState: PurchaseStateWrapper.purchased,
      ),
    );
SubscriptionOffer _offer(String id) => SubscriptionOffer(
  productId: id,
  basePlanId: 'yearly',
  price: 'store-price',
  billingPeriod: 'P1Y',
  hasTrial: false,
  details: _products(id).last,
);

List<GooglePlayProductDetails> _products(
  String id, {
  RecurrenceMode monthlyRecurrence = RecurrenceMode.infiniteRecurring,
  RecurrenceMode yearlyRecurrence = RecurrenceMode.infiniteRecurring,
}) {
  PricingPhaseWrapper phase(
    String period,
    String price,
    int micros,
    RecurrenceMode recurrence,
  ) => PricingPhaseWrapper(
    billingCycleCount: recurrence == RecurrenceMode.infiniteRecurring ? 0 : 1,
    billingPeriod: period,
    formattedPrice: price,
    priceAmountMicros: micros,
    priceCurrencyCode: 'TRY',
    recurrenceMode: recurrence,
  );
  return GooglePlayProductDetails.fromProductDetails(
    ProductDetailsWrapper(
      description: 'synthetic',
      name: 'Pro',
      title: 'Pro',
      productId: id,
      productType: ProductType.subs,
      subscriptionOfferDetails: [
        SubscriptionOfferDetailsWrapper(
          basePlanId: 'monthly',
          offerTags: [],
          offerIdToken: 'monthly-token',
          pricingPhases: [phase('P1M', '57,99 ₺', 57990000, monthlyRecurrence)],
        ),
        SubscriptionOfferDetailsWrapper(
          basePlanId: 'monthly',
          offerId: 'trial7',
          offerTags: [],
          offerIdToken: 'trial-token',
          pricingPhases: [
            phase('P7D', '0 ₺', 0, RecurrenceMode.finiteRecurring),
            phase('P1M', '57,99 ₺', 57990000, monthlyRecurrence),
          ],
        ),
        SubscriptionOfferDetailsWrapper(
          basePlanId: 'yearly',
          offerTags: [],
          offerIdToken: 'yearly-token',
          pricingPhases: [
            phase('P1Y', '469,99 ₺', 469990000, yearlyRecurrence),
          ],
        ),
      ],
    ),
  );
}

void main() {
  setUpAll(() async {
    if (!const bool.fromEnvironment('UI_REVIEW')) return;
    final font = FontLoader('Roboto');
    for (final name in ['segoeui.ttf', 'segoeuib.ttf']) {
      final file = File('C:/Windows/Fonts/$name');
      font.addFont(
        Future.value(ByteData.sublistView(await file.readAsBytes())),
      );
    }
    await font.load();
    final flutterRoot = Platform.environment['FLUTTER_ROOT'] ?? 'C:/flutter';
    final icons = File(
      '$flutterRoot/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
    );
    await (FontLoader('MaterialIcons')..addFont(
          Future.value(ByteData.sublistView(await icons.readAsBytes())),
        ))
        .load();
  });

  if (const bool.fromEnvironment('UI_REVIEW')) {
    for (final scenario in [
      (locale: 'ar', width: 320.0, scale: 2.0, dark: false, legacy: true),
      (locale: 'tr', width: 412.0, scale: 1.0, dark: true, legacy: false),
      (locale: 'en', width: 412.0, scale: 1.0, dark: false, legacy: false),
    ]) {
      testWidgets(
        'UI_REVIEW annual paywall ${scenario.locale} ${scenario.width} ${scenario.scale}',
        (tester) async {
          await tester.binding.setSurfaceSize(Size(scenario.width, 900));
          addTearDown(() => tester.binding.setSurfaceSize(null));
          final native = _NativeStore()
            ..products = [
              ..._products(SubscriptionService.proId),
              ..._products(SubscriptionService.maxId),
            ];
          final service = SubscriptionService(
            store: SettingsStore(),
            iap: native,
          );
          if (scenario.legacy) {
            service.applyOwned([
              (productId: SubscriptionService.legacyProId, token: 'existing'),
            ]);
          }
          await tester.pumpWidget(
            MaterialApp(
              locale: Locale(scenario.locale),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: scenario.dark ? AppTheme.dark() : AppTheme.light(),
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(scenario.scale)),
                child: child!,
              ),
              home: RepaintBoundary(
                key: const Key('paywall_capture'),
                child: SubscriptionPaywall(service: service),
              ),
            ),
          );
          await tester.pumpAndSettle();
          final l10n = AppLocalizations.of(
            tester.element(find.byType(SubscriptionPaywall)),
          );
          Future<void> capture(String state) async {
            expect(tester.takeException(), isNull);
            final boundary = tester.renderObject<RenderRepaintBoundary>(
              find.byKey(const Key('paywall_capture')),
            );
            await tester.runAsync(() async {
              final image = await boundary.toImage();
              try {
                final bytes = await image.toByteData(
                  format: ui.ImageByteFormat.png,
                );
                final file = File(
                  'artifacts/qa/PB-137/paywall_${scenario.locale}_${scenario.width.toInt()}_${scenario.scale}x_$state.png',
                );
                await file.parent.create(recursive: true);
                await file.writeAsBytes(bytes!.buffer.asUint8List());
              } finally {
                image.dispose();
              }
            });
          }

          await capture('top');
          if (scenario.legacy) {
            await tester.scrollUntilVisible(
              find.textContaining('Pro: 200'),
              150,
            );
            await tester.pumpAndSettle();
            await capture('retained_rights');
          }
          await tester.scrollUntilVisible(find.text(l10n.planChoose), 150);
          await tester.pumpAndSettle();
          expect(find.byKey(const Key('plan_max')), findsNothing);
          expect(find.text(l10n.planStartTrial), findsNothing);
          expect(service.monthlyAllowance, scenario.legacy ? 200 : 10);
          await capture('annual_offer');
          await tester.scrollUntilVisible(find.text(l10n.plansLegal), 150);
          await tester.pumpAndSettle();
          await capture('legal_start');
          // Long legal copy can span multiple screens at 200% text scaling.
          final position = tester
              .state<ScrollableState>(find.byType(Scrollable).first)
              .position;
          position.jumpTo(position.maxScrollExtent);
          await tester.pumpAndSettle();
          await capture('legal_end');
          await tester.pumpWidget(const SizedBox.shrink());
          service.dispose();
          await native.events.close();
        },
      );
    }
  }

  test(
    'annual Pro keeps100permonth and usesoldtoken when changing baseplan',
    () async {
      final native = _NativeStore();
      native.addition.owned = [
        _native(SubscriptionService.proId, 'monthly-owner'),
      ];
      final service = SubscriptionService(store: SettingsStore(), iap: native);
      await service.buy(_offer(SubscriptionService.proId));
      expect(native.buys, hasLength(1));
      expect(
        native
            .buys
            .single
            .changeSubscriptionParam!
            .oldPurchaseDetails
            .verificationData
            .serverVerificationData,
        'monthly-owner',
      );
      expect(
        native.buys.single.changeSubscriptionParam!.replacementMode,
        ReplacementMode.withoutProration,
      );
      expect(service.monthlyAllowance, 100);
      expect(SubscriptionService.offerIds, {SubscriptionService.proId});
      service.dispose();
      await native.events.close();
    },
  );

  test(
    'a stale monthly native phase cannot masquerade as annual Pro',
    () async {
      final native = _NativeStore();
      final service = SubscriptionService(store: SettingsStore(), iap: native);
      await service.buy(
        SubscriptionOffer(
          productId: SubscriptionService.proId,
          basePlanId: 'yearly',
          price: 'store-price',
          billingPeriod: 'P1Y',
          hasTrial: false,
          details: _products(SubscriptionService.proId).first,
        ),
      );
      expect(native.buys, isEmpty);
      expect(service.lastError, isNotNull);
      service.dispose();
      await native.events.close();
    },
  );

  test('legacy same-tier allowance wins in either order and only new IDs are offered', () async {
    final native = _NativeStore();
    final service = SubscriptionService(store: SettingsStore(), iap: native);
    for (final pair in [
      (SubscriptionService.proId, SubscriptionService.legacyProId, 200),
      (SubscriptionService.maxId, SubscriptionService.legacyMaxId, 1000),
    ]) {
      final records = [
        (productId: pair.$1, token: 'new'),
        (productId: pair.$2, token: 'old'),
      ];
      for (final order in [records, records.reversed.toList()]) {
        service.applyOwned(order);
        expect(service.monthlyAllowance, pair.$3);
        expect(service.legacy, isTrue);
      }
    }
    expect(SubscriptionService.allowanceOf(SubscriptionService.proId), 100);
    expect(SubscriptionService.allowanceOf(SubscriptionService.maxId), 300);
    expect(SubscriptionService.allowanceOf(null), 10);
    await service.loadOffers();
    expect(native.queried, SubscriptionService.offerIds);
    final loaded = SubscriptionService(
      store: SettingsStore()
        ..setString('sub_product', SubscriptionService.legacyProId)
        ..setString('sub_token', 'old'),
    )..load();
    expect(loaded.monthlyAllowance, 200);
    expect(loaded.credential!.productId, SubscriptionService.legacyProId);
    service.applyOwned([(productId: SubscriptionService.maxId, token: '')]);
    expect(service.credential, isNull);
    service.dispose();
    loaded.dispose();
    await native.events.close();
  });

  test('native highest owner is used for replacement; duplicate, failed launch and retry safe', () async {
    final native = _NativeStore();
    final service = SubscriptionService(store: SettingsStore(), iap: native);
    native.addition.owned = [
      _native(SubscriptionService.legacyProId, 'pro-token'),
      _native(SubscriptionService.legacyMaxId, 'max-token'),
    ];
    native.launch = Completer<bool>();
    final first = service.buy(_offer(SubscriptionService.proId));
    await Future<void>.delayed(Duration.zero);
    await service.buy(_offer(SubscriptionService.maxId));
    expect(native.buys, hasLength(1));
    expect(
      native.buys.single.changeSubscriptionParam!.oldPurchaseDetails.productID,
      SubscriptionService.legacyMaxId,
    );
    expect(
      native
          .buys
          .single
          .changeSubscriptionParam!
          .oldPurchaseDetails
          .verificationData
          .serverVerificationData,
      'max-token',
    );
    native.launch!.complete(false);
    await first;
    expect(service.busy, isFalse);
    expect(service.lastError, isNotNull);
    native.available = false;
    await service.buy(_offer(SubscriptionService.proId));
    expect(native.buys, hasLength(1));
    expect(service.tier, Tier.max);
    native.available = true;
    native.launch = Completer<bool>();
    final retry = service.buy(_offer(SubscriptionService.proId));
    await Future<void>.delayed(Duration.zero);
    expect(native.buys, hasLength(2));
    native.launch!.complete(false);
    await retry;
    service.dispose();
    await native.events.close();
  });

  test(
    'restore repeat and failure keep cached rights and allow retry',
    () async {
      final native = _NativeStore();
      final service = SubscriptionService(store: SettingsStore(), iap: native)
        ..applyOwned([
          (productId: SubscriptionService.legacyProId, token: 'old'),
        ]);
      native.restoring = Completer<void>();
      final first = service.restore();
      await service.restore();
      expect(native.restores, 1);
      native.restoring!.completeError(StateError('store unavailable'));
      await first;
      expect(service.busy, isFalse);
      expect(service.monthlyAllowance, 200);
      expect(service.lastError, isNotNull);
      native.restoring = null;
      native.addition.owned = [_native(SubscriptionService.proId, 'new')];
      await service.restore();
      expect(service.monthlyAllowance, 100);
      expect(service.lastError, isNull);
      service.dispose();
      await native.events.close();
    },
  );

  test(
    'late native queries cannot replace newer owner or mutate disposed cache',
    () async {
      final native = _NativeStore(), store = SettingsStore();
      final service = SubscriptionService(store: store, iap: native);
      final old = Completer<QueryPurchaseDetailsResponse>(),
          newer = Completer<QueryPurchaseDetailsResponse>();
      native.addition.pending.addAll([old, newer]);
      final first = service.refresh();
      await Future<void>.delayed(Duration.zero);
      final second = service.refresh();
      await Future<void>.delayed(Duration.zero);
      newer.complete(
        QueryPurchaseDetailsResponse(
          pastPurchases: [_native(SubscriptionService.maxId, 'new')],
        ),
      );
      await second;
      old.complete(
        QueryPurchaseDetailsResponse(
          pastPurchases: [_native(SubscriptionService.legacyProId, 'old')],
        ),
      );
      await first;
      expect(service.productId, SubscriptionService.maxId);
      final late = Completer<QueryPurchaseDetailsResponse>();
      native.addition.pending.add(late);
      final loading = service.refresh();
      await Future<void>.delayed(Duration.zero);
      service.dispose();
      late.complete(QueryPurchaseDetailsResponse(pastPurchases: []));
      await loading;
      expect(store.getString('sub_product'), SubscriptionService.maxId);
      await native.events.close();
    },
  );

  test(
    'new offers include annual Pro only; monthly Max and legacy excluded',
    () async {
      final native = _NativeStore()
        ..products = [
          ..._products(SubscriptionService.proId),
          ..._products(SubscriptionService.legacyProId),
          ..._products(SubscriptionService.maxId),
        ];
      final service = SubscriptionService(store: SettingsStore(), iap: native);
      final offers = await service.loadOffers();
      expect(offers, hasLength(1));
      expect(offers.single.price, '469,99 ₺');
      expect(offers.single.hasTrial, isFalse);
      expect(offers.single.billingPeriod, 'P1Y');
      expect(offers.single.yearly, isTrue);
      expect(offers.single.basePlanId, SubscriptionService.annualBasePlanId);
      expect(offers.single.productId, SubscriptionService.proId);
      service.dispose();
      await native.events.close();
    },
  );

  test(
    'finite annual plans are not sold as automatically renewing subscriptions',
    () async {
      final native = _NativeStore()
        ..products = _products(
          SubscriptionService.proId,
          yearlyRecurrence: RecurrenceMode.nonRecurring,
        );
      final service = SubscriptionService(store: SettingsStore(), iap: native);
      expect(await service.loadOffers(), isEmpty);
      await service.buy(
        SubscriptionOffer(
          productId: SubscriptionService.proId,
          basePlanId: 'yearly',
          price: '57,99 ₺',
          billingPeriod: 'P1Y',
          hasTrial: false,
          details: native.products.last,
        ),
      );
      expect(native.buys, isEmpty);
      expect(service.lastError, isNotNull);
      service.dispose();
      await native.events.close();
    },
  );

  test('Max and nonannual selections cannot buy; existing yearly rights restore', () async {
    final native = _NativeStore();
    native.addition.owned = [
      _native(SubscriptionService.legacyProId, 'existing-yearly-token'),
    ];
    final service = SubscriptionService(store: SettingsStore(), iap: native);
    await service.restore();
    expect(service.monthlyAllowance, 200);
    final yearlyDetails = _products(SubscriptionService.maxId).last;
    for (final period in ['P1Y', 'P3M', 'P1W', 'P1M']) {
      await service.buy(
        SubscriptionOffer(
          productId: SubscriptionService.maxId,
          basePlanId: 'yearly',
          price: '469,99 ₺',
          billingPeriod: period,
          hasTrial: false,
          details: yearlyDetails,
        ),
      );
      expect(native.buys, isEmpty);
      expect(service.lastError, isNotNull);
      expect(service.busy, isFalse);
      expect(service.credential!.token, 'existing-yearly-token');
      expect(service.monthlyAllowance, 200);
    }
    await service.restore();
    expect(service.lastError, isNull);
    expect(service.tier, Tier.pro);
    expect(service.monthlyAllowance, 200);
    // A restored annual base plan can also belong to the current product ID.
    // Ownership refresh deliberately does not filter purchases by offer period.
    native.addition.owned = [
      _native(SubscriptionService.proId, 'current-product-yearly-token'),
    ];
    await service.restore();
    expect(service.tier, Tier.pro);
    expect(service.monthlyAllowance, 100);
    expect(service.credential!.token, 'current-product-yearly-token');
    service.dispose();
    await native.events.close();
  });

  testWidgets(
    'paywall offers only annual Pro using the unmodified localized store price',
    (tester) async {
      final native = _NativeStore()
        ..products = [
          ..._products(SubscriptionService.proId),
          ..._products(SubscriptionService.maxId),
        ];
      final service = SubscriptionService(store: SettingsStore(), iap: native);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: SubscriptionPaywall(service: service),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ChoiceChip), findsNothing);
      expect(find.text('Yearly'), findsOneWidget);
      await tester.scrollUntilVisible(find.byKey(const Key('plan_pro')), 200);
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byKey(const Key('plan_pro')),
          matching: find.text('469,99 ₺ / year'),
        ),
        findsOneWidget,
      );
      expect(find.textContaining('57,99'), findsNothing);
      expect(find.byKey(const Key('plan_max')), findsNothing);
      expect(find.text('Free trial'), findsNothing);
      expect(find.text('Start free trial'), findsNothing);
      expect(find.text('100 AI requests a month'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('Choose'), 100);
      await tester.tap(find.text('Choose'));
      await tester.pumpAndSettle();
      expect(native.buys, hasLength(1));
      expect(native.buys.single.productDetails.id, SubscriptionService.proId);
      expect(native.buys.single.offerToken, 'yearly-token');
      await tester.pumpWidget(const SizedBox.shrink());
      service.dispose();
      await native.events.close();
    },
  );

  testWidgets(
    'existing paid tiers retain their allowance and can choose annual Pro',
    (tester) async {
      for (final owned in [
        (id: SubscriptionService.proId, label: 'Pro', allowance: 100),
        (id: SubscriptionService.maxId, label: 'Max', allowance: 300),
        (id: SubscriptionService.legacyProId, label: 'Pro', allowance: 200),
        (id: SubscriptionService.legacyMaxId, label: 'Max', allowance: 1000),
      ]) {
        final native = _NativeStore()
          ..products = _products(SubscriptionService.proId);
        final service = SubscriptionService(store: SettingsStore(), iap: native)
          ..applyOwned([(productId: owned.id, token: 'existing-token')]);
        await tester.pumpWidget(
          MaterialApp(
            locale: const Locale('en'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: SubscriptionPaywall(service: service),
          ),
        );
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.textContaining('${owned.label}: ${owned.allowance}'),
          100,
        );
        expect(
          find.textContaining('${owned.label}: ${owned.allowance}'),
          findsOneWidget,
        );
        await tester.scrollUntilVisible(find.text('Choose'), 100);
        expect(find.byKey(const Key('plan_max')), findsNothing);
        expect(
          find.descendant(
            of: find.byKey(const Key('plan_pro')),
            matching: find.byKey(const Key('plan_current_badge')),
          ),
          findsNothing,
        );
        expect(service.monthlyAllowance, owned.allowance);
        await tester.pumpWidget(const SizedBox.shrink());
        service.dispose();
        await native.events.close();
      }
    },
  );

  test(
    'removed Max cannot be bought; retained Max to annual Pro defers change',
    () async {
      final native = _NativeStore();
      native.addition.owned = [_native(SubscriptionService.proId, 'pro-token')];
      final s = SubscriptionService(store: SettingsStore(), iap: native)
        ..start();
      await Future<void>.delayed(Duration.zero);
      expect(s.tier, Tier.pro);

      await s.buy(_offer(SubscriptionService.maxId));
      expect(native.buys, isEmpty);
      expect(s.lastError, isNotNull);
      expect(s.tier, Tier.pro);

      native.addition.owned = [_native(SubscriptionService.maxId, 'max-token')];
      s.applyNativeOwned(native.addition.owned);
      await s.buy(_offer(SubscriptionService.proId));
      expect(
        native.buys.last.changeSubscriptionParam!.replacementMode,
        ReplacementMode.deferred,
      );
      s.dispose();
      await native.events.close();
    },
  );

  test('launched purchase stays busy until cancellation event; late refresh after dispose safe', () async {
    final native = _NativeStore(),
        service = SubscriptionService(store: SettingsStore());
    service.dispose();
    await service.refresh(); // no disposal notification
    final s = SubscriptionService(store: SettingsStore(), iap: native)..start();
    await Future<void>.delayed(Duration.zero);
    native.launch = Completer<bool>();
    final launch = s.buy(_offer(SubscriptionService.proId));
    await Future<void>.delayed(Duration.zero);
    native.launch!.complete(true);
    await launch;
    expect(s.busy, isTrue);
    await s.restore();
    expect(native.restores, 0);
    final cancel = _native(SubscriptionService.proId, 'synthetic')
      ..status = PurchaseStatus.canceled;
    native.events.add([cancel]);
    await Future<void>.delayed(Duration.zero);
    expect(s.busy, isFalse);
    s.dispose();
    await native.events.close();
  });

  test('owning Pro ends a pending purchase wait even without a purchase event (F01)', () async {
    final native = _NativeStore();
    final s = SubscriptionService(store: SettingsStore(), iap: native)..start();
    await Future<void>.delayed(Duration.zero);
    native.launch = Completer<bool>();
    final launch = s.buy(_offer(SubscriptionService.proId));
    await Future<void>.delayed(Duration.zero);
    native.launch!.complete(true);
    await launch;
    expect(s.busy, isTrue);
    s.applyOwned([(productId: SubscriptionService.proId, token: 'owned-token')]);
    expect(s.busy, isFalse);
    expect(s.tier, isNot(Tier.free));
    s.dispose();
    await native.events.close();
  });

  testWidgets(
    'legacy note, annual period and retry controls fit320dp2x Arabic',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 640));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final service = _NoStoreService(SettingsStore())
        ..applyOwned([
          (productId: SubscriptionService.legacyProId, token: 'old'),
        ]);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(2)),
            child: child!,
          ),
          home: SubscriptionPaywall(service: service),
        ),
      );
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.textContaining('Pro: 200'), 200);
      await tester.pumpAndSettle();
      expect(find.textContaining('Pro: 200'), findsOneWidget);
      final l10n = AppLocalizations.of(
        tester.element(find.byType(SubscriptionPaywall)),
      );
      await tester.scrollUntilVisible(find.text(l10n.plansYearly), 200);
      await tester.pumpAndSettle();
      expect(find.text(l10n.plansMonthly), findsNothing);
      expect(find.byType(ChoiceChip), findsNothing);
      await tester.scrollUntilVisible(find.byKey(const Key('plan_pro')), 400);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.scrollUntilVisible(
        find.byKey(const Key('plans_restore')),
        400,
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      service.dispose();
    },
  );

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

  test('geçici Pro + ücretsiz = reklamsız ama AI ücretsiz (jeton yok)', () {
    final s = SubscriptionService(store: SettingsStore());
    expect(
      SubscriptionService.adFree(temporaryPro: true, tier: s.tier),
      isTrue,
    );
    expect(s.credential, isNull);
    expect(s.monthlyAllowance, 10);
    expect(
      SubscriptionService.adFree(temporaryPro: false, tier: Tier.free),
      isFalse,
    );
    expect(
      SubscriptionService.adFree(temporaryPro: false, tier: Tier.pro),
      isTrue,
    );
  });

  test('satın alma olayları ProController’a iletilmez', () async {
    const adapter = SubscriptionPurchaseAdapter();
    final seen = <String>[];
    final sub = adapter.updates.listen(
      (l) => seen.addAll(l.map((u) => u.purchase.productId)),
    );
    expect(await adapter.queryProducts(SubscriptionService.ids), isEmpty);
    await adapter.restore();
    await Future<void>.delayed(Duration.zero);
    expect(seen, isEmpty);
    await sub.cancel();
  });

  testWidgets(
    'paywall: ücretsiz mevcut, mağaza yoksa bilgi, geri yükleme ve yasal metin',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('tr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: SubscriptionPaywall(service: _NoStoreService(SettingsStore())),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byKey(const Key('plan_free')),
          matching: find.text('Mevcut'),
        ),
        findsOneWidget,
      );
      // No annual Pro offer: stop loading and show the store availability message.
      expect(
        find.descendant(
          of: find.byKey(const Key('plan_pro')),
          matching: find.byType(LinearProgressIndicator),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('plan_pro')),
          matching: find.text('Şu an mağazada yok'),
        ),
        findsOneWidget,
      );
      expect(find.text('Yıllık'), findsOneWidget);
      expect(find.byKey(const Key('plan_max')), findsNothing);
      expect(find.byType(ChoiceChip), findsNothing);
      expect(find.byType(LinearProgressIndicator), findsNothing);
      await tester.scrollUntilVisible(
        find.text('Mağazaya şu an ulaşılamıyor.'),
        200,
      );
      expect(find.text('Mağazaya şu an ulaşılamıyor.'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.byKey(const Key('plans_restore')),
        200,
      );
      expect(find.byKey(const Key('plans_restore')), findsOneWidget);
      await tester.scrollUntilVisible(
        find.textContaining('her yıl otomatik yenilenir'),
        200,
      );
      expect(find.textContaining('her yıl otomatik yenilenir'), findsOneWidget);
    },
  );
}
