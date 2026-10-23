import '../money/decimal_fixed.dart';
import '../quantity/unit_code.dart';
import '../quantity/unit_conversion.dart';

/// A price always belongs to a stated quantity and unit. Never multiply a
/// selected-quantity total by that quantity for a second time.
class PriceInput {
  PriceInput._();

  static UnitCode displayUnit(UnitCode quantityUnit) => switch (quantityUnit) {
    UnitCode.gram => UnitCode.kilogram,
    UnitCode.mililitre => UnitCode.litre,
    _ => quantityUnit,
  };

  static DecimalFixed total({
    required DecimalFixed amount,
    required DecimalFixed quantity,
    required UnitCode quantityUnit,
    required bool isUnitPrice,
    UnitCode? priceUnit,
    DecimalFixed? priceQuantity,
  }) {
    if (!quantity.isPositive || amount.isNegative) {
      throw ArgumentError('Invalid price quantity');
    }
    if (!isUnitPrice) return amount;
    final basis = priceQuantity ?? DecimalFixed.fromInt(1);
    if (!basis.isPositive) throw ArgumentError('Invalid price basis');
    final count = UnitConversion.convert(
      quantity,
      quantityUnit,
      priceUnit ?? quantityUnit,
    );
    // The product is exact; division is rounded only at the existing maximum
    // precision, with the final currency rounding performed by the caller.
    return (amount * count).divide(
      basis,
      scale: DecimalFixed.maxFractionDigits,
    );
  }

  static DecimalFixed unitFromTotal({
    required DecimalFixed amount,
    required DecimalFixed quantity,
    required UnitCode quantityUnit,
    UnitCode? priceUnit,
  }) {
    if (!quantity.isPositive || amount.isNegative) {
      throw ArgumentError('Invalid price quantity');
    }
    final count = UnitConversion.convert(
      quantity,
      quantityUnit,
      priceUnit ?? quantityUnit,
    );
    return amount.divide(count, scale: DecimalFixed.maxFractionDigits);
  }
}
