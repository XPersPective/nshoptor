import 'dart:async';
import 'dart:convert';
import 'dart:io' show SocketException;
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:napp_core/napp_core.dart';

/// AI vekiline (server/, ADR-004) tek kapı. Uygulama hiçbir sır taşımaz:
/// yalnız rastgele kurulum kimliği ve mağazanın doğrulanacak satın alma kanıtı
/// gönderilir; fotoğraf/ses asla gönderilmez, yalnız metin (C-020).
sealed class AiResult {
  const AiResult();
}

class AiOk extends AiResult {
  const AiOk(
    this.result, {
    required this.tier,
    required this.used,
    required this.limit,
  });
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

class AiTrialWindow {
  const AiTrialWindow({required this.endsAt, required this.serverNow});
  final int endsAt;
  final int serverNow;
}

class AiClient {
  AiClient({
    required this.store,
    required this.baseUrl,
    http.Client? httpClient,
    this.credential,
    this.appleTransaction,
    this.trialFirstOpenedAt,
    this.onTrialWindow,
    this.timeout = const Duration(seconds: 25),
  }) : _http = httpClient ?? http.Client();

  static const enabledKey = 'ai_enabled';
  static const installIdKey = 'ai_install_id';
  static const maxResponseBytes = 64 * 1024;

  final SettingsStore store;
  final String baseUrl;
  final http.Client _http;
  final PurchaseCredential? Function()? credential;

  /// StoreKit 2 signed transaction. Kept separate from Google Play tokens so
  /// the server verifies it with the correct store and trust roots.
  final String? Function()? appleTransaction;
  final int? Function()? trialFirstOpenedAt;
  final void Function(AiTrialWindow)? onTrialWindow;
  final Duration timeout;
  Future<AiResult?>? _registration;
  bool _registered = false;

  bool get enabled => store.getBool(enabledKey) ?? true;
  set enabled(bool value) => store.setBool(enabledKey, value);

  /// Rastgele 32 hex; kişisel veri değildir, yalnız kota sayacının anahtarı.
  String get installId {
    final existing = store.getString(installIdKey);
    if (existing != null && RegExp(r'^[a-f0-9]{32}$').hasMatch(existing)) {
      return existing;
    }
    final rnd = Random.secure();
    final id = List.generate(
      16,
      (_) => rnd.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
    store.setString(installIdKey, id);
    return id;
  }

  Future<AiResult> request(
    String task,
    Map<String, Object?> input, {
    String locale = 'en',
  }) async {
    if (!enabled) return const AiFailed('disabled');
    var cred = credential?.call();
    var apple = appleTransaction?.call();
    // Register before spending a request under the Free fallback. Real paid
    // credentials stay independently usable when promotional registration fails.
    if (trialFirstOpenedAt != null &&
        cred == null &&
        apple == null &&
        !_registered) {
      final pending = _registration ??= _registerAccess();
      final access = await pending;
      if (identical(_registration, pending)) _registration = null;
      cred = credential?.call();
      apple = appleTransaction?.call();
      if (access != null && cred == null && apple == null) return access;
    }
    final body = jsonEncode({
      'installId': installId,
      'task': task,
      'locale': locale,
      'input': input,
      if (cred != null) 'purchaseToken': cred.token,
      if (cred != null) 'productId': cred.productId,
      'appleTransaction': ?apple,
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
      if (decoded is! Map<String, dynamic>) {
        return const AiFailed('bad_response');
      }
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

  Future<AiResult?> _registerAccess() async {
    try {
      final req = http.Request('POST', Uri.parse('$baseUrl/v1/access'))
        ..headers['content-type'] = 'application/json'
        ..body = jsonEncode({
          'installId': installId,
          'firstOpenedAt': trialFirstOpenedAt!.call(),
        });
      final response = await _http.send(req).timeout(timeout);
      final bytes = <int>[];
      await for (final chunk in response.stream.timeout(timeout)) {
        bytes.addAll(chunk);
        if (bytes.length > 2048) return const AiFailed('bad_response');
      }
      // Older workers retain their existing allowance during phased rollout.
      if (response.statusCode == 404) {
        _registered = true;
        return null;
      }
      if (response.statusCode != 200) return const AiFailed('busy');
      final decoded = jsonDecode(utf8.decode(bytes));
      final trial = decoded is Map<String, dynamic> ? decoded['trial'] : null;
      if (trial is! Map<String, dynamic>) return const AiFailed('bad_response');
      final end = trial['endsAt'], now = trial['serverNow'];
      if (end is! int ||
          now is! int ||
          end < 0 ||
          now < 0 ||
          end > 8640000000000000 ||
          now > 8640000000000000) {
        return const AiFailed('bad_response');
      }
      onTrialWindow?.call(AiTrialWindow(endsAt: end, serverNow: now));
      _registered = true;
      return null;
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
