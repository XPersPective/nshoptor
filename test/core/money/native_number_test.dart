import 'package:flutter_test/flutter_test.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:nshoptor/core/l10n/language_names.dart';
import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/core/money/locale_conventions.dart';
import 'package:nshoptor/core/money/money.dart';
import 'package:nshoptor/core/money/money_format.dart';
import 'package:nshoptor/core/money/money_parser.dart';

void main() {
  test('native Arabic/Persian/Indic/fullwidth keypad values stay exact', () {
    for (final (locale, text) in [
      ('ar_EG', '١٬٢٣٤٫٥٦'),
      ('fa_IR', '۱٬۲۳۴٫۵۶'),
      ('bn', '১,২৩৪.৫৬'),
      ('hi', '१,२३४.५६'),
      ('ja', '１，２３４．５６'),
      ('en', '١٬٢٣٤٫٥٦'),
      ('tr', '۱٬۲۳۴٫۵۶'),
    ]) {
      expect(
        MoneyParser.parseDecimal(
          text,
          separators: MoneySeparators.forLocaleCode(locale),
        ).toMinorUnits(2),
        123456,
        reason: '$locale: $text',
      );
    }
  });

  test(
    'number locale preserves regional numbering instead of forcing English',
    () {
      for (final locale in ['ar_EG', 'fa_IR', 'bn', 'mr', 'ne', 'my']) {
        expect(AppFormatLocale.forLanguage(locale), locale);
      }
      expect(knownNumberLocale('ar-EG'), 'ar_EG');
    },
  );

  test('all installed country conventions and app locales round-trip every money digit', () {
    for (final code in {
      ...appLanguages.keys,
      ...numberFormatSymbols.keys,
      'ar_EG',
      'fa_IR',
      'ar_SA',
      'en_IN',
      'bn_BD',
    }) {
      final locale = AppFormatLocale.forLanguage(code);
      final symbols = numberFormatSymbols[knownNumberLocale(locale)]!;
      for (final currencyCode in ['JPY', 'EUR', 'KWD']) {
        final currency = Currency.fromCode(currencyCode);
        for (final minor in [
          0,
          1,
          -1,
          123456789,
          -123456789,
          999999999999999,
        ]) {
          final formatted = formatMoney(
            Money.fromMinorUnits(minor, currency),
            locale: locale,
          );
          final number = formatted
              .replaceAll(currency.displaySymbol, '')
              .trim();
          expect(
            MoneyParser.parseDecimal(
              number,
              separators: MoneySeparators.forLocaleCode(locale),
            ).toMinorUnits(currency.minorUnitDigits),
            minor,
            reason: '$code / $currencyCode / $formatted',
          );
          if (symbols.ZERO_DIGIT != '0') {
            expect(
              RegExp(r'[0-9]').hasMatch(number),
              isFalse,
              reason:
                  'integer and fraction must use the same native digits: $code / $formatted',
            );
          }
        }
      }
    }
  });

  test('native minus, grouping and ASCII keyboard remain compatible', () {
    final fa = MoneySeparators.forLocaleCode('fa');
    expect(
      MoneyParser.parseDecimal('−۱۲۳٫۴۵', separators: fa).toMinorUnits(2),
      -12345,
    );
    expect(
      MoneyParser.parseDecimal('1234.56', separators: fa).toMinorUnits(2),
      123456,
    );
    expect(
      MoneyParser.parseDecimal('1,234.56', separators: fa).toMinorUnits(2),
      123456,
    );
    expect(
      () => MoneyParser.parseDecimal(
        '١٬٢٣',
        separators: MoneySeparators.forLocaleCode('ar_EG'),
      ),
      throwsFormatException,
    );
    expect(() => MoneyParser.parseDecimal('12⅓'), throwsFormatException);
    expect(() => MoneyParser.parseDecimal('一二三'), throwsFormatException);
    expect(() => MoneyParser.parseDecimal('1\u202e23'), throwsFormatException);
    for (final mark in ['\u200e', '\u200f', '\u061c']) {
      expect(
        () => MoneyParser.parseDecimal('1${mark}234'),
        throwsFormatException,
      );
      expect(
        MoneyParser.parseDecimal(
          '$mark−$mark۱۲۳٫۴۵$mark',
          separators: fa,
        ).toMinorUnits(2),
        -12345,
      );
    }
  });
}
