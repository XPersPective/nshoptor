import 'package:nshoptor/core/money/format_locale.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_form_sheet.dart';
import 'package:nshoptor/features/lists/starter_categories.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/features/voice_input/parser/parsed_item_candidate.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';

void main() {
  setUp(() => AppFormatLocale.attach('tr'));
  tearDown(AppFormatLocale.attachReset);
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  Future<void> disposeApp(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(null);
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  Future<void> openForm(WidgetTester tester, int listId, {PlannedItem? existing,
      List<PurchaseEntry> entries = const [], Future<String?> Function(BuildContext)? scan, ParsedItemCandidate? candidate}) async {
    await StarterCategories().seedIfEmpty(db);
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('tr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ItemFormSheet(
          db: db,
          starterCategories: StarterCategories(),
          listId: listId,
          existing: existing, entries: entries, onShelfPricePressed: scan, initialCandidate: candidate,
        ),
      ),
    ));
    await tester.pumpAndSettle();
    // Uzun formun tamamını görünür kılar (kaydırma gerektirmesin).
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    await tester.pumpAndSettle();
  }

  testWidgets('single voice candidate retains brand/custom category and total mode until approval', (tester) async {
    final listId = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
    await openForm(tester, listId, candidate: ParsedItemCandidate(name: 'Pear', rawText: '',
      quantity: DecimalFixed.parse('1.5'), unitCode: UnitCode.kilogram,
      unitPrice: DecimalFixed.fromInt(40), isUnitPrice: false, brand: 'Farm', category: 'New category'));
    expect(await db.select(db.plannedItems).get(), isEmpty);
    expect((await db.select(db.categories).get()).any((c) => c.name == 'New category'), isFalse);
    expect(tester.widget<TextField>(find.byKey(const Key('item_price_field'))).controller!.text, '40');
    await settleAndSave(tester);
    final item = (await db.select(db.plannedItems).get()).single;
    expect(item.name, 'Pear'); expect(item.brand, 'Farm'); expect(item.plannedQuantity, '1.5');
    expect(item.plannedUnitCode, 'kilogram'); expect(item.pricingInputMode, 'lineTotal'); expect(item.plannedLineTotalMinorUnits, 4000);
    final category = (await db.select(db.categories).get()).singleWhere((c) => c.id == item.categoryId);
    expect(category.name, 'New category');
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    await disposeApp(tester);
  });

  testWidgets('overflow preview and save preserve typed input without writing', (tester) async {
    final listId = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
    await openForm(tester, listId);
    await tester.enterText(find.byKey(const Key('item_name_field')), 'Large quantity');
    await tester.enterText(find.byKey(const Key('item_quantity_field')), '999999999999999');
    await tester.enterText(find.byKey(const Key('item_price_field')), '999999999999999');
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await settleAndSave(tester);
    expect(await db.select(db.plannedItems).get(), isEmpty);
    expect(find.text('999999999999999'), findsNWidgets(2));
    expect(find.text(AppLocalizations.of(tester.element(find.byType(ItemFormSheet))).saveFailed), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('edit keeps plan quantity and estimate independent from actual', (tester) async {
    final listId = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
    final id = await ItemRepository(db).addItem(listId: listId, name: 'Tomato', quantity: DecimalFixed.fromInt(2),
      unitCode: 'kilogram', priceIsUnitPrice: true, price: DecimalFixed.fromInt(40));
    await ShoppingRepository(db).recordPurchase(listId: listId, plannedItemId: id, name: 'Tomato', normalizedName: 'tomato',
      quantity: DecimalFixed.parse('1.5'), unitCode: 'kilogram', unitPrice: DecimalFixed.fromInt(45));
    final item = (await db.select(db.plannedItems).get()).single;
    await openForm(tester, listId, existing: item, entries: await db.select(db.purchaseEntries).get());
    expect(tester.widget<TextField>(find.byKey(const Key('item_actual_quantity_field'))).controller!.text, '1,5');
    await tester.enterText(find.byKey(const Key('item_name_field')), 'Tomatoes');
    await tester.enterText(find.byKey(const Key('item_actual_quantity_field')), '1,25');
    await settleAndSave(tester);
    final items = await db.select(db.plannedItems).get();
    expect(items, hasLength(1)); expect(items.single.id, id);
    expect(items.single.name, 'Tomatoes'); expect(items.single.plannedQuantity, '2');
    expect(items.single.plannedLineTotalMinorUnits, 8000);
    expect((await db.select(db.purchaseEntries).get()).single.actualLineTotalMinorUnits, 5625);
    await disposeApp(tester);
  });

  testWidgets('camera fills only actual; save failure rolls back and can retry', (tester) async {
    final listId = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
    await openForm(tester, listId, scan: (_) async => '45.50');
    await tester.enterText(find.byKey(const Key('item_name_field')), 'Milk');
    await tester.enterText(find.byKey(const Key('item_price_field')), '40');
    await tester.tap(find.byKey(const Key('item_shelf_label_button'))); await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.byKey(const Key('item_price_field'))).controller!.text, '40');
    expect(tester.widget<TextField>(find.byKey(const Key('item_actual_price_field'))).controller!.text, '45,50');
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    await db.customStatement("CREATE TRIGGER reject_purchase BEFORE INSERT ON purchase_entries BEGIN SELECT RAISE(ABORT, 'forced'); END");
    await settleAndSave(tester);
    expect(await db.select(db.plannedItems).get(), isEmpty);
    await tester.pumpAndSettle();
    expect(find.textContaining('Kaydedilemedi'), findsOneWidget);
    await db.customStatement('DROP TRIGGER reject_purchase');
    await settleAndSave(tester);
    expect((await db.select(db.purchaseEntries).get()).single.actualLineTotalMinorUnits, 4550);
    await disposeApp(tester);
  });

  testWidgets('KWD line total prefill and preview use three currency digits; cancel stays unchanged', (tester) async {
    final listId = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: 'KWD'));
    await ItemRepository(db).addItem(listId: listId, name: 'Milk', quantity: DecimalFixed.fromInt(3),
      unitCode: 'piece', priceIsUnitPrice: false, price: DecimalFixed.parse('5.997'));
    final item = (await db.select(db.plannedItems).get()).single;
    await openForm(tester, listId, existing: item);
    expect(tester.widget<TextField>(find.byKey(const Key('item_price_field'))).controller!.text, '5,997');
    expect(find.textContaining('1,999'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('item_name_field')), 'Cancelled');
    expect((await db.select(db.plannedItems).get()).single.name, 'Milk');
    await disposeApp(tester);
  });

  testWidgets('ondalıklı miktar + birim fiyat ile kayıt; satır toplamı görünür',
      (tester) async {
    final listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(title: const Value('L'), currencyCode: 'TRY'),
        );
    await openForm(tester, listId);

    await tester.enterText(find.byKey(const Key('item_name_field')), 'Domates');
    await tester.enterText(find.byKey(const Key('item_quantity_field')), '1,5');
    await tester.tap(find.byKey(const Key('item_unit_field')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('kg').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('item_price_field')), '42,90');
    await settleAndSave(tester);

    final item = await (db.select(db.plannedItems)..limit(1)).getSingle();
    expect(item.name, 'Domates');
    expect(item.plannedQuantity, '1.5');
    expect(item.plannedUnitCode, 'kilogram');
    expect(item.plannedUnitPrice, '42.90');
    expect(item.plannedLineTotalMinorUnits, 6435);

    await disposeApp(tester);
  });

  testWidgets('satır toplamı modunda birim fiyat hesaplanır', (tester) async {
    final listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(title: const Value('L'), currencyCode: 'TRY'),
        );
    await openForm(tester, listId);

    await tester.enterText(find.byKey(const Key('item_name_field')), 'Süt');
    await tester.enterText(find.byKey(const Key('item_quantity_field')), '3');
    // Fiyat modu anahtarı "Ayrıntılar" altında: önce bölümü aç.
    await tester.tap(find.byKey(const Key('item_details_expand')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('item_pricing_mode')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Satır toplamı').first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('item_price_field')), '59,97');
    await settleAndSave(tester);

    final item = await (db.select(db.plannedItems)..limit(1)).getSingle();
    expect(item.pricingInputMode, 'lineTotal');
    expect(item.plannedLineTotalMinorUnits, 5997);
    expect(
      item.plannedUnitPrice!.startsWith('19.99'),
      isTrue,
      reason: 'birim fiyat 19,99 hesaplanmalı: ${item.plannedUnitPrice}',
    );

    await disposeApp(tester);
  });

  testWidgets('geçersiz miktar yerelleştirilmiş hata gösterir', (tester) async {
    final listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(title: const Value('L'), currencyCode: 'TRY'),
        );
    await openForm(tester, listId);

    await tester.enterText(find.byKey(const Key('item_name_field')), 'Ekmek');
    await tester.enterText(find.byKey(const Key('item_quantity_field')), 'abc');
    await settleAndSave(tester);

    expect(find.text('Geçersiz miktar'), findsOneWidget);
    expect(await db.select(db.plannedItems).get(), isEmpty);

    await disposeApp(tester);
  });

  testWidgets('+1 adımlayıcı miktarı artırır', (tester) async {
    final listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(title: const Value('L'), currencyCode: 'TRY'),
        );
    await openForm(tester, listId);

    await tester.tap(find.byKey(const Key('item_quantity_plus_one')));
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(TextField, '2'),
      findsWidgets,
      reason: 'miktar 1 → 2 olmalı',
    );

    await disposeApp(tester);
  });
}

Future<void> settleAndSave(WidgetTester tester) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('item_save_button')));
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
}
