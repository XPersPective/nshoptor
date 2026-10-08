import '../../../core/money/decimal_fixed.dart';
import '../../ai/ai_client.dart';
import 'price_candidates.dart';

/// Raf etiketi: cihazda okunan OCR metninden fiyatı AI ile çıkarır (PB-052).
/// Fotoğraf gönderilmez, yalnız metin. Sonuçlar yalnız adaydır; kullanıcı
/// seçer. Başarısızlıkta boş liste — çağıran yerel çıkarımı kullanır.
class AiLabelReader {
  AiLabelReader(this.ai, {this.localeCode = 'tr'});

  final AiClient ai;
  final String localeCode;

  static const aiConfidence = 'ai';

  Future<List<PriceCandidate>> read(String ocrText, {required String currencyCode}) async {
    final text = ocrText.trim();
    if (!ai.enabled || text.isEmpty) return const [];
    final r = await ai.request('read_label', {'text': text}, locale: localeCode);
    if (r is! AiOk) return const [];
    final name = '${r.result['productName'] ?? ''}'.trim();
    DecimalFixed? dec(Object? v) =>
        v is String && RegExp(r'^\d{1,9}(\.\d{1,3})?$').hasMatch(v) ? DecimalFixed.parse(v) : null;
    final price = dec(r.result['price']);
    final unitPrice = dec(r.result['unitPrice']);
    return [
      if (price != null)
        PriceCandidate(
          value: price,
          currencyCode: currencyCode,
          sourceLine: name,
          confidence: aiConfidence,
          isUnitPrice: false,
        ),
      if (unitPrice != null && unitPrice != price)
        PriceCandidate(
          value: unitPrice,
          currencyCode: currencyCode,
          sourceLine: name,
          confidence: aiConfidence,
          isUnitPrice: true,
        ),
    ];
  }
}
