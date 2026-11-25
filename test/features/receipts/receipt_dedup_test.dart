import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/receipt_dedup.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  Future<(int listId, int receiptId)> seedConvertedReceipt({
    required String listTitle,
    required String store,
    required DateTime at,
    String? identityKey,
  }) async {
    final listId = await db
        .into(db.shoppingLists)
        .insert(
          ShoppingListsCompanion.insert(
            title: Value(listTitle),
            currencyCode: 'TRY',
            status: const Value('completed'),
          ),
        );
    final receiptId = await db
        .into(db.receipts)
        .insert(
          ReceiptsCompanion.insert(
            listId: Value(listId),
            confirmedStore: Value(store),
            confirmedAt: Value(at),
            identityKey: Value(identityKey),
            processingStatus: const Value('reviewed'),
            queueState: const Value('converted'),
          ),
        );
    return (listId, receiptId);
  }

  test('matches same store variants within ±15 min without mutating DB', () async {
    final (listId, receiptId) = await seedConvertedReceipt(
      listTitle: 'A101 Alışverişi',
      store: 'A101 YENİ MAĞAZACILIK A.Ş.',
      at: DateTime(2026, 11, 10, 18, 41),
    );

    final match = await findDuplicateReceipt(
      db: db,
      storeName: 'A101 Market',
      purchaseAt: DateTime(2026, 11, 10, 18, 52), // +11 min
    );

    expect(match, isNotNull);
    expect(match!.listId, listId);
    expect(match.listTitle, 'A101 Alışverişi');
    expect(match.matchedReceiptId, receiptId);
    expect(await db.select(db.receipts).get(), hasLength(1));
    expect(await db.select(db.shoppingLists).get(), hasLength(1));
  });

  test('rejects different times (> 15 min) or different stores cleanly', () async {
    await seedConvertedReceipt(
      listTitle: 'Bim Market',
      store: 'BİM BİRLEŞİK MAĞAZALAR A.Ş.',
      at: DateTime(2026, 11, 10, 18, 41),
    );

    final outsideWindow = await findDuplicateReceipt(
      db: db,
      storeName: 'Bim',
      purchaseAt: DateTime(2026, 11, 10, 18, 57), // +16 min
    );
    expect(outsideWindow, isNull);

    final differentStore = await findDuplicateReceipt(
      db: db,
      storeName: 'Migros',
      purchaseAt: DateTime(2026, 11, 10, 18, 41), // same minute, different store
    );
    expect(differentStore, isNull);
  });

  test('falls back to calendar-day match when receipt time is absent', () async {
    final (listId, _) = await seedConvertedReceipt(
      listTitle: 'Şok',
      store: 'Şok Marketler Tic. A.Ş.',
      at: DateTime(2026, 11, 10),
    );

    final sameDay = await findDuplicateReceipt(
      db: db,
      storeName: 'ŞOK',
      purchaseAt: DateTime(2026, 11, 10, 14, 20),
    );
    expect(sameDay?.listId, listId);

    final nextDay = await findDuplicateReceipt(
      db: db,
      storeName: 'ŞOK',
      purchaseAt: DateTime(2026, 11, 11, 14, 20),
    );
    expect(nextDay, isNull);
  });

  test('ignores excludeReceiptId so a receipt never duplicates itself', () async {
    final (_, receiptId) = await seedConvertedReceipt(
      listTitle: 'Migros',
      store: 'Migros',
      at: DateTime(2026, 11, 10, 12, 0),
      identityKey: 'migros/2026-11-10/101',
    );

    final selfMatch = await findDuplicateReceipt(
      db: db,
      storeName: 'Migros',
      purchaseAt: DateTime(2026, 11, 10, 12, 0),
      identityKey: 'migros/2026-11-10/101',
      excludeReceiptId: receiptId,
    );
    expect(selfMatch, isNull);
  });

  test('matches manual/linked list store without prior converted receipt', () async {
    final storeId = await db
        .into(db.stores)
        .insert(StoresCompanion.insert(name: 'CarrefourSA'));
    final listId = await db
        .into(db.shoppingLists)
        .insert(
          ShoppingListsCompanion.insert(
            title: const Value('Haftalık'),
            storeId: Value(storeId),
            currencyCode: 'TRY',
            completedAt: Value(DateTime(2026, 11, 12, 16, 10)),
          ),
        );

    final match = await findDuplicateReceipt(
      db: db,
      storeName: 'CarrefourSA Hipermarket',
      purchaseAt: DateTime(2026, 11, 12, 16, 20),
    );
    expect(match?.listId, listId);
    expect(match?.matchedReceiptId, isNull);
  });
}
