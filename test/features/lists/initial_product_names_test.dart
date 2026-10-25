import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_form_sheet.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/starter_categories.dart';
import 'package:nshoptor/features/receipts/shelf_label/price_candidates.dart';

void main() {
  late AppDatabase db;
  late int listId;
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    listId = await ListRepository(db).createList(currencyCode: 'TRY');
  });

  Future<void> settle(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  }

  Future<void> open(
    WidgetTester tester, {
    PlannedItem? existing,
    String? initialName,
    PriceCandidate? photo,
  }) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
          body: ItemFormSheet(
            db: db,
            starterCategories: StarterCategories(),
            listId: listId,
            existing: existing,
            initialName: initialName,
            initialActualCandidate: photo,
          ),
        ),
      ),
    );
    await settle(tester);
  }

  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  String name(WidgetTester tester) => tester
      .widget<TextField>(find.byKey(const Key('item_name_field')))
      .controller!
      .text;

  testWidgets(
    'initial pasted name capitalizes once; explicit lowercase survives save',
    (tester) async {
      await open(tester);
      await tester.enterText(
        find.byKey(const Key('item_name_field')),
        'incir eLMa',
      );
      expect(name(tester), 'İncir eLMa');
      await tester.enterText(
        find.byKey(const Key('item_name_field')),
        'incir eLMa',
      );
      expect(name(tester), 'incir eLMa');
      await tester.tap(find.byKey(const Key('item_save_button')));
      await settle(tester);
      expect(
        (await db.select(db.plannedItems).get()).single.name,
        'incir eLMa',
      );
      await close(tester);
    },
  );

  testWidgets(
    'new suggestion prefill capitalizes once and programmatic user edits remain',
    (tester) async {
      await open(tester, initialName: 'ıspanak');
      expect(name(tester), 'Ispanak');
      final controller = tester
          .widget<TextField>(find.byKey(const Key('item_name_field')))
          .controller!;
      controller.text = 'ıspanak';
      await tester.pump();
      expect(name(tester), 'ıspanak');
      await close(tester);
    },
  );

  testWidgets(
    'initial photo product gets local capital without changing its price',
    (tester) async {
      await open(
        tester,
        photo: PriceCandidate(
          value: DecimalFixed.fromInt(12),
          currencyCode: 'TRY',
          sourceLine: 'incir 12 TL',
          confidence: 'high',
          isUnitPrice: false,
          productName: 'incir',
        ),
      );
      expect(name(tester), 'İncir');
      await tester.tap(find.byKey(const Key('item_save_button')));
      await settle(tester);
      final item = (await db.select(db.plannedItems).get()).single;
      expect(item.name, 'İncir');
      final purchase = (await db.select(db.purchaseEntries).get()).single;
      expect(purchase.actualLineTotalMinorUnits, 1200);
      await close(tester);
    },
  );

  testWidgets('existing lowercase product is never normalized again', (
    tester,
  ) async {
    await ItemRepository(db).addItem(
      listId: listId,
      name: 'incir',
      quantity: DecimalFixed.fromInt(1),
      unitCode: 'adet',
      priceIsUnitPrice: false,
    );
    final existing = (await db.select(db.plannedItems).get()).single;
    await open(tester, existing: existing);
    expect(name(tester), 'incir');
    await tester.enterText(find.byKey(const Key('item_name_field')), 'ıspanak');
    expect(name(tester), 'ıspanak');
    await tester.tap(find.byKey(const Key('item_save_button')));
    await settle(tester);
    expect((await db.select(db.plannedItems).get()).single.name, 'ıspanak');
    await close(tester);
  });
}
