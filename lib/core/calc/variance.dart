import '../money/decimal_fixed.dart';
import '../money/money.dart';

/// Ürünün tahmine göre durumu (sonuç ekranı grupları, spec §6.11).
enum VarianceDirection { pricier, cheaper, close }

/// "Tahmine yakın" eşiği — tek merkez, test edilebilir (spec §7.3).
///
/// Varsayılan: yüzde %10 EŞİĞİ VEYA mutlak 2,00 para birimi (200 minor
/// unit). İkisinden biri sağlanırsa "yakın" sayılır (VEYA birleşimi).
/// Ayarlar'da aşırı karmaşadan kaçınılarak yalnız bu varsayılanlar kullanılır.
class VarianceThreshold {
  VarianceThreshold({DecimalFixed? percent, int? absoluteMinorUnits})
      : percent = percent ?? _defaultPercent,
        absoluteMinorUnits = absoluteMinorUnits ?? defaultAbsoluteMinorUnits;

  static final DecimalFixed _defaultPercent = DecimalFixed.parse('10');
  static const int defaultAbsoluteMinorUnits = 200;

  /// Yüzde eşiği: 10 = %10.
  final DecimalFixed percent;

  /// Mutlak para eşiği: minor unit cinsinden.
  final int absoluteMinorUnits;

  /// [variancePercent] 6 basamaklı yüzdesel değerdir (ör. 12.5 = %12,5);
  /// [varianceAmount] satır farkının kendisidir.
  bool isClose(DecimalFixed variancePercent, Money varianceAmount) =>
      variancePercent.abs() <= percent ||
      varianceAmount.minorUnits.abs() <= absoluteMinorUnits;

  VarianceDirection classify(
      DecimalFixed variancePercent, Money varianceAmount) {
    if (isClose(variancePercent, varianceAmount)) {
      return VarianceDirection.close;
    }
    return varianceAmount.isNegative
        ? VarianceDirection.cheaper
        : VarianceDirection.pricier;
  }
}

/// Yuvarlama uzlaştırma toleransı: satır toplamları ile fiş genel toplamı
/// arasındaki fark bu sınırın içindeyse "yuvarlamadan" ibarettir; yine de
/// raporlanır, gizlice SİLİNMEZ (spec §7.3, §6.9).
class ReconciliationTolerance {
  ReconciliationTolerance._();

  /// Varsayılan: ±2 minor unit (TRY'de ±2 kuruş).
  static const int defaultMinorUnits = 2;

  static bool withinTolerance(Money difference,
          {int toleranceMinorUnits = defaultMinorUnits}) =>
      difference.minorUnits.abs() <= toleranceMinorUnits;
}
