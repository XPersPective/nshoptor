import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart' show SettingsStore;
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/history_screen.dart';
import 'package:nshoptor/features/history/insights/insights_repository.dart';
import 'package:nshoptor/features/history/insights/monthly_report.dart';

void main() {
  setUpAll(() async {
    if (!const bool.fromEnvironment('UI_REVIEW')) return;
    Future<ByteData> bytes(String path) async => ByteData.sublistView(Uint8List.fromList(await File(path).readAsBytes()));
    final font = FontLoader('Roboto');
    for (final path in ['C:/Windows/Fonts/segoeui.ttf', 'C:/Windows/Fonts/segoeuib.ttf']) {
      if (File(path).existsSync()) font.addFont(bytes(path));
    }
    await font.load();
    final root = Platform.environment['FLUTTER_ROOT'] ?? 'C:/flutter';
    await (FontLoader('MaterialIcons')..addFont(bytes('$root/bin/cache/artifacts/material_fonts/materialicons-regular.otf'))).load();
  });
  late AppDatabase db;
  late SettingsStore store;
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    store = SettingsStore();
    AppDefaults.attach(store);
    AppFormatLocale.attach('tr');
  });
  tearDown(() async {
    AppFormatLocale.attachReset();
    await db.close();
  });

  Future<int> purchase(
    DateTime at,
    String name,
    int minor, {
    bool known = true,
    String currency = 'TRY',
  }) async {
    final id = await db
        .into(db.shoppingLists)
        .insert(
          ShoppingListsCompanion.insert(
            currencyCode: currency,
            title: Value(name),
            status: const Value('completed'),
            completedAt: Value(at),
          ),
        );
    await db
        .into(db.purchaseEntries)
        .insert(
          PurchaseEntriesCompanion.insert(
            listId: id,
            name: name,
            normalizedName: name.toLowerCase(),
            actualQuantity: '1',
            actualUnitCode: 'piece',
            actualLineTotalMinorUnits: minor,
            actualUnitPrice: Value(known ? '${minor ~/ 100}' : null),
            userConfirmed: const Value(true),
          ),
        );
    return id;
  }

  test(
    'spending distinguishes unknown, explicit zero and mixed known subtotal',
    () async {
      final day = DateTime(2026, 10, 23);
      final unknown = await purchase(day, 'Unknown', 0, known: false);
      final free = await purchase(day, 'Free', 0);
      await purchase(day, 'Paid', 2500);
      final points = await InsightsRepository(db).completedSpend('TRY');
      final missing = points.singleWhere((p) => p.listId == unknown);
      final zero = points.singleWhere((p) => p.listId == free);
      expect(missing.hasKnownActual, isFalse);
      expect(missing.hasUnknownActual, isTrue);
      expect(zero.hasKnownActual, isTrue);
      expect(zero.hasUnknownActual, isFalse);
      final amount = SpendMath.amount(points, day, DateTime(2026, 10, 24));
      expect(amount.minor, 2500);
      expect(amount.display((n) => '$n'), '2500 + —');
      expect(
        SpendMath.amount(
          [missing],
          day,
          DateTime(2026, 10, 24),
        ).display((n) => '$n'),
        '—',
      );
      expect(
        SpendMath.amount(
          [zero],
          day,
          DateTime(2026, 10, 24),
        ).display((n) => '$n'),
        '0',
      );
      final products = await InsightsRepository(db).purchaseStats('TRY');
      expect(
        products.singleWhere((p) => p.name == 'Unknown').amount.known,
        isFalse,
      );
    },
  );

  test(
    'retained history invalidates on category and store label changes',
    () async {
      await purchase(DateTime(2026, 10, 23), 'Paid', 1000);
      final changes = StreamIterator(InsightsRepository(db).watchCompleted());
      await changes.moveNext();
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(name: 'Renamed category'));
      expect(
        await changes.moveNext().timeout(const Duration(seconds: 2)),
        isTrue,
      );
      expect(changes.current, hasLength(1));
      await db
          .into(db.stores)
          .insert(StoresCompanion.insert(name: 'Renamed store'));
      expect(
        await changes.moveNext().timeout(const Duration(seconds: 2)),
        isTrue,
      );
      expect(changes.current, hasLength(1));
      await changes.cancel();
    },
  );

  test('period PDF keeps priced subtotal when one product also has an unknown receipt row', () async {
    final day = DateTime(2026, 10, 23);
    final list = await purchase(day, 'Mixed', 2500);
    final item = await db.into(db.plannedItems).insert(PlannedItemsCompanion.insert(
      listId: list, name: 'Mixed', normalizedName: 'mixed', plannedQuantity: '2',
      plannedUnitCode: 'piece', pricingInputMode: 'unitPrice'));
    await (db.update(db.purchaseEntries)..where((t) => t.listId.equals(list))).write(
      PurchaseEntriesCompanion(plannedItemId: Value(item)));
    await db.into(db.purchaseEntries).insert(PurchaseEntriesCompanion.insert(listId: list,
      plannedItemId: Value(item), name: 'Mixed', normalizedName: 'mixed', actualQuantity: '1',
      actualUnitCode: 'piece', actualLineTotalMinorUnits: 0, userConfirmed: const Value(true)));
    final l10n = await AppLocalizations.delegate.load(const Locale('tr'));
    final html = await buildPeriodReport(db, day, DateTime(2026, 10, 24), 'TRY', l10n, 'tr',
      periodLabel: 'Bugün', limitMinor: 10000);
    expect(html, contains('25,00 ₺ + —'));
    expect(html, isNot(contains('${l10n.monthlyLimitTitle}:')));
  });

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 30)),
      );
      await tester.pumpAndSettle();
    }
  }

  Widget subject(DateTime day, {double scale = 1}) => MaterialApp(
    theme: AppTheme.light(),
    locale: const Locale('tr'),
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
    home: RepaintBoundary(
      key: const Key('history_capture'),
      child: HistoryScreen(db: db, now: day),
    ),
  );

  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
    await tester.binding.setSurfaceSize(null);
  }

  testWidgets(
    'retained overview refreshes calendar date and default currency',
    (tester) async {
      await tester.runAsync(() async {
        await purchase(DateTime(2026, 10, 31), 'October', 2500);
        await purchase(DateTime(2026, 11, 1), 'November', 5000);
        await purchase(DateTime(2026, 11, 1), 'Euro', 7500, currency: 'EUR');
      });
      await tester.pumpWidget(subject(DateTime(2026, 10, 31)));
      await settle(tester);
      final month = find.byKey(const Key('overview_month'));
      expect(
        find.descendant(of: month, matching: find.text('25,00 ₺')),
        findsOneWidget,
      );
      await tester.pumpWidget(subject(DateTime(2026, 11, 1)));
      await settle(tester);
      expect(
        find.descendant(of: month, matching: find.text('50,00 ₺')),
        findsOneWidget,
      );
      store.setString('app.currency', 'EUR');
      await tester.pumpWidget(subject(DateTime(2026, 11, 1)));
      await settle(tester);
      expect(
        find.descendant(of: month, matching: find.textContaining('75,00')),
        findsOneWidget,
      );
      await close(tester);
    },
  );

  for (final width in [320.0, 412.0]) {
    testWidgets(
      'Today shows partial unknown spending and free shopping at ${width.toInt()}dp',
      (tester) async {
        await tester.binding.setSurfaceSize(Size(width, 850));
        final day = DateTime(2026, 10, 23);
        late int unknown, free;
        await tester.runAsync(() async {
          unknown = await purchase(day, 'Fiyatı bilinmeyen', 0, known: false);
          free = await purchase(day, 'Ücretsiz alışveriş', 0);
          await purchase(day, 'Ödenen alışveriş', 2500);
        });
        await tester.pumpWidget(subject(day, scale: width == 320 ? 2 : 1));
        await settle(tester);
        await tester.ensureVisible(find.byKey(const Key('history_today_tab')));
        await tester.tap(find.byKey(const Key('history_today_tab')));
        await settle(tester);
        expect(
          find.descendant(
            of: find.byKey(const Key('history_period_total')),
            matching: find.text('25,00 ₺ + —'),
          ),
          findsOneWidget,
        );
        if (const bool.fromEnvironment('UI_REVIEW')) {
          await tester.runAsync(() async {
            final boundary = tester.renderObject<RenderRepaintBoundary>(
              find.byKey(const Key('history_capture')),
            );
            final picture = await boundary.toImage();
            final bytes = await picture.toByteData(
              format: ui.ImageByteFormat.png,
            );
            final file = File('artifacts/qa/PB-115/${width.toInt()}_today.png');
            await file.parent.create(recursive: true);
            await file.writeAsBytes(bytes!.buffer.asUint8List());
            picture.dispose();
          });
        }
        for (final (id, text) in [(unknown, '—'), (free, '0,00 ₺')]) {
          final row = find.byKey(Key('history_list_$id'));
          await tester.scrollUntilVisible(
            row,
            300,
            scrollable: find
                .descendant(
                  of: find.byType(ListView).last,
                  matching: find.byType(Scrollable),
                )
                .first,
          );
          expect(
            find.descendant(of: row, matching: find.text(text)),
            findsOneWidget,
          );
        }
        expect(tester.takeException(), isNull);
        await close(tester);
      },
    );
  }
}
