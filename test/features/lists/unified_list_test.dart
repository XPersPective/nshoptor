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
import 'package:nshoptor/features/voice_input/voice_input_service.dart';

void main() {
  late AppDatabase db;
  late ListRepository lists;
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    lists = ListRepository(db);
  });
  Future<void> open(
    WidgetTester tester,
    int listId, {
    String locale = 'tr',
    double scale = 1,
    SpeechService? speech,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: Locale(locale),
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
        home: ListDetailScreen(
          db: db,
          listRepository: lists,
          listId: listId,
          speechService: speech,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<int> item(int listId, String name) => ItemRepository(db).addItem(
    listId: listId,
    name: name,
    quantity: DecimalFixed.fromInt(2),
    unitCode: 'kilogram',
    priceIsUnitPrice: true,
    price: DecimalFixed.fromInt(40),
  );
  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
    await tester.binding.setSurfaceSize(null);
  }

  testWidgets(
    'checkbox opens price entry without fake purchase; undo and delete protect purchases',
    (tester) async {
      final listId = await lists.createList(
        title: 'Market',
        currencyCode: 'TRY',
      );
      final id = await item(listId, 'Domates');
      await open(tester, listId);
      // Two taps before the async category seed finishes must open one form.
      final check = tester.widget<Checkbox>(find.byKey(Key('detail_check_$id')));
      check.onChanged!(true);
      check.onChanged!(true);
      await tester.pumpAndSettle();
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      expect((await db.select(db.plannedItems).get()).single.status, 'pending');
      expect(find.byKey(const Key('item_actual_price_field')), findsOneWidget);
      Navigator.of(
        tester.element(find.byKey(const Key('item_actual_price_field'))),
      ).pop();
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('price_actual')), findsNothing);
      expect(find.byKey(const Key('price_actual_empty')), findsNothing);
      await ShoppingRepository(db).recordPurchase(
        listId: listId,
        plannedItemId: id,
        name: 'Domates',
        normalizedName: 'domates',
        quantity: DecimalFixed.parse('1.5'),
        unitCode: 'kilogram',
        unitPrice: DecimalFixed.fromInt(45),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('detail_check_$id')));
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextButton),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        (await db.select(db.purchaseEntries).get())
            .single
            .actualLineTotalMinorUnits,
        6750,
      );
      // Delete is a swipe (no row menu); it removes the purchase too.
      await tester.fling(
        find.byKey(Key('detail_item_$id')),
        const Offset(-500, 0),
        1000,
      );
      await tester.pumpAndSettle();
      expect(find.byKey(Key('detail_item_menu_$id')), findsNothing);
      expect(await db.select(db.plannedItems).get(), isEmpty);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      expect(await db.select(db.priceObservations).get(), isEmpty);
      await close(tester);
    },
  );

  testWidgets(
    'archive is a direct list action and completed detail stays read-only',
    (tester) async {
      final listId = await lists.createList(
        title: 'Market',
        currencyCode: 'TRY',
      );
      await item(listId, 'Domates');
      await open(tester, listId);
      await tester.tap(find.byKey(const Key('detail_more_menu')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Arşivle'));
      await tester.pumpAndSettle();
      expect((await lists.getById(listId)).status, 'archived');
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      await close(tester);
    },
  );

  testWidgets('fresh list completes once and returns to read-only detail', (
    tester,
  ) async {
    final listId = await lists.createList(title: 'Market', currencyCode: 'TRY');
    final id = await item(listId, 'Domates');
    await open(tester, listId);
    await tester.ensureVisible(find.byKey(const Key('detail_finish_button')));
    await tester.tap(find.byKey(const Key('detail_finish_button')));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(TextButton),
      ),
    );
    await tester.pumpAndSettle();
    expect((await lists.getById(listId)).status, 'draft');
    await tester.tap(find.byKey(const Key('detail_finish_button')));
    await tester.pumpAndSettle();
    final confirm = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(FilledButton),
    );
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect((await lists.getById(listId)).status, 'completed');
    expect((await lists.getById(listId)).completedAt, isNotNull);
    expect(find.byKey(const Key('summary_details')), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('detail_quick_entry')), findsNothing);
    expect(find.byKey(const Key('detail_finish_button')), findsNothing);
    expect(
      tester.widget<Checkbox>(find.byKey(Key('detail_check_$id'))).onChanged,
      isNull,
    );
    await tester.tap(find.byKey(const Key('detail_more_menu')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('detail_continue_shopping')), findsOneWidget);
    await tester.tap(find.byKey(const Key('detail_continue_shopping')));
    await tester.pumpAndSettle();
    expect((await lists.getById(listId)).status, 'shopping');
    expect(
      tester.widget<Checkbox>(find.byKey(Key('detail_check_$id'))).onChanged,
      isNotNull,
    );
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    await close(tester);
  });

  testWidgets('swipe deletes an item and undo restores it', (tester) async {
    final listId = await lists.createList(title: 'Market', currencyCode: 'TRY');
    final id = await item(listId, 'Domates');
    await open(tester, listId);

    await tester.fling(
      find.byKey(Key('detail_item_$id')),
      const Offset(-500, 0),
      1000,
    );
    await tester.pumpAndSettle();

    expect(await db.select(db.plannedItems).get(), isEmpty);
    expect(find.byType(SnackBar), findsOneWidget);
    await tester.tap(find.text('Geri al'));
    await tester.pumpAndSettle();
    expect((await db.select(db.plannedItems).get()).single.name, 'Domates');
    await close(tester);
  });

  for (final locale in ['tr', 'ar']) {
    testWidgets(
      '320dp 2x text long names and labelled 48dp actions ($locale)',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(320, 640));
        final listId = await lists.createList(
          title: 'Market',
          currencyCode: 'TRY',
        );
        final id = await item(
          listId,
          'Çok uzun ürün adı — طماطم عضوية كبيرة الحجم Domates',
        );
        await open(tester, listId, locale: locale, scale: 2);
        expect(tester.takeException(), isNull);
        for (final key in ['detail_quick_list']) {
          final button = tester.widget<IconButton>(find.byKey(Key(key)));
          expect(button.tooltip, isNotEmpty);
          final size = tester.getSize(find.byKey(Key(key)));
          expect(size.width, greaterThanOrEqualTo(48));
          expect(size.height, greaterThanOrEqualTo(48));
        }
        expect(find.byKey(const Key('detail_quick_entry')), findsOneWidget);
        expect(find.byKey(const Key('detail_add_item_button')), findsNothing);
        expect(find.byKey(const Key('detail_scan_receipt')), findsNothing);
        expect(find.byKey(Key('detail_item_menu_$id')), findsNothing);
        expect(
          tester
              .widget<IconButton>(find.byKey(const Key('list_keep_awake')))
              .tooltip,
          isNotEmpty,
        );
        expect(find.byKey(const Key('price_enter')), findsNothing);
        expect(find.byKey(const Key('price_scan')), findsNothing);
        await close(tester);
      },
    );
  }

  testWidgets(
    'composer tap opens the item form; mic dictates many items live',
    (tester) async {
      final listId = await lists.createList(
        title: 'Market',
        currencyCode: 'TRY',
      );
      final speech = FakeSpeechService();
      await open(tester, listId, speech: speech);

      await tester.tap(find.byKey(const Key('detail_quick_entry')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('item_name_field')), findsOneWidget);
      expect(find.byKey(const Key('item_name_mic')), findsOneWidget);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('detail_quick_list')));
      // The listening indicator animates forever: pump frames, do not settle.
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(find.byKey(const Key('draft_listening')), findsOneWidget);
      speech.emitPartial('1 kilo elma');
      await tester.pump();
      expect(find.text('1 kilo elma'), findsOneWidget);
      speech.emitFinal('1 kilo elma 2 ekmek');
      await tester.pump();
      expect(find.byKey(const Key('draft_listening')), findsOneWidget);
      await tester.tap(find.byKey(const Key('draft_mic_button')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('draft_listening')), findsNothing);
      expect(find.text('1 kilo elma 2 ekmek'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('draft_convert_button')))
            .onPressed,
        isNotNull,
      );
      await close(tester);
    },
  );
}
