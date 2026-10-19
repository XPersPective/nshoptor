import 'package:napp_pro/napp_pro.dart';

/// ProController için satın alma olaylarını kapalı tutar.
/// Abonelik mağaza akışı SubscriptionService tarafından yönetilir;
/// ProController yalnızca geçici Pro ödülünü temsil eder.
class SubscriptionPurchaseAdapter implements StoreAdapter {
  SubscriptionPurchaseAdapter(this.inner);

  final StoreAdapter inner;

  @override
  Stream<List<StorePurchaseUpdate>> get updates => const Stream.empty();

  @override
  Future<List<StoreProduct>> queryProducts(Set<String> productIds) async => const [];

  @override
  Future<void> buy(StoreProduct product) async {}

  @override
  Future<void> restore() async {}
}
