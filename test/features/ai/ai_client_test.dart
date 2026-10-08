import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/ai/ai_client.dart';

void main() {
  AiClient client(MockClient mock, {SettingsStore? store}) =>
      AiClient(store: store ?? SettingsStore(), baseUrl: 'https://x', httpClient: mock);

  test('başarılı yanıt AiOk; gövdede kurulum kimliği ve metin', () async {
    late Map<String, dynamic> sent;
    final mock = MockClient((req) async {
      sent = jsonDecode(req.body) as Map<String, dynamic>;
      return http.Response(
          jsonEncode({'tier': 'free', 'used': 1, 'limit': 15, 'result': {'items': []}}), 200);
    });
    final r = await client(mock).request('parse_list', {'text': 'elma'}, locale: 'tr');
    expect(r, isA<AiOk>());
    expect((r as AiOk).limit, 15);
    expect(sent['installId'], matches(RegExp(r'^[a-f0-9]{32}$')));
    expect(sent['input'], {'text': 'elma'});
    expect(sent.containsKey('purchaseToken'), isFalse);
  });

  test('429 quota → AiQuota', () async {
    final mock = MockClient((_) async => http.Response(
        jsonEncode({'error': 'quota', 'tier': 'free', 'limit': 15, 'used': 15}), 429));
    final r = await client(mock).request('parse_list', {'text': 'x'});
    expect(r, isA<AiQuota>());
    expect((r as AiQuota).used, 15);
  });

  test('ağ hatası → AiOffline', () async {
    final mock = MockClient((_) async => throw const SocketException('down'));
    expect(await client(mock).request('parse_list', {'text': 'x'}), isA<AiOffline>());
  });

  test('sunucu hatası → AiFailed', () async {
    final mock = MockClient((_) async => http.Response(jsonEncode({'error': 'ai_failed'}), 502));
    final r = await client(mock).request('parse_list', {'text': 'x'});
    expect(r, isA<AiFailed>());
    expect((r as AiFailed).reason, 'ai_failed');
  });

  test('kapalıyken hiç istek yapılmaz', () async {
    var calls = 0;
    final mock = MockClient((_) async {
      calls++;
      return http.Response('{}', 200);
    });
    final c = client(mock)..enabled = false;
    final r = await c.request('parse_list', {'text': 'x'});
    expect(r, isA<AiFailed>());
    expect(calls, 0);
  });

  test('kurulum kimliği kalıcı ve aynı', () {
    final store = SettingsStore();
    final a = AiClient(store: store, baseUrl: 'https://x').installId;
    final b = AiClient(store: store, baseUrl: 'https://x').installId;
    expect(a, b);
  });
}
