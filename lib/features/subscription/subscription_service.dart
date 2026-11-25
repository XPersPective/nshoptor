import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart'
    show RecurrenceMode, ReplacementMode;
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_2_wrappers.dart';
import 'package:napp_core/napp_core.dart';

import '../ai/ai_client.dart' show PurchaseCredential;
import 'installation_trial.dart';
import 'apple_subscription_store.dart';

/// AI ve reklam katmanı (ADR-004 §5). Yetkinin kesin kararı sunucudadır
/// (Worker Play doğrulaması); buradaki durum yalnız arayüz ve reklam içindir.
enum Tier { free, pro, max }

/// Paywall'da bir satın alınabilir seçenek (ürün + base plan + teklif).
class SubscriptionOffer {
  const SubscriptionOffer({
    required this.productId,
    required this.basePlanId,
    required this.price,
    required this.billingPeriod,
    required this.hasTrial,
    required this.details,
  });

  final String productId;
  final String basePlanId;

  /// Mağazanın biçimlendirdiği yinelenen fiyat (deneme sonrası).
  final String price;

  /// ISO-8601 süre: P1M / P1Y.
  final String billingPeriod;
  final bool hasTrial;
  final ProductDetails details;

  Tier get tier => SubscriptionService.tierOf(productId);
  bool get yearly => billingPeriod == 'P1Y';
  bool get monthly => billingPeriod == 'P1M';
}

class SubscriptionService extends ChangeNotifier {
  SubscriptionService({
    required this.store,
    InAppPurchase? iap,
    bool? applePlatform,
    AppleSubscriptionStore? appleStore,
  }) : _iapOverride = iap,
       _applePlatform =
           applePlatform ??
           (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS),
       _appleStore = appleStore ?? const AppleSubscriptionStore();

  static const proId = 'nshoptor_pro_v2';
  static const maxId = 'nshoptor_max_v2';
  static const legacyProId = 'nshoptor_pro';
  static const legacyMaxId = 'nshoptor_max';
  static const annualBasePlanId = 'yearly';
  static const offerIds = {proId};
  static const ids = {proId, maxId, legacyProId, legacyMaxId};
  static const _productKey = 'sub_product';
  static const _tokenKey = 'sub_token';
  static const _trialKey = 'sub_trial_until';
  static const trialDays = 7;
  bool _pendingTrial = false;
  InstallationTrial? _installationTrial;
  Timer? _trialTimer;
  int? _trialMinutes;

  final SettingsStore store;
  final InAppPurchase? _iapOverride;
  final bool _applePlatform;
  bool get isAppleStore => _applePlatform;
  final AppleSubscriptionStore _appleStore;
  AppleSubscription? _appleOwned;
  List<AppleSubscription> _appleEntitlements = const [];
  Timer? _appleExpiryTimer;
  InAppPurchase get _iap => _iapOverride ?? InAppPurchase.instance;

  StreamSubscription<List<PurchaseDetails>>? _sub;
  GooglePlayPurchaseDetails? _owned;
  String? _productId;
  String? _token;
  int _refreshGeneration = 0;
  bool _disposed = false,
      _ownershipFresh = false,
      _working = false,
      _purchasePending = false;
  bool get busy => _working || _purchasePending;
  bool get legacy => productId == legacyProId || productId == legacyMaxId;
  static int allowanceOf(String? id) => switch (id) {
    legacyMaxId => 1000,
    maxId => 300,
    legacyProId => 200,
    proId => 100,
    _ => 10,
  };
  int get monthlyAllowance =>
      storeTier == Tier.free && promotionalTrial ? 100 : allowanceOf(productId);

  /// Satın alma sonucu (paywall gösterir): null = sorun yok.
  String? lastError;

  /// Boot'ta bağlanan tek örnek (kota mesajlarından planlara geçiş için).
  static SubscriptionService? instance;

  static Tier tierOf(String? productId) => switch (productId) {
    maxId || legacyMaxId => Tier.max,
    proId || legacyProId => Tier.pro,
    _ => Tier.free,
  };

