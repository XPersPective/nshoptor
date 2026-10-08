import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/money/money.dart';
import 'package:nshoptor/core/money/money_format.dart';
import 'package:nshoptor/core/money/money_parser.dart';
import 'package:nshoptor/data/db/app_database.dart';

void main() {
  test('tüm ARB dosyaları en ile aynı anahtar ve yer tutuculara sahip', () {
    final dir = Directory('lib/core/l10n');
    final en = jsonDecode(File('${dir.path}/app_en.arb').readAsStringSync()) as Map<String, dynamic>;
    final keys = en.keys.where((k) => !k.startsWith('@')).toSet();
    final arbs = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.arb'));
    expect(arbs.length, greaterThanOrEqualTo(9));
    for (final f in arbs) {
      final d = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
      final ks = d.keys.where((k) => !k.startsWith('@')).toSet();
      expect(keys.difference(ks), isEmpty, reason: '${f.path} eksik anahtar');
      for (final k in keys) {
        final ph = RegExp(r'\{(\w+)\}');
        expect(ph.allMatches('${d[k]}').map((m) => m[1]).toSet(),
            ph.allMatches('${en[k]}').map((m) => m[1]).toSet(),
            reason: '${f.path}:$k yer tutucu');
      }
    }
  });

  test('Almanca: virgüllü giriş ve sonek sembol', () {
    final eur = Currency.fromCode('EUR');
    expect(formatMoney(Money.fromMinorUnits(123456, eur), locale: 'de'), '1.234,56 €');
    expect(MoneyParser.parseDecimal('12,5', separators: MoneySeparators.forLocaleCode('de')).toDbString(), '12.5');
    expect(MoneySeparators.forLocaleCode('ar'), MoneySeparators.en);
  });

  testWidgets('Arapça arayüz sağdan sola', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(NShoptorApp(db: db, fixedLocale: const Locale('ar')));
    await tester.pumpAndSettle();
    expect(find.text('الرئيسية'), findsWidgets);
    expect(Directionality.of(tester.element(find.text('الرئيسية').first)), TextDirection.rtl);
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  });
}
