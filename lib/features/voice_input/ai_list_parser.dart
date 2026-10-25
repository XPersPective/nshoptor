import '../../core/money/decimal_fixed.dart';
import '../../core/quantity/unit_code.dart';
import '../ai/ai_client.dart';
import 'parser/parsed_item_candidate.dart';
import 'parser/voice_command_parser.dart';

/// Taslak sonucu: adaylar + kaynağı + (varsa) AI'nın neden kullanılamadığı.
class ListDraft {
  const ListDraft(
    this.items, {
    required this.fromAi,
    this.aiResult,
    this.title,
    this.plannedAt,
    this.parseDuration = Duration.zero,
    this.modelCalls = 0,
  });
  final List<ParsedItemCandidate> items;
  final bool fromAi;
  final Duration parseDuration;
  final int modelCalls;
  final String? title;
  final DateTime? plannedAt;

  /// AI denendiyse ve başarısızsa sebep (kota/çevrimdışı/hata); başarılıysa AiOk.
  final AiResult? aiResult;
}

/// "1 kilo elma alacağım 20 lira, 2 ekmek" → ürün adayları (PB-050).
/// Complete commands use local rules; unfamiliar clauses use the AI proxy.
/// Both paths return only a preview until explicit approval (C-003).
class AiListParser {
  AiListParser({this.ai, required this.localeCode});

  final AiClient? ai;
  final String localeCode;

  Future<ListDraft> parse(String text) async {
    final raw = text.trim();
    if (raw.isEmpty) return const ListDraft([], fromAi: false);
    final watch = Stopwatch()..start();
    final local = _local(raw);
    // Complete simple commands need no network call. Unfamiliar language and
    // incomplete clauses still use the model, with local preview on failure.
    final locallyCertain =
        (localeCode.startsWith('tr') || localeCode.startsWith('en')) &&
        local.isNotEmpty &&
        local.every(
          (c) =>
              c.fullyParsed &&
              c.name.split(' ').length <= 4 &&
              !RegExp(r'\d|alacağ|istiyor|\b(and|ve|toplam|fiyatı)\b')
                  .hasMatch(c.name),
        );
    if (locallyCertain) {
      return ListDraft(local, fromAi: false, parseDuration: watch.elapsed);
    }
    AiResult? result;
    final client = ai;
    if (client != null && client.enabled) {
      result = await client.request('parse_list', {
        'text': raw,
        'priceSemanticsVersion': 2,
      }, locale: localeCode);
      if (result is AiOk) {
        final items = _fromAi(result.result, raw);
        final title = _text(result.result['title'], 80);
        if (items.isNotEmpty) {
          return ListDraft(
            items,
            fromAi: true,
            aiResult: result,
            title: title,
            parseDuration: watch.elapsed,
            modelCalls: 1,
          );
        }
      }
    }
    return ListDraft(
      local,
      fromAi: false,
      aiResult: result,
      parseDuration: watch.elapsed,
      modelCalls: result == null ? 0 : 1,
    );
  }

  List<ParsedItemCandidate> _fromAi(Map<String, dynamic> json, String raw) {
    final items = json['items'];
    if (items is! List) return const [];
    final out = <ParsedItemCandidate>[];
    for (final i in items) {
      if (i is! Map) continue;
      final name = _text(i['name'], 60) ?? '';
      if (name.isEmpty) continue;
      UnitCode? unit;
      for (final u in UnitCode.values) {
        if (u.dbCode == i['unit']) unit = u;
      }
      out.add(
        ParsedItemCandidate(
          name: name,
          rawText: raw,
          brand: _text(i['brand'], 60),
          category: _text(i['category'], 60),
          quantity: _decimal(i['quantity']),
          unitCode: unit,
          priceUnitCode: UnitCode.values
              .where((u) => u.dbCode == i['priceUnitCode'])
              .firstOrNull,
          unitPrice: _decimal(i['estimatedPrice']),
          isUnitPrice: i['priceIsUnitPrice'] is bool
              ? i['priceIsUnitPrice'] as bool
              : null,
          currencyCode:
              i['currencyCode'] is String &&
                  RegExp(r'^[A-Z]{3}$').hasMatch(i['currencyCode'])
              ? i['currencyCode'] as String
              : null,
          priceDestination: i['priceDestination'] == 'actual'
              ? VoicePriceDestination.actual
              : VoicePriceDestination.planned,
        ),
      );
    }
    return out;
  }

  static String? _text(Object? v, int max) {
    if (v is! String || v.trim().isEmpty) return null;
    final t = v.trim();
    return t.length > max ? t.substring(0, max) : t;
  }

  static DecimalFixed? _decimal(Object? v) {
    if (v is! String || !RegExp(r'^\d{1,9}(\.\d{1,3})?$').hasMatch(v)) {
      return null;
    }
    return DecimalFixed.parse(v);
  }

  List<ParsedItemCandidate> _local(String raw) {
    final parser = VoiceCommandParser(localeCode: localeCode);
    return [
      for (final item in parser.splitItems(raw)) parser.parse(item),
    ].where((c) => c.name.trim().isNotEmpty).toList();
  }
}
