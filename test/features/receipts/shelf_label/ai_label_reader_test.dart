import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/features/receipts/shelf_label/ai_label_reader.dart';

AiClient _ai(http.Response Function() reply) => AiClient(
  store: SettingsStore(),
  baseUrl: 'https://x',
  httpClient: MockClient((_) async => reply()),
);

void main() {
  test('AI unit candidate must preserve literal 100g basis and reject package inference', () async {
    final reader = AiLabelReader(
      _ai(
        () => http.Response(
          jsonEncode({
            'tier': 'free',
            'used': 1,
            'limit': 15,
            'result': {
              'productName': 'Tea',
              'unitPrice': '39.90',
              'unit': 'gram',
            },
          }),
          200,
        ),
      ),
    );
    final candidate = (await reader.read(
      'Tea\n39,90 TL / 100 g',
      currencyCode: 'TRY',
    )).single;
    expect(candidate.priceQuantity!.toDbString(), '100');
    expect(candidate.unitCode, UnitCode.gram);
    expect(
      await reader.read('Tea 100 g\n39,90 TL', currencyCode: 'TRY'),
      isEmpty,
    );
    expect(
      await reader.read('Tea\n49,90 TL / 100 g', currencyCode: 'TRY'),
      isEmpty,
    );
  });
  test('AI fiyatı ve birim fiyatı aday olur, AI etiketiyle', () async {
    final reader = AiLabelReader(
      _ai(
        () => http.Response(
          jsonEncode({
            'tier': 'free',
            'used': 1,
            'limit': 15,
            'result': {
              'productName': 'DOMATES SALKIM',
              'price': '34.95',
              'unitPrice': '69.90',
              'unit': 'kilogram',
            },
          }),
          200,
        ),
      ),
    );
    final c = await reader.read(
      'DOMATES SALKIM\n34,95 TL\nKG 69,90',
      currencyCode: 'TRY',
    );
    expect(c.length, 2);
    expect(c.first.value.toDbString(), '34.95');
    expect(c.first.confidence, AiLabelReader.aiConfidence);
    expect(c.last.isUnitPrice, isTrue);
    expect(c.first.productName, 'DOMATES SALKIM');
    expect(c.first.unitCode, isNull);
    expect(c.last.productName, 'DOMATES SALKIM');
    expect(c.last.unitCode, UnitCode.kilogram);
  });

  test('AI hatası → boş liste (yerel adaylar kullanılır)', () async {
    final reader = AiLabelReader(
      _ai(() => http.Response(jsonEncode({'error': 'ai_failed'}), 502)),
    );
    expect(await reader.read('34,95', currencyCode: 'TRY'), isEmpty);
  });

  test('geçersiz sayı kabul edilmez', () async {
    final reader = AiLabelReader(
      _ai(
        () => http.Response(
          jsonEncode({
            'tier': 'free',
            'used': 1,
            'limit': 15,
            'result': {
              'productName': 'x',
              'price': '34,95 TL',
              'unitPrice': null,
            },
          }),
          200,
        ),
      ),
    );
    expect(await reader.read('x', currencyCode: 'TRY'), isEmpty);
  });
}
