import '../../../core/money/decimal_fixed.dart';

/// Fiş ayrıştırıcı çıktı adayları (spec §6.9).
class ReceiptLineCandidate {
  const ReceiptLineCandidate({
    required this.rawText,
    required this.name,
    required this.normalizedName,
    this.quantity,
    this.unitPriceMinor,
    required this.lineTotalMinor,
    required this.confidence,
  });

  final String rawText;
  final String name;
  final String normalizedName;
  final DecimalFixed? quantity;
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
  static const int parserVersion = 1;
  final List<String> storeCandidates;
  final DateTime? dateCandidate;
  final String? currencyCandidate;
  final int? subtotalMinor;
  final int? discountMinor;
  final int? taxMinor;
  final int? totalMinor;
  final List<ReceiptLineCandidate> lines;

  /// Kabul edilen ürün satırlarının toplamı.
  final int computedTotalMinor;

  /// Bildirilen genel toplam ile hesaplanan fark (uzlaştırma raporu,
  /// spec §6.9: gizlice silinmez).
  final int reconciliationDifferenceMinor;
  final bool withinReconciliationTolerance;
}
