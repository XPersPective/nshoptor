import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart' hide AppTheme;

import 'package:nshoptor/app/language_controller.dart';
import 'package:nshoptor/app/theme_mode_controller.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';
import 'package:nshoptor/features/settings/settings_screen.dart';

/// PB-200 (F02, F34-F37): Settings layout and the brand default theme.
void main() {
  group('default theme (F36)', () {
    test('fresh install starts on the brand dark-green theme', () {
      final store = SettingsStore();
      final controller = AppThemeModeController(store: store)..load();
      expect(controller.mode, ThemeMode.dark);
      expect(controller.palette, AppPalette.forest);
      expect(controller.black, isFalse);

      final dark = AppTheme.dark(palette: controller.palette, black: controller.black);
      expect(dark.colorScheme.surface, AppTheme.brandDarkSurface);
      expect(dark.colorScheme.surface, isNot(Colors.black));
      // Green-tinted, not grey: the green channel leads.
      final s = dark.colorScheme.surface;
      expect(s.g, greaterThan(s.r));
      expect(s.g, greaterThan(s.b));
    });

    test('pure black stays selectable and saved choices are kept', () {
      expect(AppTheme.dark(black: true).colorScheme.surface, Colors.black);

      final store = SettingsStore()
        ..setString(AppThemeModeController.storageKey, 'system')
        ..setBool(AppThemeModeController.blackKey, true);
      final controller = AppThemeModeController(store: store)..load();
      expect(controller.mode, ThemeMode.system);
      expect(controller.black, isTrue);

      final light = SettingsStore()..setString(AppThemeModeController.storageKey, 'light');
      expect((AppThemeModeController(store: light)..load()).mode, ThemeMode.light);
    });
  });

  group('Settings screen layout', () {
    late AppDatabase db;
    late SettingsRepository settings;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      settings = SettingsRepository(db, NappSettingsStoreOps(SettingsStore()),
          exportDirOverride: Directory.systemTemp.createTempSync('nshoptor_pb200'));
    });

    tearDown(() async {
      await db.close();
      await settings.exportDirOverride!.delete(recursive: true);
    });

    Future<void> pump(WidgetTester tester, TextDirection dir) async {
      await tester.binding.setSurfaceSize(const Size(320, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) => Directionality(textDirection: dir, child: child!),
        home: SettingsScreen(
          repository: settings,
          languageController: LanguageController(store: SettingsStore())..load(),
        ),
      ));
      await tester.pumpAndSettle();
    }

    for (final dir in TextDirection.values) {
      testWidgets('Pro badge keeps >=16dp from the edge and is centred ($dir)', (tester) async {
        await pump(tester, dir);
        final badge = tester.getRect(find.byKey(const Key('settings_plan_badge')));
        if (dir == TextDirection.ltr) {
          expect(320 - badge.right, greaterThanOrEqualTo(16));
        } else {
          expect(badge.left, greaterThanOrEqualTo(16));
        }
        final bar = tester.getRect(find.byType(AppBar));
        expect((badge.center.dy - bar.center.dy).abs(), lessThan(1));
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('header, captions and type scale follow F34/F35/F37', (tester) async {
      final semantics = tester.ensureSemantics();
      await pump(tester, TextDirection.ltr);
      final context = tester.element(find.byType(SettingsScreen));
      final l10n = AppLocalizations.of(context);
      final text = Theme.of(context).textTheme;

      // Larger app-bar title from the theme type scale.
      final title = tester.widget<AppBar>(find.byType(AppBar));
      expect(title.titleTextStyle?.fontSize, text.headlineSmall?.fontSize);

      // No small duplicate "NShoptor Pro" header above the Pro row.
      expect(find.byKey(const Key('brand_wordmark')), findsNothing);

      // Dropdown values are not repeated by captions; the field label remains
      // (visible and announced by TalkBack).
      expect(find.text(l10n.languageLabel), findsOneWidget);
      expect(find.text(l10n.formatLocaleLabel), findsOneWidget);
      expect(find.text(l10n.themeLabel), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp(l10n.languageLabel)), findsWidgets);

      // Keep-awake explains where it applies.
      final keepAwake = find.byKey(const Key('settings_keep_awake'));
      await tester.scrollUntilVisible(keepAwake, 200, scrollable: find.byType(Scrollable).first);
      expect(find.descendant(of: keepAwake, matching: find.text(l10n.keepScreenAwake)), findsOneWidget);
      expect(find.descendant(of: keepAwake, matching: find.text(l10n.shoppingTitle)), findsOneWidget);
      await tester.tap(keepAwake);
      await tester.pump();
      expect(settings.keepScreenAwake, isTrue);
      semantics.dispose();
    });
  });
}
