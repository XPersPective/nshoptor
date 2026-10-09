import 'package:nshoptor/core/money/format_locale.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/home/home_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/list_status.dart';
import 'package:nshoptor/features/history/insights/spending_screen.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/app/app_defaults.dart';
import 'package:napp_core/napp_core.dart';

void main() {
  setUp(() => AppFormatLocale.attach('tr'));
  tearDown(AppFormatLocale.attachReset);
  late AppDatabase db;
  late ListRepository listRepo;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

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

  Widget subject() => MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomeShell(
          db: db,
          listRepository: ListRepository(db),
        ),
      );

  testWidgets('monthly card refreshes its own currency limit after editing and returning', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final store = SettingsStore()..setString('app.currency', 'USD');
    AppDefaults.attach(store);
    final id = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: 'TRY',
      status: const Value('completed'), completedAt: Value(DateTime.now())));
    await db.into(db.purchaseEntries).insert(PurchaseEntriesCompanion.insert(listId: id,
      name: 'x', normalizedName: 'x', actualQuantity: '1', actualUnitCode: 'piece', actualLineTotalMinorUnits: 1000));
    await tester.pumpWidget(subject()); await settle(tester);
    await tester.tap(find.byKey(const Key('home_monthly_card_TRY'))); await settle(tester);
    await tester.tap(find.byKey(const Key('limit_edit'))); await settle(tester);
    await tester.enterText(find.byKey(const Key('limit_field')), '25,50');
    await tester.tap(find.byKey(const Key('limit_save'))); await settle(tester);
    await tester.binding.handlePopRoute(); await settle(tester);
    expect(find.byKey(const Key('home_limit_progress')), findsOneWidget);
    expect(find.text('Bu ay 15,50 ₺ kaldı'), findsOneWidget);
    expect(AppDefaults.monthlyLimitMinor(currencyCode: 'USD'), isNull);
    expect(AppDefaults.monthlyLimitMinor(currencyCode: 'TRY'), 2550);
    await disposeApp(tester);
  });

  testWidgets('home creates directly into detail; cancelling leaves no empty list', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    await tester.pumpWidget(subject()); await settle(tester);
    await tester.tap(find.byKey(const Key('home_new_list_button'))); await settle(tester);
    expect(find.byKey(const Key('list_title_field')), findsOneWidget);
    await tester.tap(find.byKey(const Key('list_cancel_button'))); await settle(tester);
    expect(await db.select(db.shoppingLists).get(), isEmpty);
    await tester.tap(find.byKey(const Key('home_new_list_button'))); await settle(tester);
    await tester.enterText(find.byKey(const Key('list_title_field')), 'New list');
    await tester.tap(find.byKey(const Key('list_save_button'))); await settle(tester);
    final lists = await db.select(db.shoppingLists).get();
    await settle(tester);
    expect(lists, hasLength(1));
    expect(tester.widget<ListDetailScreen>(find.byType(ListDetailScreen)).listId, lists.single.id);
    await disposeApp(tester);
  });

  for (final status in ['draft', 'completed']) {
    testWidgets('home opens $status through canonical detail without restarting', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1400));
      final id = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(
        title: const Value('Existing'), currencyCode: 'TRY', status: Value(status)));
      await tester.pumpWidget(subject()); await settle(tester);
      await tester.tap(find.byKey(Key(status == 'draft' ? 'home_list_tile_$id' : 'home_completed_$id')));
      await settle(tester);
      expect(tester.widget<ListDetailScreen>(find.byType(ListDetailScreen)).listId, id);
      expect((await ListRepository(db).getById(id)).status, status);
      await disposeApp(tester);
    });
  }

  testWidgets('history opens completed detail and monthly card preserves USD', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    final id = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(
      title: const Value('USD shop'), currencyCode: 'USD', status: const Value('completed'),
      completedAt: Value(DateTime.now())));
    await db.into(db.plannedItems).insert(PlannedItemsCompanion.insert(listId: id,
      name: 'Bread', normalizedName: 'bread', plannedQuantity: '1',
      plannedUnitCode: 'piece', pricingInputMode: 'lineTotal', plannedLineTotalMinorUnits: const Value(300)));
    await tester.pumpWidget(subject()); await settle(tester);
    await tester.tap(find.byKey(const Key('home_monthly_card_USD'))); await settle(tester);
    expect(tester.widget<SpendingScreen>(find.byType(SpendingScreen)).currencyCode, 'USD');
    await tester.binding.handlePopRoute(); await settle(tester);
    await tester.tap(find.text('Geçmiş').last); await settle(tester);
    await tester.tap(find.byKey(Key('history_list_$id'))); await settle(tester);
    expect(tester.widget<ListDetailScreen>(find.byType(ListDetailScreen)).listId, id);
    expect((await ListRepository(db).getById(id)).status, 'completed');
    await disposeApp(tester);
  });

  testWidgets('boş durum: hoş geldiniz kartı, aylık kart yok, demo veri yok',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    await tester.pumpWidget(subject());
    await settle(tester);

    expect(find.text('Alışverişini planla'), findsOneWidget);
    expect(find.text('Evdeki hesap çarşıya uyar.'), findsOneWidget);
    expect(find.byKey(const Key('home_monthly_card_TRY')), findsNothing);
    expect(find.byKey(const Key('home_new_list_button')), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('alışverişte olan liste hızlı devam sunar ve sayfayı açar',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    listRepo = ListRepository(db);
    final listId = await listRepo.createList(title: 'Market', currencyCode: 'TRY');
    await listRepo.changeStatus(listId, ListStatus.planned);
    await listRepo.changeStatus(listId, ListStatus.shopping);

    await tester.pumpWidget(subject());
    await settle(tester);

    expect(find.text('Market'), findsOneWidget);
    expect(find.byKey(Key('home_continue_$listId')), findsOneWidget);

    // Hızlı devam: alışveriş modu sayfası açılır.
    await tester.tap(find.byKey(Key('home_continue_$listId')));
    await settle(tester);
    expect(find.byKey(const Key('detail_add_item_button')), findsOneWidget);
    expect(find.text('Market'), findsWidgets);

    await disposeApp(tester);
  });

  testWidgets('tamamlanmış alışveriş varken aylık özet kartı çıkar',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    listRepo = ListRepository(db);
    final listId = await listRepo.createList(title: 'Pazar', currencyCode: 'TRY');
    await listRepo.changeStatus(listId, ListStatus.planned);
    await listRepo.changeStatus(listId, ListStatus.shopping);
    await listRepo.changeStatus(listId, ListStatus.completed);
    await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: 'Ekmek',
            normalizedName: 'ekmek',
            plannedQuantity: '1',
            plannedUnitCode: 'adet',
            pricingInputMode: 'lineTotal',
            plannedLineTotalMinorUnits: const Value(1500),
          ),
        );

    await tester.pumpWidget(subject());
    await settle(tester);

    expect(find.byKey(const Key('home_monthly_card_TRY')), findsOneWidget);
    expect(find.text('Pazar'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('alt navigasyon: Listeler sekmesi çalışır', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    listRepo = ListRepository(db);
    await tester.pumpWidget(subject());
    await settle(tester);

    await tester.tap(find.text('Listeler').last);
    await settle(tester);

    // Listeler ekranının arama alanı görünür olur.
    expect(find.byKey(const Key('lists_search_field')), findsOneWidget);

    await disposeApp(tester);
  });
  testWidgets('farklı para birimli listeler ayrı kartlarda raporlanır (T33)',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    listRepo = ListRepository(db);
    final tryList = await listRepo.createList(title: 'TL Pazar', currencyCode: 'TRY');
    await listRepo.changeStatus(tryList, ListStatus.planned);
    await listRepo.changeStatus(tryList, ListStatus.shopping);
    await listRepo.changeStatus(tryList, ListStatus.completed);
    await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: tryList,
            name: 'Ekmek',
            normalizedName: 'ekmek',
            plannedQuantity: '1',
            plannedUnitCode: 'adet',
            pricingInputMode: 'lineTotal',
            plannedLineTotalMinorUnits: const Value(1500),
          ),
        );

    final usdList = await listRepo.createList(title: 'USD Mall', currencyCode: 'USD');
    await listRepo.changeStatus(usdList, ListStatus.planned);
    await listRepo.changeStatus(usdList, ListStatus.shopping);
    await listRepo.changeStatus(usdList, ListStatus.completed);
    await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: usdList,
            name: 'Bread',
            normalizedName: 'bread',
            plannedQuantity: '1',
            plannedUnitCode: 'adet',
            pricingInputMode: 'lineTotal',
            plannedLineTotalMinorUnits: const Value(300),
          ),
        );

    await tester.pumpWidget(subject());
    await settle(tester);

    // Her para birimi kendi kartında: karışık toplam yok.
    expect(find.byKey(const Key('home_monthly_card_TRY')), findsOneWidget);
    expect(find.byKey(const Key('home_monthly_card_USD')), findsOneWidget);
    expect(find.text('Fark: 15,00 ₺'), findsOneWidget);
    expect(find.text('Fark: 3,00 USD'), findsOneWidget);

    await disposeApp(tester);
  });

}
