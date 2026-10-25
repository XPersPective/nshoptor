import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_list_view.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/taxonomy/item_sort.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  late AppDatabase db;
  late ListRepository lists;
  late int listId;
  late List<PlannedItem> items;
  test(
    'Turkish and Azerbaijani alphabets preserve their distinct letter order',
    () {
      addTearDown(db.close);
      List<String> ordered(List<String> names, String locale) =>
          [...names]..sort((a, b) => compareItemNames(a, b, locale));
      expect(
        ordered([
          'Üzüm',
          'İncir',
          'Ispanak',
          'Çay',
          'Ceviz',
          'Şeker',
          'Süt',
          'Öğün',
          'Ova',
          'Ğ',
          'G',
        ], 'tr'),
        [
          'Ceviz',
          'Çay',
          'G',
          'Ğ',
          'Ispanak',
          'İncir',
          'Ova',
          'Öğün',
          'Süt',
          'Şeker',
          'Üzüm',
        ],
      );
      expect(
        ordered(['İ', 'I', 'X', 'H', 'Q', 'K', 'L', 'Ə', 'E', 'F'], 'az'),
        ['E', 'Ə', 'F', 'H', 'X', 'I', 'İ', 'K', 'Q', 'L'],
      );
      expect(compareItemNames('İNCİR', 'incir', 'tr'), 0);
      expect(compareItemNames('ISPANAK', 'ıspanak', 'az'), 0);
      expect(compareItemNames('C\u0327ay', 'Çay', 'tr'), 0);
      expect(compareItemNames('I\u0307ncir', 'İncir', 'tr'), 0);
    },
  );

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    lists = ListRepository(db);
    listId = await lists.createList(title: 'Market', currencyCode: 'TRY');
    for (final name in ['Süt', 'İncir', 'Ispanak']) {
      await ItemRepository(db).addItem(
        listId: listId,
        name: name,
        quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece',
        priceIsUnitPrice: false,
      );
    }
    items = await ShoppingRepository(db).watchItems(listId).first;
  });

  test('each mode partitions explicit-zero purchases last without rewriting manual order', () async {
    addTearDown(db.close);
    final shopping = ShoppingRepository(db);
    await shopping.recordPurchase(
      listId: listId,
      plannedItemId: items.first.id,
      name: items.first.name,
      normalizedName: items.first.normalizedName,
      quantity: DecimalFixed.fromInt(1),
      unitCode: 'piece',
      unitPrice: DecimalFixed.fromInt(0),
    );
    final entries = await shopping.watchEntries(listId).first;
    List<String> names(ItemSortMode mode, List<PurchaseEntry> purchases) =>
        sortedItemsForView(
          items,
          purchases,
          mode: mode,
          localeCode: 'tr',
        ).map((item) => item.name).toList();
    expect(names(ItemSortMode.custom, entries), ['İncir', 'Ispanak', 'Süt']);
    expect(names(ItemSortMode.alphabetical, entries), [
      'Ispanak',
      'İncir',
      'Süt',
    ]);
    await shopping.removePurchases(items.first.id);
    final cleared = await shopping.watchEntries(listId).first;
    expect(names(ItemSortMode.custom, cleared), ['Süt', 'İncir', 'Ispanak']);
    expect(names(ItemSortMode.alphabetical, cleared), [
      'Ispanak',
      'İncir',
      'Süt',
    ]);
    expect(
      (await shopping.watchItems(listId).first).map((item) => item.id),
      items.map((item) => item.id),
    );
    expect(canReorderItemView(ItemSortMode.custom, ''), isTrue);
    expect(canReorderItemView(ItemSortMode.custom, ' süt '), isFalse);
    expect(canReorderItemView(ItemSortMode.alphabetical, ''), isFalse);
  });

  test('A–Z merges unplanned purchases into the purchased group without changing manual ranks', () async {
    addTearDown(db.close);
    final shopping = ShoppingRepository(db);
    await shopping.recordPurchase(
      listId: listId,
      plannedItemId: items[0].id,
      name: items[0].name,
      normalizedName: items[0].normalizedName,
      quantity: DecimalFixed.fromInt(1),
      unitCode: 'piece',
      unitPrice: DecimalFixed.fromInt(0),
    );
    for (final name in ['Çay', 'Armut']) {
      await shopping.recordPurchase(
        listId: listId,
        name: name,
        normalizedName: name,
        quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece',
        unitPrice: DecimalFixed.fromInt(5),
      );
    }
    final entries = await shopping.watchEntries(listId).first;
    final rows = alphabeticalItemRows(items, entries, localeCode: 'tr');
    expect(rows.map((row) => row.name), [
      'Ispanak',
      'İncir',
      'Armut',
      'Çay',
      'Süt',
    ]);
    expect(
      rows
          .where((row) => row.entry != null)
          .map((row) => row.entry!.id)
          .toSet(),
      entries
          .where((entry) => entry.plannedItemId == null)
          .map((entry) => entry.id)
          .toSet(),
    );
    expect(rows.where((row) => row.item != null).length, items.length);
    expect(
      (await shopping.watchItems(listId).first).map((item) => item.id),
      items.map((item) => item.id),
    );
  });

  test('manual reorder holds validation and writes in one transaction while an item is added', () async {
    addTearDown(db.close);
    final isolated = _PausedReadRepository(db);
    final reordering = isolated.reorderItems(
      listId,
      items.reversed.map((item) => item.id).toList(),
    );
    await isolated.readStarted.future;
    var mutationFinished = false;
    final addition = ItemRepository(db)
        .addItem(
          listId: listId,
          name: 'Çay',
          quantity: DecimalFixed.fromInt(1),
          unitCode: 'piece',
          priceIsUnitPrice: false,
        )
        .then((id) {
          mutationFinished = true;
          return id;
        });
    try {
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(
        mutationFinished,
        isFalse,
        reason:
            'A concurrent writer must wait for the reorder snapshot to commit',
      );
    } finally {
      isolated.releaseRead.complete();
      await reordering;
      await addition;
    }
    final saved = await ShoppingRepository(db).watchItems(listId).first;
    expect(saved.map((item) => item.name), ['Ispanak', 'İncir', 'Süt', 'Çay']);
    expect(saved.map((item) => item.sortOrder).toSet().length, saved.length);
    await expectLater(
      ItemRepository(db)
          .reorderItems(listId, items.map((item) => item.id).toList()),
      throwsArgumentError,
      reason: 'A drag captured before the new item was added must be rejected',
    );
  });

  test('equal names sort by saved rank then ID regardless of input order', () {
    addTearDown(db.close);
    final equal = [
      items[0].copyWith(name: 'İNCİR', sortOrder: 1),
      items[1].copyWith(name: 'incir', sortOrder: 0),
      items[2].copyWith(name: 'İncir', sortOrder: 0),
    ];
    final expected = [items[1].id, items[2].id, items[0].id];
    for (final input in [equal, equal.reversed.toList()]) {
      expect(
        sortItems(
          input,
          ItemSortMode.alphabetical,
          localeCode: 'tr',
        ).map((item) => item.id),
        expected,
      );
    }
  });

  test('per-list preference reloads from existing DB and invalid values fall back to manual', () async {
    addTearDown(db.close);
    final preferences = ItemSortPreferences(db);
    final secondId = await lists.createList(currencyCode: 'TRY');
    expect(await preferences.read(listId), ItemSortMode.custom);
    await preferences.write(listId, ItemSortMode.alphabetical);
    expect(
      await ItemSortPreferences(db).read(listId),
      ItemSortMode.alphabetical,
    );
    expect(await preferences.read(secondId), ItemSortMode.custom);
    await preferences.write(listId, ItemSortMode.custom);
    expect(await preferences.read(listId), ItemSortMode.custom);
    await db
        .into(db.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            key: 'list.$listId.item_sort',
            value: const Value('invalid'),
          ),
        );
    expect(await preferences.read(listId), ItemSortMode.custom);
  });

  Future<void> closeWidgetDatabase(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    var closed = false;
    final closing = db.close().then((_) => closed = true);
    // Drift stream teardown can enqueue both real-zone callbacks from setUp
    // and fake-zone timers from StreamBuilder. Drain both without awaiting a
    // fake-zone future from runAsync (which would suspend those timers).
    for (var i = 0; i < 30 && !closed; i++) {
      await tester.pump(const Duration(milliseconds: 1));
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 1)),
      );
    }
    expect(
      closed,
      isTrue,
      reason: 'Drift teardown must finish after both zones drain',
    );
    await closing;
  }

  testWidgets(
    'A–Z renders planned and unplanned purchases together with no drag handles',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(412, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      late PurchaseEntry unplanned;
      await tester.runAsync(() async {
        final shopping = ShoppingRepository(db);
        await shopping.recordPurchase(
          listId: listId,
          plannedItemId: items[0].id,
          name: 'Süt',
          normalizedName: 'süt',
          quantity: DecimalFixed.fromInt(1),
          unitCode: 'piece',
          unitPrice: DecimalFixed.fromInt(0),
        );
        await shopping.recordPurchase(
          listId: listId,
          name: 'Armut',
          normalizedName: 'armut',
          quantity: DecimalFixed.fromInt(1),
          unitCode: 'piece',
          unitPrice: DecimalFixed.fromInt(5),
        );
        final entries = await (db.select(
          db.purchaseEntries,
        )..where((row) => row.listId.equals(listId))).get();
        unplanned = entries.singleWhere((entry) => entry.plannedItemId == null);
        await ItemSortPreferences(db).write(listId, ItemSortMode.alphabetical);
      });
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('tr'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ListDetailScreen(db: db, listRepository: lists, listId: listId),
        ),
      );
      await tester.pumpAndSettle();
      double y(Key key) => tester.getTopLeft(find.byKey(key)).dy;
      expect(
        y(Key('detail_item_${items[2].id}')),
        lessThan(y(Key('detail_item_${items[1].id}'))),
      );
      expect(
        y(Key('detail_item_${items[1].id}')),
        lessThan(y(Key('detail_unplanned_${unplanned.id}'))),
      );
      expect(
        y(Key('detail_unplanned_${unplanned.id}')),
        lessThan(y(Key('detail_item_${items[0].id}'))),
      );
      expect(find.byType(ReorderableDelayedDragStartListener), findsNothing);
      expect(tester.takeException(), isNull);
      await closeWidgetDatabase(tester);
    },
  );

  testWidgets(
    'visible sort selector persists after reopening; A–Z and search disable drag',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(412, 1400));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      Future<void> open() async {
        await tester.pumpWidget(
          MaterialApp(
            locale: const Locale('tr'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ListDetailScreen(
              db: db,
              listRepository: lists,
              listId: listId,
            ),
          ),
        );
        await tester.pumpAndSettle();
      }

      await open();
      final l10n = AppLocalizations.of(
        tester.element(find.byType(ListDetailScreen)),
      );
      expect(find.text(l10n.listSortManual), findsOneWidget);
      expect(
        find.byType(ReorderableDelayedDragStartListener),
        findsNWidgets(3),
      );
      await tester.tap(find.byKey(const Key('detail_item_sort')));
      await tester.pumpAndSettle();
      await tester.tap(
        find.byWidgetPredicate(
          (widget) =>
              widget is CheckedPopupMenuItem<ItemSortMode> &&
              widget.value == ItemSortMode.alphabetical,
        ),
      );
      await tester.pumpAndSettle();
      // Keep the query in the same fake-async zone as the pending UI write.
      // Crossing into runAsync here can wait on a write whose microtasks are
      // suspended until the widget tester pumps again.
      final savedMode = ItemSortPreferences(db).read(listId);
      await tester.pumpAndSettle();
      expect(await savedMode, ItemSortMode.alphabetical);
      await tester.pumpAndSettle();
      expect(find.byType(ReorderableDelayedDragStartListener), findsNothing);
      double y(int index) => tester
          .getTopLeft(find.byKey(Key('detail_item_${items[index].id}')))
          .dy;
      expect(y(2), lessThan(y(1)));
      expect(y(1), lessThan(y(0)));
      await tester.pumpWidget(const SizedBox.shrink());
      await open();
      expect(find.text(l10n.listSortAz), findsOneWidget);
      expect(find.byType(ReorderableDelayedDragStartListener), findsNothing);
      await tester.tap(find.byKey(const Key('detail_item_sort')));
      await tester.pumpAndSettle();
      await tester.tap(
        find.byWidgetPredicate(
          (widget) =>
              widget is CheckedPopupMenuItem<ItemSortMode> &&
              widget.value == ItemSortMode.custom,
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('detail_item_search')),
        'Süt',
      );
      await tester.pumpAndSettle();
      expect(find.byType(ReorderableDelayedDragStartListener), findsNothing);
      await tester.tap(find.byKey(const Key('detail_search_clear')));
      await tester.pumpAndSettle();
      expect(
        find.byType(ReorderableDelayedDragStartListener),
        findsNWidgets(3),
      );
      await closeWidgetDatabase(tester);
    },
  );
}

class _PausedReadRepository extends ItemRepository {
  _PausedReadRepository(super.db);

  final readStarted = Completer<void>();
  final releaseRead = Completer<void>();

  @override
  Future<List<PlannedItem>> getItems(int listId) async {
    final items = await super.getItems(listId);
    readStarted.complete();
    await releaseRead.future;
    return items;
  }
}
