import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/history_screen.dart';
import 'package:nshoptor/features/history/reports/report_preview_screen.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  for (final (width, scale) in [(412.0, 1.0), (320.0, 2.0)]) {
    testWidgets(
      'history opens on the week and shows a read-only receipt preview '
      '(${width.toInt()}dp x$scale)',
      (tester) async {
        await tester.binding.setSurfaceSize(Size(width, 800));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        AppFormatLocale.attach('tr');
        addTearDown(AppFormatLocale.attachReset);
        final db = AppDatabase(NativeDatabase.memory());
        final now = DateTime(2026, 10, 21, 12);
        late int listId;
        await tester.runAsync(() async {
          listId = await db
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
                  listId: listId,
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
            listId: listId,
            plannedItemId: item,
            name: 'Elma',
            normalizedName: 'elma',
            quantity: DecimalFixed.fromInt(2),
            unitCode: 'kilogram',
            unitPrice: DecimalFixed.fromInt(36),
          );
        });
        final before = await tester.runAsync(
          () async => (
            lists: await db.select(db.shoppingLists).get(),
            items: await db.select(db.plannedItems).get(),
            purchases: await db.select(db.purchaseEntries).get(),
          ),
        );

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
            home: HistoryScreen(db: db, now: now),
          ),
        );
        for (var i = 0; i < 5; i++) {
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 50)),
          );
          await tester.pumpAndSettle();
        }

        expect(find.byKey(const Key('history_span_week')), findsOneWidget);
        expect(find.byKey(const Key('history_period_total')), findsOneWidget);
        await tester.scrollUntilVisible(
          find.byKey(Key('history_list_$listId')),
          150,
          scrollable: find
              .descendant(
                of: find.byType(ListView).last,
                matching: find.byType(Scrollable),
              )
              .first,
        );
        expect(find.byKey(Key('history_list_$listId')), findsOneWidget);
        expect(find.text('Elma'), findsNothing);
        await Scrollable.ensureVisible(tester.element(find.byKey(Key('history_list_$listId'))),
          alignment: 0.5);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key('history_list_$listId')));
        for (var i = 0; i < 5; i++) {
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 50)),
          );
          await tester.pumpAndSettle();
        }

        expect(find.byType(ReportPreviewScreen), findsOneWidget);
        expect(find.byKey(const Key('report_product_0_0')), findsOneWidget);
        expect(find.text('Elma'), findsOneWidget);
        final l10n = AppLocalizations.of(
          tester.element(find.byType(Scaffold).last),
        );
        expect(find.text(l10n.compareEstimated), findsWidgets);
        expect(find.text(l10n.compareActual), findsWidgets);
        final productCard = find.byKey(const Key('report_product_0_0'));
        expect(
          find.descendant(
            of: productCard,
            matching: find.textContaining('64,00'),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: productCard,
            matching: find.textContaining('72,00'),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: productCard,
            matching: find.textContaining('8,00'),
          ),
          findsOneWidget,
        );
        expect(find.byType(Checkbox), findsNothing);

        if (scale == 2.0) {
          await tester.tap(find.byKey(const Key('report_zoom')));
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const Key('report_zoom')));
          await tester.pumpAndSettle();
        }
        expect(tester.takeException(), isNull);

        final after = await tester.runAsync(
          () async => (
            lists: await db.select(db.shoppingLists).get(),
            items: await db.select(db.plannedItems).get(),
            purchases: await db.select(db.purchaseEntries).get(),
          ),
        );
        expect(after!.lists, before!.lists);
        expect(after.items, before.items);
        expect(after.purchases, before.purchases);

        await tester.pumpWidget(const SizedBox.shrink());
        final closing = db.close();
        await tester.pump(const Duration(milliseconds: 1));
        await closing;
      },
    );
  }
}
