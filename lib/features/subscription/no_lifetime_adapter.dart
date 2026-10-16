import 'package:napp_pro/napp_pro.dart';

/// Ömür boyu satın alma yok (yalnız Max, Pro ve ücretsiz). napp_pro'nun
/// ProController'ı geçici Pro (ödüllü hediye) için kalır; bu sarmalayıcı
/// mağaza akışını hiçbir ürün için iletmez, böylece kalıcı Pro oluşmaz.
class NoLifetimePurchaseAdapter implements StoreAdapter {
  NoLifetimePurchaseAdapter(this.inner);

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
