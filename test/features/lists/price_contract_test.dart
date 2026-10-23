import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';
import 'package:nshoptor/features/shopping_mode/item_status.dart';
import 'package:nshoptor/features/voice_input/parser/parsed_item_candidate.dart';

void main() {
  late AppDatabase db;
  late ItemRepository items;
  late int listId;
  final d = DecimalFixed.parse;
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    items = ItemRepository(db);
    listId = await ListRepository(db).createList(currencyCode: 'TRY');
  });
  tearDown(() => db.close());
  test(
    '400g350 and two packs260 store exact totals and canonical unit prices',
    () async {
      await items.addItem(
        listId: listId,
        name: 'Kıyma',
        quantity: d('400'),
        unitCode: 'gram',
        priceIsUnitPrice: false,
        price: d('350'),
      );
      await items.addItem(
        listId: listId,
        name: 'Sigara',
        quantity: d('2'),
        unitCode: 'package',
        priceIsUnitPrice: false,
        price: d('260'),
      );
      final rows = await items.getItems(listId);
      expect(rows.first.plannedLineTotalMinorUnits, 35000);
      expect(d(rows.first.plannedUnitPrice!), d('0.875'));
      expect(rows.last.plannedLineTotalMinorUnits, 26000);
      expect(d(rows.last.plannedUnitPrice!), d('130'));
      expect(await items.plannedTotalMinor(listId), 61000);
    },
  );
  test(
    'shelf perkg market price does not overwrite selected-quantity estimate',
    () async {
      final id = await items.addItem(
        listId: listId,
        name: 'Elma',
        quantity: d('2'),
        unitCode: 'kilogram',
        priceIsUnitPrice: false,
        price: d('100'),
      );
      await items.addCandidates(listId, [
        ParsedItemCandidate(
          name: 'Elma',
          rawText: 'market elma kilosu45TL',
          unitPrice: d('45'),
          isUnitPrice: true,
          priceUnitCode: UnitCode.kilogram,
          priceDestination: VoicePriceDestination.actual,
        ),
      ]);
      final row = (await items.getItems(listId)).single;
      expect(row.id, id);
      expect(row.plannedLineTotalMinorUnits, 10000);
      var entry = (await db.select(db.purchaseEntries).get()).single;
      expect(entry.actualLineTotalMinorUnits, 9000);
      expect(entry.pricingInputMode, 'unitPrice');
      expect(hasMarketPrice(entry), isTrue);
      await ShoppingRepository(db).recordPurchase(
        listId: listId,
        plannedItemId: id,
        name: 'Elma',
        normalizedName: 'elma',
        quantity: d('2'),
        unitCode: 'kilogram',
      );
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      expect(
        (await items.getItems(listId)).single.plannedLineTotalMinorUnits,
        10000,
      );
    },
  );
  test(
    '400g perkg actual conversion and receipt2x130 retain economic totals',
    () async {
      await items.addCandidates(listId, [
        ParsedItemCandidate(
          name: 'Kıyma',
          rawText: '',
          quantity: d('400'),
          unitCode: UnitCode.gram,
          unitPrice: d('875'),
          isUnitPrice: true,
          priceUnitCode: UnitCode.kilogram,
          priceDestination: VoicePriceDestination.actual,
        ),
      ]);
      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(entry.actualLineTotalMinorUnits, 35000);
      expect(d(entry.actualUnitPrice!), d('0.875'));
      await ShoppingRepository(db).recordPurchase(
        listId: listId,
        name: 'Sigara',
        normalizedName: 'sigara',
        quantity: d('2'),
        unitCode: 'package',
        unitPrice: d('130'),
        lineTotalMinor: 26000,
        source: 'receipt',
      );
      final receipt = (await db.select(db.purchaseEntries).get()).last;
      expect(receipt.actualLineTotalMinorUnits, 26000);
      expect(receipt.pricingInputMode, 'lineTotal');
    },
  );
  test(
    'known zero stays purchased; missing price never becomes zero',
    () async {
      await items.addCandidates(listId, [
        ParsedItemCandidate(
          name: 'Su',
          rawText: '',
          quantity: d('2'),
          unitCode: UnitCode.sise,
          unitPrice: d('0'),
          isUnitPrice: false,
          priceDestination: VoicePriceDestination.actual,
        ),
      ]);
      final entry = (await db.select(db.purchaseEntries).get()).single;
      expect(entry.actualLineTotalMinorUnits, 0);
      expect(hasMarketPrice(entry), isTrue);
      expect(
        (await items.getItems(listId)).single.plannedLineTotalMinorUnits,
        isNull,
      );
    },
  );
}
