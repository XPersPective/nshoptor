import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

import 'locale_conventions.dart';
import 'money.dart';

/// Locale-aware, `double` kullanmadan para biçimleyici (spec §7.1).
///
/// Gruplama ve ondalık ayracı intl'in locale sembollerinden alınır; değer
/// minor unit tam sayısından dizge olarak kurulur, hiçbir aşamada binary
/// floating point'e geçilmez. Belirsiz sembollü para birimlerinde ISO kodu
/// gösterilir ([Currency.displaySymbol]). Yerleşim: `tr` gibi sonek
/// dillerinde `1.234,56 ₺`, önek dillerinde `₺1,234.56`; negatifte `-` öneki.
String formatMoney(Money money, {String locale = 'en'}) {
  locale = knownNumberLocale(locale);
  final digits = money.currency.minorUnitDigits;
  final symbol = money.currency.displaySymbol;
  final symbols =
      numberFormatSymbols[locale] ?? numberFormatSymbols['en']!;
  final negative = money.minorUnits < 0;
  final abs = money.minorUnits.abs();

  final divisor = switch (digits) {
    0 => 1,
    2 => 100,
    3 => 1000,
    _ => _pow10(digits),
  };
  final intPart = abs ~/ divisor;
  final grouped = NumberFormat.decimalPattern(locale).format(intPart);

  final body = digits == 0
      ? grouped
      : '$grouped${symbols.DECIMAL_SEP}${(abs % divisor).toString().padLeft(digits, '0')}';

  final withSymbol = usesSuffixCurrency(locale)
      ? '$body $symbol'
      : symbol == money.currency.code
          ? '$symbol $body' // ISO kodu rakama yapışmasın: `USD 3.49`
          : '$symbol$body';
  return negative ? '-$withSymbol' : withSymbol;
}

int _pow10(int n) {
  var v = 1;
  for (var i = 0; i < n; i++) {
    v *= 10;
  }
  return v;
}
