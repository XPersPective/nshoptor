import '../../../core/money/decimal_fixed.dart';
import '../../../core/quantity/unit_code.dart';
import '../../ai/ai_client.dart';
import '../ai_image.dart';
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

  /// Image protocol `label.v1`: the photo goes to the image model (never
  /// stored). Returns candidates for the user to pick, or null when AI is
  /// unavailable and the caller should rely on on-device OCR. The model's
  /// currency must not contradict the list currency.
  Future<List<PriceCandidate>?> readImage(
    String path, {
    required String currencyCode,
    Future<String?> Function(String path) encode = encodeImageForAi,
  }) async {
    if (!ai.enabled) return null;
    final image = await encode(path);
    if (image == null) return null;
    final AiResult r;
    try {
      r = await ai.request('read_label_image', {
        'images': [image],
        'currency': currencyCode,
      }, locale: localeCode);
    } catch (_) {
      lastResult = const AiFailed('request');
      return null;
    }
    lastResult = r;
    if (r is! AiOk) return null;
    final data = r.result;
    if (data['schema'] != 1 || data['status'] != 'ok') return const [];
    final currency = data['currency'];
    if (currency is String && currency != currencyCode) {
      lastResult = const AiFailed('currency_mismatch');
      return const [];
    }
    DecimalFixed? dec(Object? v) =>
        v is String && RegExp(r'^\d{1,9}(\.\d{1,3})?$').hasMatch(v)
        ? DecimalFixed.parse(v)
        : null;
    final rawName = data['productName'];
    final name = rawName is String && rawName.trim().isNotEmpty
        ? rawName.trim()
        : null;
    final price = dec(data['price']);
    final unitPrice = dec(data['unitPrice']);
    final unit = UnitCode.values
        .where((u) => u.dbCode == data['unit'])
        .firstOrNull;
    return [
      if (price != null)
        PriceCandidate(
          value: price,
          currencyCode: currencyCode,
          sourceLine: name ?? '',
          productName: name,
          confidence: aiConfidence,
          isUnitPrice: false,
        ),
      if (unitPrice != null && unit != null)
        PriceCandidate(
          value: unitPrice,
          currencyCode: currencyCode,
          sourceLine: name ?? '',
          productName: name,
          confidence: aiConfidence,
          isUnitPrice: true,
          unitCode: unit,
        ),
    ];
  }

  /// Package price whose exact amount is printed as its own number on the label
  /// and is not part of a per-unit price already found locally.
  PriceCandidate? _printedPackage(String text, DecimalFixed? amount) {
    if (amount == null) return null;
    for (final m in RegExp(r'\d+(?:[.,]\d+)*').allMatches(text)) {
      var token = m.group(0)!;
      final comma = token.lastIndexOf(','), dot = token.lastIndexOf('.');
      final decimalAt = comma > dot ? comma : dot;
      token = decimalAt < 0
          ? token
          : '${token.substring(0, decimalAt).replaceAll(RegExp(r'[.,]'), '')}.${token.substring(decimalAt + 1)}';
      final value = DecimalFixed.tryParse(token);
      if (value == null || value != amount) continue;
      final tail = text.substring(m.end).trimLeft();
      if (RegExp(r'^(?:₺|tl|try)?\s*/').hasMatch(tail.toLowerCase())) continue;
      return PriceCandidate(
        value: amount,
        currencyCode: '',
        sourceLine: m.group(0)!,
        confidence: aiConfidence,
        isUnitPrice: false,
      );
    }
    return null;
  }

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
    // A layout the local extractor cannot structure still counts as evidence
    // when the exact amount is printed on the label; it carries no unit claim.
    final package = evidenceFor(price) ?? _printedPackage(text, price);
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
