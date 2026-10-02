import 'package:flutter_test/flutter_test.dart';
import 'dart:ui' show Locale;

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/core/quantity/unit_display.dart';

/// Birim görünen adları (hedef kuralı: kanonik kod DB'de, ad l10n'dan).
void main() {
  final tr = lookupAppLocalizations(const Locale('tr'));
  final en = lookupAppLocalizations(const Locale('en'));

  test('adet yerelleşir: tr "adet", en "pc"', () {
    expect(unitDisplayName(UnitCode.adet, tr), 'adet');
    expect(unitDisplayName(UnitCode.adet, en), 'pc');
  });

  test('db kodundan görünen ad; bilinmeyen kod aynen döner', () {
    expect(unitDisplayNameFromDb('kilogram', en), 'kg');
    expect(unitDisplayNameFromDb('bottle', tr), 'şişe');
    expect(unitDisplayNameFromDb('yeni-birim', en), 'yeni-birim');
  });

  test('ayar enum adından görünen ad', () {
    expect(unitDisplayNameFromName('mililitre', en), 'ml');
    expect(unitDisplayNameFromName('duzine', tr), 'düzine');
  });

  test('özel birim yerelleşir', () {
    expect(unitDisplayName(UnitCode.custom, en), 'Custom');
    expect(unitDisplayName(UnitCode.custom, tr), 'Özel');
  });
}
