import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/money_parser.dart';

void main() {
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
