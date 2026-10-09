import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/country_currency.dart';
import 'package:nshoptor/core/money/currency.dart';

void main() {
  test('ülke tablosundaki her para birimi uygulamada tanımlı', () {
    final known = Currency.all.map((c) => c.code).toSet();
    for (final c in ['TR', 'US', 'DE', 'JP', 'BR', 'IN', 'SA', 'ZA', 'KR', 'GB', 'FR', 'EG', 'BG', 'BY']) {
      expect(known, contains(currencyForCountry(c)), reason: c);
    }
    expect(currencyForCountry('tr'), 'TRY');
    expect(currencyForCountry('BG'), 'EUR');
    expect(currencyForCountry('by'), 'BYN');
    expect(Currency.fromCode('BYN').minorUnitDigits, 2);
    expect(Currency.fromCode('BYN').displaySymbol, 'BYN');
    expect(known, contains('BGN')); // Existing lev records remain readable.
    expect(currencyForCountry('ZZ'), isNull);
    expect(currencyForCountry(null), isNull);
  });
}
