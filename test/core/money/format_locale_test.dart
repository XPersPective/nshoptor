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

  testWidgets('ayarı yoksa arayüz dilinden gelir', (tester) async {
    AppFormatLocale.attach(null);
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
    expect(resolved, 'en');
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
