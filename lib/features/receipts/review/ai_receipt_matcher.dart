import '../../ai/ai_client.dart';

/// AI eşleşmesi: fiş satırı [lineIndex] → plandaki ürün (yoksa null).
typedef AiLineMatch = ({int lineIndex, int? plannedId, String confidence, bool isDiscount});

/// Fiş satırlarını plana AI ile bağlar (PB-051): "INDIRIMLI ELMA KG" → "elma".
/// Yalnız gönderilen plan kimlikleri kabul edilir; başarısızlıkta null döner
/// ve çağıran kural tabanlı eşleştiriciye düşer. Sonuç yalnız öneridir (C-003).
class AiReceiptMatcher {
  AiReceiptMatcher(this.ai, {this.localeCode = 'tr'});

  final AiClient ai;
  final String localeCode;

  /// [lines]: (indeks, fişteki metin, satır tutarı ondalık dizge).
  /// [planned]: (kimlik, ad).
  Future<({List<AiLineMatch> matches, AiResult result})?> match(
    List<({int index, String text, String total})> lines,
    List<({int id, String name})> planned,
  ) async {
    if (!ai.enabled || lines.isEmpty || planned.isEmpty) return null;
    final result = await ai.request('match_receipt', {
      'lines': [for (final l in lines) {'i': l.index, 'text': l.text, 'total': l.total}],
      'planned': [for (final p in planned) {'id': p.id, 'name': p.name}],
    }, locale: localeCode);
    if (result is! AiOk) return (matches: const <AiLineMatch>[], result: result);
    final known = {for (final p in planned) p.id};
    final lineIds = {for (final l in lines) l.index};
    final raw = result.result['matches'];
    final out = <AiLineMatch>[];
    if (raw is List) {
      for (final m in raw) {
        if (m is! Map) continue;
        final i = m['i'];
        if (i is! int || !lineIds.contains(i)) continue;
        final pid = m['plannedId'];
        out.add((
          lineIndex: i,
          plannedId: pid is int && known.contains(pid) ? pid : null,
          confidence: const {'high', 'medium', 'low'}.contains(m['confidence']) ? m['confidence'] as String : 'low',
          isDiscount: m['isDiscount'] == true,
        ));
      }
    }
    return (matches: out, result: result);
  }
}
