import 'package:drift/drift.dart';

import '../../app/app_defaults.dart';
import '../../core/text/list_title.dart';

import '../../data/db/app_database.dart';
import 'reminders/reminders_repository.dart';
import 'reminders/local_notifications_scheduler.dart';
import 'list_status.dart';

/// Alışveriş listesi işlemleri: CRUD, çoğaltma, para birimi değişimi,
/// geri alınabilir silme (spec §6.1, §7.1).
class ListRepository {
  ListRepository(this._db, {RemindersRepository? reminders})
    : _reminders =
          reminders ?? RemindersRepository(_db, LocalNotificationsScheduler());

  final AppDatabase _db;
  final RemindersRepository _reminders;

  /// Detay ekranları gibi aynı veritabanını paylaşan bileşenler için.
  AppDatabase get db => _db;

  /// Yeni liste kurar; [generatedTitle] başlık boş bırakıldığında UI
  /// katmanı tarafından üretilip verilir (depoda çeviri üretilmez).
  Future<int> createList({
    String? title,
    String titleLocaleCode = 'tr',
    String? generatedTitle,
    required String currencyCode,
    int? storeId,
    int? budgetMinorUnits,
    String? note,
    String? colorToken,
    String? iconToken,
  }) {
    return (_db.select(_db.shoppingLists)
          ..orderBy([(t) => OrderingTerm.desc(t.sortOrder)])
          ..limit(1))
        .getSingleOrNull()
        .then(
          (last) => _db
              .into(_db.shoppingLists)
              .insert(
                ShoppingListsCompanion.insert(
                  title: Value(
                    normalizedListTitle(title, localeCode: titleLocaleCode),
                  ),
                  generatedTitle: Value(
                    normalizedListTitle(
                      generatedTitle,
                      localeCode: titleLocaleCode,
                    ),
                  ),
                  currencyCode: currencyCode,
                  storeId: Value(storeId),
                  budgetMinorUnits: Value(
                    budgetMinorUnits ??
                        AppDefaults.shoppingLimitMinor(
                          currencyCode: currencyCode,
                        ),
                  ),
                  note: Value(note),
                  colorToken: Value(colorToken),
                  iconToken: Value(iconToken),
                  sortOrder: Value((last?.sortOrder ?? -1) + 1),
                ),
              ),
        );
  }

  Future<ShoppingList> getById(int id) => (_db.select(
    _db.shoppingLists,
  )..where((t) => t.id.equals(id))).getSingle();

