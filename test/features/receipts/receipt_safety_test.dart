import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/core/quantity/unit_conversion.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';
import 'package:nshoptor/features/receipts/shelf_label/price_candidates.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

OcrScanResult scan(List<String> lines) => OcrScanResult(lines: [for (final line in lines) OcrLine(text: line)]);

void main() {
  test('receipt header substrings inside product names never remove real products', () {
    final result = ReceiptParser().parse(scan([
      'FISTIK EZMESI 70,00', 'VATAN UN 20,00', 'TOPLAMBESIN 30,00',
      'KDV 1,00', 'TOPLAM 120,00',
    ]));
    expect(result.lines.map((line) => line.name), ['FISTIK EZMESI', 'VATAN UN', 'TOPLAMBESIN']);
    expect(result.computedTotalMinor, 12000);
    expect(result.taxMinor, 100);
  });
  test('carton product survives and cash/change never override actual total', () {
    final result = ReceiptParser().parse(scan([
      'KARTON SUT 25,00', 'KASA DOMATES 10,00', 'GENEL TOPLAM 35,00',
      'NAKIT 50,00', 'PARA USTU 15,00', 'KREDI KARTI 0,00',
    ]));
    expect(result.lines.map((l) => l.name), ['KARTON SUT', 'KASA DOMATES']);
    expect(result.totalMinor, 3500);
    final english = ReceiptParser(currency: 'USD').parse(scan([
      'BREAD 10.00', 'TOTAL 10.00', 'CASH 20.00', 'CHANGE 10.00',
    ]));
    expect(english.lines.single.name, 'BREAD');
    expect(english.totalMinor, 1000);
  });

  test('foreign shelf currency is retained and ambiguous symbols are not relabelled', () {
    final euro = ShelfPriceExtractor(defaultCurrency: 'TRY').extract(scan(['MILK', '€4.99']).lines);
    expect(euro.single.currencyCode, 'EUR');
    expect(euro.single.value.toDbString(), '4.99');
    expect(ShelfPriceExtractor(defaultCurrency: 'TRY').extract(scan([r'MILK $4.99']).lines), isEmpty);
    final usd = ShelfPriceExtractor(defaultCurrency: 'TRY').extract(scan(['MILK', '4.99 USD']).lines);
    expect(usd.single.currencyCode, 'USD');
    expect(ShelfPriceExtractor(defaultCurrency: 'TRY').extract(scan(['€4.99', '10.00 TL']).lines), isEmpty);
  });

  test('explicit receipt units persist for new items and convert safely for linked plans', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final id = await ListRepository(db).createList(currencyCode: 'TRY');
    final item = await ItemRepository(db).addItem(listId: id, name: 'TOMATO', quantity: DecimalFixed.fromInt(2), unitCode: 'kilogram', priceIsUnitPrice: false);
    final c = ReceiptReviewController(db: db, listId: id, parseResult: ReceiptParser().parse(scan([
      'TOMATO 500G X0,01 5,00', 'MILK 1,5L X20,00 30,00', 'TOPLAM 35,00',
    ])));
    addTearDown(c.dispose);
    expect(c.lines.first.unitCode, UnitCode.gram);
    expect(c.lines.last.unitCode, UnitCode.litre);
    c.linkLine(0, item); c.accept(1);
    await c.commit();
    final purchases = await db.select(db.purchaseEntries).get();
    expect(purchases.first.actualQuantity, '0.500000');
    expect(purchases.first.actualUnitCode, 'kilogram');
    expect(purchases.first.actualLineTotalMinorUnits, 500);
    expect(purchases.last.actualUnitCode, 'litre');
    expect(purchases.last.actualLineTotalMinorUnits, 3000);
    final plans = await ItemRepository(db).getItems(id);
    expect(plans.last.plannedUnitCode, 'litre');
  });

  test('incompatible receipt unit rolls back replacement and can be unlinked', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final id = await ListRepository(db).createList(currencyCode: 'TRY');
    final item = await ItemRepository(db).addItem(listId: id, name: 'MILK', quantity: DecimalFixed.fromInt(2), unitCode: 'kilogram', priceIsUnitPrice: false);
    await ShoppingRepository(db).recordPurchase(listId: id, plannedItemId: item, name: 'MILK', normalizedName: 'milk',
      quantity: DecimalFixed.fromInt(2), unitCode: 'kilogram', lineTotalMinor: 3000);
    final c = ReceiptReviewController(db: db, listId: id,
      parseResult: ReceiptParser().parse(scan(['MILK 1L X20,00 20,00'])));
    addTearDown(c.dispose); c.linkLine(0, item);
    await expectLater(c.commit(), throwsA(isA<UnsupportedConversionError>()));
    final before = await db.select(db.purchaseEntries).get();
    expect(before.single.actualLineTotalMinorUnits, 3000);
    c.unlinkLine(0);
    await c.commit();
    final after = await db.select(db.purchaseEntries).get();
    expect(after, hasLength(2));
    expect(after.last.actualUnitCode, 'litre');
  });

  test('foreign or mixed receipt currency cannot write a list in the selected currency', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    for (final lines in [ ['MILK 4.99 EUR', 'TOTAL 4.99 EUR'], ['MILK 4.99 EUR', 'BREAD 10,00 TL'] ]) {
      final parsed = ReceiptParser(currency: 'TRY').parse(scan(lines));
      final c = ReceiptReviewController(db: db, currencyCode: 'TRY', parseResult: parsed);
      addTearDown(c.dispose);
      for (var i = 0; i < c.lines.length; i++) { c.accept(i); }
      await expectLater(c.commit(), throwsArgumentError);
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
    }
  });
}
