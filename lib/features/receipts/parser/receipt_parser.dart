import 'dart:math' as math;

import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/currency.dart';
import '../../../core/util/normalize_name.dart';
import '../../../data/db/app_database.dart';
import '../ocr_text_source.dart';
import '../ocr_currency.dart';
import '../../../core/quantity/unit_code.dart';
import 'receipt_parse_result.dart';

/// Deterministik fiş ayrıştırıcı (spec §6.9).
///
/// OCR metin satırlarından; mağaza/tarih/para/ara toplam/indirim/vergi/toplam
/// adayları, ürün satırları ve uzlaştırma raporu üretir. Yanlış pozitif
/// azaltımı: tarih, telefon, vergi no, kart maskesi ve fiş no satırları
/// ürün sanılmaz. Güven düşük/orta olan satırlar otomatik kesinleşmez.
class ReceiptParser {
  ReceiptParser({this.currency = 'TRY', this.reconciliationToleranceMinor = 2});

  final String currency;
  int get _digits => Currency.fromCode(currency).minorUnitDigits;
  String get _amountPattern => currency == 'IDR'
      // Whole rupiah still use IDR's ISO two minor digits. Group separators
      // must be homogeneous; an explicit fraction has exactly two digits.
      ? r'(?:\d{1,3}(?:\.\d{3})+(?:,\d{2})?|\d{1,3}(?:,\d{3})+(?:\.\d{2})?|\d+(?:[.,]\d{2})?)'
      : r'\d+(?:[.,]\d{3})*' +
            (_digits == 0 ? r'(?:[.,]\d{2})?' : '[.,]\\d{$_digits}');

  /// ±tolerans: satır toplamları ile fiş toplamı arasındaki yuvarlama payı.
  final int reconciliationToleranceMinor;

  static const List<String> _totalMarkers = [
    'toplam',
    'genel toplam',
    'total',
    'grand total',
  ];
  static const List<String> _subtotalMarkers = ['ara toplam', 'aratoplam'];
  static const List<String> _discountMarkers = ['indirim', 'iskonto'];
  static const List<String> _taxMarkers = ['kdv', 'vergi', 'vat', 'tax'];
  static const List<String> _storeWords = ['market', 'mağaza', 'merk'];
  static const List<String> _skipWords = [
    'fiş',
    'fis',
    'no:',
    'no :',
    'kasiyer',
    'yldz',
    'yildiz',
    'misafir',
    'tarih',
    'saat',
    'date',
    'kvkk',
    'www',
    '.com',
    'mal.hizmet',
    'gv.ilk',
    'geçici',
    'gecici',
    'bilgileriniz',
    'teşekkür',
    'tesekkur',
  ];

  /// Ürün satırı olmayan yapısal satırlar.
  static final RegExp _datePattern = RegExp(
    r'(\d{1,2}[./-]\d{1,2}[./-]\d{2,4})|(\d{1,2}:\d{2})',
  );
  static final RegExp _phonePattern = RegExp(r'^\+?[\d\s-]{10,}$');
  static final RegExp _cardMaskPattern = RegExp(r'(\*{3,}\d{3,4}|\d{15,16})');
  static final RegExp _taxNoPattern = RegExp(r'\b\d{10,11}\b');

  /// Reading-order rows shared by parsing and overlapping receipt assembly.
  /// Coordinates belong to one photo; returned rows no longer carry them.
  List<OcrLine> readingRows(OcrScanResult scan) =>
      List.unmodifiable(_reconstructRows(scan.lines));

  List<OcrLine> logicalRows(OcrScanResult scan) => [
    for (final line in _mergeWrappedLines(readingRows(scan)))
      OcrLine(
        text: line.text
            .trim()
            .replaceFirst(RegExp(r'^[\s*#•·-]+$'), '')
            .replaceFirst(RegExp(r'[*\s]+$'), '')
            .replaceAll(RegExp(r'[₺€£$]'), '')
            .replaceFirst(RegExp(r'(?<=\d)\s*(?:[A-Z]{3}|TL)\s*$'), '')
            .trim(),
      ),
  ];

