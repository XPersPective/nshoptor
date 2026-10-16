import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/history_screen.dart';
import 'package:nshoptor/features/history/product_history_screen.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  for (final (width, scale) in [(412.0, 1.0), (320.0, 2.0)]) {
    testWidgets(
      'history opens on this month; product shows home vs store (${width.toInt()}dp x$scale)',
      (tester) async {
        await tester.binding.setSurfaceSize(Size(width, 800));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final db = AppDatabase(NativeDatabase.memory());
        final now = DateTime.now();
        await tester.runAsync(() async {
          final list = await db
              .into(db.shoppingLists)
              .insert(
                ShoppingListsCompanion.insert(
                  title: const Value('Pazar'),
                  currencyCode: 'TRY',
                  status: const Value('completed'),
                  completedAt: Value(now),
                ),
              );
          final item = await db
              .into(db.plannedItems)
              .insert(
                PlannedItemsCompanion.insert(
                  listId: list,
                  name: 'Elma',
                  normalizedName: 'elma',
                  plannedQuantity: '2',
                  plannedUnitCode: 'kilogram',
                  pricingInputMode: 'unitPrice',
                  plannedUnitPrice: const Value('32'),
                  plannedLineTotalMinorUnits: const Value(6400),
                ),
              );
          await ShoppingRepository(db).recordPurchase(
            listId: list,
            plannedItemId: item,
            name: 'Elma',
            normalizedName: 'elma',
            quantity: DecimalFixed.fromInt(2),
            unitCode: 'kilogram',
            unitPrice: DecimalFixed.fromInt(36),
          );
        });

        await tester.pumpWidget(
          MaterialApp(
            locale: const Locale('tr'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(scale)),
              child: child!,
            ),
            home: HistoryScreen(db: db),
          ),
        );
        for (var i = 0; i < 5; i++) {
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 50)),
          );
          await tester.pumpAndSettle();
        }

        // Geçmiş genel bakışla açılır; bu ayın sekmesine geç.
        expect(find.byKey(const Key('spending_overview')), findsOneWidget);
        await tester.ensureVisible(find.byKey(const Key('history_period_tab_1')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('history_period_tab_1')));
        for (var i = 0; i < 3; i++) {
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 50)),
          );
          await tester.pumpAndSettle();
        }
        expect(find.byKey(const Key('history_period_tab_0')), findsOneWidget);
        expect(find.text('Alınan ürünler'), findsOneWidget);
        expect(find.byKey(const Key('history_calendar')), findsOneWidget);
        await tester.tap(find.byKey(const Key('history_calendar')));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.tap(find.byKey(const Key('history_calendar')));
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
      find.byKey(const Key('history_product_elma')),
      200,
      scrollable: find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('history_product_elma')));
        for (var i = 0; i < 5; i++) {
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 50)),
          );
          await tester.pumpAndSettle();
        }
        expect(find.byType(ProductHistoryScreen), findsOneWidget);
        expect(find.byKey(const Key('product_history_chart')), findsOneWidget);
        expect(tester.takeException(), isNull);
        expect(
          find.textContaining(
            RegExp(r'Evdeki Fiyat: .*32.* · Çarşıdaki Fiyat: .*36'),
          ),
          findsOneWidget,
        );

        await tester.pumpWidget(const SizedBox.shrink());
        final closing = db.close();
        await tester.pump(const Duration(milliseconds: 1));
        await closing;
      },
    );
  }
}
