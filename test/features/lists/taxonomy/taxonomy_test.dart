import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/taxonomy/category_suggester.dart';
import 'package:nshoptor/features/lists/taxonomy/item_sort.dart';
import 'package:nshoptor/features/lists/taxonomy/taxonomy_repository.dart';

void main() {
  late AppDatabase db;
  late TaxonomyRepository taxonomy;
  late CategorySuggester suggester;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    taxonomy = TaxonomyRepository(db);
    suggester = CategorySuggester(db);
  });

  tearDown(() => db.close());

  Future<int> addItem({
    required int listId,
    required String name,
    int? categoryId,
    int? aisleId,
    int sortOrder = 0,
  }) {
    return db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: name,
            normalizedName: name.toLowerCase(),
            plannedQuantity: '1',
            plannedUnitCode: 'adet',
            pricingInputMode: 'unitPrice',
            categoryId: Value(categoryId),
            aisleId: Value(aisleId),
            sortOrder: Value(sortOrder),
          ),
        );
  }

  group('CRUD ve sıra kalıcılığı', () {
    test('mağaza ekle/yeniden adlandır/sırala: sıra kalıcıdır', () async {
      final a = await taxonomy.createStore('Market A');
      final b = await taxonomy.createStore('Market B');
      final c = await taxonomy.createStore('Market C');

      await taxonomy.reorderStores([c, a, b]);
      final stores = await taxonomy.getStores();
      expect(stores.map((s) => s.name).toList(), ['Market C', 'Market A', 'Market B']);
      expect(stores.map((s) => s.sortOrder).toList(), [0, 1, 2]);
      // kimlikler korunur
      expect(stores.map((s) => s.id).toSet(), {a, b, c});

      await taxonomy.renameStore(a, 'Market A2');
      expect((await taxonomy.getStores()).firstWhere((s) => s.id == a).name,
          'Market A2');

      await taxonomy.deleteStore(b);
      expect((await taxonomy.getStores()).length, 2);
    });

    test('kategori sırası kalıcıdır', () async {
      final k1 = await taxonomy.createCategory('Meyve-sebze');
      final k2 = await taxonomy.createCategory('Süt ürünleri');
      await taxonomy.reorderCategories([k2, k1]);
      final cats = await taxonomy.getCategories();
      expect(cats.first.name, 'Süt ürünleri');
      expect(cats.last.name, 'Meyve-sebze');
    });
  });

  group('mağaza bazlı reyon sırası (spec §6.3)', () {
    test('her mağazanın kendi sırası hatırlanır', () async {
      final m1 = await taxonomy.createStore('Market 1');
      final m2 = await taxonomy.createStore('Market 2');

      // Her reyon satırı bir mağazaya aittir; sıra o mağazaya özeldir.
      final manav1 = await taxonomy.createAisle('Manav', storeId: m1);
      final sut1 = await taxonomy.createAisle('Süt reyonu', storeId: m1);
      final firin1 = await taxonomy.createAisle('Fırın', storeId: m1);
      final sut2 = await taxonomy.createAisle('Süt reyonu', storeId: m2);

      // Market 1'de sıra: Manav, Fırın, Süt
      await taxonomy.reorderAisles(m1, [manav1, firin1, sut1]);
      final aisles1 = await taxonomy.getAisles(storeId: m1);
      expect(aisles1.map((a) => a.name).toList(), ['Manav', 'Fırın', 'Süt reyonu']);

      // Market 2'de sıra bağımsız: Süt önce.
      await taxonomy.reorderAisles(m2, [sut2]);
      final aisles2 = await taxonomy.getAisles(storeId: m2);
      expect(aisles2.map((a) => a.name).toList(), ['Süt reyonu']);

      // Market 1'in sırası değişmedi (mağaza bazlı kalıcılık).
      final aisles1Again = await taxonomy.getAisles(storeId: m1);
      expect(aisles1Again.map((a) => a.name).toList(),
          ['Manav', 'Fırın', 'Süt reyonu']);

      await taxonomy.deleteAisle(firin1);
      expect((await taxonomy.getAisles(storeId: m1)).length, 2);
    });
  });

  group('liste sıralama modları (spec §6.3)', () {
    late int listId;
    late List<Category> cats;
    late List<Aisle> aisles;

    setUp(() async {
      listId = await db
          .into(db.shoppingLists)
          .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
      final k1 = await taxonomy.createCategory('Meyve-sebze', sortOrder: 0);
      final k2 = await taxonomy.createCategory('Süt ürünleri', sortOrder: 1);
      cats = await taxonomy.getCategories();

      final firinId = await taxonomy.createAisle('Fırın', sortOrder: 0);
      final manavId = await taxonomy.createAisle('Manav', sortOrder: 1);
      aisles = await taxonomy.getAisles();

      // ekleyelim: Ekmek (fırın, kategori 2 yok→diğer), Domates (manav, k1)
      await addItem(
          listId: listId, name: 'Ekmek', categoryId: k2, aisleId: firinId, sortOrder: 2);
      await addItem(
          listId: listId, name: 'Domates', categoryId: k1, aisleId: manavId, sortOrder: 1);
      await addItem(listId: listId, name: 'Süt', sortOrder: 0);
    });

    test('kategori modu kategori sırasına göre dizer', () async {
      final items = await db.select(db.plannedItems).get();
      final sorted = sortItems(items, ItemSortMode.category, categories: cats);
      expect(sorted.map((i) => i.name).toList(), ['Domates', 'Ekmek', 'Süt']);
    });

    test('alfabetik mod normalize ada göre dizer', () async {
      final items = await db.select(db.plannedItems).get();
      final sorted = sortItems(items, ItemSortMode.alphabetical);
      expect(sorted.map((i) => i.name).toList(), ['Domates', 'Ekmek', 'Süt']);
    });

    test('özel mod kullanıcının sortOrder unu korur', () async {
      final items = await db.select(db.plannedItems).get();
      final sorted = sortItems(items, ItemSortMode.custom);
      expect(sorted.map((i) => i.name).toList(), ['Süt', 'Domates', 'Ekmek']);
    });

    test('mağaza reyonu modu reyon sırasına göre dizer; reyonsuz en son', () async {
      final items = await db.select(db.plannedItems).get();
      final sorted = sortItems(items, ItemSortMode.storeAisle, aisles: aisles);
      expect(sorted.map((i) => i.name).toList(), ['Ekmek', 'Domates', 'Süt']);
    });
  });

  group('kategori önerisi (spec §6.3)', () {
    test('hafızadan öğrenilir ve önerilir', () async {
      final k1 = await taxonomy.createCategory('Meyve-sebze');
      await suggester.learnDefaultCategory('Domates', 'domates', k1);
      expect(await suggester.suggestCategory('domates'), k1);
      // bilinmeyen ürün → null öneri (kesin kabul edilmez)
      expect(await suggester.suggestCategory('muz'), isNull);
      // öğrenme güncellenir
      final k2 = await taxonomy.createCategory('Diğer');
      await suggester.learnDefaultCategory('Domates', 'domates', k2);
      expect(await suggester.suggestCategory('domates'), k2);
    });
  });
}