  ReceiptParseResult parse(OcrScanResult scan) {
    final evidence = detectOcrCurrency(
      scan.lines.map((l) => l.text).join('\n'),
      fallback: currency,
    );
    if (evidence.code != null && evidence.code != currency) {
      return ReceiptParser(
        currency: evidence.code!,
        reconciliationToleranceMinor: reconciliationToleranceMinor,
      ).parse(scan);
    }
    final lines = logicalRows(scan);

    final storeCandidates = <String>[];
    DateTime? dateCandidate;
    String? currencyCandidate = evidence.needsConfirmation
        ? null
        : (evidence.code ?? currency);
    int? subtotalMinor;
    int? discountMinor;
    int? taxMinor;
    int? totalMinor;
    final productLines = <ReceiptLineCandidate>[];

    for (final line in lines) {
      // Kampanya/sergi işaretleri (sondaki *, #, •) fişte satır sonunda
      // gelebilir; fiyat çözümlemesini bozmamak için soyulur.
      final text = line.text
          .trim()
          .replaceFirst(RegExp(r'^[\s*#•·-]+$'), '')
          .replaceFirst(RegExp(r'[*\s]+$'), '')
          .replaceAll(RegExp(r'[₺€£$]'), '')
          .replaceFirst(RegExp(r'(?<=\d)\s*(?:[A-Z]{3}|TL)\s*$'), '')
          .trim();
      final lower = text.replaceAll('İ', 'i').toLowerCase();
      if (text.isEmpty) continue;

      // Tarih/saat adayı.
      if (dateCandidate == null && _datePattern.hasMatch(text)) {
        dateCandidate = _tryParseDate(text);
      }

      // Telefon / kart / vergi no satırları asla ürün veya toplam değildir.
      if (_phonePattern.hasMatch(text) ||
          _cardMaskPattern.hasMatch(text) ||
          _taxNoPattern.hasMatch(text)) {
        continue;
      }

      if (_isStructuralLine(lower) || _isPaymentMetadata(lower)) continue;

      // Toplamsal satırlar.
      final amount = _lastAmountMinor(text);
      if (amount != null) {
        if (_hasHeader(lower, _subtotalMarkers)) {
          subtotalMinor ??= amount;
          continue;
        }
        if (_isDiscountLine(lower)) {
          discountMinor = (discountMinor ?? 0) + amount;
          continue;
        }
        if (_hasHeader(lower, _taxMarkers)) {
          taxMinor ??= amount;
          continue;
        }
        if (_isTotalLine(lower)) {
          totalMinor = amount;
          continue;
        }
      }

      // Mağaza adayı: fiş başındaki, harf ağırlıklı kısa satırlar.
      if (storeCandidates.isEmpty &&
          text.length >= 3 &&
          text.length <= 30 &&
          RegExp(r'^[A-ZÇĞİÖŞÜ][A-ZÇĞİÖŞÜa-zçğıöşü .&]+$').hasMatch(text) &&
          !_hasDigits(text)) {
        final looksStore =
            _storeWords.any(lower.contains) || text == text.toUpperCase();
        if (looksStore) {
          storeCandidates.add(text);
          continue;
        }
      }

      // Ürün satırı adayı: metin + sondaki fiyat.
      final candidate = _parseProductLine(text);
      if (candidate != null) {
        productLines.add(candidate);
      }
    }

    final productSum = productLines.fold<int>(
      0,
      (s, l) => s + l.lineTotalMinor,
    );
    final computed =
        productSum -
        receiptDiscountToApplyMinor(
          productSumMinor: productSum,
          observedDiscountMinor: discountMinor,
          reportedTotalMinor: totalMinor,
        );
    final difference = totalMinor == null ? 0 : computed - totalMinor;

    return ReceiptParseResult(
      storeCandidates: storeCandidates,
      dateCandidate: dateCandidate,
      currencyCandidate: currencyCandidate,
      currencyNeedsConfirmation: evidence.needsConfirmation,
      subtotalMinor: subtotalMinor,
      discountMinor: discountMinor,
      taxMinor: taxMinor,
      totalMinor: totalMinor,
      lines: productLines,
      computedTotalMinor: computed,
      reconciliationDifferenceMinor: difference,
      withinReconciliationTolerance:
          difference.abs() <= reconciliationToleranceMinor,
    );
  }

