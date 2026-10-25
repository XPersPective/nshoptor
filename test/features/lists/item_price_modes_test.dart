import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_form_sheet.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/starter_categories.dart';
import 'package:nshoptor/features/receipts/shelf_label/price_candidates.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';
import 'package:nshoptor/features/voice_input/parser/parsed_item_candidate.dart';

void main() {
  late AppDatabase db;
  late int listId;
  setUp(() async {
    AppFormatLocale.attach('tr');
    db = AppDatabase(NativeDatabase.memory());
    listId = await ListRepository(db).createList(currencyCode: 'TRY');
  });
  tearDown(AppFormatLocale.attachReset);

  Future<void> open(
    WidgetTester tester, {
    PlannedItem? item,
    List<PurchaseEntry> entries = const [],
    ParsedItemCandidate? candidate,
    PriceCandidate? photo,
  }) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    await tester.pumpWidget(const SizedBox.shrink());
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
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => ItemFormSheet(
                  db: db,
                  starterCategories: StarterCategories(),
                  listId: listId,
                  existing: item,
                  entries: entries,
                  initialCandidate: candidate,
                  onShelfCandidatePressed: photo == null
                      ? null
                      : (_) async => photo,
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }

  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
    await tester.binding.setSurfaceSize(null);
  }

  String text(WidgetTester tester, String key) =>
      tester.widget<TextField>(find.byKey(Key(key))).controller!.text;
  Future<void> enter(WidgetTester tester, String key, String value) async {
    await tester.enterText(find.byKey(Key(key)), value);
    await tester.pump();
  }

  Future<void> unit(WidgetTester tester, UnitCode value) async {
    tester
        .widget<DropdownButtonFormField<UnitCode>>(
          find.byKey(const Key('item_unit_field')),
        )
        .onChanged!(value);
    await tester.pump();
  }

  Future<void> mode(
    WidgetTester tester, {
    required bool actual,
    required bool unit,
  }) async {
    final option = find.byKey(
      Key(
        '${actual ? 'item_actual_price_mode' : 'item_price_mode'}_${unit ? 'unit' : 'total'}',
      ),
    );
    await tester.ensureVisible(option);
    await tester.tap(option);
    await tester.pumpAndSettle();
  }

  Future<void> save(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('item_save_button')));
    await tester.tap(find.byKey(const Key('item_save_button')));
    await tester.pumpAndSettle();
  }

  Future<void> values(
    WidgetTester tester,
    String qty,
    UnitCode selected,
    String home,
    String actual,
  ) async {
    await enter(tester, 'item_name_field', 'Ürün');
    await unit(tester, selected);
    await enter(tester, 'item_quantity_field', qty);
    await enter(tester, 'item_price_field', home);
    await enter(tester, 'item_actual_price_field', actual);
  }

  testWidgets(
    '400 grams and 350 TRY default to selected-quantity total in both prices',
    (tester) async {
      await open(tester);
      await values(tester, '400', UnitCode.gram, '350', '350');
      await save(tester);
      final item = (await db.select(db.plannedItems).get()).single;
      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(item.pricingInputMode, 'lineTotal');
      expect(item.plannedLineTotalMinorUnits, 35000);
      expect(
        DecimalFixed.parse(item.plannedUnitPrice!)
            .compareTo(DecimalFixed.parse('0.875')),
        0,
      );
      expect(entry.pricingInputMode, 'lineTotal');
      expect(entry.actualLineTotalMinorUnits, 35000);
      expect(entry.actualQuantity, '400');
      expect(entry.actualUnitCode, 'gram');
      await open(tester, item: item, entries: [entry]);
      expect(
        DecimalFixed.parse(
          text(tester, 'item_price_field').replaceAll(',', '.'),
        ).toMinorUnits(2),
        35000,
      );
      expect(
        DecimalFixed.parse(
          text(tester, 'item_actual_price_field').replaceAll(',', '.'),
        ).toMinorUnits(2),
        35000,
      );
      await close(tester);
    },
  );

  testWidgets(
    'two packages 260 total stays 260 as quantity changes; mode switch preserves economics',
    (tester) async {
      await open(tester);
      await values(tester, '2', UnitCode.paket, '260', '260');
      await mode(tester, actual: false, unit: true);
      expect(text(tester, 'item_price_field'), '130');
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('item_price_field')))
            .focusNode!
            .hasFocus,
        isTrue,
      );
      expect(tester.testTextInput.isVisible, isTrue);
      await mode(tester, actual: true, unit: true);
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('item_actual_price_field')))
            .focusNode!
            .hasFocus,
        isTrue,
      );
      expect(text(tester, 'item_actual_price_field'), '130');
      await mode(tester, actual: false, unit: false);
      await mode(tester, actual: true, unit: false);
      await enter(tester, 'item_quantity_field', '4');
      await save(tester);
      final item = (await db.select(db.plannedItems).get()).single;
      expect(item.plannedLineTotalMinorUnits, 26000);
      expect(
        DecimalFixed.parse(item.plannedUnitPrice!)
            .compareTo(DecimalFixed.fromInt(65)),
        0,
      );
      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(entry.actualLineTotalMinorUnits, 26000);
      expect(entry.actualQuantity, '4');
      await close(tester);
    },
  );

  testWidgets(
    'explicit 45 per kilogram for two kg totals 90, unit mode follows quantity edits',
    (tester) async {
      await open(tester);
      await values(tester, '2', UnitCode.kilogram, '', '');
      await mode(tester, actual: false, unit: true);
      await mode(tester, actual: true, unit: true);
      await enter(tester, 'item_price_field', '45');
      await enter(tester, 'item_actual_price_field', '45');
      await enter(tester, 'item_quantity_field', '3');
      await save(tester);
      expect(
        (await db.select(db.plannedItems).get())
            .single
            .plannedLineTotalMinorUnits,
        13500,
      );
      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(entry.pricingInputMode, 'unitPrice');
      expect(entry.actualLineTotalMinorUnits, 13500);
      await close(tester);
    },
  );

  testWidgets(
    'editing actual price preserves independent purchased quantity and discount; untouched actual retains id',
    (tester) async {
      final id = await ItemRepository(db).addItem(
        listId: listId,
        name: 'Domates',
        quantity: DecimalFixed.fromInt(2),
        unitCode: 'kilogram',
        priceIsUnitPrice: true,
        price: DecimalFixed.fromInt(40),
      );
      await ShoppingRepository(db).recordPurchase(
        listId: listId,
        plannedItemId: id,
        name: 'Domates',
        normalizedName: 'domates',
        quantity: DecimalFixed.parse('1.5'),
        unitCode: 'kilogram',
        unitPrice: DecimalFixed.fromInt(45),
        discountMinor: 250,
      );
      var item = (await db.select(db.plannedItems).get()).single;
      var entry = (await db.select(db.purchaseEntries).get()).single;
      await open(tester, item: item, entries: [entry]);
      await enter(tester, 'item_name_field', 'Domates yeni');
      await save(tester);
      expect((await db.select(db.purchaseEntries).get()).single.id, entry.id);
      item = (await db.select(db.plannedItems).get()).single;
      await open(tester, item: item, entries: [entry]);
      await enter(tester, 'item_actual_price_field', '50');
      await save(tester);
      entry = (await db.select(db.purchaseEntries).get()).single;
      expect(entry.actualQuantity, '1.5');
      expect(entry.discountMinorUnits, 250);
      expect(entry.actualLineTotalMinorUnits, 7250);
      await close(tester);
    },
  );

  testWidgets(
    'discount-aware unit/total switch and reopen retain net total and chosen mode',
    (tester) async {
      final id = await ItemRepository(db).addItem(
        listId: listId,
        name: 'Ürün',
        quantity: DecimalFixed.fromInt(2),
        unitCode: 'piece',
        priceIsUnitPrice: false,
      );
      await ShoppingRepository(db).recordPurchase(
        listId: listId,
        plannedItemId: id,
        name: 'Ürün',
        normalizedName: 'ürün',
        quantity: DecimalFixed.fromInt(2),
        unitCode: 'piece',
        unitPrice: DecimalFixed.fromInt(10),
        discountMinor: 200,
      );
      var item = (await db.select(db.plannedItems).get()).single;
      await open(
        tester,
        item: item,
        entries: await db.select(db.purchaseEntries).get(),
      );
      await mode(tester, actual: true, unit: false);
      expect(text(tester, 'item_actual_price_field'), '18');
      await enter(tester, 'item_quantity_field', '4');
      await mode(tester, actual: true, unit: true);
      expect(text(tester, 'item_actual_price_field'), '5');
      await save(tester);
      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(entry.actualLineTotalMinorUnits, 1800);
      expect(entry.discountMinorUnits, 200);
      expect(entry.pricingInputMode, 'unitPrice');
      item = (await db.select(db.plannedItems).get()).single;
      await open(tester, item: item, entries: [entry]);
      expect(text(tester, 'item_actual_price_field'), '5');
      await enter(tester, 'item_actual_price_field', '');
      await save(tester);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      await close(tester);
    },
  );

  testWidgets(
    'explicit 400g package quote 350 scales selected 800g to 700 without double multiplication',
    (tester) async {
      await open(
        tester,
        photo: PriceCandidate(
          value: DecimalFixed.fromInt(350),
          currencyCode: 'TRY',
          sourceLine: '400 g 350 TL',
          confidence: 'high',
          isUnitPrice: false,
          unitCode: UnitCode.gram,
          priceQuantity: DecimalFixed.fromInt(400),
        ),
      );
      await values(tester, '800', UnitCode.gram, '', '');
      await tester.tap(find.byKey(const Key('item_scan_actual_price')));
      await tester.pumpAndSettle();
      expect(text(tester, 'item_actual_price_field'), '875'); // TRY/kg
      await enter(tester, 'item_quantity_field', '400');
      expect(text(tester, 'item_actual_price_field'), '875');
      await enter(tester, 'item_quantity_field', '800');
      await save(tester);
      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(entry.actualLineTotalMinorUnits, 70000);
      expect(entry.pricingInputMode, 'unitPrice');
      await close(tester);
    },
  );

  testWidgets(
    'incompatible quote cannot overwrite price or save; unknown package requires explicit price meaning',
    (tester) async {
      await open(
        tester,
        photo: PriceCandidate(
          value: DecimalFixed.fromInt(350),
          currencyCode: 'TRY',
          sourceLine: '350 TL',
          confidence: 'high',
          isUnitPrice: false,
        ),
      );
      await values(tester, '2', UnitCode.paket, '', '100');
      await tester.tap(find.byKey(const Key('item_scan_actual_price')));
      await tester.pumpAndSettle();
      expect(text(tester, 'item_actual_price_field'), '100');
      await save(tester);
      expect(await db.select(db.plannedItems).get(), isEmpty);
      await mode(tester, actual: true, unit: false);
      expect(text(tester, 'item_actual_price_field'), '350');
      await save(tester);
      expect(
        (await db.select(db.purchaseEntries).get())
            .single
            .actualLineTotalMinorUnits,
        35000,
      );
      await close(tester);
    },
  );

  testWidgets(
    'spoken per-kilogram basis for grams displays 45/kg and persists 18 total',
    (tester) async {
      await open(
        tester,
        candidate: ParsedItemCandidate(
          name: 'Domates',
          rawText: '400 gram kilosu 45 lira',
          quantity: DecimalFixed.fromInt(400),
          unitCode: UnitCode.gram,
          unitPrice: DecimalFixed.fromInt(45),
          isUnitPrice: true,
          priceUnitCode: UnitCode.kilogram,
        ),
      );
      expect(text(tester, 'item_price_field'), '45');
      await save(tester);
      final item = (await db.select(db.plannedItems).get()).single;
      expect(item.plannedLineTotalMinorUnits, 1800);
      expect(item.pricingInputMode, 'unitPrice');
      await close(tester);
    },
  );

  testWidgets(
    'photo product label does not replace a name already entered by the user',
    (tester) async {
      await open(
        tester,
        photo: PriceCandidate(
          value: DecimalFixed.fromInt(75),
          currencyCode: 'TRY',
          sourceLine: '75 TL/adet',
          confidence: 'high',
          isUnitPrice: true,
          productName: 'WRONGPRODUCT',
          unitCode: UnitCode.adet,
        ),
      );
      await values(tester, '2', UnitCode.adet, '35', '40');
      await tester.tap(find.byKey(const Key('item_scan_actual_price')));
      await tester.pumpAndSettle();
      expect(text(tester, 'item_name_field'), 'Ürün');
      expect(text(tester, 'item_price_field'), '35');
      expect(text(tester, 'item_actual_price_field'), '75');
      await save(tester);

      final item = (await db.select(db.plannedItems).get()).single;
      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(item.name, 'Ürün');
      expect(item.plannedLineTotalMinorUnits, 3500);
      expect(entry.name, 'Ürün');
      expect(DecimalFixed.parse(entry.actualUnitPrice!), DecimalFixed.fromInt(75));
      expect(entry.actualLineTotalMinorUnits, 15000);
      await close(tester);
    },
  );

  testWidgets(
    'photo product label fills an empty new name with Turkish capitalization',
    (tester) async {
      await open(
        tester,
        photo: PriceCandidate(
          value: DecimalFixed.fromInt(25),
          currencyCode: 'TRY',
          sourceLine: '25 TL',
          confidence: 'high',
          isUnitPrice: false,
          productName: 'istanbul süt',
        ),
      );
      await unit(tester, UnitCode.adet);
      await enter(tester, 'item_quantity_field', '1');
      await enter(tester, 'item_price_field', '12');
      await tester.tap(find.byKey(const Key('item_scan_actual_price')));
      await tester.pumpAndSettle();
      expect(text(tester, 'item_name_field'), 'İstanbul süt');
      expect(text(tester, 'item_actual_price_field'), '25');
      await save(tester);

      final item = (await db.select(db.plannedItems).get()).single;
      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(item.name, 'İstanbul süt');
      expect(item.plannedLineTotalMinorUnits, 1200);
      expect(entry.name, 'İstanbul süt');
      expect(entry.actualLineTotalMinorUnits, 2500);
      await close(tester);
    },
  );

  testWidgets(
    'separate per-100g shelf basis scales 400g to 80 with canonical unit price',
    (tester) async {
      final candidate = ShelfPriceExtractor().extract([
        OcrLine(
          text: '20 TL',
          boundingBoxTop: 0.10,
          boundingBoxLeft: 0.10,
          boundingBoxHeight: 0.05,
          boundingBoxWidth: 0.30,
        ),
        OcrLine(
          text: '/100g',
          boundingBoxTop: 0.17,
          boundingBoxLeft: 0.10,
          boundingBoxHeight: 0.05,
          boundingBoxWidth: 0.30,
        ),
      ]).single;
      expect(candidate.priceQuantity, DecimalFixed.fromInt(100));
      expect(candidate.unitCode, UnitCode.gram);
      expect(candidate.isUnitPrice, isTrue);

      await open(tester, photo: candidate);
      await values(tester, '400', UnitCode.gram, '100', '100');
      await tester.tap(find.byKey(const Key('item_scan_actual_price')));
      await tester.pumpAndSettle();
      expect(text(tester, 'item_actual_price_field'), '200');
      await save(tester);

      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(entry.actualQuantity, '400');
      expect(entry.actualUnitCode, 'gram');
      expect(entry.pricingInputMode, 'unitPrice');
      expect(DecimalFixed.parse(entry.actualUnitPrice!), DecimalFixed.parse('0.2'));
      expect(entry.actualLineTotalMinorUnits, 8000);
      await close(tester);
    },
  );
}
