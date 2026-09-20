import '../money/decimal_fixed.dart';

/// Satır düzeyi formüller (spec §7.3). Hepsi saf fonksiyondur; yuvarlama
/// yalnızca bölmede tanımlı ölçekte yapılır (DecimalFixed kuralı).
class LineCalc {
  LineCalc._();

  static const int _percentScale = 6;

  /// plannedLineTotal = plannedQuantity × plannedUnitPrice
  static DecimalFixed plannedLineTotal(
          DecimalFixed quantity, DecimalFixed unitPrice) =>
      quantity * unitPrice;

  /// actualGrossTotal = actualQuantity × actualUnitPrice
  static DecimalFixed actualGrossTotal(
          DecimalFixed quantity, DecimalFixed unitPrice) =>
      quantity * unitPrice;

  /// actualLineTotal = actualGrossTotal − lineDiscount
  static DecimalFixed actualLineTotal(
          DecimalFixed grossTotal, DecimalFixed discount) =>
      grossTotal - discount;

  /// lineVariance = actualLineTotal − plannedLineTotal
  static DecimalFixed lineVariance(
          DecimalFixed actualLineTotal, DecimalFixed plannedLineTotal) =>
      actualLineTotal - plannedLineTotal;

  /// lineVariancePercent = variance / planned × 100; plan 0 iken null —
  /// UI "Hesaplanamaz" gösterir (spec §7.3: sonsuz/NaN/0% üretilmez).
  /// Bölme, yüzdeye ölçeklemeden 2 basamak yüksek hassasiyette yapılır.
  static DecimalFixed? lineVariancePercent(
      DecimalFixed variance, DecimalFixed plannedLineTotal) {
    if (plannedLineTotal.isZero) return null;
    return variance
        .divide(plannedLineTotal, scale: _percentScale + 2)
        .scaleToPercent()
        .rescale(_percentScale);
  }
}

extension _PercentX on DecimalFixed {
  DecimalFixed scaleToPercent() =>
      this * DecimalFixed.fromMinorUnits(100, 0);
}

/// Fiyat ve miktar etkisinin ayrıştırması (spec §7.3). Ortak birim yoksa
/// etkiler hesaplanamaz → null döner; çağıran taraf açıklama alanı gösterir.
class EffectSplit {
  const EffectSplit({required this.priceEffect, required this.quantityEffect});

  /// priceEffect = actualQuantity × (actualUnitPrice − plannedUnitPrice)
  final DecimalFixed? priceEffect;

  /// quantityEffect = (actualQuantity − plannedQuantity) × plannedUnitPrice
  final DecimalFixed? quantityEffect;

  bool get computable => priceEffect != null && quantityEffect != null;

  /// Ortak birim yalnızca iki tarafın birimi aynıysa vardır.
  static EffectSplit compute({
    required DecimalFixed plannedQuantity,
    required DecimalFixed plannedUnitPrice,
    required DecimalFixed actualQuantity,
    required DecimalFixed actualUnitPrice,
    required bool sameUnit,
  }) {
    if (!sameUnit) {
      return const EffectSplit(priceEffect: null, quantityEffect: null);
    }
    final price = actualQuantity * (actualUnitPrice - plannedUnitPrice);
    final qty = (actualQuantity - plannedQuantity) * plannedUnitPrice;
    return EffectSplit(priceEffect: price, quantityEffect: qty);
  }
}