  /// Çok satıra taşan ürün adlarının birleştirilmesi (spec §6.9):
  /// fiyat-satırı öncesindeki ardışık yapısal-olmayan ad satırları tek
  /// ürün satırına katılır (konum+devamlılık kuralı).
  /// ML Kit geniş boşlukları kolon sanıp ad/fiyatı ayrı satırlara bölebilir
  /// ve okuma sırası görsel satır sırası olmayabilir (emülatör kanıtı
  /// 2026-10-04: adlar önce, fiyatlar sonra geldi). Konum verisi tamsa
  /// satırlar görsel satırlara yeniden kurulur. Yükseklik bilgisi varsa
  /// düşey örtüşme ve merkez uzaklığı fotoğraf ölçeğine göre karşılaştırılır;
  /// eski kaynaklarda ±8px top toleransı korunur. Metin fixture'larında konum yoktur —
  /// verilen sıra korunur (PB-040).
  List<OcrLine> _reconstructRows(List<OcrLine> lines) {
    if (lines.length < 2) return lines;
    if (lines.any((l) => l.boundingBoxTop?.isFinite != true)) return lines;
    final scaled = lines.every(
      (l) =>
          l.boundingBoxHeight != null &&
          l.boundingBoxHeight!.isFinite &&
          l.boundingBoxHeight! > 0,
    );
    double center(OcrLine line) =>
        line.boundingBoxTop! + (scaled ? line.boundingBoxHeight! / 2 : 0);
    final sorted = [...lines]
      ..sort((a, b) {
        final t = center(a).compareTo(center(b));
        if (t != 0) return t;
        return (a.boundingBoxLeft ?? 0).compareTo(b.boundingBoxLeft ?? 0);
      });
    final rows = <OcrLine>[];
    var rowTop = sorted.first.boundingBoxTop!;
    var anchor = sorted.first;
    var rowLines = <OcrLine>[];
    bool sameRow(OcrLine line) {
      if (!scaled) return (line.boundingBoxTop! - rowTop).abs() <= 8;
      final small = math.min(
        anchor.boundingBoxHeight!,
        line.boundingBoxHeight!,
      );
      final large = math.max(
        anchor.boundingBoxHeight!,
        line.boundingBoxHeight!,
      );
      if (large > small * 3) return false;
      final overlap =
          math.min(
            anchor.boundingBoxTop! + anchor.boundingBoxHeight!,
            line.boundingBoxTop! + line.boundingBoxHeight!,
          ) -
          math.max(anchor.boundingBoxTop!, line.boundingBoxTop!);
      // Compare against the first member, rather than growing the row until
      // it absorbs the next product through a chain of overlapping boxes.
      return overlap >= small * 0.5 &&
          (center(anchor) - center(line)).abs() <=
              math.max(small * 0.6, large * 0.35);
    }

    void flush() {
      if (rowLines.isEmpty) return;
      rowLines.sort(
        (a, b) => (a.boundingBoxLeft ?? 0).compareTo(b.boundingBoxLeft ?? 0),
      );
      rows.add(
        OcrLine(
          text: rowLines.map((l) => l.text).join(' '),
          boundingBoxTop: rowTop,
          boundingBoxLeft: rowLines.first.boundingBoxLeft,
          boundingBoxHeight: scaled
              ? rowLines
                        .map((l) => l.boundingBoxTop! + l.boundingBoxHeight!)
                        .reduce(math.max) -
                    rowTop
              : null,
        ),
      );
      rowLines = [];
    }

    for (final line in sorted) {
      if (sameRow(line)) {
        rowLines.add(line);
        rowTop = math.min(rowTop, line.boundingBoxTop!);
      } else {
        flush();
        rowTop = line.boundingBoxTop!;
        anchor = line;
        rowLines.add(line);
      }
    }
    flush();
    return rows;
  }

