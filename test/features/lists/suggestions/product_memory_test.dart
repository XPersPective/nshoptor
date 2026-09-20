import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/suggestions/paste_parser.dart';
import 'package:nshoptor/features/lists/suggestions/product_memory_repository.dart';

void main() {
  late AppDatabase db;
  late ProductMemoryRepository memory;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    memory = ProductMemoryRepository(db);
  });

  tearDown(() => db.close());

  group('fiyat gözlemi + ürün hafızası (spec §6.10)', () {
    test('doğrulanmış kayıt gözlem yazar ve useCount artar', () async {
      await memory.recordObservation(
        name: 'Süt',
        normalizedName: 'sut',
        listId: 1,
        quantity: '2',
        unitCode: 'adet',
        unitPrice: '32.00',
        lineTotalMinor: 6400,
        currencyCode: 'TRY',
      );
      await memory.recordObservation(
        name: 'Süt',
        normalizedName: 'sut',
        listId: 1,
        quantity: '1',
        unitCode: 'adet',
        unitPrice: '30.00',
        lineTotalMinor: 3000,
        currencyCode: 'TRY',
      );

      final products = await db.select(db.productMemory).get();
      expect(products, hasLength(1)); // aynı normalize ad → tek hafıza
      expect(products.single.useCount, 2);
      expect(products.single.lastUsedAt, isNotNull);

      final observations = await db.select(db.priceObservations).get();
      expect(observations, hasLength(2));
      expect(observations.every((o) => o.currencyCode == 'TRY'), isTrue);
    });

    test('son ödenen fiyat: genel ve mağaza bazlı', () async {
      // FK: gözlemlerin mağazaları gerçek kayıt olmalı.
      await db.into(db.stores).insert(StoresCompanion.insert(name: 'Market A', sortOrder: const Value(1)));
      await db.into(db.stores).insert(StoresCompanion.insert(name: 'Market B', sortOrder: const Value(2)));
      final productId = await db.into(db.productMemory).insert(
            ProductMemoryCompanion.insert(
              canonicalName: 'Yumurta',
              normalizedName: 'yumurta',
            ),
          );
      await db.into(db.priceObservations).insert(
            PriceObservationsCompanion.insert(
              productId: Value(productId),
              quantity: '1',
              unitCode: 'adet',
              unitPrice: '45.00',
              lineTotalMinorUnits: 4500,
              currencyCode: 'TRY',
              source: 'manual',
              storeId: const Value(1),
              observedAt: Value(DateTime(2026, 9, 1)),
            ),
          );
      await db.into(db.priceObservations).insert(
            PriceObservationsCompanion.insert(
              productId: Value(productId),
              quantity: '1',
              unitCode: 'adet',
              unitPrice: '42.00',
              lineTotalMinorUnits: 4200,
              currencyCode: 'TRY',
              source: 'manual',
              storeId: const Value(2),
              observedAt: Value(DateTime(2026, 9, 10)),
            ),
          );

      // Genel son: en yeni kayıt (store 2, 42.00).
      final latest = await memory.lastObservation(productId);
      expect(latest!.unitPrice, '42.00');
      // Mağaza 1 filtresi: 45.00 döner.
      final store1 = await memory.lastObservation(productId, storeId: 1);
      expect(store1!.unitPrice, '45.00');
      // Mağaza 3: kayıt yok → null (fiyat uydurulmaz).
      expect(await memory.lastObservation(productId, storeId: 3), isNull);
    });
  });

  group('öneriler (spec §6.2)', () {
    test('useCount ve lastUsedAt önceliğiyle sıralanır', () async {
      for (final (name, count) in const [
        ('süt', 1),
        ('ekmek', 5),
        ('peynir', 3),
      ]) {
        for (var i = 0; i < count; i++) {
          await memory.recordObservation(
            name: name,
            normalizedName: name,
            listId: 1,
            quantity: '1',
            unitCode: 'adet',
            unitPrice: '10.00',
            lineTotalMinor: 1000,
            currencyCode: 'TRY',
          );
        }
      }

      final suggestions = await memory.suggestNames('');
      expect(suggestions.map((p) => p.canonicalName).toList(),
          ['ekmek', 'peynir', 'süt']);

      final e = await memory.suggestNames('ek');
      expect(e.single.canonicalName, 'ekmek');
    });

    test('favori işaretlenir ve listelenir', () async {
      final id = await db.into(db.productMemory).insert(
            ProductMemoryCompanion.insert(
              canonicalName: 'Kahve',
              normalizedName: 'kahve',
              favorite: const Value(true),
            ),
          );
      final favs = await memory.favorites();
      expect(favs.single.id, id);
      await memory.setFavorite(id, false);
      expect(await memory.favorites(), isEmpty);
    });
  });

  group('yinelenen ürün (spec §6.2)', () {
    test('aynı normalize adda ürün varsa bulunur', () async {
      final listId = await db.into(db.shoppingLists).insert(
            ShoppingListsCompanion.insert(currencyCode: 'TRY'),
          );
      await db.into(db.plannedItems).insert(
            PlannedItemsCompanion.insert(
              listId: listId,
              name: 'Süt',
              normalizedName: 'sut',
              plannedQuantity: '1',
              plannedUnitCode: 'adet',
              pricingInputMode: 'unitPrice',
            ),
          );
      final dup = await memory.findDuplicateInList(listId, 'sut');
      expect(dup, isNotNull);
      expect(await memory.findDuplicateInList(listId, 'ekmek'), isNull);
    });
  });

  group('çok satırlı yapıştırma (spec §6.2)', () {
    test('her boş olmayan satır bir adaydır', () {
      final candidates =
          parsePastedLines('Süt\nEkmek\n\n  Peynir  \r\nDomates');
      expect(candidates.map((c) => c.name).toList(),
          ['Süt', 'Ekmek', 'Peynir', 'Domates']);
    });

    test('boş metin aday üretmez', () {
      expect(parsePastedLines('\n  \n'), isEmpty);
    });
  });
}
