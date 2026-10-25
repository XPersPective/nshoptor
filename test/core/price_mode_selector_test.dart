import 'package:flutter/material.dart';

import 'dart:ui' show Tristate;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
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

  testWidgets('dark ocean uses readable neutral options and a selected check', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final semantics = tester.ensureSemantics();
    try {
      for (final black in [false, true]) {
        final theme = AppTheme.dark(palette: AppPalette.ocean, black: black);
        bool? value;
        var calls = 0;
        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            locale: const Locale('tr'),
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
                        onChanged: (next) => setState(() {
                          value = next;
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
        expect(find.byIcon(Icons.check), findsNothing);
        final segment = tester.widget<SegmentedButton<bool>>(
          find.byType(SegmentedButton<bool>),
        );
        final neutral = segment.style!.backgroundColor!.resolve({})!;
        final neutralText = segment.style!.foregroundColor!.resolve({})!;
        double contrast(Color a, Color b) {
          final first = a.computeLuminance();
          final second = b.computeLuminance();
          return first > second
              ? (first + 0.05) / (second + 0.05)
              : (second + 0.05) / (first + 0.05);
        }

        expect(neutral, isNot(Colors.black));
        expect(contrast(neutralText, neutral), greaterThanOrEqualTo(4.5));
        final selectedBackground = segment.style!.backgroundColor!.resolve({
          WidgetState.selected,
        })!;
        final selectedForeground = segment.style!.foregroundColor!.resolve({
          WidgetState.selected,
        })!;
        expect(selectedBackground, isNot(neutral));
        expect(
          contrast(selectedForeground, selectedBackground),
          greaterThanOrEqualTo(4.5),
        );
        await tester.tap(find.byKey(const Key('price_mode_unit')));
        await tester.pumpAndSettle();
        expect(value, isTrue);
        expect(calls, 1);
        final unitButton = find
            .ancestor(
              of: find.byKey(const Key('price_mode_unit')),
              matching: find.byType(TextButton),
            )
            .first;
        expect(
          find.descendant(of: unitButton, matching: find.byIcon(Icons.check)),
          findsOneWidget,
        );
        expect(
          tester.getSemantics(unitButton).flagsCollection.isSelected,
          Tristate.isTrue,
        );
        await tester.tap(find.byKey(const Key('price_mode_total')));
        await tester.pumpAndSettle();
        expect(value, isFalse);
        expect(calls, 2);
        expect(find.byIcon(Icons.check), findsOneWidget);
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
      }
    } finally {
      semantics.dispose();
    }
  });
}
