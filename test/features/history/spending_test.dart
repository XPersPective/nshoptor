import 'package:nshoptor/core/money/format_locale.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/insights/insights_repository.dart';
import 'package:nshoptor/features/history/insights/spending_screen.dart';

void main() {
  setUp(() => AppFormatLocale.attach('tr'));
  tearDown(AppFormatLocale.attachReset);
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  for (final (currency, minor, initial, edited, expected) in [
    ('JPY', 1234, '1234', '2345', 2345),
    ('KWD', 12345, '12,345', '98,765', 98765),
    ('TRY', 12345, '123,45', '234,56', 23456),
  ]) {
    testWidgets('$currency limit prefill round-trip, validation and cancel preserve data', (tester) async {
      final store = SettingsStore();
      store.setString('app.currency', 'USD');
      AppDefaults.attach(store);
      AppDefaults.setMonthlyLimitMinor(7890, currencyCode: 'USD');
      AppDefaults.setMonthlyLimitMinor(minor, currencyCode: currency);
      await tester.pumpWidget(MaterialApp(locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        home: SpendingScreen(db: db, currencyCode: currency, now: DateTime(2026, 10, 8))));
      await tester.runAsync(() => db.select(db.shoppingLists).get());
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('limit_edit'))); await tester.pumpAndSettle();
      expect(tester.widget<TextFormField>(find.byKey(const Key('limit_field'))).initialValue, initial);
      await tester.enterText(find.byKey(const Key('limit_field')), 'invalid');
      await tester.tap(find.byKey(const Key('limit_save'))); await tester.pumpAndSettle();
      expect(find.text('Invalid price'), findsOneWidget);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(AppDefaults.monthlyLimitMinor(currencyCode: currency), minor);
      await tester.enterText(find.byKey(const Key('limit_field')), edited);
      await tester.tap(find.byKey(const Key('limit_save'))); await tester.pumpAndSettle();
      expect(AppDefaults.monthlyLimitMinor(currencyCode: currency), expected);
      expect(AppDefaults.monthlyLimitMinor(currencyCode: 'USD'), 7890);
      await tester.tap(find.byKey(const Key('limit_edit'))); await tester.pumpAndSettle();
      expect(tester.widget<TextFormField>(find.byKey(const Key('limit_field'))).initialValue, edited);
      await tester.enterText(find.byKey(const Key('limit_field')), '999');
      await tester.binding.handlePopRoute(); await tester.pumpAndSettle();
      expect(AppDefaults.monthlyLimitMinor(currencyCode: currency), expected);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  Future<void> completed(DateTime at, int minor, {String currency = 'TRY'}) async {
    final id = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(
          currencyCode: currency, status: const Value('completed'), completedAt: Value(at)));
    await db.into(db.purchaseEntries).insert(PurchaseEntriesCompanion.insert(
          listId: id, name: 'x', normalizedName: 'x', actualQuantity: '1',
          actualUnitCode: 'adet', actualLineTotalMinorUnits: minor, userConfirmed: const Value(true)));
  }

  test('günlük, haftalık, aylık toplamlar; başka para birimi karışmaz', () async {
    await completed(DateTime(2026, 10, 3, 12), 10000);
    await completed(DateTime(2026, 10, 3, 18), 5000);
    await completed(DateTime(2026, 10, 7, 10), 2500);
    await completed(DateTime(2026, 9, 20, 10), 4000);
    await completed(DateTime(2026, 10, 5, 10), 99999, currency: 'EUR');
    final points = await InsightsRepository(db).completedSpend('TRY');
    expect(points.length, 4);
    expect(SpendMath.byDay(points, 2026, 10), {3: 15000, 7: 2500});
    final weeks = SpendMath.byWeek(points, DateTime(2026, 10, 8), weeks: 2);
    expect(weeks.last.$1, DateTime(2026, 10, 5));
    expect(weeks.last.$2, 2500);
    expect(weeks.first.$2, 15000);
    final months = SpendMath.byMonth(points, DateTime(2026, 10, 8), months: 2);
    expect([for (final m in months) m.$2], [4000, 17500]);
  });

  test('boş veri: sıfır toplamlar, hata yok', () async {
    final points = await InsightsRepository(db).completedSpend('TRY');
    expect(SpendMath.byDay(points, 2026, 10), isEmpty);
    expect(SpendMath.byMonth(points, DateTime(2026, 10, 8), months: 3).every((m) => m.$2 == 0), isTrue);
  });

  testWidgets('limit aşımı kırmızı ve "aşıldı" metni', (tester) async {
    final store = SettingsStore();
    AppDefaults.attach(store);
    AppDefaults.setMonthlyLimitMinor(10000);
    await tester.runAsync(() => completed(DateTime(2026, 10, 3, 12), 15000));
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('tr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: SpendingScreen(db: db, now: DateTime(2026, 10, 8), currencyCode: 'TRY'),
    ));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump();
    expect(find.text('Limit 50,00 ₺ aşıldı'), findsOneWidget);
    final bar = tester.widget<LinearProgressIndicator>(find.byKey(const Key('limit_progress')));
    expect(bar.color, Theme.of(tester.element(find.byKey(const Key('limit_progress')))).colorScheme.error);
    expect(find.byKey(const Key('cal_day_3')), findsOneWidget);
    AppDefaults.setMonthlyLimitMinor(null);
  });
}
