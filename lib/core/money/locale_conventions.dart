import 'package:intl/number_symbols.dart' show NumberSymbols;
import 'package:intl/number_symbols_data.dart';

/// Dilin sayı/para yazım gelenekleri — intl'in locale tablosundan (PB-061),
/// 71 dil için elle liste tutulmaz.
NumberSymbols? _symbols(String code) =>
    numberFormatSymbols[code] ?? numberFormatSymbols[code.toLowerCase().split(RegExp('[-_]')).first];

/// intl'in sayı verisi olan en yakın yerel ('tl' gibi eksikler 'en'e düşer).
String knownNumberLocale(String code) {
  if (numberFormatSymbols.containsKey(code)) return code;
  final lang = code.toLowerCase().split(RegExp('[-_]')).first;
  return numberFormatSymbols.containsKey(lang) ? lang : 'en';
}

/// Ondalık ayracı virgül mü (`12,5`)?
bool usesCommaDecimal(String code) => _symbols(code)?.DECIMAL_SEP == ',';

/// Rakamlar 0-9 mu? Arapça-Hint/Fars/Devanagari vb. rakamlı dillerde giriş
/// (batı rakamı) ile gösterim tutarlı kalsın diye biçim 'en'e düşer.
bool usesLatinDigits(String code) => (_symbols(code)?.ZERO_DIGIT ?? '0') == '0';

/// Para sembolü/kodu rakamdan sonra mı (`12,50 €`)? tr/de/fr/es/it/pt/ru
/// ürün kararı olarak sonek (PB-058); diğerleri intl desenine göre.
bool usesSuffixCurrency(String code) {
  final lang = code.toLowerCase().split(RegExp('[-_]')).first;
  if (const {'tr', 'de', 'fr', 'es', 'it', 'pt', 'ru'}.contains(lang)) return true;
  final p = _symbols(code)?.CURRENCY_PATTERN ?? '';
  final sign = p.indexOf('¤');
  return sign > 0 && sign > p.indexOf('0');
}
