import 'package:flutter/material.dart';

import 'dart:ui' show Tristate;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/widgets/price_mode_selector.dart';

void main() {
  for (final language in ['tr', 'de', 'ar']) {
    testWidgets(
      '$language at320px/2x: one tap selects, both options visible and accessible',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(320, 640));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final semantics = tester.ensureSemantics();
        bool? value = false;
        var calls = 0;
        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(language),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: Scaffold(
              body: Builder(
                builder: (context) => MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(2)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: StatefulBuilder(
                      builder: (context, setState) => PriceModeSelector(
                        value: value,
                        unitLabel: 'kg',
                        onChanged: (v) => setState(() {
                          value = v;
                          calls++;
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byKey(const Key('price_mode_total')), findsOneWidget);
        final unit = find.byKey(const Key('price_mode_unit'));
        expect(unit, findsOneWidget);
        expect(find.byType(DropdownButtonFormField<bool>), findsNothing);
        await tester.tap(unit);
        await tester.pumpAndSettle();
        expect(value, isTrue);
        expect(calls, 1);
        final button = find
            .ancestor(of: unit, matching: find.byType(TextButton))
            .first;
        expect(tester.getSize(button).height, greaterThanOrEqualTo(48));
        expect(
          tester.getSemantics(button).flagsCollection.isSelected,
          Tristate.isTrue,
        );
        await tester.tap(find.byKey(const Key('price_mode_total')));
        await tester.pumpAndSettle();
        expect(value, isFalse);
        expect(calls, 2);
        expect(tester.takeException(), isNull);
        semantics.dispose();
      },
    );
  }
}
