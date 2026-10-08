import '../../core/money/decimal_fixed.dart';
import '../../core/quantity/unit_code.dart';
import '../ai/ai_client.dart';
import 'parser/parsed_item_candidate.dart';
import 'parser/voice_command_parser.dart';

/// Taslak sonucu: adaylar + kaynağı + (varsa) AI'nın neden kullanılamadığı.
class ListDraft {
  const ListDraft(this.items, {required this.fromAi, this.aiResult});
  final List<ParsedItemCandidate> items;
  final bool fromAi;

  /// AI denendiyse ve başarısızsa sebep (kota/çevrimdışı/hata); başarılıysa AiOk.
  final AiResult? aiResult;
}

/// "1 kilo elma alacağım 20 lira, 2 ekmek" → ürün adayları (PB-050).
/// Önce AI vekili; olmazsa cihazdaki kural tabanlı ayrıştırıcı, cümle
/// virgül/satır/"ve" ile bölünerek. Sonuç yalnız önizlemedir (C-003).
class AiListParser {
  AiListParser({this.ai, required this.localeCode});

  final AiClient? ai;
  final String localeCode;

  Future<ListDraft> parse(String text) async {
    final raw = text.trim();
    if (raw.isEmpty) return const ListDraft([], fromAi: false);
    AiResult? result;
    final client = ai;
    if (client != null && client.enabled) {
      result = await client.request('parse_list', {'text': raw}, locale: localeCode);
      if (result is AiOk) {
        final items = _fromAi(result.result, raw);
        if (items.isNotEmpty) return ListDraft(items, fromAi: true, aiResult: result);
      }
    }
    return ListDraft(_local(raw), fromAi: false, aiResult: result);
  }

  List<ParsedItemCandidate> _fromAi(Map<String, dynamic> json, String raw) {
    final items = json['items'];
    if (items is! List) return const [];
    final out = <ParsedItemCandidate>[];
    for (final i in items) {
      if (i is! Map) continue;
      final name = '${i['name'] ?? ''}'.trim();
      if (name.isEmpty) continue;
      UnitCode? unit;
      for (final u in UnitCode.values) {
        if (u.dbCode == i['unit']) unit = u;
      }
      out.add(ParsedItemCandidate(
        name: name,
        rawText: raw,
        quantity: _decimal(i['quantity']),
        unitCode: unit,
        unitPrice: _decimal(i['estimatedPrice']),
        isUnitPrice: i['estimatedPrice'] == null ? null : i['priceIsUnitPrice'] == true,
      ));
    }
    return out;
  }

  static DecimalFixed? _decimal(Object? v) {
    if (v is! String || !RegExp(r'^\d{1,9}(\.\d{1,3})?$').hasMatch(v)) return null;
    return DecimalFixed.parse(v);
  }

  List<ParsedItemCandidate> _local(String raw) {
    final splitter = localeCode.startsWith('tr')
        ? RegExp(r'[,;\n]+|\s+ve\s+', caseSensitive: false)
        : RegExp(r'[,;\n]+|\s+and\s+', caseSensitive: false);
    final parser = VoiceCommandParser(localeCode: localeCode);
    return [
      for (final part in raw.split(splitter))
        if (part.trim().isNotEmpty) parser.parse(part.trim()),
    ].where((c) => c.name.trim().isNotEmpty).toList();
  }
}
