import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
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
    expect(
      tester.widget<Text>(find.text('Evdeki hesap çarşıya uyar.')).style?.color,
      AppTheme.splashAccent,
    );
    expect(find.byKey(const Key('splash_icon')), findsOneWidget);
    expect(
      tester.widget<Scaffold>(find.byKey(const Key('splash_screen'))).backgroundColor,
      AppTheme.splashBackground,
    );
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

  testWidgets('every supported locale shows its own slogan without overflow', (tester) async {
    final english = lookupAppLocalizations(const Locale('en')).slogan;
    for (final locale in AppLocalizations.supportedLocales) {
      final slogan = lookupAppLocalizations(locale).slogan;
      expect(slogan.trim(), isNotEmpty, reason: '$locale slogan');
      if (locale.languageCode != 'en') {
        expect(slogan, isNot(english), reason: '$locale slogan is untranslated');
      }
      // Fresh SplashGate state per locale (otherwise the previous timer already hid it).
      await tester.pumpWidget(
        KeyedSubtree(key: ValueKey(locale), child: app(locale, const Duration(milliseconds: 300))),
      );
      expect(find.text(slogan), findsOneWidget, reason: '$locale');
      expect(find.text('NShoptor'), findsOneWidget, reason: '$locale');
      // Only the framework's "locale not supported by all delegates" notice is tolerated
      // (Material has no strings for a few app locales); overflow or other errors fail.
      final error = tester.takeException();
      expect(
        error == null || '$error'.contains('is not supported by all of its localization delegates'),
        isTrue,
        reason: '$locale: $error',
      );
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpAndSettle();
    }
  });

  test('native launch screens use the same brand background as the Flutter splash', () {
    final argb = AppTheme.splashBackground.toARGB32();
    final hex = (argb & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase();
    final colors = File('android/app/src/main/res/values/colors.xml').readAsStringSync();
    expect(colors, contains('<color name="splash_dark">#$hex</color>'));
    for (final path in [
      'android/app/src/main/res/values-v31/styles.xml',
      'android/app/src/main/res/values-night-v31/styles.xml',
    ]) {
      expect(
        File(path).readAsStringSync(),
        contains('<item name="android:windowSplashScreenBackground">@color/splash_dark</item>'),
        reason: path,
      );
    }
    for (final path in ['android/app/src/main/res/values/styles.xml', 'android/app/src/main/res/values-night/styles.xml']) {
      // NormalTheme stays branded while Flutter initializes: no black window.
      expect(
        '@drawable/launch_background'.allMatches(File(path).readAsStringSync()).length,
        2,
        reason: path,
      );
    }
    final storyboard = File('ios/Runner/Base.lproj/LaunchScreen.storyboard').readAsStringSync();
    final match = RegExp(r'<color key="backgroundColor" red="([\d.]+)" green="([\d.]+)" blue="([\d.]+)"')
        .firstMatch(storyboard)!;
    int channel(int i) => (double.parse(match.group(i)!) * 255).round();
    expect([channel(1), channel(2), channel(3)], [(argb >> 16) & 0xFF, (argb >> 8) & 0xFF, argb & 0xFF]);
  });
}
