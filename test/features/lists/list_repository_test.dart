import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/list_status.dart';

void main() {
  late AppDatabase db;
  late ListRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ListRepository(db);
  });

  tearDown(() async => db.close());

  Future<int> insertItem(int listId, String name,
      {int lineTotalMinor = 1000}) {
    return db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: name,
            normalizedName: name.toLowerCase(),
            plannedQuantity: '1',
            plannedUnitCode: 'adet',
            pricingInputMode: 'lineTotal',
            plannedLineTotalMinorUnits: Value(lineTotalMinor),
          ),
        );
  }

  group('oluşturma ve güncelleme', () {
    test('başlık boşsa generatedTitle ile kurulur', () async {
      final id = await repo.createList(
        generatedTitle: '2026-09-20 alışverişi',
        currencyCode: 'TRY',
        budgetMinorUnits: 50000,
      );
      final list = await repo.getById(id);
      expect(list.title, isNull);
      expect(list.generatedTitle, '2026-09-20 alışverişi');
      expect(list.status, 'draft');
      expect(list.budgetMinorUnits, 50000);
    });

    test('durum geçişi kurala uyar; kural dışı StateError verir', () async {
      final id = await repo.createList(currencyCode: 'TRY');
      await repo.changeStatus(id, ListStatus.planned);
      final planned = await repo.getById(id);
      expect(planned.status, 'planned');

      expect(
        () => repo.changeStatus(id, ListStatus.completed),
        throwsStateError,
      );
    });

    test('tamamlama completedAt damgası basar; arşivleme archivedAt', () async {
      final id = await repo.createList(currencyCode: 'TRY');
      await repo.changeStatus(id, ListStatus.planned);
      await repo.changeStatus(id, ListStatus.shopping);
      await repo.changeStatus(id, ListStatus.completed);
      expect((await repo.getById(id)).completedAt, isNotNull);
      await repo.changeStatus(id, ListStatus.archived);
      expect((await repo.getById(id)).archivedAt, isNotNull);
    });
  });

  group('çoğaltma', () {
    test('kopya taslaktır; ürünler pending kopyalanır', () async {
      final id = await repo.createList(
          title: 'Haftalık', currencyCode: 'TRY', budgetMinorUnits: 10000);
      await repo.changeStatus(id, ListStatus.planned);
      await repo.changeStatus(id, ListStatus.shopping);
      await insertItem(id, 'Süt');

      final copyId = await repo.duplicateList(id, generatedTitle: 'Kopya');
      final copy = await repo.getById(copyId);
      expect(copy.id, isNot(id));
      expect(copy.status, 'draft');
      expect(copy.completedAt, isNull);
      expect(copy.budgetMinorUnits, 10000);

      final copyItems =
          await (db.select(db.plannedItems)
                ..where((t) => t.listId.equals(copyId)))
              .get();
      expect(copyItems, hasLength(1));
      expect(copyItems.single.status, 'pending');
      expect(copyItems.single.name, 'Süt');
    });
  });

  group('para birimi değişimi (spec §7.1)', () {
    test('rakamları koru: değerler aynı kalır', () async {
      final id = await repo.createList(
          currencyCode: 'TRY', budgetMinorUnits: 25000);
      await insertItem(id, 'Ekmek', lineTotalMinor: 1500);

      await repo.changeCurrency(id, 'USD', resetAmounts: false);

      final list = await repo.getById(id);
      expect(list.currencyCode, 'USD');
      expect(list.budgetMinorUnits, 25000);
      final items = await db.select(db.plannedItems).get();
      expect(items.single.plannedLineTotalMinorUnits, 1500);
    });

    test('rakamları sıfırla: bütçe ve planlı tutarlar temizlenir', () async {
      final id = await repo.createList(
          currencyCode: 'TRY', budgetMinorUnits: 25000);
      await insertItem(id, 'Ekmek', lineTotalMinor: 1500);

      await repo.changeCurrency(id, 'USD', resetAmounts: true);

      final list = await repo.getById(id);
      expect(list.currencyCode, 'USD');
      expect(list.budgetMinorUnits, isNull);
      final items = await db.select(db.plannedItems).get();
      expect(items.single.plannedLineTotalMinorUnits, isNull);
    });
  });

  group('silme ve geri alma', () {
    test('silme çocuk ürünleri kaldırır; undo aynı kimlikle geri yükler',
        () async {
      final id = await repo.createList(title: 'Silinecek', currencyCode: 'TRY');
      final itemId = await insertItem(id, 'Peynir');

      final snapshot = await repo.deleteList(id);
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      expect(await db.select(db.plannedItems).get(), isEmpty);

      await repo.undoDelete(snapshot);
      final restored = await repo.getById(id);
      expect(restored.title, 'Silinecek');
      final items = await db.select(db.plannedItems).get();
      expect(items.single.id, itemId);
    });
  });
}
