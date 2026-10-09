import 'package:drift/native.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';
import 'package:nshoptor/features/shopping_mode/item_status.dart';

void main() {
  late AppDatabase db;
  late int listId;
  late int itemId;
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    listId = await db
        .into(db.shoppingLists)
        .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
    itemId = await db
        .into(db.plannedItems)
        .insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: 'Tomato',
            normalizedName: 'tomato',
            plannedQuantity: '2',
            plannedUnitCode: 'kilogram',
            pricingInputMode: 'lineTotal',
          ),
        );
  });
  tearDown(() => db.close());

  test('standalone receipt has no list before approval; rollback then concurrent retry is idempotent', () async {
    final c = ReceiptReviewController(db: db, currencyCode: 'TRY', title: 'Receipt',
      parseResult: ReceiptParser().parse(const OcrScanResult(lines: [OcrLine(text: 'MILK 10,00'), OcrLine(text: 'BREAD 5,00')])));
    addTearDown(c.dispose);
    await c.prefillSuggestions();
    expect(c.listId, isNull); expect(await db.select(db.shoppingLists).get(), hasLength(1));
    c.accept(0); c.accept(1); c.lines[1].name = '';
    await expectLater(c.commit(), throwsArgumentError);
    expect(c.listId, isNull); expect(await db.select(db.shoppingLists).get(), hasLength(1));
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    c.lines[1].name = 'Bread';
    await Future.wait([c.commit(), c.commit()]); await c.commit();
    expect(c.listId, isNotNull); expect(await db.select(db.shoppingLists).get(), hasLength(2));
    final entries = await db.select(db.purchaseEntries).get();
    expect(entries, hasLength(2)); expect(entries.fold<int>(0, (s, e) => s + e.actualLineTotalMinorUnits), 1500);
    expect(entries.every((e) => e.plannedItemId == null && e.listId == c.listId), isTrue);
    expect((await ShoppingRepository(db).getList(c.listId!)).status, 'shopping');
  });

  test('empty or foreign-linked standalone receipt cannot allocate a list', () async {
    final c = ReceiptReviewController(db: db,
      parseResult: ReceiptParser().parse(const OcrScanResult(lines: [OcrLine(text: 'MILK 10,00')])));
    addTearDown(c.dispose);
    await expectLater(c.commit(), throwsArgumentError);
    c.linkLine(0, itemId);
    await expectLater(c.commit(), throwsArgumentError);
    expect(c.listId, isNull); expect(await db.select(db.shoppingLists).get(), hasLength(1));
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
  });

  Future<void> manual({int? targetListId, String name = 'Tomato'}) =>
      ShoppingRepository(db).recordPurchase(
        listId: targetListId ?? listId,
        plannedItemId: itemId,
        name: name,
        normalizedName: 'tomato',
        quantity: DecimalFixed.fromInt(2),
        unitCode: 'kilogram',
        lineTotalMinor: 3000,
      );

  test('overflowing replacement preserves the existing purchase and price observation', () async {
    await manual();
    final before = (await db.select(db.purchaseEntries).get()).single;
    final observation = (await db.select(db.priceObservations).get()).single;
    await expectLater(ShoppingRepository(db).recordPurchase(listId: listId, plannedItemId: itemId,
      name: 'Tomato', normalizedName: 'tomato', unitCode: 'kilogram',
      quantity: DecimalFixed.parse('999999999999999'), unitPrice: DecimalFixed.parse('999999999999999')),
      throwsFormatException);
    final after = (await db.select(db.purchaseEntries).get()).single;
    expect(after.id, before.id); expect(after.actualLineTotalMinorUnits, before.actualLineTotalMinorUnits);
    final preserved = (await db.select(db.priceObservations).get()).single;
    expect(preserved.id, observation.id); expect(preserved.unitPrice, observation.unitPrice);
  });

  ReceiptReviewController receipt() {
    final c = ReceiptReviewController(
      db: db,
      listId: listId,
      parseResult: ReceiptParser().parse(
        const OcrScanResult(
          lines: [
            OcrLine(text: 'TOMATO 20,00'),
            OcrLine(text: 'TOMATO 12,00'),
          ],
        ),
      ),
    );
    for (var i = 0; i < c.lines.length; i++) {
      c.linkLine(i, itemId);
    }
    return c;
  }

  test(
    'manual 30 + receipt 20+12 replaces once, concurrent/repeat is idempotent',
    () async {
      await manual();
      final c = receipt();
      await Future.wait([c.commit(), c.commit()]);
      await c.commit();
      final entries = await db.select(db.purchaseEntries).get();
      expect(entries, hasLength(2));
      expect(
        entries.fold<int>(0, (s, e) => s + e.actualLineTotalMinorUnits),
        3200,
      );
      expect(entries.every((e) => e.actualUnitCode == 'kilogram'), isTrue);
      expect((await db.select(db.plannedItems).get()).single.status, 'inCart');
      final observations = await db.select(db.priceObservations).get();
      expect(observations, hasLength(2));
      expect(observations.every((e) => e.purchaseEntryId != null), isTrue);
    },
  );

  test('receipt failure rolls back replacement and allows retry', () async {
    await manual();
    final c = receipt();
    await db.customStatement(
      "CREATE TRIGGER reject_receipt BEFORE INSERT ON purchase_entries WHEN NEW.source = 'receiptOcr' BEGIN SELECT RAISE(ABORT, 'forced'); END",
    );
    await expectLater(c.commit(), throwsA(anything));
    expect(
      (await db.select(db.purchaseEntries).get())
          .single
          .actualLineTotalMinorUnits,
      3000,
    );
    expect(await db.select(db.priceObservations).get(), hasLength(1));
    await db.customStatement('DROP TRIGGER reject_receipt');
    await c.commit();
    expect(await db.select(db.purchaseEntries).get(), hasLength(2));
  });

  test(
    'cross-list links and invalid input fail before changing stored purchase',
    () async {
      await manual();
      final other = await db
          .into(db.shoppingLists)
          .insert(ShoppingListsCompanion.insert(currencyCode: 'USD'));
      await expectLater(manual(targetListId: other), throwsArgumentError);
      await expectLater(manual(name: ''), throwsArgumentError);
      final c = receipt();
      final foreign = await db
          .into(db.plannedItems)
          .insert(
            PlannedItemsCompanion.insert(
              listId: other,
              name: 'Milk',
              normalizedName: 'milk',
              plannedQuantity: '1',
              plannedUnitCode: 'piece',
              pricingInputMode: 'lineTotal',
            ),
          );
      c.linkLine(1, foreign);
      await expectLater(c.commit(), throwsArgumentError);
      expect(
        (await db.select(db.purchaseEntries).get())
            .single
            .actualLineTotalMinorUnits,
        3000,
      );
    },
  );

  test('manual replacement rollback includes observation and status', () async {
    await manual();
    final original = (await db.select(db.purchaseEntries).get()).single;
    await db.customStatement(
      "CREATE TRIGGER reject_observation BEFORE INSERT ON price_observations BEGIN SELECT RAISE(ABORT, 'forced'); END",
    );
    await expectLater(manual(), throwsA(anything));
    expect(
      (await db.select(db.purchaseEntries).get())
          .single
          .actualLineTotalMinorUnits,
      3000,
    );
    expect(await db.select(db.priceObservations).get(), hasLength(1));
    expect((await db.select(db.purchaseEntries).get()).single.id, original.id);
  });

  for (final (currency, price, minor) in [
    ('JPY', '32', 32),
    ('KWD', '3.215', 3215),
  ]) {
    test('$currency receipt keeps currency precision', () async {
      await (db.update(db.shoppingLists)..where((t) => t.id.equals(listId)))
          .write(ShoppingListsCompanion(currencyCode: Value(currency)));
      final c = ReceiptReviewController(
        db: db,
        listId: listId,
        parseResult: ReceiptParser(currency: currency)
            .parse(OcrScanResult(lines: [OcrLine(text: 'TOMATO $price')])),
      );
      c.linkLine(0, itemId);
      await c.commit();
      expect(
        (await db.select(db.purchaseEntries).get())
            .single
            .actualLineTotalMinorUnits,
        minor,
      );
    });
  }

  test('undo removes observations tied to a purchase', () async {
    await manual();
    await ShoppingRepository(db).setItemStatus(itemId, ItemStatus.pending);
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
    expect(await db.select(db.priceObservations).get(), isEmpty);
    expect((await db.select(db.productMemory).get()).single.useCount, 0);
  });

  test(
    'receipt discount changes money without inventing returned quantity',
    () async {
      final c = ReceiptReviewController(
        db: db,
        listId: listId,
        parseResult: ReceiptParser().parse(
          const OcrScanResult(
            lines: [
              OcrLine(text: 'TOMATO 30,00'),
              OcrLine(text: 'INDIRIM 3,00'),
              OcrLine(text: 'TOPLAM 27,00'),
            ],
          ),
        ),
      );
      c.accept(0);
      c.accept(1);
      expect(c.acceptedTotalMinor, 2700);
      await c.commit();
      final entries = await db.select(db.purchaseEntries).get();
      expect(
        entries.fold<int>(0, (s, e) => s + e.actualLineTotalMinorUnits),
        2700,
      );
      expect(entries.last.actualQuantity, '0');
      expect(await db.select(db.priceObservations).get(), hasLength(1));
    },
  );

  test('unknown price has no zero-price observation; undo removes linked observations', () async {
    await ShoppingRepository(db).recordPurchase(
      listId: listId,
      plannedItemId: itemId,
      name: 'Tomato',
      normalizedName: 'tomato',
      quantity: DecimalFixed.fromInt(2),
      unitCode: 'kilogram',
    );
    expect(
      (await db.select(db.purchaseEntries).get()).single.grossTotalMinorUnits,
      isNull,
    );
    expect(await db.select(db.priceObservations).get(), isEmpty);
  });
}