  List<OcrLine> _mergeWrappedLines(List<OcrLine> lines) {
    final priceOnly = RegExp('^$_amountPattern\$');
    final merged = <OcrLine>[];
    final nameBuffer = <String>[];
    for (final line in lines) {
      // Kampanya/sergi işaretleri (sondaki *, #, •) sonda fiyat yok sanıp
      // satırı yanlış birleştirebilir; birleştirme kararından önce soyulur.
      final text = line.text
          .trim()
          .replaceFirst(RegExp(r'^[\s*#•·-]+$'), '')
          .replaceFirst(RegExp(r'[\s*]+$'), '')
          .replaceAll(RegExp(r'[₺€£$]'), '')
          .replaceFirst(RegExp(r'(?<=\d)\s*(?:[A-Z]{3}|TL)\s*$'), '')
          .trim();
      if (text.isEmpty) continue;
      final lower = text.replaceAll('İ', 'i').toLowerCase();
      final structural =
          _isStructuralLine(lower) ||
          _hasHeader(lower, _subtotalMarkers) ||
          _isDiscountLine(lower) ||
          _hasHeader(lower, _taxMarkers) ||
          _isTotalLine(lower) ||
          _isPaymentMetadata(lower) ||
          _phonePattern.hasMatch(text) ||
          _cardMaskPattern.hasMatch(text) ||
          _taxNoPattern.hasMatch(text);

      if (structural) {
        nameBuffer.clear();
        merged.add(line);
        continue;
      }
      if (priceOnly.hasMatch(text)) {
        // fiyat-satırı: önceki taşan ad satırlarıyla birleşir.
        if (nameBuffer.isNotEmpty) {
          merged.add(
            OcrLine(
              text: '${nameBuffer.join(' ')} $text',
              boundingBoxTop: line.boundingBoxTop,
            ),
          );
          nameBuffer.clear();
        } else {
          merged.add(line);
        }
        continue;
      }
      if (_hasTrailingPrice(text)) {
        // A receipt can print the name above a quantity × price row. That
        // numeric continuation is not an independent product name.
        final quantity = _quantityPrices(text);
        merged.add(
          OcrLine(
            text: quantity?.start == 0 && nameBuffer.isNotEmpty
                ? '${nameBuffer.join(' ')} $text'
                : text,
            boundingBoxTop: line.boundingBoxTop,
          ),
        );
        nameBuffer.clear();
        continue;
      }
      nameBuffer.add(text);
    }
    if (nameBuffer.isNotEmpty) {
      merged.add(OcrLine(text: nameBuffer.join(' ')));
    }
    return merged;
  }

  /// Satır sonunda parasal değer var mı?
  // IDR's optional fraction must not make an invalid token/code's numeric
  // suffix look like an independent whole-rupiah price. A colon may delimit
  // a header amount; multiplication/unit syntax is parsed separately.
  bool _hasTrailingPrice(String text) => RegExp(
    (currency == 'IDR' ? r'(?<![^\s:])' : '') + _amountPattern + r'\s*$',
  ).hasMatch(text.trim());

  /// İndirim satırı: tutar eksiyse ya da işaret kelimesi dışında ürün adı
  /// yoksa ("İNDİRİM 5,00"). "İNDİRİMLİ ELMA 31,50" bir üründür (PB-051).
  bool _isDiscountLine(String lower) {
    if (!_discountMarkers.any(lower.contains)) return false;
    if (RegExp(r'-\s*\d').hasMatch(lower)) return true;
    final rest = lower
        .replaceAll(RegExp(r'\S*(indirim|iskonto|kampanya|kupon)\S*'), ' ')
        .replaceAll(RegExp(r'[^a-zçğıöşü]'), '');
    return rest.length < 3;
  }

