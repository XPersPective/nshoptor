import '../../../core/money/decimal_fixed.dart';
import '../../../core/quantity/unit_code.dart';

/// Ses komutundan çıkarılan ürün adayı (spec §6.7).
///
/// Alanlar adaydır: belirsiz olanlar null kalır ve kullanıcı önizleme
/// ekranında doldurur. Hiçbir alan veri kaybıyla atlanmaz — tanınmayan
/// metin [name] içinde korunur.
class ParsedItemCandidate {
  const ParsedItemCandidate({
    required this.name,
    required this.rawText,
    this.quantity,
    this.unitCode,
    this.unitPrice,
    this.currencyCode,
    this.isUnitPrice,
    this.brand,
    this.category,
  });

  final String name;
  final String rawText;
  final String? brand;
  final String? category;
  final DecimalFixed? quantity;
  final UnitCode? unitCode;
  final DecimalFixed? unitPrice;
  final String? currencyCode;

  /// true: fiyat BİRİM fiyat olarak anlaşıldı (ör. "kilosu kırk beş lira");
  /// false: satır toplamı olarak anlaşıldı.
  final bool? isUnitPrice;

  bool get fullyParsed =>
      name.trim().isNotEmpty && quantity != null && unitCode != null;
}
