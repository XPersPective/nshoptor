import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/history/reports/report_period.dart';
import 'package:nshoptor/features/history/reports/report_repository.dart';

Future<List<Object?>> _databaseSnapshot(AppDatabase db) async => [
  await db.select(db.stores).get(),
  await db.select(db.categories).get(),
  await db.select(db.aisles).get(),
  await db.select(db.shoppingLists).get(),
  await db.select(db.plannedItems).get(),
  await db.select(db.purchaseEntries).get(),
  await db.select(db.productMemory).get(),
  await db.select(db.productAliases).get(),
  await db.select(db.priceObservations).get(),
  await db.select(db.receipts).get(),
  await db.select(db.receiptCandidateLines).get(),
  await db.select(db.attachments).get(),
  await db.select(db.reminders).get(),
  await db.select(db.appSettings).get(),
];

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<int> addList({
    required String title,
    String currency = 'TRY',
    String status = 'completed',
    DateTime? completedAt,
  }) => db
      .into(db.shoppingLists)
      .insert(
        ShoppingListsCompanion.insert(
          title: Value(title),
          currencyCode: currency,
          status: Value(status),
          completedAt: Value(completedAt),
        ),
      );

  Future<int> addPlanned(
    int listId,
    String name, {
    String quantity = '1',
    String unit = 'piece',
    int? plannedMinor,
    String status = 'pending',
  }) => db
      .into(db.plannedItems)
      .insert(
        PlannedItemsCompanion.insert(
          listId: listId,
          name: name,
          normalizedName: name.toLowerCase(),
          plannedQuantity: quantity,
          plannedUnitCode: unit,
          pricingInputMode: 'lineTotal',
          plannedLineTotalMinorUnits: Value(plannedMinor),
          status: Value(status),
        ),
      );

  Future<void> addPurchase(
    int listId,
    String name,
    int amount, {
    int? plannedItemId,
    String quantity = '1',
    String unit = 'piece',
    String? unitPrice,
    int? gross,
    bool confirmed = true,
    String source = 'manual',
  }) async {
    await db
        .into(db.purchaseEntries)
        .insert(
          PurchaseEntriesCompanion.insert(
            listId: listId,
            plannedItemId: Value(plannedItemId),
            name: name,
            normalizedName: name.toLowerCase(),
            actualQuantity: quantity,
            actualUnitCode: unit,
            actualLineTotalMinorUnits: amount,
            actualUnitPrice: Value(unitPrice),
            grossTotalMinorUnits: Value(gross),
            userConfirmed: Value(confirmed),
            source: Value(source),
          ),
        );
  }

  Future<void> addReceipt(int listId, String status) async {
    await db
        .into(db.receipts)
        .insert(
          ReceiptsCompanion.insert(
            listId: Value(listId),
            processingStatus: Value(status),
          ),
        );
  }

  test(
    'period selects completed matching-currency lists in newest-first order',
    () async {
      final start = DateTime(2026, 10, 1);
      final end = DateTime(2026, 11, 1);
      await addList(title: 'At start', completedAt: start);
      await addList(title: 'Newer', completedAt: DateTime(2026, 10, 20));
      await addList(title: 'At exclusive end', completedAt: end);
      await addList(
        title: 'Active',
        status: 'shopping',
        completedAt: DateTime(2026, 10, 25),
      );
      await addList(
        title: 'Archived',
        status: 'archived',
        completedAt: DateTime(2026, 10, 26),
      );
      await addList(
        title: 'Foreign',
        currency: 'EUR',
        completedAt: DateTime(2026, 10, 27),
      );

      final period = ReportPeriod(
        span: ReportSpan.custom,
        from: start,
        to: end,
      );
      final before = await _databaseSnapshot(db);
      final report = await ReportRepository(db).period(period, 'TRY');
      final after = await _databaseSnapshot(db);

      expect(report.shopping.map((shopping) => shopping.list.title), [
        'Newer',
        'At start',
      ]);
      expect(
        report.shopping.every(
          (shopping) => shopping.list.currencyCode == 'TRY',
        ),
        isTrue,
      );
      expect(
        after,
        before,
        reason: 'loading a period report must not mutate any table',
      );
      expect(() => report.shopping.clear(), throwsUnsupportedError);
      expect(
        () => report.shopping.first.products.clear(),
        throwsUnsupportedError,
      );
      expect(
        () => report.shopping.first.receipts.clear(),
        throwsUnsupportedError,
      );
    },
  );

  test('matched, free, estimate-only, legacy and unconfirmed rows keep distinct states', () async {
    final listId = await addList(
      title: 'State cases',
      completedAt: DateTime(2026, 10, 15),
    );
    final matched = await addPlanned(
      listId,
      'Matched',
      quantity: '2',
      plannedMinor: 40,
    );
    final free = await addPlanned(listId, 'Free');
    await addPlanned(listId, 'Estimate', plannedMinor: 25);
    await addPlanned(listId, 'Legacy in cart', status: 'inCart');
    final unconfirmed = await addPlanned(listId, 'Unconfirmed');
    await addPurchase(
      listId,
      'Matched',
      30,
      plannedItemId: matched,
      unitPrice: '30',
    );
    await addPurchase(listId, 'Free', 0, plannedItemId: free, unitPrice: '0');
    await addPurchase(
      listId,
      'Unconfirmed',
      99,
      plannedItemId: unconfirmed,
      unitPrice: '99',
      confirmed: false,
    );
    await addReceipt(listId, 'pending');
    await addReceipt(listId, 'reviewed');

    final snapshot = await ReportRepository(db).shopping(listId);
    final matchedRow = snapshot.products.singleWhere(
      (row) => row.name == 'Matched',
    );
    final freeRow = snapshot.products.singleWhere((row) => row.name == 'Free');
    final estimateRow = snapshot.products.singleWhere(
      (row) => row.name == 'Estimate',
    );
    final legacyRow = snapshot.products.singleWhere(
      (row) => row.name == 'Legacy in cart',
    );
    final unconfirmedRow = snapshot.products.singleWhere(
      (row) => row.name == 'Unconfirmed',
    );

    expect(matchedRow.plannedQuantity, DecimalFixed.fromInt(2));
    expect(matchedRow.plannedMinor, 40);
    expect(matchedRow.actual.minor, 30);
    expect(matchedRow.difference, -10);
    expect(matchedRow.purchased, isTrue);
    expect(freeRow.purchased, isTrue);
    expect(freeRow.actual.known, isTrue);
    expect(freeRow.actual.minor, 0);
    expect(estimateRow.purchased, isFalse);
    expect(estimateRow.plannedMinor, 25);
    expect(legacyRow.purchased, isFalse);
    expect(legacyRow.actual.unknown, isTrue);
    expect(unconfirmedRow.purchased, isFalse);
    expect(snapshot.spent.minor, 30);
    expect(snapshot.spent.known, isTrue);
    expect(snapshot.receipts.map((receipt) => receipt.processingStatus), [
      'reviewed',
    ]);
  });

  test(
    'repeated planned purchases sum actuals once and preserve unit groups',
    () async {
      final listId = await addList(
        title: 'Multiple entries',
        completedAt: DateTime(2026, 10, 16),
      );
      final milk = await addPlanned(
        listId,
        'Milk',
        quantity: '2',
        plannedMinor: 40,
      );
      await addPurchase(
        listId,
        'Milk',
        20,
        plannedItemId: milk,
        quantity: '1',
        unit: 'piece',
        unitPrice: '20',
      );
      await addPurchase(
        listId,
        'Milk',
        10,
        plannedItemId: milk,
        quantity: '1',
        unit: 'kilogram',
        unitPrice: '10',
      );
      await addPurchase(listId, 'Bag', 5, unitPrice: '5');
      await addPurchase(listId, 'Discount', -2, source: 'receiptOcr');

      final snapshot = await ReportRepository(db).shopping(listId);
      final milkRow = snapshot.products.singleWhere(
        (row) => row.name == 'Milk',
      );
      final discount = snapshot.products.singleWhere(
        (row) => row.name == 'Discount',
      );

      expect(
        snapshot.products.where((row) => row.name == 'Milk'),
        hasLength(1),
      );
      expect(milkRow.actual.minor, 30);
      expect(milkRow.difference, -10);
      expect(milkRow.actualQuantities, hasLength(2));
      expect(
        milkRow.actualQuantities
            .singleWhere((quantity) => quantity.unitCode == 'piece')
            .quantity,
        DecimalFixed.fromInt(1),
      );
      expect(
        milkRow.actualQuantities
            .singleWhere((quantity) => quantity.unitCode == 'kilogram')
            .quantity,
        DecimalFixed.fromInt(1),
      );
      expect(discount.isDiscount, isTrue);
      expect(discount.actual.minor, -2);
      expect(snapshot.spent.minor, 33);
      expect(snapshot.plannedMinor, 40);
    },
  );

  test('period report paid total includes confirmed entries and negative adjustments', () async {
    final listId = await addList(
      title: 'Paid total',
      completedAt: DateTime(2026, 10, 17),
    );
    await addPurchase(listId, 'Paid', 30, unitPrice: '30');
    await addPurchase(
      listId,
      'Not confirmed',
      90,
      unitPrice: '90',
      confirmed: false,
    );
    await addPurchase(listId, 'Refund', -5, source: 'receiptOcr');

    final period = ReportPeriod.forSpan(
      ReportSpan.month,
      DateTime(2026, 10, 17),
    );
    final report = await ReportRepository(db).period(period, 'TRY');

    expect(report.shopping, hasLength(1));
    expect(report.spent.minor, 25);
  });
}
