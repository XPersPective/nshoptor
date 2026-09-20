import '../money/decimal_fixed.dart';
import 'unit_code.dart';

/// Ambalaj içeriği tanımı: `1 paket = 500 g` gibi (spec §7.2).
///
/// Kullanıcı tanımlıdır ve ürüne/ambalaj varyantına bağlıdır; doğrulaması
/// olmadan genellenmez. Örneğin `1 [UnitCode.paket] = 500 [UnitCode.gram]`
/// tanımı, paket↔gram dönüşümünü yalnız o ürün için mümkün kılar.
class PackagingContent {
  factory PackagingContent({
    required UnitCode unit,
    required DecimalFixed contentQuantity,
    required UnitCode contentUnit,
  }) {
    if (!contentQuantity.isPositive) {
      throw ArgumentError('içerik miktarı pozitif olmalı');
    }
    return PackagingContent._(
      unit: unit,
      contentQuantity: contentQuantity,
      contentUnit: contentUnit,
    );
  }

  const PackagingContent._({
    required this.unit,
    required this.contentQuantity,
    required this.contentUnit,
  });

  /// Ambalaj birimi: paket, kutu, şişe, kavanoz, demet, adet...
  final UnitCode unit;

  /// İçerik miktarı: pozitif olmalıdır.
  final DecimalFixed contentQuantity;

  /// İçerik birimi: kütle, hacim veya sayı ailesinden olmalıdır.
  final UnitCode contentUnit;

  /// Bu tanım geçerli mi? İçerik birimi bilinmeyen ailedeyse tanım anlamsızdır.
  bool get isValid =>
      contentUnit.dimension != UnitDimension.unknown &&
      contentUnit.dimension != unit.dimension;

  /// [quantity] [unit] miktarını içerik birimine çevirir:
  /// `n paket × 500 g/paket`. Tanım geçersizse [StateError].
  DecimalFixed toContent(DecimalFixed quantity) {
    if (!isValid) {
      throw StateError('geçersiz ambalaj içeriği tanımı');
    }
    return quantity * contentQuantity;
  }
}
