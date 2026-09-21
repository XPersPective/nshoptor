import 'package:drift/drift.dart';

import '../../data/db/app_database.dart';
import 'reminders/reminders_repository.dart';
import 'list_status.dart';

/// Alışveriş listesi işlemleri: CRUD, çoğaltma, para birimi değişimi,
/// geri alınabilir silme (spec §6.1, §7.1).
class ListRepository {
  ListRepository(this._db, {this._reminders});

  final AppDatabase _db;
  final RemindersRepository? _reminders;

  /// Detay ekranları gibi aynı veritabanını paylaşan bileşenler için.
  AppDatabase get db => _db;

  /// Yeni liste kurar; [generatedTitle] başlık boş bırakıldığında UI
  /// katmanı tarafından üretilip verilir (depoda çeviri üretilmez).
  Future<int> createList({
    String? title,
    String? generatedTitle,
    required String currencyCode,
    int? storeId,
    int? budgetMinorUnits,
    String? note,
    String? colorToken,
    String? iconToken,
  }) {
    return _db.into(_db.shoppingLists).insert(
          ShoppingListsCompanion.insert(
            title: Value(title),
            generatedTitle: Value(generatedTitle),
            currencyCode: currencyCode,
            storeId: Value(storeId),
            budgetMinorUnits: Value(budgetMinorUnits),
            note: Value(note),
            colorToken: Value(colorToken),
            iconToken: Value(iconToken),
          ),
        );
  }

  Future<ShoppingList> getById(int id) =>
      (_db.select(_db.shoppingLists)..where((t) => t.id.equals(id)))
          .getSingle();

  Stream<List<ShoppingList>> watchAll() =>
      _db.select(_db.shoppingLists).watch();

