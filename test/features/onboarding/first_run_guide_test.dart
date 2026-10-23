import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/onboarding/first_run_guide.dart';
import 'package:napp_core/napp_core.dart';

Future<void> openGuide(
  WidgetTester tester, {
  String language = 'tr',
  double scale = 1,
  bool dark = false,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: Locale(language),
      theme: ThemeData(brightness: dark ? Brightness.dark : Brightness.light),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(scale)),
        child: child!,
      ),
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            key: const Key('open_guide'),
            onPressed: () => showFirstRunGuide(context),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.byKey(const Key('open_guide')));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() => AppDefaults.attach(SettingsStore()));

  testWidgets('guide completes all seven steps, records seen and can reopen', (
    tester,
  ) async {
    expect(AppDefaults.guideSeen(), isFalse);
    await openGuide(tester);
    for (var i = 1; i <= 7; i++) {
      expect(find.text('$i / 7'), findsOneWidget);
      expect(AppDefaults.guideSeen(), isFalse);
      await tester.tap(find.byKey(const Key('first_run_guide_next')));
      await tester.pumpAndSettle();
    }
    expect(find.byKey(const Key('first_run_guide')), findsNothing);
    expect(AppDefaults.guideSeen(), isTrue);
    await tester.tap(find.byKey(const Key('open_guide')));
    await tester.pumpAndSettle();
    expect(find.text('1 / 7'), findsOneWidget);
    await tester.tap(find.byKey(const Key('first_run_guide_close')));
    await tester.pumpAndSettle();
    expect(AppDefaults.guideSeen(), isTrue);
  });

  testWidgets('previous, close and system back do not acknowledge first use', (
    tester,
  ) async {
    await openGuide(tester);
    await tester.tap(find.byKey(const Key('first_run_guide_next')));
    await tester.pumpAndSettle();
    expect(find.text('2 / 7'), findsOneWidget);
    await tester.tap(find.byKey(const Key('first_run_guide_back')));
    await tester.pumpAndSettle();
    expect(find.text('1 / 7'), findsOneWidget);
    expect(find.byKey(const Key('first_run_guide_back')), findsNothing);
    await tester.tap(find.byKey(const Key('first_run_guide_close')));
    await tester.pumpAndSettle();
    expect(AppDefaults.guideSeen(), isFalse);
    await tester.tap(find.byKey(const Key('open_guide')));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('first_run_guide')), findsNothing);
    expect(AppDefaults.guideSeen(), isFalse);
  });

  for (final language in ['tr', 'en', 'ar']) {
    for (final dark in [false, true]) {
      testWidgets(
        'guide scrolls and actions fit 320dp 2x $language dark=$dark',
        (tester) async {
          await tester.binding.setSurfaceSize(const Size(320, 640));
          addTearDown(() => tester.binding.setSurfaceSize(null));
          await openGuide(tester, language: language, scale: 2, dark: dark);
          for (var i = 1; i <= 7; i++) {
            expect(tester.takeException(), isNull);
            final next = find.byKey(const Key('first_run_guide_next'));
            expect(next.hitTestable(), findsOneWidget);
            if (i == 3) {
              final scrollable = find.descendant(
                of: find.byKey(const Key('first_run_guide')),
                matching: find.byType(Scrollable),
              );
              expect(scrollable, findsOneWidget);
              final state = tester.state<ScrollableState>(scrollable);
              expect(state.position.maxScrollExtent, greaterThan(0));
              await tester.drag(scrollable, const Offset(0, -200));
              await tester.pumpAndSettle();
              expect(next.hitTestable(), findsOneWidget);
            }
            await tester.tap(next);
            await tester.pumpAndSettle();
          }
          expect(tester.takeException(), isNull);
          expect(AppDefaults.guideSeen(), isTrue);
        },
      );
    }
  }
}
