import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/core/util/normalize_name.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';

void main() {
  late AppDatabase db;
  late ReceiptParser parser;
  late ReceiptMatcher matcher;
  late int listId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    parser = ReceiptParser();
    matcher = ReceiptMatcher(db);
    listId = await db
        .into(db.shoppingLists)
        .insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
  });

  tearDown(() => db.close());

  Future<void> addItem(String name) {
    return db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: name,
            normalizedName: normalizeName(name),
            plannedQuantity: '1',
            plannedUnitCode: 'adet',
            pricingInputMode: 'unitPrice',
          ),
        );
  }

  test('birebir normalize eşleşme: high; benzer: medium; uzak: none', () async {
    await addItem('Süt');
    await addItem('Domates');

    final scanResult = scan(['SUT 32,00', 'DOMATES 25,00', 'PEYNIR 89,90']);
    final result = parser.parse(scanResult);
    final matches = await matcher.match(result.lines, listId: listId);

    final byName = {for (final (l, item, conf) in matches) l.name: (item, conf)};
    final sut = byName['SUT']!;
    expect(sut.$1?.name, 'Süt'); // SUT → sut birebir
    expect(sut.$2, 'high');

    final domates = byName['DOMATES']!;
    expect(domates.$1?.name, 'Domates');
    expect(domates.$2, 'high');

    final peynir = byName['PEYNIR']!;
    // Peynir hafızada yok: muhafazakâr davranış → eşleşme yok (plansız olur).
    expect(peynir.$1, isNull);
    expect(peynir.$2, 'low');
  });

  test('benzer ad benzerlik eşiğiyle medium eşleşir', () async {
    await addItem('Peynir');
    final scanResult = scan(['PEYNIRI 89,90']);
    final result = parser.parse(scanResult);
    final matches = await matcher.match(result.lines, listId: listId);
    final (line, item, confidence) = matches.single;
    expect(line.name, 'PEYNIRI');
    expect(item?.name, 'Peynir');
    expect(confidence, 'medium');
  });
}

OcrScanResult scan(List<String> lines) => OcrScanResult(
      lines: [for (var i = 0; i < lines.length; i++) OcrLine(text: lines[i])],
    );
