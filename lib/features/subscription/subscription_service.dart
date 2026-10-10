import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart' show ReplacementMode;
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:napp_core/napp_core.dart';

import '../ai/ai_client.dart' show PurchaseCredential;

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
}

class SubscriptionService extends ChangeNotifier {
  SubscriptionService({required this.store, InAppPurchase? iap}) : _iapOverride = iap;

  static const proId = 'nshoptor_pro_v2';
  static const maxId = 'nshoptor_max_v2';
  static const legacyProId = 'nshoptor_pro';
  static const legacyMaxId = 'nshoptor_max';
  static const offerIds = {proId, maxId};
  static const ids = {proId, maxId, legacyProId, legacyMaxId};
  static const _productKey = 'sub_product';
  static const _tokenKey = 'sub_token';

  final SettingsStore store;
  final InAppPurchase? _iapOverride;
  InAppPurchase get _iap => _iapOverride ?? InAppPurchase.instance;

  StreamSubscription<List<PurchaseDetails>>? _sub;
  GooglePlayPurchaseDetails? _owned;
  String? _productId;
  String? _token;
  int _refreshGeneration = 0;
  bool _disposed = false, _ownershipFresh = false, _working = false, _purchasePending = false;
  bool get busy => _working || _purchasePending;
  bool get legacy => _productId == legacyProId || _productId == legacyMaxId;
  static int allowanceOf(String? id) => switch (id) { legacyMaxId => 1000, maxId => 300, legacyProId => 200, proId => 100, _ => 10 };
  int get monthlyAllowance => allowanceOf(_productId);

  /// Satın alma sonucu (paywall gösterir): null = sorun yok.
  String? lastError;

  /// Boot'ta bağlanan tek örnek (kota mesajlarından planlara geçiş için).
  static SubscriptionService? instance;

  static Tier tierOf(String? productId) => switch (productId) {
        maxId || legacyMaxId => Tier.max,
        proId || legacyProId => Tier.pro,
        _ => Tier.free,
      };

  Tier get tier => tierOf(_productId);

  /// Reklamsız mı: ömür boyu/geçici Pro ya da herhangi bir abonelik.
  static bool adFree({required bool lifetimeOrTemp, required Tier tier}) =>
      lifetimeOrTemp || tier != Tier.free;
  String? get productId => _productId;

  /// AI isteğine eklenen doğrulanacak jeton; ücretsizde null.
  PurchaseCredential? get credential =>
      _token == null || _token!.isEmpty || !ids.contains(_productId) ? null : (token: _token!, productId: _productId!);

  void load() {
    _productId = store.getString(_productKey);
    _token = store.getString(_tokenKey);
    if (!ids.contains(_productId) || _token?.isNotEmpty != true) { _productId = null; _token = null; }
  }

  /// Sahip olunan abonelikleri uygular: max > pro; hiçbiri yoksa ücretsiz.
  @visibleForTesting
  void applyOwned(List<({String productId, String token})> owned) {
    if (_disposed) return;
    final relevant = owned.where((o) => ids.contains(o.productId) && o.token.isNotEmpty).toList()
      ..sort((a, b) {
        final tier = tierOf(b.productId).index.compareTo(tierOf(a.productId).index);
        return tier != 0 ? tier : allowanceOf(b.productId).compareTo(allowanceOf(a.productId));
      });
    final best = relevant.isEmpty ? null : relevant.first;
    if (best?.productId == _productId && best?.token == _token) return;
    _productId = best?.productId;
    _token = best?.token;
    if (best == null) {
      store.remove(_productKey);
      store.remove(_tokenKey);
    } else {
      store.setString(_productKey, best.productId);
      store.setString(_tokenKey, best.token);
    }
    notifyListeners();
  }

  @visibleForTesting
  void applyNativeOwned(List<GooglePlayPurchaseDetails> purchases) {
    if (_disposed) return;
    final valid = purchases.where((p) => ids.contains(p.productID) &&
      (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored)).toList();
    applyOwned([for (final p in valid) (productId: p.productID, token: p.verificationData.serverVerificationData)]);
    _owned = valid.where((p) => p.productID == _productId && p.verificationData.serverVerificationData == _token).firstOrNull;
  }

