import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/features/ai/ai_client.dart';

http.Response _ok() => http.Response(
  jsonEncode({
    'tier': 'free',
    'used': 1,
    'limit': 10,
    'result': {'ok': true},
  }),
  200,
);

http.Response _access({
  int endsAt = 1_800_000_000_000,
  int serverNow = 1_700_000_000_000,
}) => http.Response(
  jsonEncode({
    'trial': {'endsAt': endsAt, 'serverNow': serverNow},
  }),
  200,
);

void main() {
  test(
    'a purchase restored during failed registration remains usable',
    () async {
      final pending = Completer<http.Response>();
      PurchaseCredential? credential;
      Map<String, dynamic>? sent;
      final mock = MockClient((request) async {
        if (request.url.path == '/v1/access') return pending.future;
        sent = jsonDecode(request.body) as Map<String, dynamic>;
        return _ok();
      });
      final c = AiClient(
        store: SettingsStore(),
        baseUrl: 'https://x',
        httpClient: mock,
        trialFirstOpenedAt: () => 42,
        credential: () => credential,
      );
      final result = c.request('parse_list', {'text': 'milk'});
      await Future<void>.delayed(Duration.zero);
      credential = (
        token: 'restored-private-token',
        productId: 'nshoptor_pro_v2',
      );
      pending.complete(http.Response('{}', 503));
      expect(await result, isA<AiOk>());
      expect(sent?['purchaseToken'], credential.token);
    },
  );

  AiClient client(
    MockClient mock, {
    SettingsStore? store,
    int? Function()? firstOpen,
    void Function(AiTrialWindow)? onWindow,
  }) => AiClient(
    store: store ?? SettingsStore(),
    baseUrl: 'https://x',
    httpClient: mock,
    trialFirstOpenedAt: firstOpen,
    onTrialWindow: onWindow,
  );

  test('registers installation before the first AI request and observes server window', () async {
    final paths = <String>[];
    late Map<String, dynamic> registration;
    AiTrialWindow? observed;
    final mock = MockClient((req) async {
      paths.add(req.url.path);
      if (req.url.path == '/v1/access') {
        registration = jsonDecode(req.body) as Map<String, dynamic>;
        return _access();
      }
      return _ok();
    });
    final c = client(
      mock,
      firstOpen: () => 1234,
      onWindow: (w) => observed = w,
    );

    expect(await c.request('parse_list', {'text': 'tea'}), isA<AiOk>());
    expect(paths, ['/v1/access', '/v1/ai']);
    expect(registration['installId'], matches(RegExp(r'^[a-f0-9]{32}$')));
    expect(registration['firstOpenedAt'], 1234);
    expect(observed?.endsAt, 1_800_000_000_000);
  });

  test('coalesces concurrent access registration', () async {
    final release = Completer<http.Response>();
    var accesses = 0;
    var ais = 0;
    final mock = MockClient((req) async {
      if (req.url.path == '/v1/access') {
        accesses++;
        return release.future;
      }
      ais++;
      return _ok();
    });
    final c = client(mock, firstOpen: () => 42);
    final a = c.request('one', {});
    final b = c.request('two', {});
    await Future<void>.delayed(Duration.zero);
    expect(accesses, 1);
    expect(ais, 0);
    release.complete(_access());
    expect(await Future.wait([a, b]), everyElement(isA<AiOk>()));
    expect(accesses, 1);
    expect(ais, 2);
  });

  test('failed registration blocks AI quota call and can be retried', () async {
    var accesses = 0;
    var ais = 0;
    final mock = MockClient((req) async {
      if (req.url.path == '/v1/access') {
        accesses++;
        return accesses == 1
            ? http.Response('{"error":"busy"}', 503)
            : _access();
      }
      ais++;
      return _ok();
    });
    final c = client(mock, firstOpen: () => 7);

    expect(await c.request('first', {}), isA<AiFailed>());
    expect(ais, 0);
    expect(await c.request('retry', {}), isA<AiOk>());
    expect(accesses, 2);
    expect(ais, 1);
  });

  test('404 old worker keeps the legacy AI path', () async {
    final paths = <String>[];
    final mock = MockClient((req) async {
      paths.add(req.url.path);
      return req.url.path == '/v1/access' ? http.Response('', 404) : _ok();
    });
    final c = client(mock, firstOpen: () => 7);

    expect(await c.request('parse', {}), isA<AiOk>());
    expect(await c.request('parse', {}), isA<AiOk>());
    expect(paths, ['/v1/access', '/v1/ai', '/v1/ai']);
  });

  test('disabled client performs no network IO', () async {
    var calls = 0;
    final mock = MockClient((_) async {
      calls++;
      return _ok();
    });
    final c = client(mock, firstOpen: () => 9)..enabled = false;

    expect(await c.request('parse', {}), isA<AiFailed>());
    expect(calls, 0);
  });

  test('valid paid credential skips promotional registration', () async {
    final paths = <String>[];
    final mock = MockClient((req) async {
      paths.add(req.url.path);
      return _ok();
    });
    final c = AiClient(
      store: SettingsStore(),
      baseUrl: 'https://x',
      httpClient: mock,
      trialFirstOpenedAt: () => 9,
      credential: () => (token: 'purchase', productId: 'nshoptor_pro_v2'),
    );

    expect(await c.request('parse', {}), isA<AiOk>());
    expect(paths, ['/v1/ai']);
  });

  test('invalid access window fails closed without an AI request', () async {
    var ais = 0;
    final mock = MockClient((req) async {
      if (req.url.path == '/v1/access') {
        return http.Response('{"trial":{"endsAt":-1,"serverNow":2}}', 200);
      }
      ais++;
      return _ok();
    });
    final c = client(mock, firstOpen: () => 1);

    expect(await c.request('parse', {}), isA<AiFailed>());
    expect(ais, 0);
  });
}