  /// Ürün satırı: `SUT 2X32,90 64,00` | `DOMATES 1,5KG X42,90 64,35` |
  /// `EKMEK 15,00`. Dönüşüm: name + opsiyonel miktar/birim fiyat + son fiyat.
  RegExp get _quantityPricePattern => RegExp(
    r'(?<!\S)(\d+(?:[.,]\d+)?)\s*(kg|gr|g|lt|l|ml|adet|x)?\s*(?:x|X|×)\s*'
    '($_amountPattern)\\s+($_amountPattern)\$',
    caseSensitive: false,
  );

  /// Invoice columns can state quantity and unit without a multiplication
  /// sign. Require the explicit unit and both printed prices; bare numeric
  /// product codes and package sizes must not manufacture a quantity.
  RegExp get _quantityColumnsPattern => RegExp(
    r'(?<!\S)(\d+(?:[.,]\d+)?)\s*'
    r'(kg|gr|g|lt|l|ml|adet|ad|pcs|piece|paket|pkg)\s+'
    '($_amountPattern)'
    '(?:\\s*(?:${Currency.all.map((c) => c.code).join('|')}|TL))?'
    '\\s+($_amountPattern)\$',
    caseSensitive: false,
    unicode: true,
  );

  RegExpMatch? _quantityPrices(String text) {
    final match =
        _quantityPricePattern.firstMatch(text) ??
        _quantityColumnsPattern.firstMatch(text);
    if (match == null) return null;
    // A separated sign is still part of a signed quantity. Preserve the raw
    // row for review rather than silently turning a return into a purchase.
    if (RegExp(r'[-−+/]\s*$').hasMatch(text.substring(0, match.start))) {
      return null;
    }
    return match;
  }

  ReceiptLineCandidate? _parseProductLine(String text) {
    final m = _quantityPrices(text);
    if (m != null) {
      final name = text.substring(0, m.start).trim();
      if (name.isEmpty) return null;
      final qty = DecimalFixed.tryParse(m.group(1)!.replaceAll(',', '.'));
      final unitPrice = _minorFrom(m.group(3)!);
      final lineTotal = _minorFrom(m.group(4)!);
      final consistent =
          qty != null &&
          qty.isPositive &&
          unitPrice != null &&
          lineTotal != null &&
          ((qty * DecimalFixed.fromInt(unitPrice)).rescale(0).unscaled -
                      BigInt.from(lineTotal))
                  .abs() <=
              BigInt.from(reconciliationToleranceMinor);
      return ReceiptLineCandidate(
        rawText: text,
        name: name,
        normalizedName: normalizeName(name),
        quantity: qty,
        unitCode: switch (m.group(2)?.toLowerCase()) {
          'kg' => UnitCode.kilogram,
          'gr' || 'g' => UnitCode.gram,
          'lt' || 'l' => UnitCode.litre,
          'ml' => UnitCode.mililitre,
          'adet' || 'ad' || 'pcs' || 'piece' || 'x' => UnitCode.adet,
          'paket' || 'pkg' => UnitCode.paket,
          _ => null,
        },
        unitPriceMinor: unitPrice,
        lineTotalMinor: lineTotal ?? 0,
        confidence: consistent ? 'high' : 'medium',
      );
    }

    // Basit satır: ad + sondaki fiyat (açgözlü ad yakalar: EKMEK).
    final simple = RegExp('^(.+)\\s+($_amountPattern)\$').firstMatch(text);
    if (simple != null) {
      final name = simple.group(1)!.trim();
      if (name.isEmpty) return null;
      if (currency == 'IDR' && RegExp(r'[-−+]\s*$').hasMatch(name)) {
        return null;
      }
      final lineTotal = _minorFrom(simple.group(2)!);
      if (lineTotal == null) return null;
      // Kısa/harfsiz adlar düşük güvenle korunur: düşürülmez, incelenir.
      final low =
          name.length < 3 || !name.contains(RegExp(r'[A-Za-zÇĞİÖŞÜçğıöşü]'));
      return ReceiptLineCandidate(
        rawText: text,
        name: name,
        normalizedName: normalizeName(name),
        lineTotalMinor: lineTotal,
        confidence: low ? 'low' : 'medium',
      );
    }
    return null;
  }