  Tier get storeTier =>
      _applePlatform ? tierOf(_activeApple?.productId) : tierOf(_productId);
  AppleSubscription? get _activeApple =>
      _appleOwned != null && _appleOwned!.expiresAt.isAfter(DateTime.now())
      ? _appleOwned
      : null;
  String? get appleTransaction =>
      _applePlatform ? _activeApple?.signedTransaction : null;
  Tier get tier =>
      storeTier == Tier.free && promotionalTrial ? Tier.pro : storeTier;
  bool get promotionalTrial =>
      storeTier == Tier.free && _installationTrial?.active == true;
  Duration get trialRemaining => _installationTrial?.remaining ?? Duration.zero;
  int? get trialFirstOpenedAt => _installationTrial?.firstOpenedAt;
  bool get needsTrialExpiryNotice =>
      storeTier == Tier.free && _installationTrial?.needsExpiryNotice == true;

  /// Called explicitly by app boot; tests/legacy purchase consumers retain
  /// store-only behavior unless they opt into promotional access.
  void initializeTrial({DateTime Function()? now}) {
    _installationTrial ??= InstallationTrial(store, now: now);
    refreshTrial();
    _trialTimer ??= Timer.periodic(
      const Duration(minutes: 1),
      (_) => refreshTrial(),
    );
  }

  void refreshTrial() {
    if (_disposed || _installationTrial == null) return;
    final micros = trialRemaining.inMicroseconds;
    final minutes = micros == 0
        ? 0
        : 1 + (micros - 1) ~/ Duration.microsecondsPerMinute;
    if (_trialMinutes == minutes) return;
    _trialMinutes = minutes;
    notifyListeners();
  }

  void observeTrialServer({required int endsAt, required int serverNow}) {
    _installationTrial?.observeServer(endsAt: endsAt, serverNow: serverNow);
    refreshTrial();
  }

  void acknowledgeTrialExpiry() => _installationTrial?.acknowledgeExpiry();

  /// Ücretsiz deneme süresinde mi (yalnız gösterim; Play faturalar).
  bool inTrial([DateTime? now]) {
    if (storeTier == Tier.free && promotionalTrial) return true;
    final until = store.getInt(_trialKey);
    return storeTier != Tier.free &&
        until != null &&
        (now ?? DateTime.now()).millisecondsSinceEpoch < until;
  }

  /// Denemeli bir teklif satın alındı: 7 günlük deneme başlar.
  @visibleForTesting
  void markTrialStarted(DateTime now) => store.setInt(
    _trialKey,
    now.add(const Duration(days: trialDays)).millisecondsSinceEpoch,
  );

  /// Reklamsız mı: geçici Pro ya da herhangi bir abonelik.
  static bool adFree({required bool temporaryPro, required Tier tier}) =>
      temporaryPro || tier != Tier.free;
  String? get productId =>
      _applePlatform ? _activeApple?.productId : _productId;

  /// AI isteğine eklenen doğrulanacak jeton; ücretsizde null.
  PurchaseCredential? get credential =>
      _applePlatform ||
          _token == null ||
          _token!.isEmpty ||
          !ids.contains(_productId)
      ? null
      : (token: _token!, productId: _productId!);

  void load() {
    // Apple ownership is never reconstructed from Android's persisted token.
    // StoreKit current entitlements are the only local source of Apple benefits.
    if (_applePlatform) return;
    _productId = store.getString(_productKey);
    _token = store.getString(_tokenKey);
    if (!ids.contains(_productId) || _token?.isNotEmpty != true) {
      _productId = null;
      _token = null;
    }
  }

  /// Sahip olunan abonelikleri uygular: max > pro; hiçbiri yoksa ücretsiz.
  @visibleForTesting
  void applyOwned(List<({String productId, String token})> owned) {
    if (_disposed) return;
    final relevant =
        owned
            .where((o) => ids.contains(o.productId) && o.token.isNotEmpty)
            .toList()
          ..sort((a, b) {
            final tier = tierOf(b.productId).index
                .compareTo(tierOf(a.productId).index);
            return tier != 0
                ? tier
                : allowanceOf(b.productId).compareTo(allowanceOf(a.productId));
          });
    final best = relevant.isEmpty ? null : relevant.first;
    // Owning the plan ends any purchase wait, even when the store stream
    // reports the purchase under a different event (F01: stuck progress).
    if (best != null && _purchasePending) {
      _purchasePending = false;
      notifyListeners();
    }
    if (best?.productId == _productId && best?.token == _token) return;
    _productId = best?.productId;
    _token = best?.token;
    if (best == null) {
      store.remove(_productKey);
      store.remove(_tokenKey);
      store.remove(_trialKey);
    } else {
      store.setString(_productKey, best.productId);
      store.setString(_tokenKey, best.token);
    }
    notifyListeners();
  }

