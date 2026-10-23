import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/currency.dart';
import '../../../core/quantity/unit_code.dart';
import '../ocr_text_source.dart';
import '../ocr_currency.dart';

/// Raf etiketinden çıkarılan fiyat adayı (spec §6.8).
class PriceCandidate {
  const PriceCandidate({
    required this.value,
    required this.currencyCode,
    required this.sourceLine,
    required this.confidence,
    required this.isUnitPrice,
    this.productName,
    this.unitCode,
    this.priceQuantity,
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
  final String? productName;
  final UnitCode? unitCode;

  /// Explicit package quantity, e.g. 350 TRY for 400 g. Null means one
  /// quoted unit when isUnitPrice, or an unqualified package price otherwise.
  final DecimalFixed? priceQuantity;
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
    final evidence = detectOcrCurrency(
      lines.map((l) => l.text).join('\n'),
      fallback: defaultCurrency,
    );
    if (evidence.needsConfirmation) return const [];
    if (evidence.code != null && evidence.code != defaultCurrency) {
      return ShelfPriceExtractor(defaultCurrency: evidence.code!)
          .extract(lines);
    }
    final candidates = <PriceCandidate>[];
    for (final line in lines) {
      // Hacim/ağırlık miktarı görünen satırlarda (ör. '1 LT SÜT') tam sayı
      // fiyat sanılmaz.
      final quantityMatches = _quantityPattern.allMatches(line.text).toList();
      final matches = _pricePattern
          .allMatches(line.text)
          .where(
            (m) =>
                !quantityMatches.any(
                  (q) => m.start >= q.start && m.end <= q.end,
                ) &&
                !RegExp(r'^\d{8,}$').hasMatch(m.group(1)!),
          )
          .toList();
      for (final (index, match) in matches.indexed) {
        final raw = match.group(1)!;
        final normalized = _normalizePriceText(raw);
        final value = normalized == null
            ? null
            : DecimalFixed.tryParse(normalized);
        if (value == null || value.isNegative) continue;
        if (quantityMatches.any(
          (q) => match.start >= q.start && match.end <= q.end,
        )) {
          continue;
        }
        if (RegExp(r'^\d{8,}$').hasMatch(raw)) continue; // barcode/product code

        final around = line.text.substring(
          match.end,
          index + 1 < matches.length
              ? matches[index + 1].start
              : line.text.length,
        );
        final before = line.text.substring(
          index == 0 ? 0 : matches[index - 1].end,
          match.start,
        );
        final hasCurrency =
            _currencyWords.any(line.text.contains) ||
            RegExp(r'[₺€$]').hasMatch(line.text);
        final prefixUnit = RegExp(
          r'^\s*(kg|gr|g|lt|l|ml|adet)\s*[:=]?\s*$',
          caseSensitive: false,
        ).firstMatch(before)?.group(1)?.toLowerCase();
        final isUnit =
            prefixUnit != null ||
            RegExp(
              r'[/]\s*(?:\d+(?:[.,]\d+)?\s*)?(kg|gr|g|lt|L|ml|adet)\b',
              caseSensitive: false,
            ).hasMatch(around);
        final wellFormed = RegExp(r'^\d{1,3}([.,]\d{3})*[.,]\d{2}$')
            .hasMatch(raw);

        String confidence;
        if (hasCurrency && wellFormed) {
          confidence = 'high';
        } else if (wellFormed || hasCurrency) {
          confidence = 'medium';
        } else {
          confidence = 'low';
        }

        UnitCode? unit;
        if (isUnit) {
          final code = RegExp(
            r'/\s*(?:\d+(?:[.,]\d+)?\s*)?(kg|gr|g|lt|l|ml|adet)\b',
            caseSensitive: false,
          ).firstMatch(around)?.group(1)?.toLowerCase();
          unit = switch (code) {
            'kg' => UnitCode.kilogram,
            'gr' || 'g' => UnitCode.gram,
            'lt' || 'l' => UnitCode.litre,
            'ml' => UnitCode.mililitre,
            'adet' => UnitCode.adet,
            _ => null,
          };
          unit ??= prefixUnit == 'adet'
              ? UnitCode.adet
              : prefixUnit == null
              ? null
              : _unit(prefixUnit);
        }
        // ponytail: nearest preceding non-price text may be a brand/promotion; preview is editable. Upgrade to layout-aware extraction if needed.
        final preceding = lines
            .takeWhile((l) => !identical(l, line))
            .where(
              (l) =>
                  RegExp(r'[A-Za-z\u00c0-\uffff]').hasMatch(l.text) &&
                  !RegExp(r'[₺€$]|\d+[.,]\d{2}').hasMatch(l.text),
            );
        final name = preceding.isEmpty ? null : preceding.last.text.trim();
        final explicitBasis = RegExp(
          r'/\s*(\d+(?:[.,]\d+)?)\s*(kg|gr|g|lt|l|ml)\b',
          caseSensitive: false,
        ).firstMatch(around);
        final inlinePackage = quantityMatches
            .where(
              (q) =>
                  q.end <= match.start &&
                  !RegExp(r'/\s*$').hasMatch(line.text.substring(0, q.start)),
            )
            .firstOrNull;
        final package = !isUnit
            ? inlinePackage ?? _quantityPattern.firstMatch(name ?? '')
            : null;
        final basisQuantity = explicitBasis?.group(1) ?? package?.group(1);
        final basisCode = explicitBasis?.group(2) ?? package?.group(2);
        if (basisCode != null) unit = _unit(basisCode);
        candidates.add(
          PriceCandidate(
            value: value,
            currencyCode: defaultCurrency,
            sourceLine: line.text.trim(),
            confidence: confidence,
            isUnitPrice: isUnit,
            productName: name == null || name.isEmpty
                ? null
                : name.length > 60
                ? name.substring(0, 60)
                : name,
            unitCode: unit,
            priceQuantity: basisQuantity == null
                ? null
                : DecimalFixed.tryParse(basisQuantity.replaceAll(',', '.')),
          ),
        );
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

  static final _quantityPattern = RegExp(
    r'\b(\d+(?:[.,]\d+)?)\s*(kg|gr|g|lt|l|ml)\b',
    caseSensitive: false,
  );
  static UnitCode? _unit(String code) => switch (code.toLowerCase()) {
    'kg' => UnitCode.kilogram,
    'gr' || 'g' => UnitCode.gram,
    'lt' || 'l' => UnitCode.litre,
    'ml' => UnitCode.mililitre,
    _ => null,
  };

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
  String? _normalizePriceText(String raw) {
    final digits = Currency.fromCode(defaultCurrency).minorUnitDigits;
    final comma = raw.lastIndexOf(','), dot = raw.lastIndexOf('.');
    if (comma >= 0 && dot >= 0) {
      final decimal = comma > dot ? ',' : '.';
      final grouping = decimal == ',' ? '.' : ',';
      final parts = raw.split(decimal);
      if (parts.length != 2 ||
          parts.last.length > digits ||
          !RegExp(r'^\d{1,3}(?:[.,]\d{3})*$').hasMatch(parts.first)) {
        return null;
      }
      return '${parts.first.replaceAll(grouping, '')}.${parts.last}';
    }
    if (comma < 0 && dot < 0) return raw;
    final separator = comma >= 0 ? ',' : '.';
    final parts = raw.split(separator);
    if (separator == '.' &&
        parts.skip(1).every((p) => p.length == 3) &&
        parts.first.length <= 3 &&
        (digits != 3 || parts.length > 2)) {
      return parts.join();
    }
    if (parts.length != 2 || parts.last.length > digits) return null;
    return '${parts.first}.${parts.last}';
  }

  // Consume the complete numeric token: never turn 12.3456 into 12.34 + 56.
  RegExp get _pricePattern => RegExp(r'(\d+(?:[.,]\d+)*)');
  static const List<String> _currencyWords = [
    'TL',
    'TRY',
    '₺',
    'lira',
    'EUR',
    '€',
    'USD',
    r'$',
    'KR',
    'kr',
  ];
}
