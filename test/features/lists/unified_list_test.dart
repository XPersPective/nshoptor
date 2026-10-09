import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  late AppDatabase db;
  late ListRepository lists;
  setUp(() { db = AppDatabase(NativeDatabase.memory()); lists = ListRepository(db); });
  Future<void> open(WidgetTester tester, int listId, {String locale = 'tr', double scale = 1}) async {
    await tester.pumpWidget(MaterialApp(locale: Locale(locale),
      localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)), child: child!),
      home: ListDetailScreen(db: db, listRepository: lists, listId: listId)));
    await tester.pumpAndSettle();
  }
  Future<int> item(int listId, String name) => ItemRepository(db).addItem(listId: listId, name: name,
    quantity: DecimalFixed.fromInt(2), unitCode: 'kilogram', priceIsUnitPrice: true, price: DecimalFixed.fromInt(40));
  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close(); await tester.pump(const Duration(milliseconds: 1)); await closing;
    await tester.binding.setSurfaceSize(null);
  }

  testWidgets('checkbox has no fake purchase; undo and delete require confirmation', (tester) async {
    final listId = await lists.createList(title: 'Market', currencyCode: 'TRY');
    final id = await item(listId, 'Domates');
    await open(tester, listId);
    await tester.tap(find.byKey(Key('detail_check_$id'))); await tester.pumpAndSettle();
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    expect((await db.select(db.plannedItems).get()).single.status, 'inCart');
    expect(tester.widget<Text>(find.byKey(const Key('price_actual_empty'))).data, '—');
    await ShoppingRepository(db).recordPurchase(listId: listId, plannedItemId: id, name: 'Domates', normalizedName: 'domates',
      quantity: DecimalFixed.parse('1.5'), unitCode: 'kilogram', unitPrice: DecimalFixed.fromInt(45));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('detail_check_$id'))); await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextButton))); await tester.pumpAndSettle();
    expect((await db.select(db.purchaseEntries).get()).single.actualLineTotalMinorUnits, 6750);
    await tester.tap(find.byKey(Key('detail_item_menu_$id'))); await tester.pumpAndSettle();
    await tester.tap(find.byWidgetPredicate((w) => w is PopupMenuItem<String> && w.value == 'delete')); await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextButton))); await tester.pumpAndSettle();
    expect(await db.select(db.plannedItems).get(), hasLength(1));
    await tester.tap(find.byKey(Key('detail_item_menu_$id'))); await tester.pumpAndSettle();
    await tester.tap(find.byWidgetPredicate((w) => w is PopupMenuItem<String> && w.value == 'delete')); await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.byType(FilledButton))); await tester.pumpAndSettle();
    expect(await db.select(db.plannedItems).get(), isEmpty);
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    expect(await db.select(db.priceObservations).get(), isEmpty);
    await close(tester);
  });

  testWidgets('incomplete finish can be cancelled and completed detail never offers restart', (tester) async {
    final listId = await lists.createList(title: 'Market', currencyCode: 'TRY');
    await item(listId, 'Domates'); await open(tester, listId);
    await tester.tap(find.byKey(const Key('detail_finish_button'))); await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextButton))); await tester.pumpAndSettle();
    expect((await lists.getById(listId)).status, 'draft');
    await tester.tap(find.byKey(const Key('detail_finish_button'))); await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.byType(FilledButton)));
    await tester.pumpAndSettle();
    expect((await lists.getById(listId)).status, 'completed');
    await tester.binding.handlePopRoute(); await tester.pumpAndSettle();
    expect(find.byKey(const Key('detail_finish_button')), findsNothing);
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    await close(tester);
  });

  for (final locale in ['tr', 'ar']) {
    testWidgets('320dp 2x text long names and labelled 48dp actions ($locale)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 640));
      final listId = await lists.createList(title: 'Market', currencyCode: 'TRY');
      final id = await item(listId, 'Çok uzun ürün adı — طماطم عضوية كبيرة الحجم Domates');
      await open(tester, listId, locale: locale, scale: 2);
      expect(tester.takeException(), isNull);
      for (final key in ['detail_add_item_button', 'detail_quick_list', 'detail_scan_receipt']) {
        final button = tester.widget<IconButton>(find.byKey(Key(key)));
        expect(button.tooltip, isNotEmpty);
        final size = tester.getSize(find.byKey(Key(key)));
        expect(size.width, greaterThanOrEqualTo(48)); expect(size.height, greaterThanOrEqualTo(48));
      }
      await tester.scrollUntilVisible(find.byKey(Key('detail_item_menu_$id')), 150); await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(tester.widget<PopupMenuButton<String>>(find.byKey(Key('detail_item_menu_$id'))).tooltip, isNotEmpty);
      await tester.scrollUntilVisible(find.byKey(const Key('price_scan')), 150); await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      for (final key in ['price_enter', 'price_scan']) {
        expect(tester.widget<IconButton>(find.byKey(Key(key))).tooltip, isNotEmpty);
        expect(tester.getSize(find.byKey(Key(key))).shortestSide, greaterThanOrEqualTo(48));
      }
      await close(tester);
    });
  }
}
