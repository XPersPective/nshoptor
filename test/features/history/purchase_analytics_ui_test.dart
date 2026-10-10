import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/insights/spending_screen.dart';
import 'package:nshoptor/features/history/price_history/price_history_sheet.dart';

void main() {
  for (final (language, size, brightness) in [
    ('en', const Size(320, 640), Brightness.light),
    ('ar', const Size(320, 640), Brightness.dark),
    ('en', const Size(375, 812), Brightness.light),
    ('ar', const Size(640, 375), Brightness.dark),
  ]) {
    testWidgets('real quantity/visit graphs and filtered price history at $size/2x ($language/$brightness)', (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(() => db.close());
      AppDefaults.attach(SettingsStore()); AppFormatLocale.attach('en');
      addTearDown(AppFormatLocale.attachReset);
      await tester.binding.setSurfaceSize(size);
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final name = List.filled(5, 'Long tomatoes name').join(' ');
      final product = await db.into(db.productMemory).insert(ProductMemoryCompanion.insert(canonicalName: name, normalizedName: 'tomatoes'));
      for (final (day, qty, minor) in [(1, '2', 2000), (11, '3', 3000), (21, '-1', -1000)]) {
        final list = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: 'TRY',
          status: const Value('completed'), completedAt: Value(DateTime(2026, 10, day))));
        await db.into(db.purchaseEntries).insert(PurchaseEntriesCompanion.insert(listId: list, name: name,
          normalizedName: 'tomatoes', actualQuantity: qty, actualUnitCode: 'kilogram',
          actualLineTotalMinorUnits: minor, grossTotalMinorUnits: Value(minor), userConfirmed: const Value(true)));
      }
      final observations = <int>[];
      for (final (currency, unit) in [('TRY', 'kilogram'), ('USD', 'kilogram'), ('TRY', 'piece')]) {
        observations.add(await db.into(db.priceObservations).insert(PriceObservationsCompanion.insert(
          productId: Value(product), observedAt: Value(DateTime(2026, 10, 1)), quantity: '1', unitCode: unit,
          unitPrice: '10', lineTotalMinorUnits: 1000, currencyCode: currency, source: 'manual')));
      }
      final key = GlobalKey<NavigatorState>();
      await tester.pumpWidget(MaterialApp(navigatorKey: key, theme: ThemeData(brightness: brightness), locale: Locale(language),
        localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate], supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(2), disableAnimations: true), child: child!),
        home: SpendingScreen(db: db, currencyCode: 'TRY', now: DateTime(2026, 10, 25))));
      await tester.pump();
      await tester.runAsync(() => tester.widget<FutureBuilder>(find.byWidgetPredicate((w) => w is FutureBuilder).first).future!);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.descendant(of: find.byKey(const Key('cal_day_11')), matching: find.text('11')), findsOneWidget);
      final l10n = AppLocalizations.of(tester.element(find.byType(SpendingScreen)));
      final scroll = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(find.textContaining(l10n.purchaseHistoryHint), 400, scrollable: scroll);
      expect(tester.takeException(), isNull);
      await tester.scrollUntilVisible(find.widgetWithText(TextButton, l10n.priceHistoryAction), 400, scrollable: scroll);
      expect(find.text('${l10n.purchaseVisits}: 2'), findsWidgets);
      expect(find.text('${l10n.purchasedQuantity}: 4 ${l10n.unitKilogram}'), findsWidgets);
      expect(find.text('${l10n.purchaseInterval}: 10.00'), findsWidgets);
      expect(tester.takeException(), isNull);
      await tester.scrollUntilVisible(find.widgetWithText(TextButton, l10n.priceHistoryAction), 300, scrollable: scroll);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, l10n.priceHistoryAction)); await tester.pumpAndSettle();
      expect(find.byType(PriceHistoryScreen), findsOneWidget);
      expect(find.byKey(Key('price_obs_${observations[0]}')), findsOneWidget);
      expect(find.byKey(Key('price_obs_${observations[1]}')), findsNothing);
      expect(find.byKey(Key('price_obs_${observations[2]}')), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close(); await tester.pump(); await closing;
    });
  }
}
