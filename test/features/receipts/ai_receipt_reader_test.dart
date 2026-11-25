import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/features/receipts/ai_receipt_reader.dart';
import 'package:nshoptor/features/receipts/receipt_document.dart';

AiClient _ai(
  Map<String, dynamic> body, {
  int status = 200,
  List<Map<String, dynamic>>? log,
}) => AiClient(
  store: SettingsStore(),
  baseUrl: 'https://x',
  httpClient: MockClient((request) async {
    log?.add(jsonDecode(request.body) as Map<String, dynamic>);
    return http.Response(
      jsonEncode(
        status == 200
            ? {'tier': 'pro', 'used': 1, 'limit': 100, 'result': body}
            : body,
      ),
      status,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
  }),
);

AiReceiptReader _reader(AiClient ai) =>
    AiReceiptReader(ai, encode: (path) async => '/9j/$path');

Map<String, dynamic> _sok() => {
  'schema': 2,
  'status': 'complete',
  'store': 'ŞOK MARKETLER TİC.A.Ş',
  'date': '2024-02-01',
  'time': '20:51:41',
  'documentNumber': '0259',
  'currency': 'TRY',
  'items': [
    {'name': 'OZMO FUN FİGÜRLÜ 23G', 'lineTotal': '13.50'},
    {
      'name': 'TADPİ PİLİÇ BAGET',
      'quantity': '1.033',
      'unit': 'kilogram',
      'unitPrice': '99.00',
      'lineTotal': '102.27',
    },
    {'name': 'FINISH QUANTUM ÖZEL', 'lineTotal': '259.00'},
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
  test(
    'canonical AI KWD decimals survive durable replay without OCR guessing',
    () {
      final data = _sok()
        ..['currency'] = 'KWD'
        ..['items'] = [
          {'name': 'MILK', 'lineTotal': '1.234'},
        ]
        ..['discounts'] = []
        ..['tax'] = null
        ..['total'] = '1.234';
      final result = AiReceiptReader.interpret(data, currencyCode: 'KWD');
      final doc = (result as AiReceiptVerified).document;
      expect(doc.metadata.totalMinor, 1234);
      expect(doc.toParseResult().totalMinor, 1234);
      final replay = ReceiptDocument.decode(doc.encode());
      expect(replay.state, ReceiptDocumentState.complete);
      expect(replay.productLines.single.lineTotalMinor, 1234);
      expect(replay.toParseResult().withinReconciliationTolerance, isTrue);
    },
  );
  test('all photos of one receipt are sent together; verified reading builds the document', () async {
    final log = <Map<String, dynamic>>[];
    final read = await _reader(_ai(_sok(), log: log))
        .read(['top', 'bottom'], currencyCode: 'TRY');
    expect(log.single['task'], 'read_receipt_image');
    expect((log.single['input'] as Map)['images'], ['/9j/top', '/9j/bottom']);
    final document = (read as AiReceiptVerified).document;
    final parsed = document.toParseResult();
    expect(document.state, ReceiptDocumentState.complete);
    expect(parsed.lines.map((l) => l.lineTotalMinor), [1350, 10227, 25900]);
    expect(parsed.lines[1].quantity!.toDbString(), '1.033');
    expect(parsed.discountMinor, 14900);
    expect(parsed.totalMinor, 22577);
    expect(document.metadata.store, 'ŞOK MARKETLER');
    expect(document.metadata.documentNumber, '0259');
    expect(document.metadata.dateTime, DateTime(2024, 2, 1, 20, 51, 41));
  });

  test('Arabic and Japanese receipts in their own currencies are accepted', () {
    final arabic = AiReceiptReader.interpret({
      'schema': 2,
      'status': 'complete',
      'store': 'بنده هايبر',
      'date': '2026-10-20',
      'time': null,
      'documentNumber': null,
      'currency': 'SAR',
      'items': [
        {'name': 'حليب المراعي', 'lineTotal': '7.50'},
        {'name': 'خبز', 'lineTotal': '2.00'},
      ],
      'discounts': [],
      'total': '9.50',
    }, currencyCode: 'SAR');
    final doc = (arabic as AiReceiptVerified).document;
    expect(doc.metadata.store, 'بنده هايبر');
    expect(doc.metadata.currencyCode, 'SAR');
    expect(doc.metadata.documentNumber, startsWith('AUTO-'));
    expect(doc.productLines.map((l) => l.name), ['حليب المراعي', 'خبز']);

    final japanese = AiReceiptReader.interpret({
      'schema': 2,
      'status': 'complete',
      'store': 'セブン-イレブン',
      'date': '2026-10-20',
      'time': '09:12',
      'documentNumber': '1234',
      'currency': 'JPY',
      'items': [
        {'name': 'おにぎり', 'lineTotal': '150'},
        {'name': 'お茶', 'lineTotal': '128'},
      ],
      'discounts': [],
      'tax': '22',
      'total': '278',
    }, currencyCode: 'JPY');
    final jp = (japanese as AiReceiptVerified).document.toParseResult();
    expect(jp.totalMinor, 278);
    expect(jp.lines.map((l) => l.name), ['おにぎり', 'お茶']);
  });

  test(
    'model status guides the user instead of accepting partial receipts',
    () {
      for (final (status, gap) in [
        ('top_missing', AiReceiptGap.top),
        ('bottom_missing', AiReceiptGap.bottom),
        ('middle_gap', AiReceiptGap.middle),
      ]) {
        final read = AiReceiptReader.interpret({
          'schema': 2,
          'status': status,
        }, currencyCode: 'TRY');
        expect((read as AiReceiptNeedsMore).gap, gap);
      }
      expect(
        AiReceiptReader.interpret({
          'schema': 2,
          'status': 'unreadable',
        }, currencyCode: 'TRY'),
        isA<AiReceiptRetake>(),
      );
      final noDate = _sok()..['date'] = null;
      expect(
        (AiReceiptReader.interpret(
          noDate,
          currencyCode: 'TRY',
        ) as AiReceiptNeedsMore).gap,
        AiReceiptGap.top,
      );
    },
  );

  test('client re-verification rejects anything that does not add up', () {
    for (final mutate in <void Function(Map<String, dynamic>)>[
      (a) => a['total'] = '225.78',
      (a) => a['schema'] = 1,
      (a) => (a['items'] as List)[0]['lineTotal'] = '1.234',
      (a) => (a['items'] as List)[0]['lineTotal'] = '0',
      (a) => a['items'] = [],
      (a) => a['currency'] = 'XXX',
    ]) {
      final answer = _sok();
      mutate(answer);
      expect(
        AiReceiptReader.interpret(answer, currencyCode: 'TRY'),
        isA<AiReceiptRetake>(),
      );
    }
  });

  test('failures route to retake or to the on-device path', () async {
    final rejected = await _reader(
      _ai({
        'error': 'bad_model_output',
        'reason': 'not_reconciled',
      }, status: 502),
    ).read(['a'], currencyCode: 'TRY');
    expect((rejected as AiReceiptRetake).reason, 'rejected');

    final quota = await _reader(
      _ai({
        'error': 'quota',
        'tier': 'free',
        'limit': 10,
        'used': 10,
      }, status: 429),
    ).read(['a'], currencyCode: 'TRY');
    expect((quota as AiReceiptUnavailable).result, isA<AiQuota>());

    final log = <Map<String, dynamic>>[];
    final off = _ai(_sok(), log: log)..enabled = false;
    expect(
      await _reader(off).read(['a'], currencyCode: 'TRY'),
      isA<AiReceiptUnavailable>(),
    );
    final unreadable = AiReceiptReader(
      _ai(_sok(), log: log),
      encode: (_) async => null,
    );
    expect(
      await unreadable.read(['a'], currencyCode: 'TRY'),
      isA<AiReceiptRetake>(),
    );
    expect(
      await _reader(_ai(_sok(), log: log))
          .read(['1', '2', '3', '4', '5'], currencyCode: 'TRY'),
      isA<AiReceiptRetake>(),
    );
    expect(log, isEmpty);
  });
}
