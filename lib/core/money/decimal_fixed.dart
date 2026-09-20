/// String tabanlı sabit ölçekli ondalık sayı.
///
/// Parasal ve ondalıklı hesaplamalarda `double` KULLANILMAZ (spec §7.1); değer
/// `[BigInt]` unscaled + `int` scale olarak tutulur: değer = unscaled / 10^scale.
///
/// Yuvarlama kuralı (tek kural, yalnız tanımlı sınırda): **yarıdan uzağa**
/// (half away from zero). Yuvarlama yalnız [rescale], [divide] ve
/// [toMinorUnits] sınırlarında yapılır; ara çarpımlarda yapılmaz.
class DecimalFixed implements Comparable<DecimalFixed> {
  const DecimalFixed._(this.unscaled, this.scale)
      : assert(scale >= 0),
        assert(scale <= _maxInternalScale);

  /// Depolama ve kullanıcı girişi için ondalık basamak sınırı.
  static const int maxFractionDigits = 6;

  /// Ara hesaplarda izin verilen en büyük ölçek (çarpım ölçek toplamı).
  static const int _maxInternalScale = 12;

  /// Tamsayı kısmı için izin verilen maksimum basamak (aşırı büyük girişe karşı).
  static const int _maxIntegerDigits = 15;

  final BigInt unscaled;
  final int scale;

  static final BigInt _ten = BigInt.from(10);

  static DecimalFixed zero() => DecimalFixed._(BigInt.zero, 0);

  static DecimalFixed fromInt(int value, [int scale = 0]) =>
      DecimalFixed._(BigInt.from(value) * _ten.pow(scale), scale);

  /// Minor unit tam sayısını majör birimde [DecimalFixed]'a çevirir
  /// (ör. 6435 kuruş, 2 basamak → 64.35). Yuvarlama yoktur.
  static DecimalFixed fromMinorUnits(int minorUnits, int digits) =>
      DecimalFixed._(BigInt.from(minorUnits), digits);

  /// Sıkı ayrıştırma: `[işaret]basamaklar[.basamaklar]`; boşluk, binlik ayraç,
  /// boş kesir kabul edilmez. Kanonik ondalık ayracı `.`'dır; yerel ayraç
  /// dönüşümü `MoneyParser`'ın işidir. Maksimum [_maxIntegerDigits] tamsayı
  /// ve [maxFractionDigits] ondalık basamak; aşımında [FormatException].
  static DecimalFixed parse(String input) {
    final s = input.trim();
    if (s.isEmpty) {
      throw const FormatException('boş girdi');
    }
    final match = RegExp(r'^([+-]?)(\d+)(?:\.(\d+))?$').firstMatch(s);
    if (match == null) {
      throw FormatException('geçersiz ondalık sayı: "$input"');
    }
    final sign = match.group(1) == '-' ? -1 : 1;
    final intPart = match.group(2)!;
    final fracPart = match.group(3) ?? '';
    if (intPart.length > _maxIntegerDigits) {
      throw FormatException('değer çok büyük: "$input"');
    }
    if (fracPart.length > maxFractionDigits) {
      throw FormatException(
          'en fazla $maxFractionDigits ondalık basamak desteklenir: "$input"');
    }
    final digits = fracPart.isEmpty
        ? BigInt.parse(intPart)
        : BigInt.parse('$intPart$fracPart');
    final unscaled = BigInt.from(sign) * digits;
    return DecimalFixed._(unscaled, fracPart.length);
  }

  static DecimalFixed? tryParse(String input) {
    try {
      return parse(input);
    } on FormatException {
      return null;
    }
  }

  DecimalFixed operator +(DecimalFixed other) =>
      DecimalFixed._(_aligned(other).unscaled + other._aligned(this).unscaled,
          scale >= other.scale ? scale : other.scale);

  DecimalFixed operator -(DecimalFixed other) =>
      DecimalFixed._(_aligned(other).unscaled - other._aligned(this).unscaled,
          scale >= other.scale ? scale : other.scale);

  /// Tam çarpım: ölçekler toplanır, ara yuvarlama YOK.
  DecimalFixed operator *(DecimalFixed other) => DecimalFixed._(
      unscaled * other.unscaled,
      (scale + other.scale).clamp(0, _maxInternalScale));

  /// [scale] ondalık basamaklı bölüm; yarıdan uzağa yuvarlama uygulanır.
  DecimalFixed divide(DecimalFixed other, {required int scale}) {
    if (other.unscaled == BigInt.zero) {
      throw ArgumentError('sıfıra bölüm');
    }
    final k = scale - this.scale + other.scale;
    if (k >= 0) {
      return DecimalFixed._(
          _divRound(unscaled * _ten.pow(k), other.unscaled), scale);
    }
    return DecimalFixed._(
        _divRound(unscaled, other.unscaled * _ten.pow(-k)), scale);
  }

  /// Yeni ölçeğe çevirir; küçültmede yarıdan uzağa yuvarlama uygulanır.
  DecimalFixed rescale(int newScale) {
    if (newScale == scale) return this;
    if (newScale > scale) {
      return DecimalFixed._(unscaled * _ten.pow(newScale - scale), newScale);
    }
    return DecimalFixed._(_divRound(unscaled, _ten.pow(scale - newScale)),
        newScale);
  }

  DecimalFixed abs() =>
      DecimalFixed._(unscaled.abs(), scale);

  DecimalFixed negated() => DecimalFixed._(-unscaled, scale);

  bool get isZero => unscaled == BigInt.zero;
  bool get isNegative => unscaled < BigInt.zero;
  bool get isPositive => unscaled > BigInt.zero;

  /// Yarıdan uzağa yuvarlayıp int'e çevirir.
  int roundToInt() => _divRound(unscaled, BigInt.one).toInt();

  /// [digits] minor unit basamağına yarıdan uzağa yuvarlayarak minor unit
  /// değerini döndürür — Money'a dönüşümün tek noktası.
  int toMinorUnits(int digits) => rescale(digits).unscaled.toInt();

  /// Kanonik dize gösterimi (veritabanı saklaması için kararlı): `1234.5600`.
  String toDbString() {
    if (scale == 0) return unscaled.toString();
    final negative = unscaled < BigInt.zero;
    final digits = unscaled.abs().toString().padLeft(scale + 1, '0');
    final cut = digits.length - scale;
    return '${negative ? "-" : ""}${digits.substring(0, cut)}.'
        '${digits.substring(cut)}';
  }

  BigInt _divRound(BigInt n, BigInt d) {
    assert(d != BigInt.zero);
    var q = n ~/ d;
    final r = n - q * d;
    final twice = (r * BigInt.from(2)).abs();
    if (twice >= d.abs()) {
      q += (n < BigInt.zero) == (d < BigInt.zero)
          ? BigInt.one
          : -BigInt.one;
    }
    return q;
  }

  DecimalFixed _aligned(DecimalFixed other) => scale >= other.scale
      ? this
      : rescale(other.scale);

  @override
  int compareTo(DecimalFixed other) =>
      _aligned(other).unscaled.compareTo(other._aligned(this).unscaled);

  bool operator <(DecimalFixed other) => compareTo(other) < 0;
  bool operator <=(DecimalFixed other) => compareTo(other) <= 0;
  bool operator >(DecimalFixed other) => compareTo(other) > 0;
  bool operator >=(DecimalFixed other) => compareTo(other) >= 0;

  @override
  bool operator ==(Object other) =>
      other is DecimalFixed && compareTo(other) == 0;

  @override
  int get hashCode => rescale(maxFractionDigits).unscaled.hashCode;

  @override
  String toString() => toDbString();
}
