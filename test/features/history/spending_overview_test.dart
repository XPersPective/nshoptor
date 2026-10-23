import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart' show SettingsStore;

import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/insights/insights_repository.dart';
import 'package:nshoptor/features/history/insights/monthly_report.dart';
import 'package:nshoptor/features/history/insights/spending_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';

void main() {
  setUp(() => AppFormatLocale.attach('tr'));
  tearDown(AppFormatLocale.attachReset);
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<int> completed(DateTime at, int minor, {String name = 'Elma', String currency = 'TRY'}) async {
    final id = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(
          currencyCode: currency, title: Value('Pazar <b>'), status: const Value('completed'), completedAt: Value(at)));
    await db.into(db.purchaseEntries).insert(PurchaseEntriesCompanion.insert(
          listId: id, name: name, normalizedName: name.toLowerCase(), actualQuantity: '1',
          actualUnitCode: 'adet', actualLineTotalMinorUnits: minor, userConfirmed: const Value(true)));
    return id;
  }

  test('period ranges and totals: week from Monday, month, year; yearly buckets', () async {
    final now = DateTime(2026, 10, 8); // Thursday
    expect(SpendSpan.week.range(now).from, DateTime(2026, 10, 5));
    expect(SpendSpan.week.range(now).to, DateTime(2026, 10, 12));
    expect(SpendSpan.month.range(now).from, DateTime(2026, 10));
    expect(SpendSpan.year.range(now).to, DateTime(2027));

    await completed(DateTime(2026, 10, 6, 10), 1000);
    await completed(DateTime(2026, 10, 2, 10), 2000);
    await completed(DateTime(2026, 3, 2, 10), 4000);
    await completed(DateTime(2025, 12, 31, 10), 8000);
    final points = await InsightsRepository(db).completedSpend('TRY');
    int total(SpendSpan s) => SpendMath.total(points, s.range(now).from, s.range(now).to);
    expect(total(SpendSpan.week), 1000);
    expect(total(SpendSpan.month), 3000);
    expect(total(SpendSpan.year), 7000);
    final years = SpendMath.byYear(points, now, years: 2);
    expect([for (final y in years) (y.$1.year, y.$2)], [(2025, 8000), (2026, 7000)]);
  });

  test('weekly and per-shopping limits are stored per currency; new lists get the shopping limit', () async {
    final store = SettingsStore();
    AppDefaults.attach(store);
    AppDefaults.setWeeklyLimitMinor(50000, currencyCode: 'TRY');
    AppDefaults.setShoppingLimitMinor(30000, currencyCode: 'TRY');
    expect(AppDefaults.weeklyLimitMinor(currencyCode: 'TRY'), 50000);
    expect(AppDefaults.weeklyLimitMinor(currencyCode: 'EUR'), isNull);

    final repo = ListRepository(db);
    final withDefault = await repo.createList(currencyCode: 'TRY');
    final explicit = await repo.createList(currencyCode: 'TRY', budgetMinorUnits: 1200);
    final otherCurrency = await repo.createList(currencyCode: 'EUR');
    expect((await repo.getById(withDefault)).budgetMinorUnits, 30000);
    expect((await repo.getById(explicit)).budgetMinorUnits, 1200);
    expect((await repo.getById(otherCurrency)).budgetMinorUnits, isNull);

    AppDefaults.setShoppingLimitMinor(null, currencyCode: 'TRY');
    expect(AppDefaults.shoppingLimitMinor(currencyCode: 'TRY'), isNull);
  });

  test('monthly report: brand, escaped list title, totals of the month only, limit line', () async {
    await completed(DateTime(2026, 10, 6, 10), 1500);
    await completed(DateTime(2026, 10, 9, 10), 2500);
    await completed(DateTime(2026, 9, 30, 10), 9900);
    final l10n = await AppLocalizations.delegate.load(const Locale('tr'));
    final html = await buildMonthlyReport(db, DateTime(2026, 10), 'TRY', l10n, 'tr',
        monthLabel: 'Ekim 2026', limitMinor: 3000);
    expect(html, contains('<span>N</span>Shoptor'));
    expect(html, contains('Aylık rapor · Ekim 2026'));
    expect(html, contains('Pazar &lt;b&gt;'));
    expect(html, isNot(contains('Pazar <b>')));
    expect(html, contains('40,00'));
    expect(html, isNot(contains('99,00')));
    expect(html, contains('Limit'));
  });

  test('day and week PDF snapshots use inclusive start, exclusive end and one currency', () async {
    final day = DateTime(2026, 10, 8);
    await completed(day, 1500, name: 'DayStart');
    await completed(DateTime(2026, 10, 8, 23, 59, 59), 2500, name: 'DayEnd');
    await completed(DateTime(2026, 10, 9), 9900, name: 'NextDay');
    await completed(DateTime(2026, 10, 7, 23, 59, 59), 100, name: 'PreviousDay');
    await completed(day, 999999, name: 'OtherCurrency', currency: 'EUR');
    final l10n = await AppLocalizations.delegate.load(const Locale('tr'));
    final html = await buildPeriodReport(db, day, DateTime(2026, 10, 9), 'TRY', l10n, 'tr',
      periodLabel: '<Bugün>');
    expect(html, contains('&lt;Bugün&gt;'));
    expect(html, contains('40,00'));
    expect(html, isNot(contains('99,00')));
    expect(html, isNot(contains('OtherCurrency')));
    // No planned price is known: do not invent a zero estimate or saving.
    expect(html, contains('${l10n.compareEstimated}: <b>—</b>'));
    expect(html, contains('${l10n.compareDiff}: <b>—</b>'));
    final week = SpendSpan.week.range(day);
    final weekly = await buildPeriodReport(db, week.from, week.to, 'TRY', l10n, 'tr',
      periodLabel: l10n.historyThisWeek);
    expect(weekly, contains('140,00'));
    await expectLater(buildPeriodReport(db, day, day, 'TRY', l10n, 'tr', periodLabel: 'invalid'),
      throwsArgumentError);
  });

  testWidgets('spending screen: overview, weekly and shopping limits, product spending by period', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 3200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final store = SettingsStore();
    AppDefaults.attach(store);
    AppDefaults.setWeeklyLimitMinor(500, currencyCode: 'TRY');
    await tester.runAsync(() async {
      await completed(DateTime(2026, 10, 6, 10), 1000, name: 'Elma');
      await completed(DateTime(2026, 3, 6, 10), 7000, name: 'Peynir');
    });
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('tr'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      home: SpendingScreen(db: db, currencyCode: 'TRY', now: DateTime(2026, 10, 8)),
    ));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('spending_overview')), findsOneWidget);
    expect(find.byKey(const Key('weekly_limit_card')), findsOneWidget);
    expect(find.byKey(const Key('shopping_limit_card')), findsOneWidget);
    expect(find.byKey(const Key('monthly_report')), findsOneWidget);
    // weekly spend 10,00 over a 5,00 limit shows the over text
    expect(find.descendant(of: find.byKey(const Key('weekly_limit_card')), matching: find.textContaining('aşıldı')),
        findsOneWidget);

    final chart = find.byKey(const Key('product_spending_chart'));
    expect(find.descendant(of: chart, matching: find.textContaining('Elma')), findsOneWidget);
    expect(find.descendant(of: chart, matching: find.textContaining('Peynir')), findsNothing);

    await tester.tap(find.text('Yıl'));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pumpAndSettle();
    expect(find.descendant(of: find.byKey(const Key('product_spending_chart')), matching: find.textContaining('Peynir')),
        findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
