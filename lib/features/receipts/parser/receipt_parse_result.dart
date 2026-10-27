import '../../../core/quantity/unit_code.dart';
import '../../../core/money/decimal_fixed.dart';

/// A printed discount summary may already be reflected in product prices.
/// Only exact equality with a known total proves that it must not be deducted
/// again. Missing/mismatched totals retain the observed positive deduction for
/// review; tolerance must never be used to infer this accounting choice.
int receiptDiscountToApplyMinor({
  required int productSumMinor,
  required int? observedDiscountMinor,
  required int? reportedTotalMinor,
}) {
  if (reportedTotalMinor != null && productSumMinor == reportedTotalMinor) {
    return 0;
  }
  final observed = observedDiscountMinor ?? 0;
  return observed > 0 ? observed : 0;
}

/// Fiş ayrıştırıcı çıktı adayları (spec §6.9).
class ReceiptLineCandidate {
  const ReceiptLineCandidate({
    required this.rawText,
    required this.name,
    required this.normalizedName,
    this.quantity,
    this.unitCode,
    this.unitPriceMinor,
    required this.lineTotalMinor,
    required this.confidence,
  });

  final String rawText;
  final String name;
  final String normalizedName;
  final DecimalFixed? quantity;
  final UnitCode? unitCode;
  final int? unitPriceMinor;
  final int lineTotalMinor;

  /// high: net ürün+fiyat satırı; medium: kısmi; low: belirsiz.
  /// Düşük ve orta güven OTOMATİK kesinleştirilmez (spec §6.9).
  final String confidence;
}

class ReceiptParseResult {
  const ReceiptParseResult({
    required this.storeCandidates,
    required this.dateCandidate,
    required this.currencyCandidate,
    this.currencyNeedsConfirmation = false,
    required this.subtotalMinor,
    required this.discountMinor,
    required this.taxMinor,
    required this.totalMinor,
    required this.lines,
    required this.computedTotalMinor,
    required this.reconciliationDifferenceMinor,
    required this.withinReconciliationTolerance,
  });

  /// Üretici sürümü; yedek/içe aktarma uyumluluğu için saklanır.
  static const int parserVersion = 2;
  final List<String> storeCandidates;
  final DateTime? dateCandidate;
  final String? currencyCandidate;
  final bool currencyNeedsConfirmation;
  final int? subtotalMinor;
  final int? discountMinor;

  /// Observed metadata above stays intact even when prices are already net.
  int get appliedDiscountMinor => receiptDiscountToApplyMinor(
    productSumMinor: lines.fold<int>(
      0,
      (sum, line) => sum + line.lineTotalMinor,
    ),
    observedDiscountMinor: discountMinor,
    reportedTotalMinor: totalMinor,
  );
  final int? taxMinor;
  final int? totalMinor;
  final List<ReceiptLineCandidate> lines;

  /// Ürün toplamı, yalnız uygulanması gereken indirim düşüldükten sonra.
  final int computedTotalMinor;

  /// Bildirilen genel toplam ile hesaplanan fark (uzlaştırma raporu,
  /// spec §6.9: gizlice silinmez).
  final int reconciliationDifferenceMinor;
  final bool withinReconciliationTolerance;
}
