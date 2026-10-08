import 'package:napp_pro/napp_pro.dart';

/// napp_pro'nun ProController'ı akıştaki her "purchased" olayını ömür boyu
/// Pro sayar; abonelikler (PB-055) aynı mağaza akışından geldiği için bu
/// sarmalayıcı akışı yalnız ömür boyu ürüne süzer. Diğer ürünlerin
/// tamamlanmasını SubscriptionService yapar.
class LifetimeOnlyAdapter implements StoreAdapter {
  LifetimeOnlyAdapter(this.inner, {required this.productId});

  final StoreAdapter inner;
  final String productId;

  @override
  Stream<List<StorePurchaseUpdate>> get updates => inner.updates
      .map((list) => list.where((u) => u.purchase.productId == productId).toList())
      .where((list) => list.isNotEmpty);

  @override
  Future<List<StoreProduct>> queryProducts(Set<String> productIds) => inner.queryProducts(productIds);

  @override
  Future<void> buy(StoreProduct product) => inner.buy(product);

  @override
  Future<void> restore() => inner.restore();
}
