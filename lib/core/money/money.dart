import 'currency.dart';
import 'decimal_fixed.dart';

/// Minor unit (ör. kuruş) tam sayısı + [Currency] olarak para.
///
/// Tek yuvarlama noktası: [Money.fromDecimal] (yarıdan uzağa). Minor unit
/// değerleri int olarak saklanır; farklı para birimleri arasında aritmetik ve
/// karşılaştırma [ArgumentError] ile reddedilir (spec §7.1: kur olmadan
/// dönüşüm/denetim yok).
class Money implements Comparable<Money> {
  const Money._(this.minorUnits, this.currency);

  const Money.zero(Currency currency) : this._(0, currency);

  /// Minor unit değerinden üretir; kesinleşmiş değerlerin deposu budur.
  const Money.fromMinorUnits(this.minorUnits, this.currency);

  /// [value] değerini para biriminin minor basamağına yarıdan uzağa
  /// yuvarlar. Girişteki tek yuvarlama budur; sonuç kesindir.
  factory Money.fromDecimal(DecimalFixed value, Currency currency) =>
      Money._(value.toMinorUnits(currency.minorUnitDigits), currency);

  final int minorUnits;
  final Currency currency;

  bool get isZero => minorUnits == 0;
  bool get isNegative => minorUnits < 0;
  bool get isPositive => minorUnits > 0;

  Money operator -() => Money._(-minorUnits, currency);

  Money operator +(Money other) {
    _requireSame(other);
    return Money._(minorUnits + other.minorUnits, currency);
  }

  Money operator -(Money other) {
    _requireSame(other);
    return Money._(minorUnits - other.minorUnits, currency);
  }

  /// Adet gibi tam sayı çarpanıyla ölçekleme; para × para geçersizdir.
  Money scaledBy(int factor) => Money._(minorUnits * factor, currency);

  Money abs() => Money._(minorUnits.abs(), currency);

  /// Minor unit değerinin [DecimalFixed] karşılığı (majör birimde).
  DecimalFixed toDecimal() => DecimalFixed.fromMinorUnits(minorUnits, currency.minorUnitDigits);

  void _requireSame(Money other) {
    if (currency != other.currency) {
      throw ArgumentError(
          'farklı para birimleri: ${currency.code} ve ${other.currency.code}');
    }
  }

  @override
  int compareTo(Money other) {
    _requireSame(other);
    return minorUnits.compareTo(other.minorUnits);
  }

  bool operator <(Money other) => compareTo(other) < 0;
  bool operator <=(Money other) => compareTo(other) <= 0;
  bool operator >(Money other) => compareTo(other) > 0;
  bool operator >=(Money other) => compareTo(other) >= 0;

  @override
  bool operator ==(Object other) =>
      other is Money &&
      other.minorUnits == minorUnits &&
      other.currency == currency;

  @override
  int get hashCode => Object.hash(minorUnits, currency);

  @override
  String toString() => '${currency.code} $minorUnits';
}
