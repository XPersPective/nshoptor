import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/core/l10n/language_names.dart';
import 'package:nshoptor/core/money/format_locale.dart';
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
    expect(arbs.length, greaterThanOrEqualTo(71));
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

  test('71 dil: her kodun ARB dosyası var ve para yazımı geri okunur', () {
    expect(appLanguages.length, 71);
    final eur = Currency.fromCode('EUR');
    for (final code in appLanguages.keys) {
      expect(File('lib/core/l10n/app_$code.arb').existsSync(), isTrue, reason: code);
      final loc = AppFormatLocale.forLanguage(code);
      final text = formatMoney(Money.fromMinorUnits(1250, eur), locale: loc);
      final number = RegExp(r'\d+[.,]\d+').firstMatch(text)![0]!;
      expect(
        MoneyParser.parseDecimal(number, separators: MoneySeparators.forLocaleCode(loc)).toDbString(),
        '12.50',
        reason: '$code → $text',
      );
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

  testWidgets('71 dilin hepsinde uygulama açılır; RTL diller sağdan sola', (tester) async {
    for (final code in appLanguages.keys) {
      final db = AppDatabase(NativeDatabase.memory());
      await tester.pumpWidget(NShoptorApp(db: db, fixedLocale: Locale(code)));
      await tester.pumpAndSettle();
      // Yalnız Cupertino Peştuca bilmez (Android'de kullanılmaz); başka uyarı hatadır.
      expect(tester.takeException(), code == 'ps' ? isNotNull : isNull, reason: code);
      final dir = Directionality.of(tester.element(find.byType(NavigationBar)));
      expect(dir, const {'ar', 'fa', 'he', 'ur', 'ps'}.contains(code) ? TextDirection.rtl : TextDirection.ltr,
          reason: code);
      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 1));
      await closing;
    }
  });

  testWidgets('uzun çeviriler (el ka hy nl fi hu de ru): sekmeler taşmadan çizilir', (tester) async {
    // Test ortamı yazı tipi taşımaz (Ahem her glifi 1 em çizer → sahte taşma);
    // gerçek metrik için Segoe UI (Latin/Yunan/Kiril/Gürcü/Ermeni) yüklenir.
    const segoe = 'C:/Windows/Fonts/segoeui.ttf';
    if (!File(segoe).existsSync()) return;
    final roboto = FontLoader('Roboto')
      ..addFont(Future.value(ByteData.sublistView(File(segoe).readAsBytesSync())));
    await roboto.load();
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    for (final code in ['el', 'ka', 'hy', 'nl', 'fi', 'hu', 'de', 'ru']) {
      final db = AppDatabase(NativeDatabase.memory());
      await tester.pumpWidget(NShoptorApp(db: db, fixedLocale: Locale(code)));
      await tester.pumpAndSettle();
      for (var tab = 0; tab < 5; tab++) {
        await tester.tap(find.byType(NavigationDestination).at(tab));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: '$code sekme $tab');
      }
      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 1));
      await closing;
    }
  });
}
