import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:napp_core/napp_core.dart' show SettingsStore;

import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations_en.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/history_screen.dart';
import 'package:nshoptor/features/history/insights/history_budget_card.dart';
import 'package:nshoptor/features/history/reports/report_document.dart';
import 'package:nshoptor/features/history/reports/report_groups.dart';
import 'package:nshoptor/features/history/reports/report_period.dart';
import 'package:nshoptor/features/history/reports/report_repository.dart';

void main() {
  late AppDatabase db;
  late SettingsStore store;
  final now = DateTime(2026, 10, 21, 12);
  late int listA, listB;
  var closed = false;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    store = SettingsStore();
    AppDefaults.attach(store);
    AppFormatLocale.attach('tr');
    closed = false;
  });
  tearDown(() async {
    AppFormatLocale.attachReset();
    if (!closed) await db.close();
  });

  Future<void> buy(
    int list,
    String name,
    int minor,
    String qty,
    String unit, {
    int? receipt,
  }) => db
      .into(db.purchaseEntries)
      .insert(
        PurchaseEntriesCompanion.insert(
          listId: list,
          receiptId: Value(receipt),
          name: name,
          normalizedName: name.toLowerCase(),
          actualQuantity: qty,
          actualUnitCode: unit,
          actualUnitPrice: Value('${minor ~/ 100}'),
          actualLineTotalMinorUnits: minor,
          userConfirmed: const Value(true),
        ),
      );

  /// Trip A (Mon) at ŞOK with one receipt from BİM: one trip spans 2 stores.
  /// Trip B (Tue) at "Şok Marketler" (the same store, different spelling).
  Future<void> seed() async {
    final sok = await db
        .into(db.stores)
        .insert(StoresCompanion.insert(name: 'ŞOK MARKETLER TİC. A.Ş.'));
    final sok2 = await db
        .into(db.stores)
        .insert(StoresCompanion.insert(name: 'Şok Marketler'));
    listA = await db
        .into(db.shoppingLists)
        .insert(
          ShoppingListsCompanion.insert(
            title: const Value('Haftalık'),
            currencyCode: 'TRY',
            storeId: Value(sok),
            status: const Value('completed'),
            completedAt: Value(DateTime(2026, 10, 19, 10)),
          ),
        );
    listB = await db
        .into(db.shoppingLists)
        .insert(
          ShoppingListsCompanion.insert(
            title: const Value('Akşam'),
            currencyCode: 'TRY',
            storeId: Value(sok2),
            status: const Value('completed'),
            completedAt: Value(DateTime(2026, 10, 20, 18)),
          ),
        );
    final receipt = await db
        .into(db.receipts)
        .insert(
          ReceiptsCompanion.insert(
            listId: Value(listA),
            processingStatus: const Value('reviewed'),
            confirmedStore: const Value('BİM BİRLEŞİK MAĞAZALAR A.Ş.'),
          ),
        );
    await buy(listA, 'Elma', 6400, '2', 'kilogram');
    await buy(listA, 'Süt', 2500, '1', 'piece', receipt: receipt);
    await buy(listB, 'elma ', 3000, '1', 'kilogram');
  }

  Future<PeriodReport> week() =>
      ReportRepository(db)
          .period(ReportPeriod.forSpan(ReportSpan.week, now), 'TRY');

  test('groups one period by shopping day, store and product', () async {
    await seed();
    final report = await week();
    expect(report.shopping, hasLength(2));

    final days = spendByDay(report.shopping);
    expect(
      [for (final d in days) d.day],
      [DateTime(2026, 10, 19), DateTime(2026, 10, 20)],
    );
    expect([for (final d in days) d.spent.minor], [8900, 3000]);

    final stores = groupByStore(report.shopping);
    // "ŞOK MARKETLER TİC. A.Ş." and "Şok Marketler" are one store.
    expect(stores, hasLength(2));
    expect(stores.first.label!.toLowerCase(), 'şok marketler');
    expect(stores.last.label, 'BİM BİRLEŞİK MAĞAZALAR');
    expect([for (final s in stores) s.spent.minor], [9400, 2500]);
    expect([for (final s in stores) s.count], [2, 1]);
    expect(
      stores.fold<int>(0, (sum, s) => sum + s.spent.minor),
      report.spent.minor,
    );

    final products = groupByProduct(report.shopping);
    expect([for (final p in products) p.label], ['Elma', 'Süt']);
    final apple = products.first;
    expect(apple.spent.minor, 9400);
    expect(apple.count, 2);
    expect(apple.quantities.single.unitCode, 'kilogram');
    expect(apple.quantities.single.quantity.toDbString(), '3');
    expect(apple.byDay, hasLength(2));
  });

  test('a trip without a store is grouped as unknown store', () async {
    final id = await db
        .into(db.shoppingLists)
        .insert(
          ShoppingListsCompanion.insert(
            currencyCode: 'TRY',
            status: const Value('completed'),
            completedAt: Value(now),
          ),
        );
    await buy(id, 'Ekmek', 1000, '1', 'piece');
    final groups = groupByStore((await week()).shopping);
    expect(groups.single.label, isNull);
    expect(groups.single.spent.minor, 1000);
    final text = ReportText(AppLocalizationsEn(), 'en', 'TRY');
    expect(text.groupLabel(groups.single), 'Unknown store');
  });

  test(
    'each view exports its own table; Share all exports everything',
    () async {
      await initializeDateFormatting('en');
      await seed();
      final report = await week();
      final l = AppLocalizationsEn();
      final text = ReportText(l, 'en', 'TRY');

      final byStore = historyViewDocument(report, HistoryView.store, 'W', l);
      final storeCsv = buildShoppingReportCsv(byStore, text);
      expect(
        storeCsv,
        contains('"By store","Şok Marketler","2","TRY","94.00"'),
      );
      expect(storeCsv, isNot(contains(l.reportDateColumn)));
      final storeHtml = buildShoppingReportHtml(byStore, text);
      expect(storeHtml, contains('<h2>By store</h2>'));
      expect(storeHtml, isNot(contains('<h2>Haftalık</h2>')));
      expect(
        buildShoppingReportText(byStore, text),
        contains('BİM BİRLEŞİK MAĞAZALAR'),
      );

      final byProduct = historyViewDocument(
        report,
        HistoryView.product,
        'W',
        l,
      );
      final productCsv = buildShoppingReportCsv(byProduct, text);
      expect(
        productCsv,
        contains('"By product","Elma","3 kg","2","TRY","94.00"'),
      );
      expect(
        buildShoppingReportHtml(byProduct, text),
        contains('<h2>By product</h2>'),
      );

      final byShopping = historyViewDocument(
        report,
        HistoryView.shopping,
        'W',
        l,
      );
      expect(byShopping.summaries, isEmpty);
      expect(buildShoppingReportHtml(byShopping, text), contains('Haftalık'));

      final all = historyViewDocument(report, null, 'W', l);
      final allHtml = buildShoppingReportHtml(all, text);
      for (final part in ['Haftalık', 'Akşam', 'By store', 'By product']) {
        expect(allHtml, contains(part));
      }
      expect(
        '${l.reportTotalSpent}: ${text.money(11900)}'.allMatches(allHtml),
        hasLength(1),
      );
      final allCsv = buildShoppingReportCsv(all, text);
      expect(allCsv, contains(l.reportDateColumn));
      expect(allCsv, contains('"By product","Süt"'));
    },
  );

  Widget app({double scale = 1, String locale = 'tr'}) => MaterialApp(
    theme: AppTheme.light(),
    locale: Locale(locale),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: TextScaler.linear(scale)),
      child: child!,
    ),
    home: HistoryScreen(db: db, now: now),
  );

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 30)),
      );
      await tester.pumpAndSettle();
    }
  }

  Future<void> unmount(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.binding.setSurfaceSize(null);
  }

  Future<void> close(WidgetTester tester) async {
    await unmount(tester);
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
    closed = true;
  }

  Future<void> reveal(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
  }

  Finder scrollable() => find
      .descendant(
        of: find.byType(ListView).last,
        matching: find.byType(Scrollable),
      )
      .first;

  for (final (width, scale, locale) in [
    (412.0, 1.0, 'tr'),
    (320.0, 2.0, 'tr'),
    (320.0, 2.0, 'ar'),
  ]) {
    testWidgets('views by shopping, store and product show values at '
        '${width.toInt()}dp x$scale $locale', (tester) async {
      await tester.binding.setSurfaceSize(Size(width, 900));
      AppFormatLocale.attach(locale);
      await tester.runAsync(seed);
      await tester.pumpWidget(app(scale: scale, locale: locale));
      await settle(tester);
      final l = AppLocalizations.of(tester.element(find.byType(HistoryScreen)));
      final money = ReportText(l, locale, 'TRY').money;

      // Date range is a labelled 48dp button at the top.
      final calendar = find.byKey(const Key('history_calendar'));
      expect(tester.getSize(calendar).height, greaterThanOrEqualTo(48));
      expect(find.byKey(const Key('history_period_reset')), findsNothing);

      // By shopping: daily chart with visible amounts.
      await tester.scrollUntilVisible(
        find.byKey(const Key('history_shopping_chart')),
        200,
        scrollable: scrollable(),
      );
      final daily = find.byKey(const Key('history_shopping_chart'));
      expect(
        find.descendant(of: daily, matching: find.textContaining(money(8900))),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        find.byKey(Key('history_share_list_$listA')),
        200,
        scrollable: scrollable(),
      );
      expect(
        tester.getSize(find.byKey(Key('history_share_list_$listA'))).height,
        greaterThanOrEqualTo(48),
      );

      for (final (view, chart, value) in [
        ('store', 'history_store_chart', money(9400)),
        ('product', 'history_product_chart', money(9400)),
      ]) {
        await tester.scrollUntilVisible(
          find.byKey(Key('history_view_$view')),
          -200,
          scrollable: scrollable(),
        );
        await reveal(tester, find.byKey(Key('history_view_$view')));
        await tester.tap(find.byKey(Key('history_view_$view')));
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.byKey(Key(chart)),
          200,
          scrollable: scrollable(),
        );
        expect(
          find.descendant(
            of: find.byKey(Key(chart)),
            matching: find.textContaining(value),
          ),
          findsOneWidget,
        );
      }
      // Per-product daily chart inside the product row.
      await tester.scrollUntilVisible(
        find.byKey(const Key('history_product_0')),
        200,
        scrollable: scrollable(),
      );
      await reveal(tester, find.byKey(const Key('history_product_0')));
      await tester.tap(find.byKey(const Key('history_product_0')));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.byKey(const Key('history_product_chart_0')),
        200,
        scrollable: scrollable(),
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('history_product_chart_0')),
          matching: find.textContaining(money(6400)),
        ),
        findsOneWidget,
      );

      // Export this view.
      await tester.scrollUntilVisible(
        find.byKey(const Key('history_share_view')),
        -200,
        scrollable: scrollable(),
      );
      await reveal(tester, find.byKey(const Key('history_share_view')));
      await tester.tap(find.byKey(const Key('history_share_view')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('report_share_menu')), findsOneWidget);
      await tester.tapAt(const Offset(5, 5));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await close(tester);
    });
  }

  testWidgets('moving away shows a reset back to this week', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 800));
    await tester.pumpWidget(app(scale: 2));
    await settle(tester);
    await tester.tap(
      find.byTooltip(
        AppLocalizations.of(tester.element(find.byType(HistoryScreen)))
            .previousPeriodAction,
      ),
    );
    await settle(tester);
    final reset = find.byKey(const Key('history_period_reset'));
    expect(reset, findsOneWidget);
    await tester.tap(reset);
    await settle(tester);
    expect(reset, findsNothing);
    expect(tester.takeException(), isNull);
    await close(tester);
  });

  for (final (width, scale) in [(412.0, 1.0), (320.0, 2.0)]) {
    testWidgets('budget card shows weekly and monthly progress at '
        '${width.toInt()}dp x$scale', (tester) async {
      await tester.binding.setSurfaceSize(Size(width, 900));
      await tester.runAsync(seed);
      await tester.pumpWidget(app(scale: scale));
      await settle(tester);
      expect(find.byKey(const Key('history_budget_card')), findsNothing);
      await unmount(tester);

      AppDefaults.setWeeklyLimitMinor(10000, currencyCode: 'TRY', week: now);
      AppDefaults.setMonthlyLimitMinor(
        10000,
        currencyCode: 'TRY',
        month: DateTime(now.year, now.month),
      );
      await tester.binding.setSurfaceSize(Size(width, 900));
      await tester.pumpWidget(app(scale: scale));
      await settle(tester);
      final l = AppLocalizations.of(tester.element(find.byType(HistoryScreen)));
      final money = ReportText(l, 'tr', 'TRY').money;
      final card = find.byKey(const Key('history_budget_card'));
      expect(card, findsOneWidget);
      final weekRow = find.byKey(const Key('history_budget_week'));
      expect(
        find.descendant(
          of: weekRow,
          matching: find.text('${money(11900)} / ${money(10000)}'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: weekRow,
          matching: find.text(l.monthlyLimitOver(money(1900))),
        ),
        findsOneWidget,
      );
      final bar = tester.widget<LinearProgressIndicator>(
        find.descendant(
          of: weekRow,
          matching: find.byType(LinearProgressIndicator),
        ),
      );
      expect(bar.value, 1);
      expect(bar.color, Theme.of(tester.element(card)).colorScheme.error);
      expect(find.byKey(const Key('history_budget_month')), findsOneWidget);
      expect(
        tester.getSize(find.byKey(const Key('history_budget_edit'))).height,
        greaterThanOrEqualTo(48),
      );
      final handle = tester.ensureSemantics();
      expect(tester.getSemantics(weekRow).label, contains(l.weeklyLimitTitle));
      handle.dispose();
      expect(tester.takeException(), isNull);
      await close(tester);
    });
  }

  testWidgets('budget at 80% turns to the warning colour', (tester) async {
    await tester.runAsync(seed);
    AppDefaults.setWeeklyLimitMinor(14000, currencyCode: 'TRY', week: now);
    await tester.pumpWidget(app());
    await settle(tester);
    final row = find.byKey(const Key('history_budget_week'));
    final bar = tester.widget<LinearProgressIndicator>(
      find.descendant(of: row, matching: find.byType(LinearProgressIndicator)),
    );
    expect(11900 / 14000, greaterThanOrEqualTo(HistoryBudgetCard.warnRatio));
    expect(bar.color, Theme.of(tester.element(row)).colorScheme.tertiary);
    expect(find.byKey(const Key('history_budget_month')), findsNothing);
    await close(tester);
  });
}