  bool _isTotalLine(String text) => _totalMarkers.any(
    (marker) => RegExp(
      r'^[*#•\s]*' + RegExp.escape(marker) + r'(?=\s|:|$)',
      caseSensitive: false,
    ).hasMatch(text),
  );

  bool _hasHeader(String text, List<String> markers) => markers.any(
    (marker) => RegExp(
      r'^[*#•\s]*' + RegExp.escape(marker) + r'(?=\s|:|\(|%|$)',
      caseSensitive: false,
    ).hasMatch(text),
  );

  bool _isStructuralLine(String text) =>
      _hasHeader(text, _skipWords) ||
      text.contains('www.') ||
      text.contains('.com');

  bool _isPaymentMetadata(String text) =>
      RegExp(r'^kasa\s*(?:no\b|:|\d)', caseSensitive: false).hasMatch(text) ||
      RegExp(
        r'^[*#•\s]*(?:nakit|kredi\s+kart[ıi]|banka\s+kart[ıi]|kart|visa|mastercard|cash|change|para\s*[üu]st[üu]|[öo]denen|payment|paid)(?=\s|:|$)',
        caseSensitive: false,
      ).hasMatch(text);

  int? _lastAmountMinor(String text) {
    final boundary = currency == 'IDR' ? r'(?<![^\s:])' : '';
    final signedDiscount =
        currency == 'IDR' &&
        _isDiscountLine(text.replaceAll('İ', 'i').toLowerCase());
    // Discount rows store a positive magnitude, including a printed sign.
    // Do not grant that exception to signed product or total amounts.
    final sign = signedDiscount ? r'(?:[-−+]\s*)?' : '';
    final match = RegExp(
      '$boundary$sign($_amountPattern)'
      r'\s*(TL|₺|TRY)?\s*$',
    ).firstMatch(text);
    if (match == null) return null;
    if (currency == 'IDR' &&
        !signedDiscount &&
        RegExp(r'[-−+]\s*$').hasMatch(text.substring(0, match.start))) {
      return null;
    }
    return _minorFrom(match.group(1)!);
  }

  int? _minorFrom(String decimalText) {
    if (currency == 'IDR') {
      if (!RegExp('^$_amountPattern\$').hasMatch(decimalText)) return null;
      var raw = decimalText;
      if (raw.contains(',') && raw.contains('.')) {
        raw = raw.lastIndexOf(',') > raw.lastIndexOf('.')
            ? raw.replaceAll('.', '').replaceAll(',', '.')
            : raw.replaceAll(',', '');
      } else if (RegExp(r'^\d{1,3}(?:\.\d{3})+$').hasMatch(raw) ||
          RegExp(r'^\d{1,3}(?:,\d{3})+$').hasMatch(raw)) {
        raw = raw.replaceAll(RegExp(r'[.,]'), '');
      } else {
        raw = raw.replaceAll(',', '.');
      }
      return DecimalFixed.tryParse(raw)?.toMinorUnits(_digits);
    }
    var raw = decimalText;
    final hasComma = raw.contains(',');
    final hasDot = raw.contains('.');
    if (hasComma && hasDot) {
      raw = raw.lastIndexOf(',') > raw.lastIndexOf('.')
          ? raw.replaceAll('.', '').replaceAll(',', '.')
          : raw.replaceAll(',', '');
    } else if (hasComma) {
      raw = raw.replaceAll(',', '.');
    } else if (hasDot) {
      final frac = raw.substring(raw.lastIndexOf('.') + 1);
      if (frac.length != (_digits == 0 ? 2 : _digits)) {
        raw = raw.replaceAll('.', '');
      }
    }
    final value = DecimalFixed.tryParse(raw);
    if (value == null) return null;
    return value.toMinorUnits(_digits);
  }

