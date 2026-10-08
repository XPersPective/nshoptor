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

  static const proId = 'nshoptor_pro';
  static const maxId = 'nshoptor_max';
  static const ids = {proId, maxId};
  static const _productKey = 'sub_product';
  static const _tokenKey = 'sub_token';

  final SettingsStore store;
  final InAppPurchase? _iapOverride;
  InAppPurchase get _iap => _iapOverride ?? InAppPurchase.instance;

  StreamSubscription<List<PurchaseDetails>>? _sub;
  GooglePlayPurchaseDetails? _owned;
  String? _productId;
  String? _token;

  /// Satın alma sonucu (paywall gösterir): null = sorun yok.
  String? lastError;

  /// Boot'ta bağlanan tek örnek (kota mesajlarından planlara geçiş için).
  static SubscriptionService? instance;

  static Tier tierOf(String? productId) => switch (productId) {
        maxId => Tier.max,
        proId => Tier.pro,
        _ => Tier.free,
      };

  Tier get tier => tierOf(_productId);

  /// Reklamsız mı: ömür boyu/geçici Pro ya da herhangi bir abonelik.
  static bool adFree({required bool lifetimeOrTemp, required Tier tier}) =>
      lifetimeOrTemp || tier != Tier.free;
  String? get productId => _productId;

  /// AI isteğine eklenen doğrulanacak jeton; ücretsizde null.
  PurchaseCredential? get credential =>
      _token == null || _productId == null ? null : (token: _token!, productId: _productId!);

  void load() {
    _productId = store.getString(_productKey);
    _token = store.getString(_tokenKey);
  }

  /// Sahip olunan abonelikleri uygular: max > pro; hiçbiri yoksa ücretsiz.
  @visibleForTesting
  void applyOwned(List<({String productId, String token})> owned) {
    final relevant = owned.where((o) => ids.contains(o.productId)).toList()
      ..sort((a, b) => tierOf(b.productId).index.compareTo(tierOf(a.productId).index));
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

  void start() {
    _sub ??= _iap.purchaseStream.listen(_onPurchases, onError: (_) {});
    unawaited(refresh());
  }

  /// Mağazadan güncel sahiplik: iptal/süre bitimi burada düşer.
  Future<void> refresh() async {
    try {
      if (!await _iap.isAvailable()) return;
      final addition = _iap.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final res = await addition.queryPastPurchases();
      if (res.error != null) return;
      final owned = res.pastPurchases
          .where((p) => ids.contains(p.productID) && p.status != PurchaseStatus.pending)
          .toList();
      _owned = owned.isEmpty ? null : owned.first;
      applyOwned([
        for (final p in owned) (productId: p.productID, token: p.verificationData.serverVerificationData),
      ]);
    } catch (_) {
      // mağaza yoksa (emülatör/çevrimdışı) son bilinen durum korunur
    }
  }

  Future<void> _onPurchases(List<PurchaseDetails> list) async {
    for (final p in list) {
      if (!ids.contains(p.productID)) continue;
      if (p.pendingCompletePurchase) {
        try {
          await _iap.completePurchase(p);
        } catch (_) {}
      }
      switch (p.status) {
        case PurchaseStatus.purchased || PurchaseStatus.restored:
          if (p is GooglePlayPurchaseDetails) _owned = p;
          lastError = null;
          applyOwned([(productId: p.productID, token: p.verificationData.serverVerificationData)]);
        case PurchaseStatus.error:
          lastError = p.error?.message ?? 'error';
          notifyListeners();
        case PurchaseStatus.pending || PurchaseStatus.canceled:
          break;
      }
    }
  }

  Future<List<SubscriptionOffer>> loadOffers() async {
    final res = await _iap.queryProductDetails(ids);
    final out = <SubscriptionOffer>[];
    for (final d in res.productDetails.whereType<GooglePlayProductDetails>()) {
      final index = d.subscriptionIndex;
      final offers = d.productDetails.subscriptionOfferDetails;
      if (index == null || offers == null) continue;
      final o = offers[index];
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
    lastError = null;
    final old = _owned;
    final change = old != null && old.productID != offer.productId
        ? ChangeSubscriptionParam(
            oldPurchaseDetails: old,
            replacementMode: ReplacementMode.withTimeProration,
          )
        : null;
    await _iap.buyNonConsumable(
      purchaseParam: GooglePlayPurchaseParam(
        productDetails: offer.details,
        changeSubscriptionParam: change,
      ),
    );
  }

  Future<void> restore() async {
    await _iap.restorePurchases();
    await refresh();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
