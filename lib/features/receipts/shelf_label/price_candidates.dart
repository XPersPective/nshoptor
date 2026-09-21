import '../../../core/money/decimal_fixed.dart';
import '../ocr_text_source.dart';

/// Raf etiketinden çıkarılan fiyat adayı (spec §6.8).
class PriceCandidate {
  const PriceCandidate({
    required this.value,
    required this.currencyCode,
    required this.sourceLine,
    required this.confidence,
    required this.isUnitPrice,
  });

  /// Etiketteki ham metin (kullanıcı doğrulaması için).
  final String sourceLine;
  final DecimalFixed value;
  final String currencyCode;

  /// high: para birimi simgesi/kodu VE virgüllü iki basamak gibi net işaret;
  /// medium: biçim tutarlı; low: yalnız sayı.
  final String confidence;

  /// `₺/kg` gibi birim fiyat kalıbı bulunduysa true.
  final bool isUnitPrice;
}

/// Raf etiketi fiyat adayı çıkarımı (spec §6.8).
///
/// KURAL: en BÜYÜK sayı körlemesine fiyat sanılmaz. Eski fiyat (üstü çizili
/// görünemez ama genelde küçük/kalın farkı satırda işaretsizdir), üyelik
/// fiyatı ve birim fiyat birlikte bulunabilir; adaylar güven derecesiyle
/// LİSTELENİR, kullanıcı seçer.
class ShelfPriceExtractor {
  ShelfPriceExtractor({this.defaultCurrency = 'TRY'});

  final String defaultCurrency;

  /// Etikette bulunan tüm fiyat adayları; konuma göre (üst-sol) sıralı.
  List<PriceCandidate> extract(List<OcrLine> lines) {
    final candidates = <PriceCandidate>[];
    for (final line in lines) {
      // Hacim/ağırlık miktarı görünen satırlarda (ör. '1 LT SÜT') tam sayı
      // fiyat sanılmaz.
      final isQuantityLine = RegExp(r'\b\d+\s*(LT|KG|GR|G|ML)\b',
              caseSensitive: false)
          .hasMatch(line.text);
      final matches = _pricePattern.allMatches(line.text);
      for (final match in matches) {
        final raw = match.group(1)!;
        final value = DecimalFixed.tryParse(_normalizePriceText(raw));
        if (value == null || !value.isPositive) continue;
        if (isQuantityLine && RegExp(r'^\d+$').hasMatch(raw)) continue;

        final around = line.text;
        final hasCurrency = _currencyWords.any(around.contains) ||
            RegExp(r'[₺€$]').hasMatch(around);
        final isUnit = RegExp(r'[/]\s*(kg|gr|g|lt|L|ml|adet)', caseSensitive: false)
            .hasMatch(around);
        final wellFormed = RegExp(r'^\d{1,3}([.,]\d{3})*[.,]\d{2}$').hasMatch(raw);

        String confidence;
        if (hasCurrency && wellFormed) {
          confidence = 'high';
        } else if (wellFormed || hasCurrency) {
          confidence = 'medium';
        } else {
          confidence = 'low';
        }

        candidates.add(PriceCandidate(
          value: value,
          currencyCode: defaultCurrency,
          sourceLine: line.text.trim(),
          confidence: confidence,
          isUnitPrice: isUnit,
        ));
      }
    }

    // konum sırası: üst-sol önce (etikette ana fiyat genelde üsttedir)
    candidates.sort((a, b) {
      final sa = _sourceOrder(a.sourceLine, lines);
      final sb = _sourceOrder(b.sourceLine, lines);
      return sa.compareTo(sb);
    });
    return candidates;
  }

  int _sourceOrder(String sourceLine, List<OcrLine> lines) {
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].text.trim() == sourceLine) return i;
    }
    return lines.length;
  }

  /// Eşleşen fiyat dizgesini kanonik `.`-ondalık biçime çevirir:
  /// - İki ayraç da varsa SONRAKİ ondalıktır, diğeri binlik.
  /// - Yalnız `,` → ondalık. Yalnız `.` ve sonrası 2 basamak → ondalık;
  ///   aksi halde binlik (kaldırılır).
  static String _normalizePriceText(String raw) {
    final hasComma = raw.contains(',');
    final hasDot = raw.contains('.');
    if (hasComma && hasDot) {
      final lastComma = raw.lastIndexOf(',');
      final lastDot = raw.lastIndexOf('.');
      return lastComma > lastDot
          ? raw.replaceAll('.', '').replaceAll(',', '.')
          : raw.replaceAll(',', '');
    }
    if (hasComma) return raw.replaceAll(',', '.');
    if (hasDot) {
      final frac = raw.substring(raw.lastIndexOf('.') + 1);
      return frac.length == 2 ? raw : raw.replaceAll('.', '');
    }
    return raw;
  }

  /// `42,90` | `42.90` | `1.234,56` | `1,234.56` | `₺42,90` fiyat çekirdeği.
  static final RegExp _pricePattern = RegExp(
    r'(\d{1,3}(?:[.,]\d{3})+[.,]\d{2}|\d+[.,]\d{2}|\d+)',
  );

  static const List<String> _currencyWords = [
    'TL', 'TRY', '₺', 'lira', 'EUR', '€', 'USD', r'$', 'KR', 'kr',
  ];
}
