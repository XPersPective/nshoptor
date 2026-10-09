import 'dart:math' as math;

import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/currency.dart';
import '../../../core/util/normalize_name.dart';
import '../../../data/db/app_database.dart';
import '../ocr_text_source.dart';
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
  String get _amountPattern =>
      r'\d+(?:[.,]\d{3})*' +
      (_digits == 0 ? r'(?:[.,]\d{2})?' : '[.,]\\d{$_digits}');

  /// ±tolerans: satır toplamları ile fiş toplamı arasındaki yuvarlama payı.
  final int reconciliationToleranceMinor;

  static const List<String> _totalMarkers = [
    'toplam',
    'genel toplam',
    'total',
    'nakit',
    'kasa',
    'kart',
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

  ReceiptParseResult parse(OcrScanResult scan) {
    final lines = _mergeWrappedLines(_reconstructRows(scan.lines));

    final storeCandidates = <String>[];
    DateTime? dateCandidate;
    String? currencyCandidate = currency;
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
          .trim();
      final lower = text.toLowerCase();
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

      if (_skipWords.any(lower.contains)) continue;

      // Toplamsal satırlar.
      final amount = _lastAmountMinor(text);
      if (amount != null) {
        if (_subtotalMarkers.any(lower.contains)) {
          subtotalMinor ??= amount;
          continue;
        }
        if (_isDiscountLine(lower)) {
          discountMinor = (discountMinor ?? 0) + amount;
          continue;
        }
        if (_taxMarkers.any(lower.contains)) {
          taxMinor ??= amount;
          continue;
        }
        if (_totalMarkers.any(lower.contains) && !lower.contains('ara')) {
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

    final computed = productLines.fold<int>(0, (s, l) => s + l.lineTotalMinor);
    final difference = totalMinor == null ? 0 : computed - totalMinor;

    return ReceiptParseResult(
      storeCandidates: storeCandidates,
      dateCandidate: dateCandidate,
      currencyCandidate: currencyCandidate,
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
  /// satırlar görsel satırlara yeniden kurulur: aynı top (±8px) tek satır,
  /// soldan sağa birleştirilir. Metin fixture'larında konum yoktur —
  /// verilen sıra korunur (PB-040).
  List<OcrLine> _reconstructRows(List<OcrLine> lines) {
    if (lines.length < 2) return lines;
    if (lines.any((l) => l.boundingBoxTop == null)) return lines;
    final sorted = [...lines]
      ..sort((a, b) {
        final t = a.boundingBoxTop!.compareTo(b.boundingBoxTop!);
        if (t != 0) return t;
        return (a.boundingBoxLeft ?? 0).compareTo(b.boundingBoxLeft ?? 0);
      });
    final rows = <OcrLine>[];
    var rowTop = sorted.first.boundingBoxTop!;
    var rowLines = <OcrLine>[];
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
        ),
      );
      rowLines = [];
    }

    for (final line in sorted) {
      if ((line.boundingBoxTop! - rowTop).abs() <= 8) {
        rowLines.add(line);
      } else {
        flush();
        rowTop = line.boundingBoxTop!;
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
          .trim();
      if (text.isEmpty) continue;
      final lower = text.toLowerCase();
      final structural =
          _skipWords.any(lower.contains) ||
          _subtotalMarkers.any(lower.contains) ||
          _isDiscountLine(lower) ||
          _taxMarkers.any(lower.contains) ||
          _totalMarkers.any(lower.contains) ||
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
        // kendi fiyatı olan tam ürün satırı: doğrudan çıkar.
        merged.add(line);
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
  bool _hasTrailingPrice(String text) =>
      RegExp(_amountPattern + r'\s*$').hasMatch(text.trim());

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
  ReceiptLineCandidate? _parseProductLine(String text) {
    final matches = RegExp(
      r'(\d+(?:[.,]\d+)?)(kg|g|lt|l|adet|x)?\s*(?:x|X|×)\s*'
      '($_amountPattern)\\s+($_amountPattern)\$',
      caseSensitive: false,
    ).allMatches(text);
    if (matches.isNotEmpty) {
      final m = matches.last;
      final name = text.substring(0, m.start).trim();
      if (name.isEmpty) return null;
      final qty = DecimalFixed.tryParse(m.group(1)!.replaceAll(',', '.'));
      final unitPrice = _minorFrom(m.group(3)!);
      final lineTotal = _minorFrom(m.group(4)!);
      return ReceiptLineCandidate(
        rawText: text,
        name: name,
        normalizedName: normalizeName(name),
        quantity: qty,
        unitPriceMinor: unitPrice,
        lineTotalMinor: lineTotal ?? 0,
        confidence: (qty != null && unitPrice != null && lineTotal != null)
            ? 'high'
            : 'medium',
      );
    }

    // Basit satır: ad + sondaki fiyat (açgözlü ad yakalar: EKMEK).
    final simple = RegExp('^(.+)\\s+($_amountPattern)\$').firstMatch(text);
    if (simple != null) {
      final name = simple.group(1)!.trim();
      if (name.isEmpty) return null;
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

  int? _lastAmountMinor(String text) {
    final match = RegExp(
      '($_amountPattern)'
      r'\s*(TL|₺|TRY)?\s*$',
    ).firstMatch(text);
    if (match == null) return null;
    return _minorFrom(match.group(1)!);
  }

  int? _minorFrom(String decimalText) {
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