  Future<void> updateTitle(int id, String? title) =>
      (_db.update(_db.shoppingLists)..where((t) => t.id.equals(id))).write(
        ShoppingListsCompanion(
          title: Value(title),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> updateBudget(int id, int? budgetMinorUnits) =>
      (_db.update(_db.shoppingLists)..where((t) => t.id.equals(id))).write(
        ShoppingListsCompanion(
          budgetMinorUnits: Value(budgetMinorUnits),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> updateStore(int id, int? storeId) =>
      (_db.update(_db.shoppingLists)..where((t) => t.id.equals(id))).write(
        ShoppingListsCompanion(
          storeId: Value(storeId),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> updateNote(int id, String? note) =>
      (_db.update(_db.shoppingLists)..where((t) => t.id.equals(id))).write(
        ShoppingListsCompanion(
          note: Value(note),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Durum değişimi; kural dışı geçiş [StateError] verir.
  /// Arşivleme archivedAt'i, tamamlama completedAt'i damgalar.
  Future<void> changeStatus(int id, ListStatus next) async {
    final current =
        ListStatus.fromDb((await getById(id)).status);
    if (!current.canTransitionTo(next)) {
      throw StateError('geçersiz durum geçişi: ${current.name} → ${next.name}');
    }
    await (_db.update(_db.shoppingLists)..where((t) => t.id.equals(id))).write(
      ShoppingListsCompanion(
        status: Value(next.name),
        archivedAt: Value(next == ListStatus.archived ? DateTime.now() : null),
        completedAt:
            Value(next == ListStatus.completed ? DateTime.now() : null),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Listeyi çocuk ürünleriyle kopyalar: kopya taslaktır, tamamlama/
  /// alışveriş damgaları temizlenir; ürünler `pending` olur (spec §6.1).
  Future<int> duplicateList(int listId,
      {String? generatedTitle}) async {
    final source = await getById(listId);
    return _db.transaction(() async {
      final newId = await _db.into(_db.shoppingLists).insert(
            ShoppingListsCompanion.insert(
              title: Value(source.title),
              generatedTitle: Value(generatedTitle ?? source.generatedTitle),
              currencyCode: source.currencyCode,
              storeId: Value(source.storeId),
              budgetMinorUnits: Value(source.budgetMinorUnits),
              note: Value(source.note),
              colorToken: Value(source.colorToken),
              iconToken: Value(source.iconToken),
            ),
          );
      final items = await (_db.select(_db.plannedItems)
            ..where((t) => t.listId.equals(listId)))
          .get();
      for (final item in items) {
        await _db.into(_db.plannedItems).insert(
              PlannedItemsCompanion.insert(
                listId: newId,
                productId: Value(item.productId),
                name: item.name,
                normalizedName: item.normalizedName,
                brand: Value(item.brand),
                categoryId: Value(item.categoryId),
                aisleId: Value(item.aisleId),
                plannedQuantity: item.plannedQuantity,
                plannedUnitCode: item.plannedUnitCode,
                pricingInputMode: item.pricingInputMode,
                plannedUnitPrice: Value(item.plannedUnitPrice),
                plannedLineTotalMinorUnits:
                    Value(item.plannedLineTotalMinorUnits),
                maxAcceptablePrice: Value(item.maxAcceptablePrice),
                requiredFlag: Value(item.requiredFlag),
                note: Value(item.note),
                sortOrder: Value(item.sortOrder),
              ),
            );
      }
      return newId;
    });
  }

  /// Para birimi değişimi (spec §7.1: kur dönüşümü YAPILMAZ).
  ///
  /// [resetAmounts] doğruysa bütçe ve planlı tutarlar temizlenir (kullanıcı
  /// "sıfırla" seçti); yanlışsa sayılar olduğu gibi kalır ve yeni para
  /// birimiyle yorumlanır (kullanıcı "koru" seçti).
  Future<void> changeCurrency(int listId, String newCode,
      {required bool resetAmounts}) async {
    await _db.transaction(() async {
      await (_db.update(_db.shoppingLists)
            ..where((t) => t.id.equals(listId)))
          .write(ShoppingListsCompanion(
        currencyCode: Value(newCode),
        budgetMinorUnits:
            resetAmounts ? const Value(null) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ));
      if (resetAmounts) {
        final items = await (_db.select(_db.plannedItems)
              ..where((t) => t.listId.equals(listId)))
            .get();
        for (final item in items) {
          await (_db.update(_db.plannedItems)
                ..where((t) => t.id.equals(item.id)))
              .write(const PlannedItemsCompanion(
            plannedUnitPrice: Value(null),
            plannedLineTotalMinorUnits: Value(null),
          ));
        }
      }
    });
  }

  /// Silmeden önce anlık görüntü alır; [undoDelete] ile aynı kimliklerle
  /// geri yüklenir (spec §6.1: silmede onay + mümkünse geri alma).
  Future<DeletedListSnapshot> deleteList(int listId) async {
    final list = await getById(listId);
    final items = await (_db.select(_db.plannedItems)
          ..where((t) => t.listId.equals(listId)))
        .get();
    // OS hatırlatmaları cascade'e takılmaz; açıkça iptal edilir (spec §6.13).
    await _reminders?.cancelForList(listId);
    await _db.transaction(() async {
      await (_db.delete(_db.plannedItems)
            ..where((t) => t.listId.equals(listId)))
          .go();
      await (_db.delete(_db.shoppingLists)
            ..where((t) => t.id.equals(listId)))
          .go();
    });
    return DeletedListSnapshot(list: list, items: items);
  }

  Future<void> undoDelete(DeletedListSnapshot snapshot) {
    return _db.transaction(() async {
      await _db.into(_db.shoppingLists).insert(snapshot.list, mode: InsertMode.insertOrReplace);
      for (final item in snapshot.items) {
        await _db.into(_db.plannedItems)
            .insert(item, mode: InsertMode.insertOrReplace);
      }
    });
  }
}

/// Silinen listenin geri yükleme paketi.
class DeletedListSnapshot {
  const DeletedListSnapshot({required this.list, required this.items});

  final ShoppingList list;
  final List<PlannedItem> items;
}
