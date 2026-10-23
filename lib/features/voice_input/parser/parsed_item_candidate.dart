import '../../../core/money/decimal_fixed.dart';
import '../../../core/quantity/unit_code.dart';

enum VoicePriceDestination { planned, actual }

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
    this.priceUnitCode,
    this.priceDestination = VoicePriceDestination.planned,
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
  /// Null with a price requires the user to choose its meaning before saving.
  final bool? isUnitPrice;

  /// Unit named by an explicit per-unit price, independent of quantity unit.
  /// Example: 400 grams at 875 per kilogram keeps gram + kilogram separately.
  final UnitCode? priceUnitCode;

  final VoicePriceDestination priceDestination;

  bool get requiresPriceConfirmation => unitPrice != null && isUnitPrice == null;

  bool get fullyParsed =>
      name.trim().isNotEmpty && quantity != null && unitCode != null;
}
