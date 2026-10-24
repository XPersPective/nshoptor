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
import 'package:nshoptor/features/history/insights/spending_screen.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/core/money/money.dart';
import 'package:nshoptor/core/money/money_format.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/core/widgets/amount_axis_chart.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/price_history/price_history_sheet.dart';
import 'package:nshoptor/features/history/product_history_screen.dart';

void main() {
  setUpAll(() async {
    if (!const bool.fromEnvironment('UI_REVIEW')) return;
    final loader = FontLoader('Roboto');
    for (final name in ['segoeui.ttf', 'segoeuib.ttf']) {
      final file = File('C:/Windows/Fonts/$name');
      if (file.existsSync()) {
        loader.addFont(
          Future.value(ByteData.sublistView(await file.readAsBytes())),
        );
      }
    }
    await loader.load();
  });

  Widget app(Widget home, String locale, double scale, Brightness brightness) =>
      MaterialApp(
        locale: Locale(locale),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: brightness == Brightness.dark
            ? AppTheme.dark()
            : AppTheme.light(),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        ),
        home: RepaintBoundary(key: const Key('capture'), child: home),
      );

  Future<void> capture(WidgetTester tester, String name) async {
    if (!const bool.fromEnvironment('UI_REVIEW')) return;
    final boundary = tester.renderObject<RenderRepaintBoundary>(
      find.byKey(const Key('capture')),
    );
    await tester.runAsync(() async {
      final image = await boundary.toImage();
      try {
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        final file = File('artifacts/qa/PB-136/$name.png');
        await file.parent.create(recursive: true);
        await file.writeAsBytes(data!.buffer.asUint8List());
      } finally {
        image.dispose();
      }
    });
  }

  for (final width in [320.0, 412.0, 800.0]) {
    for (final scenario in [
      ('en', 'JPY', 1.0, Brightness.light, -987654321, 1234567890),
      ('tr', 'TRY', 2.0, Brightness.dark, 0, 123456789012),
      ('ar', 'KWD', 2.0, Brightness.light, -123456789012, 987654321000),
      ('ar', 'KWD', 2.0, Brightness.dark, 0, 0),
    ]) {
      final (locale, code, scale, brightness, minimum, maximum) = scenario;
      testWidgets('axis $width $locale $code $scale $brightness $minimum', (
        tester,
      ) async {
        await tester.binding.setSurfaceSize(Size(width, 1000));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        String money(int n) => formatMoney(
          Money.fromMinorUnits(n, Currency.fromCode(code)),
          locale: locale,
        );
        await tester.pumpWidget(
          app(
            Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(28),
                child: AmountAxisChart(
                  minimum: minimum,
                  maximum: maximum,
                  formatAmount: money,
                  compactFormatAmount: (value) => compactChartAmount(
                    value,
                    digits: Currency.fromCode(code).minorUnitDigits,
                    locale: locale,
                  ),
                  plot: const SizedBox.expand(),
                ),
              ),
            ),
            locale,
            scale,
            brightness,
          ),
        );
        await tester.pumpAndSettle();
        final axis = find.byType(AmountAxisChart);
        final bounds = tester.getRect(axis);
        final labelRects = <Rect>[];
        for (final element
            in find
                .descendant(of: axis, matching: find.byType(Text))
                .evaluate()) {
          final finder = find.byElementPredicate((e) => identical(e, element));
          final rect = tester.getRect(finder);
          expect(rect.left, greaterThanOrEqualTo(bounds.left));
          expect(rect.right, lessThanOrEqualTo(bounds.right + .01));
          expect(rect.top, greaterThanOrEqualTo(bounds.top));
          expect(rect.bottom, lessThanOrEqualTo(bounds.bottom + .01));
          for (final previous in labelRects) {
            expect(rect.overlaps(previous), isFalse);
          }
          labelRects.add(rect);
        }
        final texts = tester.widgetList<Text>(
          find.descendant(of: axis, matching: find.byType(Text)),
        );
        expect(
          texts.every((text) => text.textDirection == TextDirection.ltr),
          isTrue,
        );
        if (find.text(money(maximum)).evaluate().isEmpty) {
          // Exact values may wrap only between currency and numeric tokens.
          // Every digit and the negative sign stay in the original token.
          for (final part in money(maximum).split(RegExp(r'\s+'))) {
            expect(
              find.descendant(of: axis, matching: find.text(part)),
              findsWidgets,
            );
          }
          final fullValues = texts.where((text) => text.softWrap == false);
          expect(fullValues, isNotEmpty);
          expect(
            fullValues.every((text) => text.overflow != TextOverflow.ellipsis),
            isTrue,
          );
        }
        expect(
          texts.any((text) => text.semanticsLabel == money(maximum)),
          isTrue,
        );
        expect(tester.takeException(), isNull);
        await capture(
          tester,
          'axis_${width.toInt()}_${locale}_${brightness.name}_$minimum',
        );
      });
    }
  }

  testWidgets(
    'weekly wide chart shows exact amounts without opening a tooltip',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      AppDefaults.attach(SettingsStore());
      AppFormatLocale.attach('tr');
      addTearDown(AppFormatLocale.attachReset);
      await tester.runAsync(() async {
        final list = await db
            .into(db.shoppingLists)
            .insert(
              ShoppingListsCompanion.insert(
                currencyCode: 'TRY',
                status: const Value('completed'),
                completedAt: Value(DateTime(2026, 10, 23)),
              ),
            );
        await db
            .into(db.purchaseEntries)
            .insert(
              PurchaseEntriesCompanion.insert(
                listId: list,
                name: 'Coffee',
                normalizedName: 'coffee',
                actualQuantity: '1',
                actualUnitCode: 'kilogram',
                actualUnitPrice: const Value('25'),
                actualLineTotalMinorUnits: 2500,
                userConfirmed: const Value(true),
              ),
            );
      });
      await tester.pumpWidget(
        app(
          SpendingScreen(
            db: db,
            currencyCode: 'TRY',
            now: DateTime(2026, 10, 23),
          ),
          'tr',
          1,
          Brightness.light,
        ),
      );
      await tester.runAsync(() => db.select(db.purchaseEntries).get());
      await tester.pumpAndSettle();
      final l10n = AppLocalizations.of(
        tester.element(find.byType(SpendingScreen)),
      );
      final card = find
          .ancestor(
            of: find.text(l10n.spendingWeekly),
            matching: find.byType(Card),
          )
          .first;
      expect(
        find.descendant(of: card, matching: find.textContaining('25,00 ₺')),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(card);
      await tester.pumpAndSettle();
      await capture(tester, 'spending_800_exact_values');
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  for (final width in [320.0, 412.0]) {
    for (final priceScreen in [false, true]) {
      testWidgets(
        'real ${priceScreen ? 'price' : 'product'} chart at $width with readable amounts',
        (tester) async {
          await tester.binding.setSurfaceSize(Size(width, 1100));
          addTearDown(() => tester.binding.setSurfaceSize(null));
          final db = AppDatabase(NativeDatabase.memory());
          addTearDown(db.close);
          AppFormatLocale.attach(width == 320 ? 'ar' : 'tr');
          addTearDown(AppFormatLocale.attachReset);
          late int product;
          await tester.runAsync(() async {
            product = await db
                .into(db.productMemory)
                .insert(
                  ProductMemoryCompanion.insert(
                    canonicalName: 'Coffee',
                    normalizedName: 'coffee',
                  ),
                );
            for (final (i, price) in ['125.25', '260.75'].indexed) {
              final at = DateTime(2026, 10, 20 + i);
              await db
                  .into(db.priceObservations)
                  .insert(
                    PriceObservationsCompanion.insert(
                      productId: Value(product),
                      quantity: '1',
                      unitCode: 'kilogram',
                      unitPrice: price,
                      lineTotalMinorUnits: i == 0 ? 12525 : 26075,
                      currencyCode: 'TRY',
                      source: 'manual',
                      observedAt: Value(at),
                    ),
                  );
              final list = await db
                  .into(db.shoppingLists)
                  .insert(
                    ShoppingListsCompanion.insert(
                      currencyCode: 'TRY',
                      status: const Value('completed'),
                      completedAt: Value(at),
                    ),
                  );
              await db
                  .into(db.purchaseEntries)
                  .insert(
                    PurchaseEntriesCompanion.insert(
                      listId: list,
                      name: 'Coffee',
                      normalizedName: 'coffee',
                      actualQuantity: '1',
                      actualUnitCode: 'kilogram',
                      actualUnitPrice: Value(price),
                      actualLineTotalMinorUnits: i == 0 ? 12525 : 26075,
                      userConfirmed: const Value(true),
                    ),
                  );
            }
          });
          await tester.pumpWidget(
            app(
              priceScreen
                  ? PriceHistoryScreen(
                      db: db,
                      productId: product,
                      currencyCode: 'TRY',
                      unitCode: 'kilogram',
                    )
                  : ProductHistoryScreen(
                      db: db,
                      name: 'Coffee',
                      normalizedName: 'coffee',
                      currencyCode: 'TRY',
                    ),
              width == 320 ? 'ar' : 'tr',
              2,
              width == 320 ? Brightness.dark : Brightness.light,
            ),
          );
          await tester.runAsync(() => db.select(db.purchaseEntries).get());
          await tester.pumpAndSettle();
          final axis = find.byType(AmountAxisChart);
          expect(axis, findsOneWidget);
          expect(
            find.descendant(of: axis, matching: find.byType(Text)),
            findsAtLeastNWidgets(3),
          );
          expect(tester.takeException(), isNull);
          await capture(
            tester,
            '${priceScreen ? 'price' : 'product'}_${width.toInt()}_2x',
          );
          await tester.pumpWidget(const SizedBox.shrink());
        },
      );
    }
  }
}
