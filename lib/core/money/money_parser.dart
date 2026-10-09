import 'package:intl/number_symbols_data.dart';
import 'decimal_fixed.dart';
import 'locale_conventions.dart';

/// Yerel ayraç yapılandırması: ondalık ve binlik ayraç karakterleri.
class MoneySeparators {
  const MoneySeparators(this.decimal, this.thousands, {this.primaryGroupSize = 3, this.secondaryGroupSize = 3})
      : assert(decimal != thousands),
        assert(decimal.length == 1),
        assert(thousands.length == 1),
        assert(primaryGroupSize > 0), assert(secondaryGroupSize > 0);

  final String decimal;
  final String thousands;
  final int primaryGroupSize;
  final int secondaryGroupSize;

  /// Türkçe: ondalık `,`, binlik `.`.
  static const MoneySeparators tr = MoneySeparators(',', '.');

  /// İngilizce: ondalık `.`, binlik `,`.
  static const MoneySeparators en = MoneySeparators('.', ',');

  /// Installed intl data is also the formatter's source of separators/grouping.
  static MoneySeparators forLocaleCode(String localeCode) {
    if (!usesLatinDigits(localeCode)) return en;
    final symbols = numberFormatSymbols[knownNumberLocale(localeCode)]!;
    final groups = symbols.DECIMAL_PATTERN.split('.').first.split(',');
    final primary = groups.length > 1 ? groups.last.length : 3;
    final secondary = groups.length > 2 ? groups[groups.length - 2].length : primary;
    if (primary == 3 && secondary == 3) {
      if (symbols.DECIMAL_SEP == tr.decimal && symbols.GROUP_SEP == tr.thousands) return tr;
      if (symbols.DECIMAL_SEP == en.decimal && symbols.GROUP_SEP == en.thousands) return en;
    }
    return MoneySeparators(symbols.DECIMAL_SEP, symbols.GROUP_SEP,
      primaryGroupSize: primary, secondaryGroupSize: secondary);
  }

}

/// Kullanıcı girişindeki yerel ondalık sayı ayrıştırıcısı.
///
/// Belirsizlik kuralı (deterministik ve test edilebilir, spec §13):
/// - Ayraç karakteri kendi rolüne göre yorumlanır: [MoneySeparators.decimal]
///   ondalık, [MoneySeparators.thousands] binliktir.
/// - Binlik ayracı seçilmiş yerelin intl gruplamasına uymalıdır. Geçersiz gruplama `FormatException` verir — tahmin edilmez.
/// - Ondalık ayracı en fazla bir kez görünebilir; ilk veya son karakter olamaz.
/// - Örnekler (tr): `1,5` → 1.5; `1.234,5` → 1234.5; `1.234` → 1234.
///   (en): `1.5` → 1.5; `1,234.5` → 1234.5; `1,234` → 1234; `1,23` → HATA.
class MoneyParser {
  MoneyParser._();


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
    if (!RegExp(r'^[+-]?[0-9' + RegExp.escape(separators.decimal + separators.thousands) + r']+$').hasMatch(s)) {
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
      _checkGrouping(intPart, sep, s);
      return '${intPart.replaceAll(t, "")}.$fracPart';
    }

    // Ondalık ayraç yok: görünen tüm ayraçlar binliktir.
    if (thousandsCount > 0) {
      _checkGrouping(s, sep, s);
      return s.replaceAll(t, '');
    }
    return s;
  }

  /// Ungrouped integers have no size ceiling; grouped integers follow intl.
  static void _checkGrouping(String intPart, MoneySeparators sep, String original) {
    final groups = intPart.split(sep.thousands);
    if (groups.length == 1) return;
    if (groups.first.isEmpty || groups.first.length > sep.secondaryGroupSize) {
      throw FormatException('geçersiz binlik gruplama: "$original"');
    }
    for (var i = 1; i < groups.length; i++) {
      if (groups[i].length != (i == groups.length - 1 ? sep.primaryGroupSize : sep.secondaryGroupSize)) {
        throw FormatException('geçersiz binlik gruplama: "$original"');
      }
    }
  }

  static int _count(String s, String char) =>
      char.allMatches(s).length;
}
