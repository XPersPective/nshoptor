import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/shopping_mode/shopping_mode_screen.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
  });

  Future<void> disposeApp(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(null);
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  Future<void> settle(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  }

  Future<int> seedShoppingList() async {
    final listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(
            title: const Value('Market'),
            currencyCode: 'TRY',
            budgetMinorUnits: const Value(20000),
          ),
        );
    await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: 'Domates',
            normalizedName: 'domates',
            plannedQuantity: '1.5',
            plannedUnitCode: 'kilogram',
            pricingInputMode: 'lineTotal',
            plannedLineTotalMinorUnits: const Value(6435),
          ),
        );
    return listId;
  }

  Widget subject(int listId) => MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: ShoppingModeScreen(
          repository: ShoppingRepository(db),
          listId: listId,
        ),
      );

  testWidgets('gerçek fiyat girişi sepeti günceller; özet anında değişir',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final listId = await seedShoppingList();
    await tester.pumpWidget(subject(listId));
    await settle(tester);

    // Planlanan özet: 64,35
    expect(find.text('64,35 ₺'), findsWidgets);

    // Ürün satırına dokun (checkbox) → giriş sayfası açılır.
    await tester.tap(find.byType(Checkbox).first);
    await settle(tester);
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    await tester.tap(find.byKey(const Key('price_enter')));
    await settle(tester);

    await tester.enterText(
        find.byKey(const Key('item_actual_price_field')), '45,00');
    await settle(tester);
    await tester.tap(find.byKey(const Key('item_save_button')));
    await settle(tester);

    // Sepet: 1,5 × 45,00 = 67,50; kalan plan 0; tahmini kasa 67,50.
    expect(find.text('67,50 ₺'), findsWidgets);

    await disposeApp(tester);
  });

  testWidgets('yeniden mount sonrası oturum ve sepet korunur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final listId = await seedShoppingList();

    // 1. oturum: ürünü sepete al.
    await tester.pumpWidget(subject(listId));
    await settle(tester);
    await tester.tap(find.byType(Checkbox).first);
    await settle(tester);
    await tester.tap(find.byKey(const Key('price_enter')));
    await settle(tester);
    await tester.enterText(
        find.byKey(const Key('item_actual_price_field')), '45,00');
    await settle(tester);
    await tester.tap(find.byKey(const Key('item_save_button')));
    await settle(tester);
    expect(find.text('67,50 ₺'), findsWidgets);

    // Uygulama kapanıp döner: yeni repo, aynı veritabanı.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    final freshRepo = ShoppingRepository(db);
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('tr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: ShoppingModeScreen(repository: freshRepo, listId: listId),
    ));
    await settle(tester);

    // Sepet içeriği ve özet korunur.
    expect(find.text('67,50 ₺'), findsWidgets);

    await disposeApp(tester);
  });

  testWidgets('plansız ürün ekleme gerçek toplama dahil edilir',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final listId = await seedShoppingList();
    await tester.pumpWidget(subject(listId));
    await settle(tester);

    await tester.tap(find.byKey(const Key('detail_more_menu')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('add_unplanned_button')));
    await settle(tester);
    await tester.enterText(find.byKey(const Key('entry_name_field')), 'Poşet');
    await tester.enterText(find.byKey(const Key('entry_quantity_field')), '1');
    await tester.enterText(find.byKey(const Key('entry_price_field')), '5,50');
    await settle(tester);
    await tester.tap(find.byKey(const Key('entry_save_button')));
    await settle(tester);

    // Sepet: 5,50 plansız + 0 planlı; tahmini kasa 5,50 + 64,35 = 69,85.
    expect(find.text('5,50 ₺'), findsWidgets);
    final summary = await tester.runAsync(() => ShoppingRepository(db).watchSummary(listId).first);
    expect(summary!.projectedCheckoutMinor, 6985);

    await disposeApp(tester);
  });
}
