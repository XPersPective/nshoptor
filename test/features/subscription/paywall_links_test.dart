import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart' hide AppTheme;
import 'package:nshoptor/core/config/env_config.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/subscription/subscription_paywall.dart';
import 'package:nshoptor/features/subscription/subscription_service.dart';

class _Service extends SubscriptionService {
  _Service(bool apple) : super(store: SettingsStore(), applePlatform: apple);
  int loads = 0;
  @override
  Future<List<SubscriptionOffer>> loadOffers() async {
    loads++;
    if (loads == 1) throw StateError('offline');
    return [];
  }
}

Widget _app(
  _Service service,
  Locale locale,
  Future<bool> Function(Uri) launcher, {
  double scale = 1,
}) => MaterialApp(
  locale: locale,
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: [
    AppLocalizations.delegate,
    NappLocalizationsDelegate(
      NappTranslations({
        'en': {'common.errorGeneric': 'Please try again.'},
        'ar': {'common.errorGeneric': 'يرجى المحاولة مرة أخرى.'},
      }),
    ),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
    child: child!,
  ),
  home: SubscriptionPaywall(service: service, launcher: launcher),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('all71 source/legal translations support exact brand-only substitution and accurate license labels', () async {
    final files = Directory('lib/core/l10n')
        .listSync()
        .whereType<File>()
        .where((file) => RegExp(r'app_.*\.arb$').hasMatch(file.path))
        .toList();
    expect(files, hasLength(71));
    final brand = RegExp(r'Googl(?:e|u) Play');
    for (final file in files) {
      final arb = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(
        brand.allMatches(arb['plansLegal'] as String),
        hasLength(1),
        reason: file.path,
      );
      expect(
        '(GPL-3.0)'.allMatches(arb['aboutLicenses'] as String),
        hasLength(1),
        reason: file.path,
      );
    }
    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = await AppLocalizations.delegate.load(locale);
      expect(
        brand.allMatches(l10n.plansLegal),
        hasLength(1),
        reason: locale.toString(),
      );
      expect(
        SubscriptionPaywall.legalText(l10n, apple: false),
        l10n.plansLegal,
      );
      final apple = SubscriptionPaywall.legalText(l10n, apple: true);
      expect(apple, contains('App Store'));
      expect(brand.hasMatch(apple), isFalse);
      expect(
        apple.replaceFirst(
          'App Store',
          brand.firstMatch(l10n.plansLegal)!.group(0)!,
        ),
        l10n.plansLegal,
      );
      expect(
        SubscriptionPaywall.licenseLabel(l10n, apple: true),
        isNot(contains('GPL-3.0')),
      );
      expect(
        SubscriptionPaywall.licenseLabel(l10n, apple: false),
        l10n.aboutLicenses,
      );
    }
  });

  for (final apple in [false, true]) {
    testWidgets('retry and legal links launch only on tap apple=$apple', (
      tester,
    ) async {
      final service = _Service(apple);
      final opened = <Uri>[];
      await tester.pumpWidget(
        _app(service, const Locale('en'), (uri) async {
          opened.add(uri);
          return true;
        }),
      );
      await tester.pumpAndSettle();
      expect(opened, isEmpty);
      await tester.scrollUntilVisible(
        find.byKey(const Key('plans_retry')),
        200,
      );
      await tester.tap(find.byKey(const Key('plans_retry')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(service.loads, 2);
      for (final key in ['plans_manage', 'plans_privacy', 'plans_terms']) {
        await tester.scrollUntilVisible(find.byKey(Key(key)), 150);
        await tester.tap(find.byKey(Key(key)));
        await tester.pumpAndSettle();
      }
      expect(opened.map((uri) => uri.toString()).toList(), [
        apple
            ? 'https://apps.apple.com/account/subscriptions'
            : 'https://play.google.com/store/account/subscriptions',
        EnvConfig.identity.privacyPolicyUrl,
        apple
            ? 'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/'
            : 'https://github.com/XPersPective/nshoptor/blob/main/LICENSE',
      ]);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      service.dispose();
    });
  }

  testWidgets(
    '320dp2xRTL link failure uses localized feedback and retry stays usable',
    (tester) async {
      tester.view.physicalSize = const Size(320, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final service = _Service(true);
      await tester.pumpWidget(
        _app(service, const Locale('ar'), (_) async => false, scale: 2),
      );
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.byKey(const Key('plans_privacy')),
        200,
      );
      await tester.tap(find.byKey(const Key('plans_privacy')));
      await tester.pumpAndSettle();
      expect(find.text('يرجى المحاولة مرة أخرى.'), findsOneWidget);
      expect(tester.takeException(), isNull);
      for (final key in ['plans_manage', 'plans_privacy', 'plans_terms']) {
        await tester.scrollUntilVisible(find.byKey(Key(key)), 150);
        expect(
          tester.getSize(find.byKey(Key(key))).height,
          greaterThanOrEqualTo(48),
        );
      }
      await tester.pumpWidget(const SizedBox.shrink());
      service.dispose();
    },
  );
}
