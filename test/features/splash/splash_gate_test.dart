import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/splash/splash_gate.dart';

void main() {
  Widget app(Locale locale, Duration duration) => MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: SplashGate(
          duration: duration,
          child: const Text('home', key: Key('home_child')),
        ),
      );

  testWidgets('splash shows the localized name and slogan, then the child', (tester) async {
    await tester.pumpWidget(app(const Locale('tr'), const Duration(milliseconds: 300)));
    expect(find.byKey(const Key('splash_screen')), findsOneWidget);
    expect(find.text('NShoptor'), findsOneWidget);
    expect(find.text('Evdeki hesap çarşıya uyar.'), findsOneWidget);
    expect(find.byKey(const Key('home_child')), findsNothing);

    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('splash_screen')), findsNothing);
    expect(find.byKey(const Key('home_child')), findsOneWidget);
  });

  testWidgets('zero duration shows the child immediately (tests and placeholders)', (tester) async {
    await tester.pumpWidget(app(const Locale('en'), Duration.zero));
    expect(find.byKey(const Key('splash_screen')), findsNothing);
    expect(find.byKey(const Key('home_child')), findsOneWidget);
  });

  testWidgets('English slogan on an English device', (tester) async {
    await tester.pumpWidget(app(const Locale('en'), const Duration(milliseconds: 300)));
    expect(find.text('Plan at home, match at checkout.'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
  });
}
