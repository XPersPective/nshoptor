import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart' show SettingsStore;
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/home/home_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/subscription/subscription_paywall.dart';
import 'package:nshoptor/features/subscription/subscription_service.dart';

void main() {
  setUpAll(() async {
    if (const String.fromEnvironment('CAPTURE_OUT').isEmpty) return;
    final fonts = FontLoader('Roboto');
    for (final name in ['segoeui.ttf', 'segoeuib.ttf']) {
      fonts.addFont(
        File('C:/Windows/Fonts/$name').readAsBytes().then(ByteData.sublistView),
      );
    }
    await fonts.load();
    final root = Platform.environment['FLUTTER_ROOT'] ?? 'C:/flutter';
    await (FontLoader('MaterialIcons')..addFont(
          File(
            '$root/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
          ).readAsBytes().then(ByteData.sublistView),
        ))
        .load();
  });

  late AppDatabase db;
  late ListRepository repo;
  late SettingsStore store;
  late SubscriptionService subs;

  setUp(() {
    store = SettingsStore();
    AppDefaults.attach(store);
    db = AppDatabase(NativeDatabase.memory());
    repo = ListRepository(db);
    subs = SubscriptionService(store: store)..initializeTrial();
  });

  tearDown(() => subs.dispose());

  Widget host({
    String locale = 'tr',
    ThemeData? theme,
    double scale = 1.0,
    SubscriptionService? service,
  }) => MaterialApp(
    locale: Locale(locale),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    theme: theme ?? AppTheme.light(),
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
      child: child!,
    ),
    home: HomeShell(
      db: db,
      listRepository: repo,
      appsCacheStore: store,
      subscriptions: service ?? subs,
    ),
  );

  Future<void> closeTree(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  testWidgets('displays 7-day Free Pro card, opens paywall on tap, and persists dismissal', (tester) async {
    await tester.pumpWidget(host(locale: 'tr'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('home_pro_promo_card')), findsOneWidget);
    expect(find.text('7 gün ücretsiz Pro deneyin'), findsOneWidget);
    expect(find.byKey(const Key('home_pro_promo_remaining')), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('home_pro_promo_dismiss'))).height,
      greaterThanOrEqualTo(48),
    );
    expect(
      tester.getSize(find.byKey(const Key('home_pro_promo_card'))).height,
      greaterThanOrEqualTo(48),
    );

    final captureOut = const String.fromEnvironment('CAPTURE_OUT');
    if (captureOut.isNotEmpty) {
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('$captureOut/pb219_home_promo_tr_light.png'),
      );
    }

    await tester.tap(find.byKey(const Key('home_pro_promo_card')));
    await tester.pumpAndSettle();
    expect(find.byType(SubscriptionPaywall), findsOneWidget);

    Navigator.of(tester.element(find.byType(SubscriptionPaywall))).pop();
    await tester.pumpAndSettle();
    expect(find.byType(SubscriptionPaywall), findsNothing);

    await tester.tap(find.byKey(const Key('home_pro_promo_dismiss')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home_pro_promo_card')), findsNothing);
    expect(store.getBool('home_pro_promo_dismissed_v1'), isTrue);

    await tester.pumpWidget(host(locale: 'tr', service: subs));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home_pro_promo_card')), findsNothing);
    await closeTree(tester);
  });

  testWidgets('hides promo card when trial is inactive', (tester) async {
    final freeSubs = SubscriptionService(store: SettingsStore());
    addTearDown(freeSubs.dispose);
    await tester.pumpWidget(host(locale: 'en', service: freeSubs));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home_pro_promo_card')), findsNothing);
    await closeTree(tester);
  });

  for (final cfg in [
    (width: 320.0, locale: 'tr', scale: 2.0, theme: AppTheme.dark()),
    (width: 320.0, locale: 'ar', scale: 2.0, theme: AppTheme.dark(black: true)),
  ]) {
    testWidgets('fits ${cfg.width} ${cfg.locale} scale=${cfg.scale} without overflow', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = Size(cfg.width, 640);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        host(locale: cfg.locale, scale: cfg.scale, theme: cfg.theme),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('home_pro_promo_card')), findsOneWidget);
      expect(tester.takeException(), isNull);
      final captureOut = const String.fromEnvironment('CAPTURE_OUT');
      if (captureOut.isNotEmpty && cfg.locale == 'ar') {
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('$captureOut/pb219_home_promo_320_ar_amoled.png'),
        );
      }
      await closeTree(tester);
    });
  }

  test('all 71 locales translate homeProPromoTitle and homeProPromoSubtitle cleanly', () {
    final en = lookupAppLocalizations(const Locale('en'));
    for (final loc in AppLocalizations.supportedLocales) {
      final t = lookupAppLocalizations(loc);
      expect(t.homeProPromoTitle.trim(), isNotEmpty, reason: '$loc title');
      expect(t.homeProPromoSubtitle.trim(), isNotEmpty, reason: '$loc subtitle');
      if (loc.languageCode != 'en') {
        expect(t.homeProPromoTitle, isNot(en.homeProPromoTitle), reason: '$loc title untranslated');
        expect(t.homeProPromoSubtitle, isNot(en.homeProPromoSubtitle), reason: '$loc subtitle untranslated');
      }
    }
  });
}
