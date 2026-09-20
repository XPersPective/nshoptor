import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_form_sheet.dart';
import 'package:nshoptor/features/lists/starter_categories.dart';

void main() {
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

  Future<void> openForm(WidgetTester tester, int listId) async {
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
        ),
      ),
    ));
    await tester.pumpAndSettle();
    // Uzun formun tamamını görünür kılar (kaydırma gerektirmesin).
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    await tester.pumpAndSettle();
  }

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
