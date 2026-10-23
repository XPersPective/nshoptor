import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/text/list_title.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_form_sheet.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/starter_categories.dart';
import 'package:nshoptor/features/shopping_mode/item_status.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';
import 'package:nshoptor/features/voice_input/parser/parsed_item_candidate.dart';

void main() {
  late AppDatabase db;
  late int listId;
  late int itemId;
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    listId = await ListRepository(db).createList(currencyCode: 'TRY');
    itemId = await ItemRepository(db).addItem(
      listId: listId,
      name: 'Süt',
      quantity: DecimalFixed.fromInt(2),
      unitCode: 'litre',
      priceIsUnitPrice: true,
    );
  });
  tearDown(() => db.close());

  Future<void> record(DecimalFixed? price) =>
      ShoppingRepository(db).recordPurchase(
        listId: listId,
        plannedItemId: itemId,
        name: 'Süt',
        normalizedName: 'süt',
        quantity: DecimalFixed.fromInt(2),
        unitCode: 'litre',
        unitPrice: price,
      );

  test('Turkish list names normalize at creation and update', () async {
    final lists = ListRepository(db);
    final id = await lists.createList(
      title: '  istanbul alışverişi  ',
      currencyCode: 'TRY',
    );
    expect((await lists.getById(id)).title, 'İstanbul alışverişi');
    await lists.updateTitle(id, '  ısparta pazarı ');
    expect((await lists.getById(id)).title, 'Isparta pazarı');
  });

  test('typing and pasted Turkish titles preserve selection, whitespace and composition', () {
    const formatter = ListTitleFormatter();
    const pasted = TextEditingValue(
      text: '  istanbul alışverişi',
      selection: TextSelection.collapsed(offset: 5),
    );
    final formatted = formatter.formatEditUpdate(
      TextEditingValue.empty,
      pasted,
    );
    expect(formatted.text, '  İstanbul alışverişi');
    expect(formatted.selection, pasted.selection);
    const composing = TextEditingValue(
      text: 'istanbul',
      selection: TextSelection.collapsed(offset: 1),
      composing: TextRange(start: 0, end: 1),
    );
    expect(
      formatter.formatEditUpdate(TextEditingValue.empty, composing),
      composing,
    );
    final committed = formatter.formatEditUpdate(
      composing,
      composing.copyWith(composing: TextRange.empty),
    );
    expect(committed.text, 'İstanbul');
    expect(committed.selection, composing.selection);
    expect(capitalizeListTitle('  ısparta'), '  Isparta');
    expect(capitalizeListTitle('  '), '  ');
    expect(capitalizeListTitle('çocuk alışverişi'), 'Çocuk alışverişi');
    expect(capitalizeListTitle('ideas', localeCode: 'en'), 'Ideas');
  });

  test('spoken actual totals update unique existing product without changing home estimate', () async {
    final items = ItemRepository(db);
    await items.addCandidates(listId, [
      ParsedItemCandidate(
        name: 'Süt',
        rawText: '',
        unitPrice: DecimalFixed.fromInt(260),
        isUnitPrice: false,
        priceDestination: VoicePriceDestination.actual,
        currencyCode: 'TRY',
      ),
    ]);
    expect(await items.getItems(listId), hasLength(1));
    final saved = (await items.getItems(listId)).single;
    expect(saved.plannedLineTotalMinorUnits, isNull);
    final purchase = (await db.select(db.purchaseEntries).get()).single;
    expect(purchase.actualLineTotalMinorUnits, 26000);
    expect(
      DecimalFixed.parse(purchase.actualUnitPrice!)
          .compareTo(DecimalFixed.fromInt(130)),
      0,
    );
    await items.addCandidates(listId, [
      ParsedItemCandidate(
        name: 'Süt',
        rawText: '',
        quantity: DecimalFixed.fromInt(2),
        unitPrice: DecimalFixed.fromInt(130),
        isUnitPrice: true,
        priceDestination: VoicePriceDestination.actual,
      ),
    ]);
    expect(await db.select(db.purchaseEntries).get(), hasLength(1));
    expect(
      (await db.select(db.purchaseEntries).get())
          .single
          .actualLineTotalMinorUnits,
      26000,
    );
  });

  test('candidate batch rolls back unresolved, foreign currency and duplicate-product choices', () async {
    final items = ItemRepository(db);
    final first = ParsedItemCandidate(name: 'Ekmek', rawText: '');
    for (final candidate in [
      ParsedItemCandidate(
        name: 'Süt',
        rawText: '',
        unitPrice: DecimalFixed.fromInt(20),
      ),
      ParsedItemCandidate(
        name: 'Süt',
        rawText: '',
        unitPrice: DecimalFixed.fromInt(20),
        isUnitPrice: true,
        currencyCode: 'EUR',
      ),
    ]) {
      await expectLater(
        items.addCandidates(listId, [first, candidate]),
        throwsArgumentError,
      );
      expect(await items.getItems(listId), hasLength(1));
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
    }
    await items.addItem(
      listId: listId,
      name: 'Süt',
      quantity: DecimalFixed.fromInt(1),
      unitCode: 'litre',
      priceIsUnitPrice: true,
    );
    await expectLater(
      items.addCandidates(listId, [
        ParsedItemCandidate(
          name: 'Süt',
          rawText: '',
          unitPrice: DecimalFixed.zero(),
          isUnitPrice: true,
          priceDestination: VoicePriceDestination.actual,
        ),
      ]),
      throwsArgumentError,
    );
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
  });

  test(
    'unknown, explicit zero, cleared and unavailable are distinct after reread',
    () async {
      final repo = ShoppingRepository(db);
      await repo.setItemStatus(itemId, ItemStatus.inCart);
      expect(
        (await ItemRepository(db).getItems(listId)).single.status,
        'pending',
      );
      expect((await repo.watchSummary(listId).first).doneCount, 0);
      await record(DecimalFixed.zero());
      expect(
        (await ItemRepository(db).getItems(listId)).single.status,
        'inCart',
      );
      expect((await repo.watchSummary(listId).first).doneCount, 1);
      expect(
        (await db.select(db.purchaseEntries).get()).single.grossTotalMinorUnits,
        0,
      );
      await record(null);
      expect(
        (await ItemRepository(db).getItems(listId)).single.status,
        'pending',
      );
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      expect((await repo.watchSummary(listId).first).doneCount, 0);
      await repo.setItemStatus(itemId, ItemStatus.notFound);
      expect(
        (await ItemRepository(db).getItems(listId)).single.status,
        'notFound',
      );
      expect((await repo.watchSummary(listId).first).doneCount, 0);
    },
  );

  test(
    'zero purchase and cleared state survive closing and reopening SQLite',
    () async {
      await db.close();
      final directory = await Directory.systemTemp.createTemp(
        'enshop-price-regression-',
      );
      final file = File('${directory.path}/shopping.sqlite');
      AppDatabase? persistent;
      try {
        persistent = AppDatabase(NativeDatabase(file));
        final list = await ListRepository(persistent)
            .createList(title: 'istanbul', currencyCode: 'TRY');
        final id = await ItemRepository(persistent).addItem(
          listId: list,
          name: 'Süt',
          quantity: DecimalFixed.fromInt(1),
          unitCode: 'litre',
          priceIsUnitPrice: true,
        );
        await ShoppingRepository(persistent).recordPurchase(
          listId: list,
          plannedItemId: id,
          name: 'Süt',
          normalizedName: 'süt',
          quantity: DecimalFixed.fromInt(1),
          unitCode: 'litre',
          unitPrice: DecimalFixed.zero(),
        );
        await persistent.close();
        persistent = AppDatabase(NativeDatabase(file));
        expect(
          (await ListRepository(persistent).getById(list)).title,
          'İstanbul',
        );
        expect(
          (await ShoppingRepository(
            persistent,
          ).watchSummary(list).first).doneCount,
          1,
        );
        expect(
          (await persistent.select(persistent.purchaseEntries).get())
              .single
              .actualUnitPrice,
          '0',
        );
        await ShoppingRepository(persistent).recordPurchase(
          listId: list,
          plannedItemId: id,
          name: 'Süt',
          normalizedName: 'süt',
          quantity: DecimalFixed.fromInt(1),
          unitCode: 'litre',
        );
        await persistent.close();
        persistent = AppDatabase(NativeDatabase(file));
        expect(
          (await ItemRepository(persistent).getItems(list)).single.status,
          'pending',
        );
        expect(
          await persistent.select(persistent.purchaseEntries).get(),
          isEmpty,
        );
        expect(
          (await ShoppingRepository(
            persistent,
          ).watchSummary(list).first).doneCount,
          0,
        );
      } finally {
        await persistent?.close();
        // Only individual files in the freshly created test directory are removed.
        for (final entry in directory.listSync()) {
          if (entry is File) await entry.delete();
        }
        await directory.delete();
      }
    },
  );

  Future<void> form(WidgetTester tester, {bool focusPrices = false}) async {
    final item = (await ItemRepository(db).getItems(listId)).single;
    final entries = await db.select(db.purchaseEntries).get();
    await tester.binding.setSurfaceSize(const Size(800, 1600));
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
        home: Scaffold(
          body: ItemFormSheet(
            db: db,
            starterCategories: StarterCategories(),
            listId: listId,
            existing: item,
            entries: entries,
            focusActual: focusPrices,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.binding.setSurfaceSize(null);
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  for (final home in [false, true]) {
    for (final market in [false, true]) {
      testWidgets(
        'price focus home=$home market=$market preserves values and keyboard',
        (tester) async {
          if (home) {
            await (db.update(
              db.plannedItems,
            )..where((t) => t.id.equals(itemId))).write(
              const PlannedItemsCompanion(
                plannedUnitPrice: Value('12'),
                plannedLineTotalMinorUnits: Value(2400),
              ),
            );
          }
          if (market) await record(DecimalFixed.zero());
          await form(tester, focusPrices: true);
          final target = find.byKey(
            Key(
              !home && !market ? 'item_price_field' : 'item_actual_price_field',
            ),
          );
          final editable = tester.widget<EditableText>(
            find.descendant(of: target, matching: find.byType(EditableText)),
          );
          expect(editable.focusNode.hasFocus, isTrue);
          expect(tester.testTextInput.isVisible, isTrue);
          expect(
            editable.keyboardType,
            const TextInputType.numberWithOptions(decimal: true),
          );
          final homeField = tester.widget<TextField>(
            find.byKey(const Key('item_price_field')),
          );
          final actualField = tester.widget<TextField>(
            find.byKey(const Key('item_actual_price_field')),
          );
          expect(homeField.controller!.text, home ? '12' : '');
          expect(actualField.controller!.text, market ? '0' : '');
          await tester.tap(find.byKey(const Key('item_quantity_field')));
          await tester.pump();
          expect(editable.focusNode.hasFocus, isFalse);
          await close(tester);
        },
      );
    }
  }

  testWidgets(
    'clearing actual price in form removes priced purchase and persisted tick',
    (tester) async {
      await record(DecimalFixed.fromInt(42));
      await form(tester);
      await tester.enterText(
        find.byKey(const Key('item_actual_price_field')),
        '',
      );
      await tester.tap(find.byKey(const Key('item_save_button')));
      await tester.pumpAndSettle();
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      expect(
        (await ItemRepository(db).getItems(listId)).single.status,
        'pending',
      );
      await close(tester);
    },
  );
}