  @visibleForTesting
  void applyNativeOwned(List<GooglePlayPurchaseDetails> purchases) {
    if (_disposed) return;
    final valid = purchases
        .where(
          (p) =>
              ids.contains(p.productID) &&
              (p.status == PurchaseStatus.purchased ||
                  p.status == PurchaseStatus.restored),
        )
        .toList();
    applyOwned([
      for (final p in valid)
        (
          productId: p.productID,
          token: p.verificationData.serverVerificationData,
        ),
    ]);
    _owned = valid
        .where(
          (p) =>
              p.productID == _productId &&
              p.verificationData.serverVerificationData == _token,
        )
        .firstOrNull;
  }

  void start() {
    if (_disposed) return;
    _sub ??= _iap.purchaseStream.listen(
      _onPurchases,
      onError: (_) {
        if (!_disposed) {
          _purchasePending = false;
          lastError = 'error';
          notifyListeners();
        }
      },
    );
    unawaited(refresh());
  }

  /// Mağazadan güncel sahiplik: iptal/süre bitimi burada düşer.
  Future<void> refresh() async {
    final generation = ++_refreshGeneration;
    _ownershipFresh = false;
    try {
      if (!await _iap.isAvailable() || _disposed) return;
      if (_applePlatform) {
        final owned = await _appleStore.currentEntitlements();
        if (_disposed || generation != _refreshGeneration) return;
        final valid =
            owned
                .where(
                  (p) =>
                      ids.contains(p.productId) &&
                      p.expiresAt.isAfter(DateTime.now()),
                )
                .toList()
              ..sort((a, b) {
                final rank = allowanceOf(b.productId)
                    .compareTo(allowanceOf(a.productId));
                return rank != 0 ? rank : b.expiresAt.compareTo(a.expiresAt);
              });
        _appleEntitlements = valid;
        _appleOwned = valid.firstOrNull;
        _productId = _appleOwned?.productId;
        _token = null;
        _owned = null;
        _appleExpiryTimer?.cancel();
        if (_appleOwned != null) {
          _appleExpiryTimer = Timer(
            _appleOwned!.expiresAt.difference(DateTime.now()),
            () {
              if (!_disposed) {
                notifyListeners();
                unawaited(refresh());
              }
            },
          );
        }
        _ownershipFresh = true;
        notifyListeners();
        if (!_disposed && generation == _refreshGeneration) {
          // Delivery precedes queue recovery; native re-verifies the snapshot
          // and finishes only recognized unfinished transactions in its lineage.
          try {
            await _appleStore.finishDeliveredTransactions(valid);
          } catch (_) {
            /* Keep delivered rights; retry recovery on next refresh. */
          }
        }
        return;
      }
      final addition = _iap
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final res = await addition.queryPastPurchases();
      if (res.error != null || _disposed || generation != _refreshGeneration) {
        return;
      }
      for (final p in res.pastPurchases.where(
        (p) => ids.contains(p.productID) && p.pendingCompletePurchase,
      )) {
        await _iap.completePurchase(p);
      }
      if (_disposed || generation != _refreshGeneration) return;
      applyNativeOwned(res.pastPurchases);
      _ownershipFresh = true;
    } catch (_) {
      // Offline retains cached benefits; buy requires a fresh native ownership query.
    }
  }

  Future<void> _onPurchases(List<PurchaseDetails> list) async {
    if (_applePlatform) {
      await _onApplePurchases(list);
      return;
    }
    final purchased = <GooglePlayPurchaseDetails>[];
    for (final p in list) {
      if (!ids.contains(p.productID)) continue;
      if (p.pendingCompletePurchase) {
        try {
          await _iap.completePurchase(p);
        } catch (_) {
          if (!_disposed) lastError = 'error';
        }
      }
      if (_disposed) return;
      switch (p.status) {
        case PurchaseStatus.purchased || PurchaseStatus.restored:
          if (p is GooglePlayPurchaseDetails) purchased.add(p);
          if (p.status == PurchaseStatus.purchased && _pendingTrial) {
            markTrialStarted(DateTime.now());
          }
          _pendingTrial = false;
          _purchasePending = false;
        case PurchaseStatus.error:
          _purchasePending = false;
          lastError = 'error';
        case PurchaseStatus.pending:
          _purchasePending = true;
        case PurchaseStatus.canceled:
          _purchasePending = false;
      }
    }
    if (_disposed) return;
    if (purchased.isNotEmpty) {
      applyNativeOwned([?_owned, ...purchased]);
      unawaited(refresh());
    }
    notifyListeners();
  }

