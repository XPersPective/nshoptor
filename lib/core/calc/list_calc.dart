import '../money/currency.dart';
import '../money/decimal_fixed.dart';
import '../money/money.dart';

/// Liste düzeyi toplamlar ve projeksiyon (spec §7.3). Girdiler satır
/// katmanında hesaplanmış [Money] değerleridir; para birimi uyuşmazlığı
/// Money aritmetiğinde zaten reddedilir.
class ListCalc {
  ListCalc._();

  /// plannedTotal = tüm planlanan satır toplamları; boş girdi [currency]
  /// cinsinden sıfır döner.
  static Money plannedTotal(Iterable<Money> lineTotals, Currency currency) =>
      _sum(lineTotals, currency);

  /// actualTotal = tüm doğrulanmış satın alım satır satırları.
  static Money actualTotal(Iterable<Money> lineTotals, Currency currency) =>
      _sum(lineTotals, currency);

  /// totalVariance = actualTotal − plannedTotal
  static Money totalVariance(Money actualTotal, Money plannedTotal) =>
      actualTotal - plannedTotal;

  /// projectedCheckoutTotal = sepetteki gerçek + kalan plan tahmini
  static Money projectedCheckoutTotal(
          Money purchasedActualTotal, Money remainingPlannedEstimate) =>
      purchasedActualTotal + remainingPlannedEstimate;

  /// budgetRemaining = budgetLimit − projectedCheckoutTotal.
  /// Bütçe girilmemişse null; negatif değer bütçe aşımıdır.
  static Money? budgetRemaining(Money? budgetLimit, Money projected) {
    if (budgetLimit == null) return null;
    return budgetLimit - projected;
  }

  /// Plansız alınan ürünlerin toplamı (sonuçta ayrı gösterilir).
  static Money unplannedTotal(
          Iterable<Money> unplannedLineTotals, Currency currency) =>
      _sum(unplannedLineTotals, currency);

  /// Planlanıp alınmayan ürünlerin planlanan toplamı. Alınmayanlar gerçeğe
  /// 0 olarak YAZILMAZ; bu toplam ayrı anlamlıdır (spec §6.6).
  static Money unpurchasedPlannedTotal(
          Iterable<Money> plannedLineTotals, Currency currency) =>
      _sum(plannedLineTotals, currency);

  /// Tahmin doğruluk oranı: max(0, 100 − |varyans|/planned × 100).
  /// Plan 0 iken null. Sonuç 6 basamaklı yüzdesel [DecimalFixed].
  static DecimalFixed? estimateAccuracy(Money plannedTotal, Money actualTotal) {
    if (plannedTotal.isZero) return null;
    final variance = totalVariance(actualTotal, plannedTotal);
    final planned = DecimalFixed.fromMinorUnits(
        plannedTotal.minorUnits, plannedTotal.currency.minorUnitDigits);
    final varianceDecimal = DecimalFixed.fromMinorUnits(
        variance.minorUnits.abs(), variance.currency.minorUnitDigits);
    final ratioPercent = varianceDecimal.divide(planned, scale: 6) *
        DecimalFixed.fromMinorUnits(100, 0);
    if (ratioPercent >= DecimalFixed.fromMinorUnits(100, 0)) {
      return DecimalFixed.zero();
    }
    return DecimalFixed.fromMinorUnits(100, 0) - ratioPercent;
  }

  static Money _sum(Iterable<Money> totals, Currency currency) {
    var minor = 0;
    for (final t in totals) {
      if (t.currency != currency) {
        throw ArgumentError(
            'farklı para birimleri toplanamaz: ${currency.code}/${t.currency.code}');
      }
      minor += t.minorUnits;
    }
    return Money.fromMinorUnits(minor, currency);
  }
}
