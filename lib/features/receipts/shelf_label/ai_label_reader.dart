import '../../../core/money/decimal_fixed.dart';
import '../../../core/quantity/unit_code.dart';
import '../../ai/ai_client.dart';
import 'price_candidates.dart';
import '../ocr_currency.dart';
import '../ocr_text_source.dart';

/// Raf etiketi: cihazda okunan OCR metninden fiyatı AI ile çıkarır (PB-052).
/// Fotoğraf gönderilmez, yalnız metin. Sonuçlar yalnız adaydır; kullanıcı
/// seçer. Başarısızlıkta boş liste — çağıran yerel çıkarımı kullanır.
class AiLabelReader {
  AiLabelReader(this.ai, {this.localeCode = 'tr'});

  final AiClient ai;
  final String localeCode;
  AiResult? lastResult;

  static const aiConfidence = 'ai';

  Future<List<PriceCandidate>> read(
    String ocrText, {
    required String currencyCode,
  }) async {
    final text = ocrText.trim();
    if (!ai.enabled || text.isEmpty) return const [];
    final evidence = detectOcrCurrency(text, fallback: currencyCode);
    if (evidence.conflictsWith(currencyCode)) {
      lastResult = const AiFailed('currency_mismatch');
      return const [];
    }
    final AiResult r;
    try {
      r = await ai.request('read_label', {'text': text}, locale: localeCode);
    } catch (_) {
      lastResult = const AiFailed('request');
      return const [];
    }
    lastResult = r;
    if (r is! AiOk) return const [];
    final data = r.result;
    final rawName = data['productName'];
    final name = rawName is String ? rawName.trim() : '';
    final unit = UnitCode.values
        .where((u) => u.dbCode == data['unit'])
        .firstOrNull;
    DecimalFixed? dec(Object? v) =>
        v is String && RegExp(r'^\d{1,9}(\.\d{1,3})?$').hasMatch(v)
        ? DecimalFixed.parse(v)
        : null;
    final price = dec(r.result['price']);
    final unitPrice = dec(r.result['unitPrice']);
    final local = ShelfPriceExtractor(defaultCurrency: currencyCode)
        .extract(text.split('\n').map((s) => OcrLine(text: s)).toList());
    // Model output cannot introduce a price absent from the scanned text.
    PriceCandidate? evidenceFor(DecimalFixed? amount) => amount == null
        ? null
        : local.where((c) => c.value == amount).firstOrNull;
    final package = evidenceFor(price);
    final unitEvidence = local
        .where(
          (c) => c.value == unitPrice && c.isUnitPrice && c.unitCode == unit,
        )
        .firstOrNull;
    return [
      if (price != null && package != null && !package.isUnitPrice)
        PriceCandidate(
          value: price,
          currencyCode: currencyCode,
          sourceLine: name,
          productName: name.isEmpty
              ? null
              : name.length > 60
              ? name.substring(0, 60)
              : name,
          confidence: aiConfidence,
          isUnitPrice: false,
          unitCode: package.unitCode,
          priceQuantity: package.priceQuantity,
        ),
      if (unitPrice != null &&
          unitEvidence != null &&
          (unitPrice != price || unit != UnitCode.adet))
        PriceCandidate(
          value: unitPrice,
          currencyCode: currencyCode,
          sourceLine: name,
          productName: name.isEmpty
              ? null
              : name.length > 60
              ? name.substring(0, 60)
              : name,
          unitCode: unitEvidence.unitCode,
          priceQuantity: unitEvidence.priceQuantity,
          confidence: aiConfidence,
          isUnitPrice: true,
        ),
    ];
  }
}
