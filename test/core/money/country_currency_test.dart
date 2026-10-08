import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/country_currency.dart';
import 'package:nshoptor/core/money/currency.dart';

void main() {
  test('ülke tablosundaki her para birimi uygulamada tanımlı', () {
    final known = Currency.all.map((c) => c.code).toSet();
    for (final c in ['TR', 'US', 'DE', 'JP', 'BR', 'IN', 'SA', 'ZA', 'KR', 'GB', 'FR', 'EG']) {
      expect(known, contains(currencyForCountry(c)), reason: c);
    }
    expect(currencyForCountry('tr'), 'TRY');
    expect(currencyForCountry('ZZ'), isNull);
    expect(currencyForCountry(null), isNull);
  });
}