  void start() {
    if (_disposed) return;
    _sub ??= _iap.purchaseStream.listen(_onPurchases, onError: (_) {
      if (!_disposed) { _purchasePending = false; lastError = 'error'; notifyListeners(); }
    });
    unawaited(refresh());
  }

  /// Mağazadan güncel sahiplik: iptal/süre bitimi burada düşer.
  Future<void> refresh() async {
    final generation = ++_refreshGeneration;
    _ownershipFresh = false;
    try {
      if (!await _iap.isAvailable() || _disposed) return;
      final addition = _iap.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final res = await addition.queryPastPurchases();
      if (res.error != null || _disposed || generation != _refreshGeneration) return;
      for (final p in res.pastPurchases.where((p) => ids.contains(p.productID) && p.pendingCompletePurchase)) {
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
    final purchased = <GooglePlayPurchaseDetails>[];
    for (final p in list) {
      if (!ids.contains(p.productID)) continue;
      if (p.pendingCompletePurchase) {
        try { await _iap.completePurchase(p); }
        catch (_) { if (!_disposed) lastError = 'error'; }
      }
      if (_disposed) return;
      switch (p.status) {
        case PurchaseStatus.purchased || PurchaseStatus.restored:
          if (p is GooglePlayPurchaseDetails) purchased.add(p);
          _purchasePending = false;
        case PurchaseStatus.error:
          _purchasePending = false; lastError = 'error';
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

  Future<List<SubscriptionOffer>> loadOffers() async {
    final res = await _iap.queryProductDetails(offerIds);
    final out = <SubscriptionOffer>[];
    for (final d in res.productDetails.whereType<GooglePlayProductDetails>()) {
      if (!offerIds.contains(d.id)) continue;
      final index = d.subscriptionIndex;
      final offers = d.productDetails.subscriptionOfferDetails;
      if (index == null || offers == null || index < 0 || index >= offers.length) continue;
      final o = offers[index];
      if (o.pricingPhases.isEmpty) continue;
      final recurring = o.pricingPhases.last;
      out.add(SubscriptionOffer(
        productId: d.id,
        basePlanId: o.basePlanId,
        price: recurring.formattedPrice,
        billingPeriod: recurring.billingPeriod,
        hasTrial: o.pricingPhases.first.priceAmountMicros == 0,
        details: d,
      ));
    }
    // Aynı base planın denemeli ve denemesiz teklifinden denemeliyi tut.
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
    _working = true; lastError = null; notifyListeners();
    try {
      await refresh();
      if (_disposed) return;
      if (!_ownershipFresh || !offerIds.contains(offer.productId) || (_productId != null && _owned == null)) {
        throw StateError('ownership_not_verified');
      }
      final old = _owned;
      final change = old != null && old.productID != offer.productId
          ? ChangeSubscriptionParam(oldPurchaseDetails: old, replacementMode: ReplacementMode.withTimeProration) : null;
      _purchasePending = true;
      final launched = await _iap.buyNonConsumable(purchaseParam: GooglePlayPurchaseParam(
        productDetails: offer.details, changeSubscriptionParam: change));
      if (!launched) throw StateError('purchase_not_launched');
    } catch (_) { _purchasePending = false; lastError = 'error'; }
    finally { _working = false; if (!_disposed) notifyListeners(); }
  }

  Future<void> restore() async {
    if (busy || _disposed) return;
    _working = true; lastError = null; notifyListeners();
    try {
      await _iap.restorePurchases(); await refresh();
      if (!_ownershipFresh && !_disposed) throw StateError('ownership_not_verified');
    } catch (_) { lastError = 'error'; }
    finally { _working = false; if (!_disposed) notifyListeners(); }
  }

  @override
  void dispose() {
    _disposed = true;
    _sub?.cancel();
    super.dispose();
  }
}