  DateTime? _tryParseDate(String text) {
    final m = RegExp(r'(\d{1,2})[./-](\d{1,2})[./-](\d{2,4})').firstMatch(text);
    if (m == null) return null;
    var year = int.parse(m.group(3)!);
    if (year < 100) year += 2000;
    try {
      return DateTime(year, int.parse(m.group(2)!), int.parse(m.group(1)!));
    } on FormatException {
      return null;
    }
  }

  bool _hasDigits(String text) => RegExp(r'\d').hasMatch(text);
}

/// Ayrıştırılan satırların planlanan ürünlerle muhafazakâr eşleştirmesi
/// (spec §6.9): normalize ad birebir → high; içerme veya benzerlik ≥0.75 →
/// medium; aksi halde eşleşme yok. Benzerlik alt sınırı kasıtlı yüksektir.
class ReceiptMatcher {
  ReceiptMatcher(this._db);

  final AppDatabase _db;

  /// Satır adayı ↔ planlanan ürün eşleşmesi döndürür.
  Future<List<(ReceiptLineCandidate, PlannedItem?, String)>> match(
    List<ReceiptLineCandidate> lines, {
    required int listId,
  }) async {
    final items = await (_db.select(
      _db.plannedItems,
    )..where((t) => t.listId.equals(listId))).get();
    return [
      for (final line in lines)
        (
          line,
          _bestMatch(line.normalizedName, items),
          _matchConfidence(line.normalizedName, items),
        ),
    ];
  }

  PlannedItem? _bestMatch(String needle, List<PlannedItem> items) {
    PlannedItem? best;
    var bestScore = 0.0;
    final n = stripUnits(needle);
    for (final item in items) {
      final score = _similarity(n, stripUnits(item.normalizedName));
      if (score > bestScore) {
        bestScore = score;
        best = item;
      }
    }
    return bestScore >= 0.75 ? best : null;
  }

  /// Fişte birim çoğu kez ADIN sonundadır ("DOMATES KG", "SUT 1L");
  /// planda yoktur. Eşleştirme için bilinen birim/ambalaj jetonları ve
  /// boyut+birim öbekleri (\d+l, \d+x\d+ml) soyulur (PB-040).
  static final RegExp _trailingUnitWords = RegExp(
    r'(\s+\d+(?:x\d+)?(?:kg|gr|g|lt|l|ml|m))'
    r'|(\s+(kg|gr|g|lt|l|ml|adet|pk|pkt|paket|kutu|dz|dzn|düzine|şişe|sise|kavanoz|demet|metre))$',
    caseSensitive: false,
  );

  static String stripUnits(String normalized) =>
      normalized.replaceAll(_trailingUnitWords, '').trim();

  String _matchConfidence(String needle, List<PlannedItem> items) {
    final n = stripUnits(needle);
    for (final item in items) {
      if (stripUnits(item.normalizedName) == n) return 'high';
    }
    for (final item in items) {
      if (_similarity(n, stripUnits(item.normalizedName)) >= 0.75) {
        return 'medium';
      }
    }
    return 'low';
  }

  /// 0..1 benzerlik: içerme + Levenshtein oranı.
  static double _similarity(String a, String b) {
    if (a.isEmpty || b.isEmpty) return 0;
    if (a == b) return 1;
    if (a.contains(b) || b.contains(a)) return 0.9;
    final distance = levenshtein(a, b);
    return 1 - distance / (a.length > b.length ? a.length : b.length);
  }

  static int levenshtein(String a, String b) {
    final m = a.length, n = b.length;
    if (m == 0) return n;
    if (n == 0) return m;
    var prev = List<int>.generate(n + 1, (i) => i);
    final curr = List<int>.filled(n + 1, 0);
    for (var i = 1; i <= m; i++) {
      curr[0] = i;
      for (var j = 1; j <= n; j++) {
        final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
        curr[j] = [
          prev[j] + 1,
          curr[j - 1] + 1,
          prev[j - 1] + cost,
        ].reduce(math.min);
      }
      prev = List.of(curr);
    }
    return prev[n];
  }
}
