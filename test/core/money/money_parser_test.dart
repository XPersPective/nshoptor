import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/money_parser.dart';
import 'package:nshoptor/core/l10n/language_names.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/money/money.dart';
import 'package:nshoptor/core/money/money_format.dart';

void main() {
  test('large ungrouped decimals are valid; all supported formatted groups round-trip', () {
    expect(MoneyParser.parseDecimal('1234567.89').toDbString(), '1234567.89');
    expect(MoneyParser.parseDecimal('1234567,89', separators: MoneySeparators.tr).toDbString(), '1234567.89');
    final currency = Currency.fromCode('EUR');
    for (final code in {...appLanguages.keys, 'en_IN', 'fr_FR', 'ru_RU', 'ar_KW'}) {
      final locale = AppFormatLocale.forLanguage(code);
      const minor = 123456789;
      final text = formatMoney(Money.fromMinorUnits(minor, currency), locale: locale);
      final number = text.replaceAll(currency.displaySymbol, '').trim();
      expect(MoneyParser.parseDecimal(number, separators: MoneySeparators.forLocaleCode(locale)).toMinorUnits(2), minor,
        reason: '$locale: $text');
    }
  });
  test('Indian grouping follows installed intl pattern rather than accepting broken groups', () {
    final sep = MoneySeparators.forLocaleCode('en_IN');
    expect(MoneyParser.parseDecimal('12,34,567.89', separators: sep).toDbString(), '1234567.89');
    expect(() => MoneyParser.parseDecimal('1,234,567.89', separators: sep), throwsFormatException);
    expect(() => MoneyParser.parseDecimal('12,34,56.89', separators: sep), throwsFormatException);
  });
  group('Türkçe ayraçlar', () {
    const sep = MoneySeparators.tr;

    test('ondalık virgül', () {
      expect(MoneyParser.parseDecimal('1,5', separators: sep).toDbString(),
          '1.5');
      expect(MoneyParser.parseDecimal('42,90', separators: sep).toDbString(),
          '42.90');
    });

    test('binlik nokta gruplaması', () {
      expect(MoneyParser.parseDecimal('1.234,5', separators: sep).toDbString(),
          '1234.5');
      expect(MoneyParser.parseDecimal('1.234', separators: sep).toDbString(),
          '1234');
      expect(MoneyParser.parseDecimal('12.345.678', separators: sep)
          .toDbString(), '12345678');
    });

    test('geçersiz gruplama reddedilir', () {
      // "1.23" tr'de binlik nokta ama grup 2 basamak → tahmin edilmez, hata.
      expect(() => MoneyParser.parseDecimal('1.23', separators: sep),
          throwsFormatException);
      expect(() => MoneyParser.parseDecimal('1234.5', separators: sep),
          throwsFormatException);
      expect(() => MoneyParser.parseDecimal('1,5,5', separators: sep),
          throwsFormatException);
    });
  });

  group('İngilizce ayraçlar', () {
    const sep = MoneySeparators.en;

    test('ondalık nokta', () {
      expect(MoneyParser.parseDecimal('1.5', separators: sep).toDbString(),
          '1.5');
      expect(MoneyParser.parseDecimal('19.99', separators: sep).toDbString(),
          '19.99');
    });

    test('binlik virgül gruplaması', () {
      expect(MoneyParser.parseDecimal('1,234.5', separators: sep).toDbString(),
          '1234.5');
      expect(MoneyParser.parseDecimal('1,234', separators: sep).toDbString(),
          '1234');
    });

    test('geçersiz gruplama reddedilir', () {
      // "1,23" en'de binlik virgül ama grup 2 basamak → hata.
      expect(() => MoneyParser.parseDecimal('1,23', separators: sep),
          throwsFormatException);
      // "1.234,5" en'de ondalıktan sonra binlik ayraç → hata.
      expect(() => MoneyParser.parseDecimal('1.234,5', separators: sep),
          throwsFormatException);
    });
  });

  group('locale eşleme', () {
    test('forLocaleCode: virgüllü diller tr ayracı, bilinmeyen en düşer', () {
      expect(MoneySeparators.forLocaleCode('tr_TR'), MoneySeparators.tr);
      expect(MoneySeparators.forLocaleCode('en_US'), MoneySeparators.en);
      expect(MoneySeparators.forLocaleCode('de_DE'), MoneySeparators.tr);
      expect(MoneySeparators.forLocaleCode('ja_JP'), MoneySeparators.en);
    });
  });

  group('girdi doğrulama', () {
    const sep = MoneySeparators.tr;

    test('boş ve çöp girdi reddedilir', () {
      expect(() => MoneyParser.parseDecimal('', separators: sep),
          throwsFormatException);
      expect(() => MoneyParser.parseDecimal('  ', separators: sep),
          throwsFormatException);
      expect(() => MoneyParser.parseDecimal('abc', separators: sep),
          throwsFormatException);
      expect(() => MoneyParser.parseDecimal('1a5', separators: sep),
          throwsFormatException);
      expect(() => MoneyParser.parseDecimal('1 5', separators: sep),
          throwsFormatException);
    });

    test('negatif işaret desteklenir (varyans girişleri için)', () {
      expect(MoneyParser.parseDecimal('-12,5', separators: sep).toDbString(),
          '-12.5');
    });

    test('requirePositive sıfır ve negatifi reddeder', () {
      expect(() => MoneyParser.parseDecimal('0', separators: sep, requirePositive: true),
          throwsFormatException);
      expect(() => MoneyParser.parseDecimal('-1,5', separators: sep, requirePositive: true),
          throwsFormatException);
      expect(MoneyParser.parseDecimal('1,5', separators: sep, requirePositive: true)
          .toDbString(), '1.5');
    });
  });
}
