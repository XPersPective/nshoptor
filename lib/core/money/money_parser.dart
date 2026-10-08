import 'decimal_fixed.dart';

/// Yerel ayraç yapılandırması: ondalık ve binlik ayraç karakterleri.
class MoneySeparators {
  const MoneySeparators(this.decimal, this.thousands)
      : assert(decimal != thousands),
        assert(decimal.length == 1),
        assert(thousands.length == 1);

  final String decimal;
  final String thousands;

  /// Türkçe: ondalık `,`, binlik `.`.
  static const MoneySeparators tr = MoneySeparators(',', '.');

  /// İngilizce: ondalık `.`, binlik `,`.
  static const MoneySeparators en = MoneySeparators('.', ',');

  /// Ondalık virgül kullanan uygulama dilleri (PB-058); diğerleri [en].
  static const _commaDecimal = {'tr', 'de', 'fr', 'es', 'it', 'pt', 'ru'};

  static MoneySeparators forLocaleCode(String localeCode) =>
      _commaDecimal.contains(localeCode.toLowerCase().split(RegExp('[-_]')).first) ? tr : en;
}

/// Kullanıcı girişindeki yerel ondalık sayı ayrıştırıcısı.
///
/// Belirsizlik kuralı (deterministik ve test edilebilir, spec §13):
/// - Ayraç karakteri kendi rolüne göre yorumlanır: [MoneySeparators.decimal]
///   ondalık, [MoneySeparators.thousands] binliktir.
/// - Binlik ayracı geçerli gruplamak zorundadır: ilk grup 1-3, sonrakiler
///   tam 3 basamak. Geçersiz gruplama `FormatException` verir — tahmin edilmez.
/// - Ondalık ayracı en fazla bir kez görünebilir; ilk veya son karakter olamaz.
/// - Örnekler (tr): `1,5` → 1.5; `1.234,5` → 1234.5; `1.234` → 1234.
///   (en): `1.5` → 1.5; `1,234.5` → 1234.5; `1,234` → 1234; `1,23` → HATA.
class MoneyParser {
  MoneyParser._();

  static final RegExp _allowed = RegExp(r'^[+-]?[\d.,]+$');

  /// [input] girdisini [separators] kurallarına göre ayrıştırır.
  ///
  /// [requirePositive] doğrudurca sıfır ve negatif değerler
  /// [FormatException] verir (fiyat/miktar girişi doğrulaması; spec §13).
  static DecimalFixed parseDecimal(
    String input, {
    MoneySeparators separators = MoneySeparators.en,
    bool requirePositive = false,
  }) {
    final s = input.trim();
    if (s.isEmpty) {
      throw const FormatException('boş girdi');
    }
    if (!_allowed.hasMatch(s)) {
      throw FormatException('geçersiz karakter: "$input"');
    }

    final signIndex = s.indexOf(RegExp(r'[+-]'));
    var digitsPart = s;
    if (signIndex == 0) digitsPart = s.substring(1);
    if (digitsPart.isEmpty) {
      throw FormatException('eksik sayı: "$input"');
    }

    final canonical = _toCanonical(digitsPart, separators);
    final value = DecimalFixed.parse(
        signIndex == 0 && s.startsWith('-') ? '-$canonical' : canonical);
    if (requirePositive && !value.isPositive) {
      throw const FormatException('değer pozitif olmalı');
    }
    return value;
  }

  static String _toCanonical(String s, MoneySeparators sep) {
    final d = sep.decimal;
    final t = sep.thousands;
    final decimalCount = _count(s, d);
    final thousandsCount = _count(s, t);

    if (decimalCount > 1) {
      throw FormatException('birden fazla ondalık ayraç: "$s"');
    }

    if (decimalCount == 1) {
      final di = s.indexOf(d);
      if (di == 0 || di == s.length - 1) {
        throw FormatException('ayraç uçta: "$s"');
      }
      final intPart = s.substring(0, di);
      final fracPart = s.substring(di + 1);
      if (fracPart.contains(t)) {
        throw FormatException('ondalık ayracın sağında binlik ayraç: "$s"');
      }
      _checkGrouping(intPart, t, s);
      return '${intPart.replaceAll(t, "")}.$fracPart';
    }

    // Ondalık ayraç yok: görünen tüm ayraçlar binliktir.
    if (thousandsCount > 0) {
      _checkGrouping(s, t, s);
      return s.replaceAll(t, '');
    }
    return s;
  }

  /// Geçerli gruplama: ilk grup 1-3 basamak, kalan gruplar tam 3.
  static void _checkGrouping(String intPart, String t, String original) {
    final groups = intPart.split(t);
    if (groups.first.isEmpty || groups.first.length > 3) {
      throw FormatException('geçersiz binlik gruplama: "$original"');
    }
    for (var i = 1; i < groups.length; i++) {
      if (groups[i].length != 3) {
        throw FormatException('geçersiz binlik gruplama: "$original"');
      }
    }
  }

  static int _count(String s, String char) =>
      char.allMatches(s).length;
}
