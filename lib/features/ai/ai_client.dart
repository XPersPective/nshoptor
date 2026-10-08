import 'dart:async';
import 'dart:convert';
import 'dart:io' show SocketException;
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:napp_core/napp_core.dart';

/// AI vekiline (server/, ADR-004) tek kapı. Uygulama hiçbir sır taşımaz:
/// yalnız rastgele kurulum kimliği ve (Pro/Max'ta) Play satın alma jetonu
/// gönderilir; fotoğraf/ses asla gönderilmez, yalnız metin (C-020).
sealed class AiResult {
  const AiResult();
}

class AiOk extends AiResult {
  const AiOk(this.result, {required this.tier, required this.used, required this.limit});
  final Map<String, dynamic> result;
  final String tier;
  final int used;
  final int limit;
}

class AiQuota extends AiResult {
  const AiQuota({required this.tier, required this.limit, required this.used});
  final String tier;
  final int limit;
  final int used;
}

class AiOffline extends AiResult {
  const AiOffline();
}

class AiFailed extends AiResult {
  const AiFailed(this.reason);
  final String reason;
}

/// Pro/Max doğrulaması için mağaza jetonu (PB-055 bağlar).
typedef PurchaseCredential = ({String token, String productId});

class AiClient {
  AiClient({
    required this.store,
    required this.baseUrl,
    http.Client? httpClient,
    this.credential,
    this.timeout = const Duration(seconds: 25),
  }) : _http = httpClient ?? http.Client();

  static const enabledKey = 'ai_enabled';
  static const installIdKey = 'ai_install_id';
  static const maxResponseBytes = 64 * 1024;

  final SettingsStore store;
  final String baseUrl;
  final http.Client _http;
  final PurchaseCredential? Function()? credential;
  final Duration timeout;

  bool get enabled => store.getBool(enabledKey) ?? true;
  set enabled(bool value) => store.setBool(enabledKey, value);

  /// Rastgele 32 hex; kişisel veri değildir, yalnız kota sayacının anahtarı.
  String get installId {
    final existing = store.getString(installIdKey);
    if (existing != null && RegExp(r'^[a-f0-9]{32}$').hasMatch(existing)) {
      return existing;
    }
    final rnd = Random.secure();
    final id = List.generate(16, (_) => rnd.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
    store.setString(installIdKey, id);
    return id;
  }

  Future<AiResult> request(String task, Map<String, Object?> input, {String locale = 'en'}) async {
    if (!enabled) return const AiFailed('disabled');
    final cred = credential?.call();
    final body = jsonEncode({
      'installId': installId,
      'task': task,
      'locale': locale,
      'input': input,
      if (cred != null) 'purchaseToken': cred.token,
      if (cred != null) 'productId': cred.productId,
    });
    try {
      final req = http.Request('POST', Uri.parse('$baseUrl/v1/ai'))
        ..headers['content-type'] = 'application/json'
        ..body = body;
      final res = await _http.send(req).timeout(timeout);
      final bytes = <int>[];
      await for (final chunk in res.stream.timeout(timeout)) {
        bytes.addAll(chunk);
        if (bytes.length > maxResponseBytes) return const AiFailed('too_large');
      }
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is! Map<String, dynamic>) return const AiFailed('bad_response');
      if (res.statusCode == 429 && decoded['error'] == 'quota') {
        return AiQuota(
          tier: '${decoded['tier']}',
          limit: (decoded['limit'] as num?)?.toInt() ?? 0,
          used: (decoded['used'] as num?)?.toInt() ?? 0,
        );
      }
      final result = decoded['result'];
      if (res.statusCode != 200 || result is! Map<String, dynamic>) {
        return AiFailed('${decoded['error'] ?? res.statusCode}');
      }
      return AiOk(
        result,
        tier: '${decoded['tier']}',
        used: (decoded['used'] as num?)?.toInt() ?? 0,
        limit: (decoded['limit'] as num?)?.toInt() ?? 0,
      );
    } on SocketException {
      return const AiOffline();
    } on TimeoutException {
      return const AiOffline();
    } on http.ClientException {
      return const AiOffline();
    } on FormatException {
      return const AiFailed('bad_response');
    }
  }
}

/// Boot'ta bağlanan tek örnek (AppDefaults deseni). Testlerde null → AI yok.
class AiService {
  AiService._();
  static AiClient? client;
}