  Stream<List<ShoppingList>> watchAll() =>
      (_db.select(_db.shoppingLists)..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
          .watch();

  Future<void> reorderLists(List<int> orderedIds) async {
    await _db.transaction(() async {
      for (var index = 0; index < orderedIds.length; index++) {
        await (_db.update(
          _db.shoppingLists,
        )..where((t) => t.id.equals(orderedIds[index]))).write(
          ShoppingListsCompanion(
            sortOrder: Value(index),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    });
  }

  Future<void> updateTitle(
    int id,
    String? title, {
    String titleLocaleCode = 'tr',
  }) => (_db.update(_db.shoppingLists)..where((t) => t.id.equals(id))).write(
    ShoppingListsCompanion(
      title: Value(normalizedListTitle(title, localeCode: titleLocaleCode)),
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
    final current = ListStatus.fromDb((await getById(id)).status);
    if (current == next) return;
    if (!current.canTransitionTo(next)) {
      throw StateError('geçersiz durum geçişi: ${current.name} → ${next.name}');
    }
    await (_db.update(_db.shoppingLists)..where((t) => t.id.equals(id))).write(
      ShoppingListsCompanion(
        status: Value(next.name),
        archivedAt: Value(next == ListStatus.archived ? DateTime.now() : null),
        completedAt: Value(
          next == ListStatus.completed ? DateTime.now() : null,
        ),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Listeyi çocuk ürünleriyle kopyalar: kopya taslaktır, tamamlama/
  /// alışveriş damgaları temizlenir; ürünler `pending` olur (spec §6.1).
  Future<int> duplicateList(int listId, {String? generatedTitle}) async {
    final source = await getById(listId);
    return _db.transaction(() async {
      final newId = await _db
          .into(_db.shoppingLists)
          .insert(
            ShoppingListsCompanion.insert(
              title: Value(normalizedListTitle(source.title)),
              generatedTitle: Value(
                normalizedListTitle(generatedTitle ?? source.generatedTitle),
              ),
              currencyCode: source.currencyCode,
              storeId: Value(source.storeId),
              budgetMinorUnits: Value(source.budgetMinorUnits),
              note: Value(source.note),
              colorToken: Value(source.colorToken),
              iconToken: Value(source.iconToken),
            ),
          );
      final items = await (_db.select(
        _db.plannedItems,
      )..where((t) => t.listId.equals(listId))).get();
      for (final item in items) {
        await _db
            .into(_db.plannedItems)
            .insert(
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
                plannedLineTotalMinorUnits: Value(
                  item.plannedLineTotalMinorUnits,
                ),
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
  Future<void> changeCurrency(
    int listId,
    String newCode, {
    required bool resetAmounts,
  }) async {
    await _db.transaction(() async {
      await (_db.update(
        _db.shoppingLists,
      )..where((t) => t.id.equals(listId))).write(
        ShoppingListsCompanion(
          currencyCode: Value(newCode),
          budgetMinorUnits: resetAmounts
              ? const Value(null)
              : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );
      if (resetAmounts) {
        final items = await (_db.select(
          _db.plannedItems,
        )..where((t) => t.listId.equals(listId))).get();
        for (final item in items) {
          await (_db.update(
            _db.plannedItems,
          )..where((t) => t.id.equals(item.id))).write(
            const PlannedItemsCompanion(
              plannedUnitPrice: Value(null),
              plannedLineTotalMinorUnits: Value(null),
            ),
          );
        }
      }
    });
  }

  /// Silmeden önce anlık görüntü alır; [undoDelete] ile aynı kimliklerle
  /// geri yüklenir (spec §6.1: silmede onay + mümkünse geri alma).
  Future<DeletedListSnapshot> deleteList(int listId) async {
    final list = await getById(listId);
    final items = await (_db.select(
      _db.plannedItems,
    )..where((t) => t.listId.equals(listId))).get();
    final purchases = await (_db.select(
      _db.purchaseEntries,
    )..where((t) => t.listId.equals(listId))).get();
    final purchaseIds = purchases.map((purchase) => purchase.id).toList();
    final observations = purchaseIds.isEmpty
        ? const <PriceObservation>[]
        : await (_db.select(
            _db.priceObservations,
          )..where((t) => t.purchaseEntryId.isIn(purchaseIds))).get();
    final receipts = await (_db.select(
      _db.receipts,
    )..where((t) => t.listId.equals(listId))).get();
    final receiptIds = receipts.map((receipt) => receipt.id).toList();
    final receiptLines = receiptIds.isEmpty
        ? const <ReceiptCandidateLine>[]
        : await (_db.select(
            _db.receiptCandidateLines,
          )..where((t) => t.receiptId.isIn(receiptIds))).get();
    final reminders = await (_db.select(
      _db.reminders,
    )..where((t) => t.listId.equals(listId))).get();
    // OS hatırlatmaları cascade'e takılmaz; açıkça iptal edilir (spec §6.13).
    await _reminders.cancelForList(listId);
    await _db.transaction(() async {
      if (purchaseIds.isNotEmpty) {
        await (_db.delete(
          _db.priceObservations,
        )..where((t) => t.purchaseEntryId.isIn(purchaseIds))).go();
      }
      if (receiptIds.isNotEmpty) {
        await (_db.delete(
          _db.receiptCandidateLines,
        )..where((t) => t.receiptId.isIn(receiptIds))).go();
        await (_db.delete(
          _db.receipts,
        )..where((t) => t.id.isIn(receiptIds))).go();
      }
      await (_db.delete(
        _db.plannedItems,
      )..where((t) => t.listId.equals(listId))).go();
      await (_db.delete(
        _db.shoppingLists,
      )..where((t) => t.id.equals(listId))).go();
    });
    return DeletedListSnapshot(
      list: list,
      items: items,
      purchases: purchases,
      observations: observations,
      receipts: receipts,
      receiptLines: receiptLines,
      reminders: reminders,
    );
  }

  Future<void> undoDelete(DeletedListSnapshot snapshot) {
    return _db.transaction(() async {
      await _db
          .into(_db.shoppingLists)
          .insert(snapshot.list, mode: InsertMode.insertOrReplace);
      for (final item in snapshot.items) {
        await _db
            .into(_db.plannedItems)
            .insert(item, mode: InsertMode.insertOrReplace);
      }
      for (final receipt in snapshot.receipts) {
        await _db
            .into(_db.receipts)
            .insert(receipt, mode: InsertMode.insertOrReplace);
      }
      for (final purchase in snapshot.purchases) {
        await _db
            .into(_db.purchaseEntries)
            .insert(purchase, mode: InsertMode.insertOrReplace);
      }
      for (final observation in snapshot.observations) {
        await _db
            .into(_db.priceObservations)
            .insert(observation, mode: InsertMode.insertOrReplace);
      }
      for (final line in snapshot.receiptLines) {
        await _db
            .into(_db.receiptCandidateLines)
            .insert(line, mode: InsertMode.insertOrReplace);
      }
      for (final reminder in snapshot.reminders) {
        await _db
            .into(_db.reminders)
            .insert(reminder, mode: InsertMode.insertOrReplace);
      }
    });
  }
}

/// Silinen listenin geri yükleme paketi.
class DeletedListSnapshot {
  const DeletedListSnapshot({
    required this.list,
    required this.items,
    required this.purchases,
    required this.observations,
    required this.receipts,
    required this.receiptLines,
    required this.reminders,
  });

  final ShoppingList list;
  final List<PlannedItem> items;
  final List<PurchaseEntry> purchases;
  final List<PriceObservation> observations;
  final List<Receipt> receipts;
  final List<ReceiptCandidateLine> receiptLines;
  final List<Reminder> reminders;
}
