import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/onboarding/first_run_guide.dart';
import 'package:napp_core/napp_core.dart';

void main() {
  testWidgets('first-run guide shows four steps once and is marked seen', (tester) async {
    final store = SettingsStore();
    AppDefaults.attach(store);
    expect(AppDefaults.guideSeen(), isFalse);

    await tester.pumpWidget(MaterialApp(
      locale: const Locale('tr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            key: const Key('open_guide'),
            onPressed: () => showFirstRunGuide(context),
            child: const Text('open'),
          ),
        ),
      ),
    ));
    await tester.tap(find.byKey(const Key('open_guide')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('first_run_guide')), findsOneWidget);

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.byKey(const Key('first_run_guide_next')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('first_run_guide')), findsOneWidget);
    }
    await tester.tap(find.byKey(const Key('first_run_guide_next')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('first_run_guide')), findsNothing);
    expect(AppDefaults.guideSeen(), isTrue);
  });
}
