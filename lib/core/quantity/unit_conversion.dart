import '../money/decimal_fixed.dart';
import 'unit_code.dart';

/// Güvenli birim dönüşümü (spec §7.2).
///
/// Dönüşüm grupları:
/// - Kütle: kg ↔ g
/// - Hacim: L ↔ ml
/// - Sayım: adet ↔ düzine (yalnız açık istekle: [convert] `allowCount=true`)
///
/// Paket/kutu/şişe/kavanoz/demet gibi içerik miktarı bilinmeyen birimler
/// kg/L/adet ile DÖNÜŞTÜRÜLEMEZ: [UnsupportedConversionError] fırlatılır.
class UnitConversion {
  UnitConversion._();

  /// Aynı aile içinde [to] birimine çevirir. [allowCount] adet↔düzine
  /// dönüşümünü açar; varsayılan kapalıdır (yanlışlıkla 12 kat hata olmasın).
  ///
  /// Sonuç tam değilse 6 ondalık basamağa yuvarlanır (DecimalFixed üst sınırı).
  static DecimalFixed convert(
    DecimalFixed quantity,
    UnitCode from,
    UnitCode to, {
    bool allowCount = false,
  }) {
    if (from == to) return quantity;
    if (from.dimension != to.dimension ||
        from.dimension == UnitDimension.unknown) {
      throw UnsupportedConversionError(from, to);
    }
    if (from.dimension == UnitDimension.count && !allowCount) {
      throw UnsupportedConversionError(from, to);
    }
    final converted = switch ((from, to)) {
      (UnitCode.kilogram, UnitCode.gram) ||
      (UnitCode.litre, UnitCode.mililitre) =>
        _mul(quantity, 1000),
      (UnitCode.gram, UnitCode.kilogram) ||
      (UnitCode.mililitre, UnitCode.litre) =>
        _div(quantity, 1000),
      (UnitCode.duzine, UnitCode.adet) => _mul(quantity, 12),
      (UnitCode.adet, UnitCode.duzine) => _div(quantity, 12),
      _ => throw UnsupportedConversionError(from, to),
    };
    return converted;
  }

  /// [to] birimindeki karşılığı; dönüşümsüzse null (karşılaştırma yapılamaz).
  static DecimalFixed? tryConvertToBase(
    DecimalFixed quantity,
    UnitCode unit, {
    bool allowCount = false,
  }) =>
      switch (unit) {
        UnitCode.kilogram ||
        UnitCode.litre ||
        UnitCode.adet ||
        UnitCode.metre =>
          quantity,
        UnitCode.gram => _to(quantity, 1000),
        UnitCode.mililitre => _to(quantity, 1000),
        UnitCode.duzine => allowCount ? _mul(quantity, 12) : null,
        _ => null,
      };

  static DecimalFixed _to(DecimalFixed q, int divisor) => _div(q, divisor);

  static DecimalFixed _mul(DecimalFixed q, int factor) =>
      q * DecimalFixed.fromMinorUnits(factor, 0);

  static DecimalFixed _div(DecimalFixed q, int divisor) =>
      q.divide(DecimalFixed.fromMinorUnits(divisor, 0), scale: 6);
}

/// İçerik bilgisi olmadan yapılamayacak dönüşüm denendiğinde fırlatır.
class UnsupportedConversionError implements Exception {
  UnsupportedConversionError(this.from, this.to);

  final UnitCode from;
  final UnitCode to;

  @override
  String toString() =>
      'dönüşüm desteklenmiyor: ${from.dbCode} → ${to.dbCode}';
}
