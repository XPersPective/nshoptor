import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/core/money/money_parser.dart';

/// Biçim yereli dilden bağımsızdır (C-001, PB-042): İngilizce arayüz +
/// Türkçe biçim birlikte mümkün.
void main() {
  tearDown(AppFormatLocale.attachReset);

  for (final (device, expected) in [
    (const Locale('en', 'GB'), 'en_GB'),
    (const Locale('en', 'IN'), 'en_IN'),
    (const Locale('ar', 'KW'), 'ar_KW'),
    (const Locale('fa', 'IR'), 'en'),
  ]) {
    testWidgets('device $device region/fallback independent of Turkish UI', (tester) async {
      tester.binding.platformDispatcher.localeTestValue = device;
      addTearDown(tester.binding.platformDispatcher.clearLocaleTestValue);
      late String resolved;
      await tester.pumpWidget(MaterialApp(locale: const Locale('tr'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        home: Builder(builder: (context) { resolved = formatLocaleCode(context); return const SizedBox.shrink(); })));
      expect(resolved, expected);
    });
  }

  testWidgets('system follows device region independently of app language', (tester) async {
    AppFormatLocale.attach(null);
    tester.binding.platformDispatcher.localeTestValue = const Locale('tr', 'TR');
    addTearDown(tester.binding.platformDispatcher.clearLocaleTestValue);
    late String resolved;
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('en'),
      supportedLocales: const [Locale('tr'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Builder(
        builder: (context) {
          resolved = AppFormatLocale.effective(context);
          return const SizedBox.shrink();
        },
      ),
    ));
    expect(resolved, 'tr_TR');
  });

  testWidgets('tr biçim ayarı en arayüzde bile tr kalır', (tester) async {
    AppFormatLocale.attach('tr');
    late String resolved;
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('en'),
      supportedLocales: const [Locale('tr'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Builder(
        builder: (context) {
          resolved = AppFormatLocale.effective(context);
          return const SizedBox.shrink();
        },
      ),
    ));
    expect(resolved, 'tr');
    // Ayrıştırıcı da aynı ayracı kullanır: "1.234,56" tr biçimi.
    expect(
      MoneyParser.parseDecimal('1.234,56',
              separators: MoneySeparators.forLocaleCode(resolved),
              requirePositive: true)
          .toString()
          .startsWith('1234.56'),
      isTrue,
    );
  });
}
