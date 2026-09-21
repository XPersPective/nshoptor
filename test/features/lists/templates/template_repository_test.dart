import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/templates/template_repository.dart';

void main() {
  late AppDatabase db;
  late TemplateRepository templates;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    templates = TemplateRepository(db);
  });

  tearDown(() => db.close());

  Future<int> makeCompletedListWithEntries() async {
    final listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(
            title: const Value('Geçen hafta'),
            currencyCode: 'TRY',
          ),
        );
    await (db.update(db.shoppingLists)..where((t) => t.id.equals(listId)))
        .write(const ShoppingListsCompanion(status: Value('completed')));

    // Domates: plan 1,5 × 42,90; gerçek 2 × 45,00 = 9000.
    final tomatoId = await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: 'Domates',
            normalizedName: 'domates',
            plannedQuantity: '1.5',
            plannedUnitCode: 'kilogram',
            pricingInputMode: 'unitPrice',
            plannedUnitPrice: const Value('42.90'),
            plannedLineTotalMinorUnits: const Value(6435),
          ),
        );
    await db.into(db.purchaseEntries).insert(
          PurchaseEntriesCompanion.insert(
            listId: listId,
            plannedItemId: Value(tomatoId),
            name: 'Domates',
            normalizedName: 'domates',
            actualQuantity: '2',
            actualUnitCode: 'kilogram',
            actualUnitPrice: const Value('45.00'),
            actualLineTotalMinorUnits: 9000,
            source: const Value('manual'),
            userConfirmed: const Value(true),
          ),
        );

    // Süt: hiç alınmadı (kayıt yok) → plan değerleriyle kopyalanır.
    await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: 'Süt',
            normalizedName: 'sut',
            plannedQuantity: '2',
            plannedUnitCode: 'adet',
            pricingInputMode: 'unitPrice',
            plannedUnitPrice: const Value('32.00'),
            plannedLineTotalMinorUnits: const Value(6400),
          ),
        );
    return listId;
  }

  test('gerçek alımlardan taslak plan üretilir', () async {
    final sourceId = await makeCompletedListWithEntries();

    final planId = await templates.createPlanFromActuals(sourceId,
        title: 'Bu hafta');
    final plan = await (db.select(db.shoppingLists)
          ..where((t) => t.id.equals(planId)))
        .getSingle();

    expect(plan.id, isNot(sourceId));
    expect(plan.status, 'draft'); // durum taslak
    expect(plan.completedAt, isNull);
    expect(plan.title, 'Bu hafta');

    final items = await (db.select(db.plannedItems)
          ..where((t) => t.listId.equals(planId)))
        .get();
    expect(items, hasLength(2));

    final domates = items.firstWhere((i) => i.name == 'Domates');
    // Gerçek miktar ve birim fiyat tahmine dönüştü:
    expect(domates.plannedQuantity, '2');
    expect(domates.plannedUnitPrice, '45.00');
    expect(domates.plannedLineTotalMinorUnits, 9000);

    final sut = items.firstWhere((i) => i.name == 'Süt');
    // Alınmayan ürün plan değerleriyle korunur:
    expect(sut.plannedQuantity, '2');
    expect(sut.plannedUnitPrice, '32.00');
    expect(sut.plannedLineTotalMinorUnits, 6400);

    // Kayıtlar kopyalanmaz.
    final entries = await db.select(db.purchaseEntries).get();
    expect(entries, hasLength(1)); // yalnız kaynak listedeki kayıt
  });

  test('şablon işareti AppSettings\'te saklanır ve kalkar', () async {
    final listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(currencyCode: 'TRY'),
        );
    expect(await templates.templateIds(), isEmpty);

    await templates.markTemplate(listId);
    expect(await templates.templateIds(), [listId]);

    await templates.markTemplate(listId); // idempotent
    expect(await templates.templateIds(), [listId]);

    await templates.unmarkTemplate(listId);
    expect(await templates.templateIds(), isEmpty);
  });
}