  static bool _annualAppleProduct(AppStoreProduct2Details details) {
    final period = details.sk2Product.subscription?.subscriptionPeriod;
    return offerIds.contains(details.id) &&
        details.sk2Product.id == details.id &&
        details.sk2Product.type == SK2ProductType.autoRenewable &&
        period?.unit == SK2SubscriptionPeriodUnit.year &&
        period?.value == 1;
  }

  Future<void> _onApplePurchases(List<PurchaseDetails> list) async {
    final relevant = list.where((p) => ids.contains(p.productID)).toList();
    for (final p in relevant) {
      if (_disposed) return;
      switch (p.status) {
        case PurchaseStatus.purchased || PurchaseStatus.restored:
          // Stream status and unverified payloads alone never deliver access.
          // Deliver from current verified native ownership before finishing.
          await refresh();
          if (_disposed) return;
          if (_ownershipFresh &&
              _appleEntitlements.any(
                (owned) =>
                    owned.productId == p.productID &&
                    owned.expiresAt.isAfter(DateTime.now()),
              )) {
            if (p.pendingCompletePurchase) {
              try {
                await _iap.completePurchase(p);
              } catch (_) {
                lastError = 'error';
              }
            }
          } else {
            lastError = 'error';
          }
          _purchasePending = false;
        case PurchaseStatus.pending:
          _purchasePending = true;
        case PurchaseStatus.error:
          _purchasePending = false;
          lastError = 'error';
        case PurchaseStatus.canceled:
          _purchasePending = false;
      }
    }
    if (!_disposed && relevant.isNotEmpty) notifyListeners();
  }

  Future<List<SubscriptionOffer>> loadOffers() async {
    final res = await _iap.queryProductDetails(offerIds);
    final out = <SubscriptionOffer>[];
    if (_applePlatform) {
      final eligible = await _appleStore.eligibleAnnualProductIds(offerIds);
      for (final d in res.productDetails.whereType<AppStoreProduct2Details>()) {
        if (!_annualAppleProduct(d) || !eligible.contains(d.id)) continue;
        out.add(
          SubscriptionOffer(
            productId: d.id,
            basePlanId: annualBasePlanId,
            price: d.price,
            billingPeriod: 'P1Y',
            hasTrial: false,
            details: d,
          ),
        );
      }
      return out;
    }
    for (final d in res.productDetails.whereType<GooglePlayProductDetails>()) {
      if (!offerIds.contains(d.id)) continue;
      final index = d.subscriptionIndex;
      final offers = d.productDetails.subscriptionOfferDetails;
      if (index == null ||
          offers == null ||
          index < 0 ||
          index >= offers.length) {
        continue;
      }
      final o = offers[index];
      if (o.pricingPhases.isEmpty) continue;
      final recurring = o.pricingPhases.last;
      // New purchases use the single annual Pro base plan. Restore remains
      // independent so paid legacy Pro/Max entitlements are preserved.
      if (o.basePlanId != annualBasePlanId ||
          o.offerId != null ||
          recurring.billingPeriod != 'P1Y' ||
          recurring.recurrenceMode != RecurrenceMode.infiniteRecurring) {
        continue;
      }
      out.add(
        SubscriptionOffer(
          productId: d.id,
          basePlanId: o.basePlanId,
          price: recurring.formattedPrice,
          billingPeriod: recurring.billingPeriod,
          hasTrial: o.pricingPhases.first.priceAmountMicros == 0,
          details: d,
        ),
      );
    }
    // Return each verified annual base plan once.
    final byPlan = <String, SubscriptionOffer>{};
    for (final o in out) {
      final key = '${o.productId}/${o.basePlanId}';
      final prev = byPlan[key];
      if (prev == null || (o.hasTrial && !prev.hasTrial)) byPlan[key] = o;
    }
    return byPlan.values.toList();
  }

