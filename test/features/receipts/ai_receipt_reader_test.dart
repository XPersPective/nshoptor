import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/receipts/ai_receipt_reader.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';

OcrScanResult _scan(List<String> rows) =>
    OcrScanResult(lines: [for (final r in rows) OcrLine(text: r)]);

AiClient _ai(
  Map<String, dynamic> result, {
  int status = 200,
  List<String>? log,
}) => AiClient(
  store: SettingsStore(),
  baseUrl: 'https://x',
  httpClient: MockClient((request) async {
    log?.add(request.body);
    return http.Response(
      jsonEncode(
        status == 200
            ? {'tier': 'pro', 'used': 1, 'limit': 100, 'result': result}
            : result,
      ),
      status,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
  }),
);

const _rows = [
  'ŞOK MARKETLER TİC.A.Ş',
  'TARİH : 01/02/2024',
  'FİŞ NO : 0259',
  'OZMO FUN FİGÜRLÜ 23G %01 *13,50',
  '1,033Kg X 99,00',
  'TADPİ PİLİÇ BAGET KG %01 *102,27',
  'FINISH QUANTUM ÖZEL %20 *259,00',
  '25TLFINISH110TL *149,00-',
  'TOPKDV *46,60',
  'TOPLAM *225,77',
];

Map<String, dynamic> _answer() => {
  'schema': 1,
  'store': 'ŞOK MARKETLER TİC.A.Ş',
  'date': '2024-02-01',
  'time': '20:51:41',
  'currency': 'TRY',
  'documentNumber': '0259',
  'items': [
    {
      'name': 'OZMO FUN FİGÜRLÜ 23G',
      'quantity': null,
      'unit': null,
      'unitPrice': null,
      'lineTotal': '13.50',
    },
    {
      'name': 'TADPİ PİLİÇ BAGET',
      'quantity': '1.033',
      'unit': 'kilogram',
      'unitPrice': '99.00',
      'lineTotal': '102.27',
    },
    {
      'name': 'FINISH QUANTUM ÖZEL',
      'quantity': null,
      'unit': null,
      'unitPrice': null,
      'lineTotal': '259.00',
    },
  ],
  'discounts': [
    {'label': '25TLFINISH110TL', 'amount': '149.00'},
  ],
  'tax': '46.60',
  'subtotal': null,
  'total': '225.77',
  'reconciles': true,
};

void main() {
  test('verified AI reading becomes canonical rows the deterministic pipeline reconciles', () async {
    final sent = <String>[];
    final reader = AiReceiptReader(_ai(_answer(), log: sent));
    final rows = await reader.normalize(_scan(_rows), currencyCode: 'TRY');
    expect(rows, isNotNull, reason: '${reader.lastResult is AiFailed ? (reader.lastResult as AiFailed).reason : reader.lastResult}');
    final request = jsonDecode(sent.single) as Map<String, dynamic>;
    expect(request['task'], 'read_receipt');
    expect((request['input'] as Map)['currency'], 'TRY');

    final document = ReceiptDocument.fromScan(rows!, currencyCode: 'TRY');
    final result = document.toParseResult();
    expect(document.state, ReceiptDocumentState.complete);
    expect(result.totalMinor, 22577);
    expect(result.taxMinor, 4660);
    expect(result.discountMinor, 14900);
    expect(result.lines.map((l) => l.lineTotalMinor), [1350, 10227, 25900]);
    expect(result.lines[1].quantity!.toDbString(), '1.033');
    expect(result.lines[1].unitPriceMinor, 9900);
    expect(result.withinReconciliationTolerance, isTrue);
    expect(result.storeCandidates.first, 'ŞOK MARKETLER TİC.A.Ş');
    expect(result.dateCandidate, DateTime(2024, 2, 1, 20, 51, 41));
  });

  test('an answer that does not reconcile exactly is never used', () async {
    for (final mutate in <void Function(Map<String, dynamic>)>[
      (a) => a['total'] = '225.78',
      (a) => a['reconciles'] = false,
      (a) => a['schema'] = 2,
      (a) => a['currency'] = 'EUR',
      (a) => (a['items'] as List)[0]['lineTotal'] = '1.234',
      (a) => a['items'] = [],
    ]) {
      final answer = _answer();
      mutate(answer);
      final reader = AiReceiptReader(_ai(answer));
      expect(await reader.normalize(_scan(_rows), currencyCode: 'TRY'), isNull);
      expect(reader.lastResult, isA<AiFailed>());
    }
  });

  test(
    'offline, quota and provider failure keep the raw OCR scan and report why',
    () async {
      final quota = AiReceiptReader(
        _ai({
          'error': 'quota',
          'tier': 'free',
          'limit': 15,
          'used': 15,
        }, status: 429),
      );
      expect(await quota.normalize(_scan(_rows), currencyCode: 'TRY'), isNull);
      expect(quota.lastResult, isA<AiQuota>());

      final failed = AiReceiptReader(_ai({'error': 'ai_failed'}, status: 502));
      expect(await failed.normalize(_scan(_rows), currencyCode: 'TRY'), isNull);
      expect(failed.lastResult, isA<AiFailed>());
    },
  );

  test('disabled AI and oversize receipts make no request', () async {
    final sent = <String>[];
    final client = _ai(_answer(), log: sent)..enabled = false;
    expect(
      await AiReceiptReader(client)
          .normalize(_scan(_rows), currencyCode: 'TRY'),
      isNull,
    );
    final big = _scan([for (var i = 0; i < 300; i++) 'ÜRÜN $i 1,00']);
    final on = _ai(_answer(), log: sent);
    expect(
      await AiReceiptReader(on).normalize(big, currencyCode: 'TRY'),
      isNull,
    );
    expect(sent, isEmpty);
  });
}
