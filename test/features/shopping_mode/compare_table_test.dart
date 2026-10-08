import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/semantic_colors.dart';
import 'package:nshoptor/features/shopping_mode/summary/compare_table.dart';
import 'package:nshoptor/features/shopping_mode/summary/result_repository.dart';

ItemResultRow _row(String name, int planned, int actual, {bool notTaken = false, bool unplanned = false}) =>
    ItemResultRow(
      name: name,
      plannedQuantity: null,
      actualQuantity: null,
      plannedUnitPrice: null,
      actualUnitPrice: null,
      plannedLineTotalMinor: planned,
      actualLineTotalMinor: actual,
      lineVarianceMinor: notTaken ? 0 : actual - planned,
      variancePercent: null,
      discountMinor: 0,
      groups: const {},
      notTaken: notTaken,
      isUnplanned: unplanned,
      userConfirmed: true,
    );

void main() {
  testWidgets('elma 20→30 +10 (pahalı rengi), ekmek 0, alınmayan —, toplam ve bütçe', (tester) async {
    final result = ListResult(
      currencyCode: 'TRY',
      plannedTotalMinor: 4400,
      actualTotalMinor: 4500,
      unplannedTotalMinor: 300,
      unpurchasedPlannedMinor: 1200,
      totalDiscountMinor: 0,
      variancePercent: null,
      accuracy: null,
      budgetMinor: 4000,
      rows: [
        _row('elma', 2000, 3000),
        _row('ekmek', 1200, 1200),
        _row('peynir', 1200, 0, notTaken: true),
        _row('poşet', 0, 300, unplanned: true),
      ],
    );
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('tr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: SingleChildScrollView(child: CompareTable(result: result))),
    ));

    final elmaDiff = find.byKey(const Key('compare_diff_0'));
    expect(find.descendant(of: elmaDiff, matching: find.text('+10,00 ₺')), findsOneWidget);
    final over = SemanticDelta.resolve(direction: SpendingDirection.overPlan, brightness: Brightness.light);
    final text = tester.widget<Text>(find.descendant(of: elmaDiff, matching: find.byType(Text)));
    expect(text.style?.color, over.color);

    expect(tester.widget<Text>(find.byKey(const Key('compare_diff_1'))).data, '0');
    expect(find.text('alınmadı'), findsOneWidget);
    expect(find.text('plan dışı'), findsOneWidget);
    expect(find.descendant(of: find.byKey(const Key('compare_diff_total')), matching: find.text('+1,00 ₺')), findsOneWidget);
    expect(find.descendant(of: find.byKey(const Key('compare_diff_budget')), matching: find.text('+5,00 ₺')), findsOneWidget);
  });
}