  Future<void> buy(SubscriptionOffer offer) async {
    if (busy || _disposed) return;
    _working = true;
    lastError = null;
    notifyListeners();
    try {
      if (!offer.yearly ||
          offer.basePlanId != annualBasePlanId ||
          !offerIds.contains(offer.productId)) {
        throw StateError('annual_pro_offer_required');
      }
      final nativeDetails = offer.details;
      if (_applePlatform) {
        if (nativeDetails is! AppStoreProduct2Details ||
            nativeDetails.id != offer.productId ||
            !_annualAppleProduct(nativeDetails)) {
          throw StateError('annual_native_offer_required');
        }
        final eligible = await _appleStore.eligibleAnnualProductIds(offerIds);
        if (!eligible.contains(nativeDetails.id)) {
          throw StateError('paid_annual_catalog_required');
        }
        await refresh();
        if (_disposed) return;
        if (!_ownershipFresh) throw StateError('ownership_not_verified');
        _purchasePending = true;
        _pendingTrial = false;
        final launched = await _iap.buyNonConsumable(
          purchaseParam: PurchaseParam(productDetails: nativeDetails),
        );
        if (!launched) throw StateError('purchase_not_launched');
        return;
      }
      if (nativeDetails is! GooglePlayProductDetails) {
        throw StateError('native_offer_required');
      }
      {
        final index = nativeDetails.subscriptionIndex;
        final catalog = nativeDetails.productDetails.subscriptionOfferDetails;
        if (nativeDetails.id != offer.productId ||
            index == null ||
            catalog == null ||
            index < 0 ||
            index >= catalog.length ||
            catalog[index].basePlanId != offer.basePlanId ||
            catalog[index].offerId != null ||
            catalog[index].pricingPhases.isEmpty ||
            (catalog[index].pricingPhases.last.billingPeriod != 'P1Y' ||
                catalog[index].pricingPhases.last.recurrenceMode !=
                    RecurrenceMode.infiniteRecurring)) {
          throw StateError('annual_native_offer_required');
        }
      }
      await refresh();
      if (_disposed) return;
      if (!_ownershipFresh ||
          !offerIds.contains(offer.productId) ||
          (_productId != null && _owned == null)) {
        throw StateError('ownership_not_verified');
      }
      final old = _owned;
      // Yükseltme: yeni planın kalan süresi hemen tahsil edilir, eski plan kredilenir.
      // Düşürme: mevcut dönem bitince geçer.
      final upgrade =
          old != null &&
          tierOf(offer.productId).index > tierOf(old.productID).index;
      final change = old != null
          ? ChangeSubscriptionParam(
              oldPurchaseDetails: old,
              // Same-product benefits switch immediately; the new annual
              // price is charged at the next bill, not a second charge now.
              replacementMode: old.productID == offer.productId
                  ? ReplacementMode.withoutProration
                  : upgrade
                  ? ReplacementMode.chargeProratedPrice
                  : ReplacementMode.deferred,
            )
          : null;
      _purchasePending = true;
      _pendingTrial = false; // The only new offering is the paid annual base.
      final launched = await _iap.buyNonConsumable(
        purchaseParam: GooglePlayPurchaseParam(
          productDetails: offer.details,
          offerToken: nativeDetails.offerToken,
          changeSubscriptionParam: change,
        ),
      );
      if (!launched) throw StateError('purchase_not_launched');
    } catch (_) {
      _purchasePending = false;
      lastError = 'error';
    } finally {
      _working = false;
      if (!_disposed) notifyListeners();
    }
  }

  Future<void> restore() async {
    if (busy || _disposed) return;
    _working = true;
    lastError = null;
    notifyListeners();
    try {
      await _iap.restorePurchases();
      await refresh();
      if (!_ownershipFresh && !_disposed) {
        throw StateError('ownership_not_verified');
      }
    } catch (_) {
      lastError = 'error';
    } finally {
      _working = false;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _trialTimer?.cancel();
    _appleExpiryTimer?.cancel();
    _sub?.cancel();
    super.dispose();
  }
}

/// Uygulama öne gelince (ödeme sayfasından dönüş dahil) mağaza sahipliğini yeniler.
class SubscriptionResumeObserver with WidgetsBindingObserver {
  SubscriptionResumeObserver(this.service);

  final SubscriptionService service;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      service.refreshTrial();
      unawaited(service.refresh());
    }
  }
}
