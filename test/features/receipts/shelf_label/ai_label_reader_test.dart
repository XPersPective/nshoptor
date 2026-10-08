import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/receipts/shelf_label/ai_label_reader.dart';

AiClient _ai(http.Response Function() reply) => AiClient(
    store: SettingsStore(), baseUrl: 'https://x', httpClient: MockClient((_) async => reply()));

void main() {
  test('AI fiyatı ve birim fiyatı aday olur, AI etiketiyle', () async {
    final reader = AiLabelReader(_ai(() => http.Response(jsonEncode({
          'tier': 'free', 'used': 1, 'limit': 15,
          'result': {'productName': 'DOMATES SALKIM', 'price': '34.95', 'unitPrice': '69.90', 'unit': 'kilogram'},
        }), 200)));
    final c = await reader.read('DOMATES SALKIM\n34,95 TL\nKG 69,90', currencyCode: 'TRY');
    expect(c.length, 2);
    expect(c.first.value.toDbString(), '34.95');
    expect(c.first.confidence, AiLabelReader.aiConfidence);
    expect(c.last.isUnitPrice, isTrue);
  });

  test('AI hatası → boş liste (yerel adaylar kullanılır)', () async {
    final reader = AiLabelReader(_ai(() => http.Response(jsonEncode({'error': 'ai_failed'}), 502)));
    expect(await reader.read('34,95', currencyCode: 'TRY'), isEmpty);
  });

  test('geçersiz sayı kabul edilmez', () async {
    final reader = AiLabelReader(_ai(() => http.Response(jsonEncode({
          'tier': 'free', 'used': 1, 'limit': 15,
          'result': {'productName': 'x', 'price': '34,95 TL', 'unitPrice': null},
        }), 200)));
    expect(await reader.read('x', currencyCode: 'TRY'), isEmpty);
  });
}
