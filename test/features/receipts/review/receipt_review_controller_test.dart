import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';

void main() {
  late AppDatabase db;
  late int listId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    listId = await db
        .into(db.shoppingLists)
        .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
  });

  tearDown(() => db.close());

  ReceiptReviewController controllerFrom(List<String> receiptLines) {
    final scan = OcrScanResult(
      lines: [
        for (var i = 0; i < receiptLines.length; i++)
          OcrLine(text: receiptLines[i]),
      ],
    );
    return ReceiptReviewController(
      db: db,
      listId: listId,
      parseResult: ReceiptParser().parse(scan),
    );
  }

  test('onay öncesi DB\'ye yazım YOKTUR (spec §6.9: onaysız değişiklik yok)',
      () async {
    final controller = controllerFrom(['EKMEK 15,00', 'SUT 32,00']);
    controller.accept(0);
    controller.accept(1);
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
  });

  test('bağlama: satır planlanan ürüne bağlanır; bağlantısız plansızdır',
      () async {
    final controller = controllerFrom(['EKMEK 15,00', 'POSET 2,50']);
    await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: 'Ekmek',
            normalizedName: 'ekmek',
            plannedQuantity: '1',
            plannedUnitCode: 'adet',
            pricingInputMode: 'unitPrice',
          ),
        );
    final ekmek = (await db.select(db.plannedItems).get()).single;

    controller.accept(0);
    controller.linkLine(0, ekmek.id);
    controller.accept(1);
    controller.unlinkLine(1);

    await controller.commit();

    final entries = await db.select(db.purchaseEntries).get();
    expect(entries, hasLength(2));
    final linked = entries.firstWhere((e) => e.name == 'EKMEK');
    expect(linked.plannedItemId, ekmek.id);
    final unplanned = entries.firstWhere((e) => e.name == 'POSET');
    expect(unplanned.plannedItemId, isNull); // plansız: ayrı raporlanır
  });

  test('birleştirme: ad bitişir, tutar toplanır', () async {
    final controller = controllerFrom(
        ['DANET KAHVALTILIK', '500 GR KARIŞIK', '89,90', 'TOPLAM 89,90']);
    expect(controller.lines, hasLength(1)); // taşan ad zaten birleşti
    final line = controller.lines.single;

    // Ayrılabilirlik: ikiye böl.
    controller.splitLine(0, firstMinor: 4000);
    expect(controller.lines, hasLength(2));
    expect(controller.lines[0].lineTotalMinor, 4000);
    expect(controller.lines[1].lineTotalMinor, 4990);

    // Tekrar birleştir: tutarlar toplanır.
    controller.mergeLines(0, 1);
    expect(controller.lines, hasLength(1));
    expect(controller.lines.single.lineTotalMinor, 8990);
    expect(line.name, isNotEmpty);
  });

  test('yok sayılan satırlar kabul toplamına girmez ve kayda geçmez',
      () async {
    final controller = controllerFrom(['EKMEK 15,00', 'REKLAM 0,00']);
    controller.accept(0);
    controller.ignore(1);

    expect(controller.acceptedTotalMinor, 1500);
    await controller.commit();
    final entries = await db.select(db.purchaseEntries).get();
    expect(entries, hasLength(1));
    expect(entries.single.name, 'EKMEK');
  });

  test('fark gösterimi: kabul edilenler ↔ bildirilen toplam', () async {
    final controller =
        controllerFrom(['EKMEK 15,00', 'SUT 32,00', 'TOPLAM 48,00']);
    expect(controller.reportedTotalMinor, 4800);

    controller.accept(0);
    expect(controller.reconciliationDifference, 1500 - 4800);

    controller.accept(1);
    expect(controller.reconciliationDifference, 4700 - 4800);
  });

  test('kullanıcı raporlanan toplamı düzeltebilir', () async {
    final controller = controllerFrom(['EKMEK 15,00', 'TOPLAM 99,00']);
    controller.setReportedTotal(1500);
    expect(controller.reportedTotalMinor, 1500);
  });
}
