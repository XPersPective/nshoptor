import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';

import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/parser/receipt_parser.dart';
import 'package:nshoptor/features/receipts/review/receipt_review_controller.dart';

void main() {
  late AppDatabase db;
  late int listId;
  late int elmaId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    listId = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(currencyCode: 'TRY'));
    elmaId = await db.into(db.plannedItems).insert(PlannedItemsCompanion.insert(
          listId: listId, name: 'elma', normalizedName: 'elma',
          plannedQuantity: '1', plannedUnitCode: 'kilogram', pricingInputMode: 'unitPrice'));
  });

  tearDown(() => db.close());

  ReceiptReviewController controller(MockClient mock) => ReceiptReviewController(
        db: db,
        listId: listId,
        parseResult: ReceiptParser().parse(const OcrScanResult(lines: [
          OcrLine(text: 'INDIRIMLI ELMA KG 31,50'),
          OcrLine(text: 'EKMEK 15,00'),
        ])),
        ai: AiClient(store: SettingsStore(), baseUrl: 'https://x', httpClient: mock),
      );

  http.Response ok(List<Map<String, Object?>> matches) => http.Response(
      jsonEncode({'tier': 'free', 'used': 1, 'limit': 15, 'result': {'matches': matches}}), 200);

  test('"INDIRIMLI ELMA" AI ile "elma"ya bağlanır, indirim işaretlenir, onaysız yazım yok', () async {
    final c = controller(MockClient((_) async => ok([
          {'i': 0, 'plannedId': elmaId, 'confidence': 'high', 'isDiscount': true},
          {'i': 1, 'plannedId': null, 'confidence': 'low', 'isDiscount': false},
        ])));
    await c.prefillSuggestions();
    expect(c.aiMatched, isTrue);
    expect(c.lines[0].linkedPlannedItemId, elmaId);
    expect(c.lines[0].isDiscount, isTrue);
    expect(c.lines[0].status, ReviewStatus.pending);
    expect(c.lines[1].linkedPlannedItemId, isNull);
    expect(await db.select(db.purchaseEntries).get(), isEmpty);
  });

  test('bilinmeyen plan kimliği yok sayılır; orta güven "kontrol et" ister', () async {
    final c = controller(MockClient((_) async => ok([
          {'i': 0, 'plannedId': elmaId, 'confidence': 'medium'},
          {'i': 1, 'plannedId': 9999, 'confidence': 'high'},
        ])));
    await c.prefillSuggestions();
    expect(c.lines[0].needsCheck, isTrue);
    expect(c.lines[1].linkedPlannedItemId, isNull);
  });

  test('AI hatası → kural tabanlı eşleştiriciye düşer, sebep tutulur', () async {
    final c = controller(MockClient((_) async => http.Response(jsonEncode({'error': 'ai_failed'}), 502)));
    await c.prefillSuggestions();
    expect(c.aiMatched, isFalse);
    expect(c.aiProblem, isA<AiFailed>());
  });
}
