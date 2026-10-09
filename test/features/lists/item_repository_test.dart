import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/item_form_sheet.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/starter_categories.dart';
import 'package:nshoptor/features/shopping_mode/shopping_repository.dart';

void main() {
  late AppDatabase db;
  late ItemRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ItemRepository(db);
  });

  tearDown(() async {
    // Widget testleri FakeAsync'te çalıştığından close()'u yalnız birim
    // testlerde bekleyerek kapatıyoruz.
    await db.close();
  });

  Future<int> makeList() => db.into(db.shoppingLists).insert(
        ShoppingListsCompanion.insert(
          title: const Value('Test'),
          currencyCode: 'TRY',
        ),
      );

  group('ItemRepository (spec §6.2)', () {
    test('update keeps ID and rejects foreign list; delete removes linked purchases and observations', () async {
      final listId = await makeList();
      final id = await repo.addItem(listId: listId, name: 'Milk', quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece', priceIsUnitPrice: false, price: DecimalFixed.zero());
      await repo.addItem(listId: listId, existingId: id, name: 'Milk 2', quantity: DecimalFixed.fromInt(2),
        unitCode: 'piece', priceIsUnitPrice: false, price: DecimalFixed.fromInt(30));
      expect(await repo.getItems(listId), hasLength(1));
      final other = await makeList();
      await expectLater(repo.addItem(listId: other, existingId: id, name: 'Bad', quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece', priceIsUnitPrice: false), throwsArgumentError);
      await ShoppingRepository(db).recordPurchase(listId: listId, plannedItemId: id, name: 'Milk 2', normalizedName: 'milk2',
        quantity: DecimalFixed.fromInt(2), unitCode: 'piece', lineTotalMinor: 3200);
      await repo.removeItem(id);
      expect(await db.select(db.plannedItems).get(), isEmpty);
      expect(await db.select(db.purchaseEntries).get(), isEmpty);
      expect(await db.select(db.priceObservations).get(), isEmpty);
    });

    test('null and zero prices differ; boundary rejects zero quantity and negative price', () async {
      final listId = await makeList();
      await repo.addItem(listId: listId, name: 'Free', quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece', priceIsUnitPrice: true, price: DecimalFixed.zero());
      await repo.addItem(listId: listId, name: 'Unknown', quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece', priceIsUnitPrice: true);
      final items = await repo.getItems(listId);
      expect(items.first.plannedLineTotalMinorUnits, 0);
      expect(items.last.plannedLineTotalMinorUnits, isNull);
      await expectLater(repo.addItem(listId: listId, name: 'Bad', quantity: DecimalFixed.zero(),
        unitCode: 'piece', priceIsUnitPrice: true), throwsArgumentError);
      await expectLater(repo.addItem(listId: listId, name: 'Bad', quantity: DecimalFixed.fromInt(1),
        unitCode: 'piece', priceIsUnitPrice: true, price: DecimalFixed.fromInt(-1)), throwsArgumentError);
    });
    test('birim fiyat girilince satır toplamı hesaplanır', () async {
      final listId = await makeList();
      final id = await repo.addItem(
        listId: listId,
        name: 'Domates',
        quantity: DecimalFixed.parse('1.5'),
        unitCode: 'kilogram',
        priceIsUnitPrice: true,
        price: DecimalFixed.parse('42.90'),
      );
      final item = await (db.select(db.plannedItems)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      expect(item.pricingInputMode, 'unitPrice');
      expect(item.plannedUnitPrice, '42.90');
      expect(item.plannedLineTotalMinorUnits, 6435);
    });

    test('satır toplamı girilince birim fiyat hesaplanır', () async {
      final listId = await makeList();
      final id = await repo.addItem(
        listId: listId,
        name: 'Süt',
        quantity: DecimalFixed.parse('3'),
        unitCode: 'adet',
        priceIsUnitPrice: false,
        price: DecimalFixed.parse('59.97'),
      );
      final item = await (db.select(db.plannedItems)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      expect(item.pricingInputMode, 'lineTotal');
      expect(item.plannedLineTotalMinorUnits, 5997);
      expect(
        DecimalFixed.parse(item.plannedUnitPrice!),
        DecimalFixed.parse('19.99'),
      );
    });

    test('normalize ad Türkçe karakterleri katlar', () {
      expect(
        normalizeItemName('Türk Çayı Şişe'),
        'turk cayi sise',
      );
      expect(normalizeItemName('牛乳'), '牛乳');
      expect(normalizeItemName('حليب'), 'حليب');
      expect(normalizeItemName('Γάλα'), 'γάλα');
    });

    test('planlanan toplam satırların minor toplamıdır', () async {
      final listId = await makeList();
      await repo.addItem(
          listId: listId,
          name: 'A',
          quantity: DecimalFixed.parse('1'),
          unitCode: 'adet',
          priceIsUnitPrice: true,
          price: DecimalFixed.parse('10.00'));
      await repo.addItem(
          listId: listId,
          name: 'B',
          quantity: DecimalFixed.parse('2'),
          unitCode: 'adet',
          priceIsUnitPrice: true,
          price: DecimalFixed.parse('5.50'));
      expect(await repo.plannedTotalMinor(listId), 2100);
    });
  });

  group('StarterCategories', () {
    test('boş tabloya 9 kategori ekler; ikinci çağrı eklemez', () async {
      final starter = StarterCategories();
      await starter.seedIfEmpty(db);
      expect(await db.select(db.categories).get(), hasLength(9));
      await starter.seedIfEmpty(db);
      expect(await db.select(db.categories).get(), hasLength(9));
      expect(starter.labelOf(_TrL10n(), 'dairy'), 'Süt ürünleri');
      expect(starter.labelOf(_TrL10n(), 'özel'), 'özel');
    });
  });

  group('birim tam sayı tercihi', () {
    test('adet/düzine tam sayı ister; kg ondalıklı kabul eder', () {
      expect(unitPrefersInteger(UnitCode.adet), isTrue);
      expect(unitPrefersInteger(UnitCode.duzine), isTrue);
      expect(unitPrefersInteger(UnitCode.kilogram), isFalse);
      expect(unitPrefersInteger(UnitCode.litre), isFalse);
    });
  });
}

/// labelOf için AppLocalizations taklidi (yalnız kullanılan alanlar).
class _TrL10n implements AppLocalizations {
  @override
  String get categoryProduce => 'Meyve-sebze';
  @override
  String get categoryDairy => 'Süt ürünleri';
  @override
  String get categoryMeat => 'Et';
  @override
  String get categoryBakery => 'Fırın';
  @override
  String get categoryDrinks => 'İçecek';
  @override
  String get categoryCleaning => 'Temizlik';
  @override
  String get categoryPersonalCare => 'Kişisel bakım';
  @override
  String get categoryHome => 'Ev';
  @override
  String get categoryOther => 'Diğer';

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
