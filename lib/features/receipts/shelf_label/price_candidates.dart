import 'dart:math' as math;

import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/currency.dart';
import '../../../core/quantity/unit_code.dart';
import '../ocr_text_source.dart';
import '../ocr_currency.dart';
import '../ocr_number_view.dart';

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
    // Turkish labels print kuruş as a small raised number beside the big
    // whole-lira figure and OCR emits that as separate lines (PB-208).
    lines = mergeSmallCents(lines);
    if (lines.every(
      (l) => l.boundingBoxTop != null && l.boundingBoxLeft != null,
    )) {
      lines = [...lines]
        ..sort((a, b) {
          final y = a.boundingBoxTop!.compareTo(b.boundingBoxTop!);
          return y != 0 ? y : a.boundingBoxLeft!.compareTo(b.boundingBoxLeft!);
        });
    }
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
    final origins = <PriceCandidate, OcrLine>{};
    final explicit = <PriceCandidate>{};
    for (final line in lines) {
      final view = OcrNumberView(line.text);
      if (!view.valid) continue;
      final text = view.text;
      // Hacim/ağırlık miktarı görünen satırlarda (ör. '1 LT SÜT') tam sayı
      // fiyat sanılmaz.
      final quantityMatches = _quantityPattern.allMatches(text).toList();
      final matches = _pricePattern
          .allMatches(text)
          .where(
            (m) =>
                !quantityMatches.any((q) => m.start >= q.start && m.end <= q.end),
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
        // Barcodes and product codes are bare 6+ digit integer runs. A real
        // price of that size always carries a decimal separator, or its own
        // currency marker with no other amount in between; a barcode that
        // merely shares a line with the printed price stays a code (PB-208).
        if (RegExp(r'^\d{6,}$').hasMatch(raw) &&
            !_currencyMarkerAdjacent(text, match.start, match.end)) {
          continue;
        }

        final around = text.substring(
          match.end,
          index + 1 < matches.length ? matches[index + 1].start : text.length,
        );
        final before = text.substring(
          index == 0 ? 0 : matches[index - 1].end,
          match.start,
        );
        final hasCurrency =
            _currencyWords.any(text.contains) ||
            RegExp(r'[₺€$]').hasMatch(text);
        final prefixUnit = RegExp(
          r'^\s*(kg|gr|g|lt|l|ml|adet)\s*[:=]?\s*$',
          caseSensitive: false,
        ).firstMatch(before)?.group(1)?.toLowerCase();
        final isUnit =
            prefixUnit != null ||
            RegExp(
              r'[/]\s*(?:\d+(?:[.,\u066b]\d+)?\s*)?(kg|gr|g|lt|L|ml|adet)\b',
              caseSensitive: false,
            ).hasMatch(around);
        final wellFormed = RegExp(r'^\d{1,3}([.,\u066b]\d{3})*[.,\u066b]\d{2}$')
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
            r'/\s*(?:\d+(?:[.,\u066b]\d+)?\s*)?(kg|gr|g|lt|l|ml|adet)\b',
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
        // Keep package evidence in its own product column.
        final preceding = lines
            .takeWhile((l) => !identical(l, line))
            .where(
              (l) =>
                  OcrNumberView(l.text).valid &&
                  RegExp(r'\p{L}', unicode: true).hasMatch(l.text) &&
                  !RegExp(r'[₺€$]|\d+[.,\u066b]\d{2}')
                      .hasMatch(OcrNumberView(l.text).text),
            );
        final names = preceding.where((l) => _separateBasis(l.text) == null);
        final name = _nearbyProductName(line, names);
        final explicitBasis = RegExp(
          r'/\s*(\d+(?:[.,\u066b]\d+)?)\s*(kg|gr|g|lt|l|ml)\b',
          caseSensitive: false,
        ).firstMatch(around);
        final inlinePackage = quantityMatches
            .where(
              (q) =>
                  q.start >= (index == 0 ? 0 : matches[index - 1].end) &&
                  q.end <= match.start &&
                  !RegExp(r'/\s*$').hasMatch(text.substring(0, q.start)),
            )
            .firstOrNull;
        final package = !isUnit
            ? inlinePackage ??
                  _quantityPattern.firstMatch(OcrNumberView(name ?? '').text)
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
                : DecimalFixed.tryParse(
                    basisQuantity
                        .replaceAll(',', '.')
                        .replaceAll('\u066b', '.'),
                  ),
          ),
        );
        origins[candidates.last] = line;
        if (isUnit || inlinePackage != null || matches.length != 1) {
          explicit.add(candidates.last);
        }
      }
    }

    // konum sırası: üst-sol önce (etikette ana fiyat genelde üsttedir)
    candidates.sort((a, b) {
      final sa = _sourceOrder(a.sourceLine, lines);
      final sb = _sourceOrder(b.sourceLine, lines);
      return sa.compareTo(sb);
    });
    return _attachSeparateBases(candidates, origins, explicit, lines);
  }

  static final _quantityPattern = RegExp(
    r'\b(\d+(?:[.,\u066b]\d+)?)\s*(kg|gr|g|lt|l|ml|adet)\b',
    caseSensitive: false,
  );
  static UnitCode? _unit(String code) => switch (code.toLowerCase()) {
    'kg' => UnitCode.kilogram,
    'gr' || 'g' => UnitCode.gram,
    'lt' || 'l' => UnitCode.litre,
    'ml' => UnitCode.mililitre,
    'adet' => UnitCode.adet,
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
    if (ambiguousOcrAmount(raw, digits)) return null;
    raw = raw.replaceAll('\u066b', '.');
    if (digits == 0) return wholeOcrAmount(raw)?.toString();
    final comma = raw.lastIndexOf(','), dot = raw.lastIndexOf('.');
    if (comma >= 0 && dot >= 0) {
      final decimal = comma > dot ? ',' : '.';
      final grouping = decimal == ',' ? '.' : ',';
      final parts = raw.split(decimal);
      final group = RegExp.escape(grouping);
      final validGrouping =
          RegExp('^\\d{1,3}(?:$group\\d{3})*\$').hasMatch(parts.first) ||
          RegExp('^\\d{1,2}(?:$group\\d{2})+$group\\d{3}\$')
              .hasMatch(parts.first);
      if (parts.length != 2 || parts.last.length > digits || !validGrouping) {
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
  RegExp get _pricePattern => RegExp(r'(\d+(?:[.,\u066b]\d+)*)');

  /// Whether a currency marker in [text] borders the [start]/[end] match with
  /// no other number in between, so a 6+ digit run is the marker's own amount
  /// ('123456 TL' is a price; '8690123456789 24,95 TL' keeps only 24,95).
  static bool _currencyMarkerAdjacent(String text, int start, int end) {
    for (final word in _currencyWords) {
      for (var i = text.indexOf(word); i >= 0; i = text.indexOf(word, i + 1)) {
        // A currency marker is a standalone token: SÜTLÜ/TATLI/KRAKER must
        // not turn a barcode next to them into a price (review finding).
        final before = i == 0 || RegExp(r'[^\p{L}\p{N}]').hasMatch(text[i - 1]);
        final after = i + word.length >= text.length ||
            RegExp(r'[^\p{L}\p{N}]').hasMatch(text[i + word.length]);
        if (!before || !after) continue;
        final String span;
        if (i >= end) {
          span = text.substring(end, i);
        } else if (i + word.length <= start) {
          span = text.substring(i + word.length, start);
        } else {
          continue; // The marker cannot overlap a digits-only match.
        }
        if (!RegExp(r'\d').hasMatch(span)) return true;
      }
    }
    return false;
  }

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

typedef _ShelfBasis = ({UnitCode unit, DecimalFixed? quantity, bool perUnit});

/// Joins the raised kuruş line of a Turkish shelf label with its big
/// whole-lira line: labels print a large "24" with a small superscript "95"
/// beside it, and OCR emits two separate lines. A small 2-digit line merges
/// into a big whole-number line only when its box sits to the RIGHT of the
/// big digits, is aligned to their top half (superscript) and is clearly
/// smaller. Merged text is `'<big>,<small>'`; the big line's box is kept and
/// the cents line is consumed. Pure function: [lines] is not modified.
List<OcrLine> mergeSmallCents(List<OcrLine> lines) {
  final merged = <OcrLine>[];
  final consumed = <OcrLine>{};
  for (final big in lines) {
    if (consumed.contains(big)) continue;
    final bigText = big.text.trim();
    OcrLine? cents;
    // Only plain whole-lira lines (1-5 digits, no separators) can adopt a
    // cents line; longer runs are barcodes/codes, never a lira figure.
    if (RegExp(r'^\d{1,5}$').hasMatch(bigText)) {
      for (final small in lines) {
        if (identical(small, big) || consumed.contains(small)) continue;
        if (RegExp(r'^\d{2}$').hasMatch(small.text.trim()) &&
            _isRaisedCents(big, small)) {
          cents = small;
          break;
        }
      }
    }
    if (cents == null) {
      merged.add(big);
      continue;
    }
    consumed.add(cents);
    merged.add(
      OcrLine(
        text: '$bigText,${cents.text.trim()}',
        boundingBoxTop: big.boundingBoxTop,
        boundingBoxLeft: big.boundingBoxLeft,
        boundingBoxHeight: big.boundingBoxHeight,
        boundingBoxWidth: big.boundingBoxWidth,
      ),
    );
  }
  return merged;
}

/// Geometry gate for [mergeSmallCents]: [small] must be the raised kuruş of
/// [big]. Both boxes must exist and be finite/positive; equal boxes within
/// noise (duplicate OCR lines) never merge.
bool _isRaisedCents(OcrLine big, OcrLine small) {
  final dims = [
    big.boundingBoxTop,
    big.boundingBoxLeft,
    big.boundingBoxHeight,
    big.boundingBoxWidth,
    small.boundingBoxTop,
    small.boundingBoxLeft,
    small.boundingBoxHeight,
    small.boundingBoxWidth,
  ];
  if (dims.any((d) => d == null || !d.isFinite)) return false;
  if (big.boundingBoxHeight! <= 0 || big.boundingBoxWidth! <= 0) return false;
  if (small.boundingBoxHeight! <= 0 || small.boundingBoxWidth! <= 0) {
    return false;
  }
  final noise = math.max(
    1.0,
    0.02 * math.max(big.boundingBoxHeight!, big.boundingBoxWidth!),
  );
  if ((big.boundingBoxTop! - small.boundingBoxTop!).abs() <= noise &&
      (big.boundingBoxLeft! - small.boundingBoxLeft!).abs() <= noise &&
      (big.boundingBoxHeight! - small.boundingBoxHeight!).abs() <= noise &&
      (big.boundingBoxWidth! - small.boundingBoxWidth!).abs() <= noise) {
    return false;
  }
  // The kuruş is printed clearly smaller than the lira digits.
  if (small.boundingBoxHeight! > 0.7 * big.boundingBoxHeight!) return false;
  // Superscript: the cents sit in the top half of the big line and share its
  // vertical span.
  final bigCenterY = big.boundingBoxTop! + big.boundingBoxHeight! / 2;
  final smallCenterY = small.boundingBoxTop! + small.boundingBoxHeight! / 2;
  if (smallCenterY > bigCenterY) return false;
  if (small.boundingBoxTop! >= big.boundingBoxTop! + big.boundingBoxHeight! ||
      small.boundingBoxTop! + small.boundingBoxHeight! <=
          big.boundingBoxTop!) {
    return false;
  }
  // To the RIGHT of the big digits: a slight overlap is tolerated, a distant
  // column never merges.
  final bigRight = big.boundingBoxLeft! + big.boundingBoxWidth!;
  if (small.boundingBoxLeft! < bigRight - 0.25 * small.boundingBoxWidth!) {
    return false;
  }
  if (small.boundingBoxLeft! > bigRight + 1.5 * big.boundingBoxHeight!) {
    return false;
  }
  return true;
}

String? _nearbyProductName(OcrLine price, Iterable<OcrLine> names) {
  if (price.boundingBoxHeight == null ||
      price.boundingBoxWidth == null ||
      price.boundingBoxLeft == null ||
      price.boundingBoxTop == null) {
    return names.isEmpty ? null : names.last.text.trim();
  }
  final nearby = <({String name, double distance})>[];
  for (final line in names) {
    final distance = _basisDistance(price, line);
    if (distance != null) {
      nearby.add((name: line.text.trim(), distance: distance));
    }
  }
  nearby.sort((a, b) => a.distance.compareTo(b.distance));
  if (nearby.isEmpty ||
      nearby.length > 1 && nearby[1].distance - nearby[0].distance < 0.15) {
    return null;
  }
  return nearby.first.name;
}

_ShelfBasis? _separateBasis(String text) {
  final view = OcrNumberView(text);
  if (!view.valid) return null;
  text = view.text;
  final match = RegExp(
    r'^\s*(?:(?:birim\s*fiyat[ıi]?|unit\s*price)\s*[:=]?\s*)?'
    r'(?:(?:[A-Z]{3}|TL|[₺€£$])\s*)?/?\s*'
    r'(?:(\d+(?:[.,\u066b]\d+)?)\s*)?(kg|gr|g|lt|l|ml|adet)'
    r'\s*(?:[A-Z]{3}|TL|[₺€£$])?\s*$',
    caseSensitive: false,
  ).firstMatch(text);
  if (match == null) return null;
  final quantity = match.group(1) == null
      ? null
      : DecimalFixed.tryParse(
          match.group(1)!.replaceAll(',', '.').replaceAll('\u066b', '.'),
        );
  if (quantity != null && !quantity.isPositive) return null;
  final unit = ShelfPriceExtractor._unit(match.group(2)!);
  if (unit == null) return null;
  return (
    unit: unit,
    quantity: quantity,
    perUnit:
        quantity == null ||
        text.contains('/') ||
        RegExp(r'birim|unit', caseSensitive: false).hasMatch(text),
  );
}

/// Only nearby boxes with one unambiguous price may share a separate unit
/// label. Plain OCR order or a distant product's unit never supplies a basis.
List<PriceCandidate> _attachSeparateBases(
  List<PriceCandidate> candidates,
  Map<PriceCandidate, OcrLine> origins,
  Set<PriceCandidate> explicit,
  List<OcrLine> lines,
) {
  final assignments =
      <PriceCandidate, List<({OcrLine line, _ShelfBasis basis})>>{};
  for (final line in lines) {
    final basis = _separateBasis(line.text);
    if (basis == null) continue;
    final nearby = <({PriceCandidate candidate, double distance})>[];
    for (final candidate in candidates) {
      final origin = origins[candidate]!;
      final distance = _basisDistance(origin, line);
      if (distance != null) {
        nearby.add((candidate: candidate, distance: distance));
      }
    }
    nearby.sort((a, b) => a.distance.compareTo(b.distance));
    if (nearby.isEmpty ||
        nearby.length > 1 && nearby[1].distance - nearby[0].distance < 0.15) {
      continue;
    }
    // An already-qualified nearer price still owns its adjacent label; do
    // not redirect that evidence to a farther unqualified amount.
    if (explicit.contains(nearby.first.candidate)) continue;
    assignments.putIfAbsent(nearby.first.candidate, () => []).add((
      line: line,
      basis: basis,
    ));
  }
  final result = <PriceCandidate>[];
  for (final candidate in candidates) {
    final labels = assignments[candidate];
    if (labels == null || labels.map((l) => l.basis).toSet().length != 1) {
      result.add(candidate);
      continue;
    }
    final basis = labels.first.basis;
    result.add(
      PriceCandidate(
        value: candidate.value,
        currencyCode: candidate.currencyCode,
        sourceLine: [
          candidate.sourceLine,
          ...labels.map((l) => l.line.text),
        ].join('\n'),
        confidence: candidate.confidence,
        isUnitPrice: basis.perUnit,
        productName: candidate.productName,
        unitCode: basis.unit,
        priceQuantity: basis.quantity,
      ),
    );
  }
  return result;
}

double? _basisDistance(OcrLine price, OcrLine label) {
  for (final box in [price, label]) {
    if ([
          box.boundingBoxTop,
          box.boundingBoxLeft,
          box.boundingBoxHeight,
          box.boundingBoxWidth,
        ].any((n) => n == null || !n.isFinite) ||
        box.boundingBoxHeight! <= 0 ||
        box.boundingBoxWidth! <= 0) {
      return null;
    }
  }
  if (identical(price, label)) return null;
  final h = math.max(price.boundingBoxHeight!, label.boundingBoxHeight!);
  final xOverlap =
      math.min(
        price.boundingBoxLeft! + price.boundingBoxWidth!,
        label.boundingBoxLeft! + label.boundingBoxWidth!,
      ) -
      math.max(price.boundingBoxLeft!, label.boundingBoxLeft!);
  final yOverlap =
      math.min(
        price.boundingBoxTop! + price.boundingBoxHeight!,
        label.boundingBoxTop! + label.boundingBoxHeight!,
      ) -
      math.max(price.boundingBoxTop!, label.boundingBoxTop!);
  if (xOverlap <
          math.min(price.boundingBoxWidth!, label.boundingBoxWidth!) * 0.25 &&
      yOverlap <
          math.min(price.boundingBoxHeight!, label.boundingBoxHeight!) * 0.5) {
    return null;
  }
  final xGap = math.max(0.0, -xOverlap), yGap = math.max(0.0, -yOverlap);
  if (xGap > h * 1.5 || yGap > h * 1.5) return null;
  final centerY =
      ((price.boundingBoxTop! + price.boundingBoxHeight! / 2) -
              (label.boundingBoxTop! + label.boundingBoxHeight! / 2))
          .abs();
  return (xGap + yGap + centerY * 0.25) / h;
}
