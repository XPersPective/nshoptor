// PB-040: sentetik fiş GÖRSELİ ile cihaz içi OCR uçtan uca akış.
// Görsel (base64 gömülü) → ML Kit (cihaz içi, çevrimdışı) → ReceiptParser
// → ReceiptMatcher: "domates kg" planındaki "Domates"e YÜKSEK güvenle
// eşleşir. Koşum: flutter test integration_test/receipt_flow_test.dart
// -d <emülatör>
import 'dart:convert' show base64Decode;
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/shelf_label/mlkit_text_source.dart';

import 'receipt_fixture_bytes.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('cihaz: görsel fiş → OCR → ayrıştırma → eşleştirme',
      (tester) async {
    // 1) Gömülü görseli cihazın kendi tmp dizinine yaz (uygulama sahibi).
    final tmp = Directory.systemTemp.path;
    final file = File('$tmp/receipt_synthetic.png');
    await file.writeAsBytes(base64Decode(receiptFixtureBase64));

    // 2) Cihaz içi OCR (Latin modeli gömülü; ağ yok).
    final source = MlKitTextSource();
    final scan = await source.scan(file.path);
    source.dispose();
    expect(scan.lines, isNotEmpty, reason: 'OCR satır okumalı');

    // 3) Planlı ürün: kullanıcının senaryosu ("Domates" + fiyat).
    final db = AppDatabase(NativeDatabase.memory());
    final listId = await db.into(db.shoppingLists).insert(
          ShoppingListsCompanion.insert(
              title: const Value('Pazar'), currencyCode: 'TRY'),
        );
    final itemId = await db.into(db.plannedItems).insert(
          PlannedItemsCompanion.insert(
            listId: listId,
            name: 'Domates',
            normalizedName: 'domates',
            plannedQuantity: '1',
            plannedUnitCode: 'kilogram',
            pricingInputMode: 'unitPrice',
          ),
        );

    // 4) Ayrıştırma: ürün satırları + toplam; yapısal satırlar ürün değil.
    final result = ReceiptParser(currency: 'TRY').parse(scan);
    final names = result.lines
        .map((l) => ReceiptMatcher.stripUnits(l.normalizedName))
        .toList();
    expect(names, contains('domates'),
        reason: 'OCR çıktısından DOMATES satırı ayrışmalı');
    expect(result.totalMinor, 19929, reason: 'fiş toplamı okunmalı');

    // 5) Eşleştirme: yüksek güven + doğru ürün.
    final matches = await ReceiptMatcher(db).match(result.lines,
        listId: listId);
    final domates = matches.firstWhere(
        (m) => ReceiptMatcher.stripUnits(m.$1.normalizedName) == 'domates');
    expect(domates.$2?.id, itemId);
    expect(domates.$3, 'high');

    await db.close();
  });
}
