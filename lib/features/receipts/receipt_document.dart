import 'dart:convert';

import '../../core/money/currency.dart';
import '../../core/money/money_parser.dart';
import '../../core/util/normalize_name.dart';
import 'ocr_currency.dart';
import 'ocr_text_source.dart';
import 'parser/receipt_parse_result.dart';
import 'parser/receipt_parser.dart';

enum ReceiptDocumentState { incompleteHeader, incompleteTail, complete }

enum ReceiptHeaderField { store, documentNumber, dateTime, currency }

/// OCR evidence only: absent document numbers and times are never invented.
final class ReceiptMetadata {
  const ReceiptMetadata({
    this.store,
    this.documentNumber,
    this.dateTime,
    this.totalMinor,
    this.currencyCode,
  });

  final String? store;
  final String? documentNumber;

  /// Printed local wall time; a receipt does not establish a timezone.
  final DateTime? dateTime;
  final int? totalMinor;

  /// Explicit OCR currency, or the caller's known currency context when the
  /// image has no currency marker. Conflicting/ambiguous markers yield null.
  final String? currencyCode;

  List<ReceiptHeaderField> get missingHeaderFields => List.unmodifiable([
    if (store == null) ReceiptHeaderField.store,
    if (documentNumber == null) ReceiptHeaderField.documentNumber,
    if (dateTime == null) ReceiptHeaderField.dateTime,
    if (currencyCode == null) ReceiptHeaderField.currency,
  ]);

  /// A deterministic candidate key, not a database uniqueness guarantee.
  /// Products, totals and image paths alone never establish document identity.
  String? get identity => missingHeaderFields.isNotEmpty
      ? null
      : jsonEncode([
          'receipt-v2',
          normalizeName(store!),
          // OCR can omit printed seconds without changing the document.
          // Retain the full observed time in metadata, key at minute precision.
          _minute(dateTime!).toIso8601String(),
          documentNumber!.toUpperCase(),
          currencyCode,
        ]);
}

enum ReceiptAppendError { noOverlap, conflictingDocument }

sealed class ReceiptAppendResult {
  const ReceiptAppendResult();
}

final class ReceiptAppended extends ReceiptAppendResult {
  const ReceiptAppended({required this.document, required this.overlapLines});

  final ReceiptDocument document;
  final int overlapLines;
}

final class ReceiptAppendRejected extends ReceiptAppendResult {
  const ReceiptAppendRejected(this.error);

  final ReceiptAppendError error;
}

/// Immutable in-memory document foundation. Completeness describes observed
/// header/products/total coverage, not OCR accuracy or reconciled payment.
/// Persistence, user review and transactional duplicate protection are separate.
final class ReceiptDocument {
  ReceiptDocument._({
    required this.metadata,
    required this._currencyContext,
    required List<OcrScanResult> fragments,
    required List<ReceiptLineCandidate> productLines,
    required List<OcrLine> financialRows,
  }) : fragments = List.unmodifiable(fragments),
       productLines = List.unmodifiable(productLines),
       _financialRows = List.unmodifiable(financialRows);

  factory ReceiptDocument.fromScan(
    OcrScanResult scan, {
    required String currencyCode,
  }) {
    final context = Currency.fromCode(currencyCode).code;
    final snapshot = OcrScanResult(lines: List.unmodifiable(scan.lines));
    final readingRows = ReceiptParser(currency: context).readingRows(snapshot);
    final textLines = readingRows
        .map((line) => line.text.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    final currency = detectOcrCurrency(textLines.join('\n'), fallback: context);
    final code = currency.needsConfirmation ? null : currency.code ?? context;
    final store = _readStore(textLines);
    // The existing wrapped-product parser does not recognize every invoice
    // header/total label. Remove those metadata-only rows before it buffers
    // names, while retaining the complete OCR evidence in [fragments].
    final products = OcrScanResult(
      lines: readingRows
          .where((line) => !_isDocumentMetadata(line.text, store))
          .toList(),
    );
    final parser = ReceiptParser(currency: code ?? context);
    final parsed = parser.parse(products);
    return ReceiptDocument._(
      metadata: ReceiptMetadata(
        store: store,
        documentNumber: _readDocumentNumber(textLines),
        dateTime: _readDateTime(textLines),
        totalMinor: code == null ? null : _readTotal(textLines, code),
        currencyCode: code,
      ),
      currencyContext: context,
      fragments: [snapshot],
      productLines: parsed.lines
          .where((line) => !_totalLine.hasMatch(_fold(line.rawText)))
          .toList(),
      financialRows: parser.logicalRows(products),
    );
  }

  final ReceiptMetadata metadata;
  final String _currencyContext;
  final List<OcrScanResult> fragments;
  final List<ReceiptLineCandidate> productLines;
  final List<OcrLine> _financialRows;

  ReceiptDocumentState get state => metadata.missingHeaderFields.isNotEmpty
      ? ReceiptDocumentState.incompleteHeader
      : metadata.totalMinor == null || productLines.isEmpty
      ? ReceiptDocumentState.incompleteTail
      : ReceiptDocumentState.complete;

  String? get identity => metadata.identity;

  /// Versioned OCR evidence, kept locally so a partial receipt survives restart.
  /// Derived metadata is replayed on load instead of trusting stored flags.
  String encode() {
    final encoded = jsonEncode({
      'version': 1,
      // Replay currency-free earlier fragments in the final observed currency.
      'currency': metadata.currencyCode ?? _currencyContext,
      'fragments': [
        for (final fragment in fragments)
          [
            for (final line in fragment.lines)
              {
                'text': line.text,
                if (line.boundingBoxTop != null) 'top': line.boundingBoxTop,
                if (line.boundingBoxLeft != null) 'left': line.boundingBoxLeft,
                if (line.boundingBoxHeight != null)
                  'height': line.boundingBoxHeight,
                if (line.boundingBoxWidth != null)
                  'width': line.boundingBoxWidth,
              },
          ],
      ],
    });
    if (encoded.length > 2000000 ||
        fragments.length > 25 ||
        fragments.fold<int>(0, (n, f) => n + f.lines.length) > 10000) {
      throw const FormatException('Receipt capture exceeds local limit');
    }
    return encoded;
  }

  factory ReceiptDocument.decode(String encoded) {
    if (encoded.length > 2000000) {
      throw const FormatException('Receipt capture exceeds local limit');
    }
    try {
      final json = jsonDecode(encoded) as Map<String, dynamic>;
      final frames = json['fragments'] as List;
      final currency = json['currency'] as String;
      if (json['version'] != 1 ||
          frames.isEmpty ||
          frames.length > 25 ||
          !Currency.all.any((c) => c.code == currency)) {
        throw const FormatException('Unsupported receipt capture');
      }
      var count = 0;
      double? position(Object? value) {
        if (value == null) return null;
        if (value is! num || !value.toDouble().isFinite) {
          throw const FormatException('Invalid receipt position');
        }
        return value.toDouble();
      }

      final fragments = <OcrScanResult>[];
      for (final frame in frames) {
        final rows = frame as List;
        count += rows.length;
        if (count > 10000) {
          throw const FormatException('Receipt capture exceeds local limit');
        }
        fragments.add(
          OcrScanResult(
            lines: [
              for (final value in rows)
                OcrLine(
                  text: (value as Map<String, dynamic>)['text'] as String,
                  boundingBoxTop: position(value['top']),
                  boundingBoxLeft: position(value['left']),
                  boundingBoxHeight: position(value['height']),
                  boundingBoxWidth: position(value['width']),
                ),
            ],
          ),
        );
      }
      var document = ReceiptDocument.fromScan(
        fragments.first,
        currencyCode: currency,
      );
      for (final fragment in fragments.skip(1)) {
        final result = document.append(fragment);
        if (result is! ReceiptAppended) {
          throw const FormatException(
            'Receipt continuation cannot be replayed',
          );
        }
        document = result.document;
      }
      return document;
    } on FormatException {
      rethrow;
    } catch (_) {
      throw const FormatException('Invalid receipt capture');
    }
  }

  ReceiptParseResult toParseResult() {
    final parsed = ReceiptParser(
      currency: metadata.currencyCode ?? _currencyContext,
    ).parse(OcrScanResult(lines: _financialRows));
    final discount = parsed.discountMinor;
    final productSum = productLines.fold<int>(
      0,
      (n, l) => n + l.lineTotalMinor,
    );
    final computed =
        productSum -
        receiptDiscountToApplyMinor(
          productSumMinor: productSum,
          observedDiscountMinor: discount,
          reportedTotalMinor: metadata.totalMinor,
        );
    final difference = computed - (metadata.totalMinor ?? computed);
    return ReceiptParseResult(
      storeCandidates: [if (metadata.store != null) metadata.store!],
      dateCandidate: metadata.dateTime,
      currencyCandidate: metadata.currencyCode,
      currencyNeedsConfirmation: metadata.currencyCode == null,
      subtotalMinor: parsed.subtotalMinor,
      discountMinor: discount,
      taxMinor: parsed.taxMinor,
      totalMinor: metadata.totalMinor,
      lines: productLines,
      computedTotalMinor: computed,
      reconciliationDifferenceMinor: difference,
      withinReconciliationTolerance:
          metadata.totalMinor != null && difference.abs() <= 2,
    );
  }

  /// Only adjacent suffix/prefix product-text overlap can join fragments.
  /// No set-based product deduplication is performed. Repeated-only ambiguous
  /// overlaps are rejected rather than guessing how many purchases to remove.
  ReceiptAppendResult append(OcrScanResult fragment) {
    final next = ReceiptDocument.fromScan(
      fragment,
      currencyCode: metadata.currencyCode ?? _currencyContext,
    );
    return _appendDocument(next);
  }

  ReceiptAppendResult prepend(OcrScanResult fragment) =>
      ReceiptDocument.fromScan(
        fragment,
        currencyCode: metadata.currencyCode ?? _currencyContext,
      )._appendDocument(this);

  ReceiptAppendResult _appendDocument(ReceiptDocument next) {
    final nextCode = next.metadata.currencyCode;
    if (nextCode != null &&
        metadata.currencyCode != nextCode &&
        !_observedCurrency &&
        next._observedCurrency) {
      // The caller's default is context, not conflicting printed evidence.
      // Reparse earlier amounts in the now-observed currency before merging.
      var replay = ReceiptDocument.fromScan(
        fragments.first,
        currencyCode: nextCode,
      );
      for (final frame in fragments.skip(1)) {
        final joined = replay.append(frame);
        if (joined is! ReceiptAppended) {
          return const ReceiptAppendRejected(ReceiptAppendError.noOverlap);
        }
        replay = joined.document;
      }
      return replay._appendDocument(next);
    }
    if (_conflicts(metadata, next.metadata)) {
      return const ReceiptAppendRejected(
        ReceiptAppendError.conflictingDocument,
      );
    }
    final overlaps = <int>[];
    final limit = productLines.length < next.productLines.length
        ? productLines.length
        : next.productLines.length;
    for (var length = 1; length <= limit; length++) {
      var matches = true;
      for (var i = 0; i < length; i++) {
        if (_overlapText(productLines[productLines.length - length + i]) !=
            _overlapText(next.productLines[i])) {
          matches = false;
          break;
        }
      }
      if (matches) overlaps.add(length);
    }
    if (overlaps.length != 1) {
      return const ReceiptAppendRejected(ReceiptAppendError.noOverlap);
    }
    final overlap = overlaps.single;
    final oldPositions = _productPositions(_financialRows, productLines);
    final newPositions = _productPositions(
      next._financialRows,
      next.productLines,
    );
    if (oldPositions == null || newPositions == null) {
      return const ReceiptAppendRejected(ReceiptAppendError.noOverlap);
    }
    return ReceiptAppended(
      overlapLines: overlap,
      document: ReceiptDocument._(
        metadata: ReceiptMetadata(
          store: metadata.store ?? next.metadata.store,
          documentNumber:
              metadata.documentNumber ?? next.metadata.documentNumber,
          dateTime: _printedTime(metadata.dateTime, next.metadata.dateTime),
          totalMinor: metadata.totalMinor ?? next.metadata.totalMinor,
          currencyCode: metadata.currencyCode ?? next.metadata.currencyCode,
        ),
        currencyContext: _currencyContext,
        fragments: [...fragments, ...next.fragments],
        productLines: [...productLines, ...next.productLines.skip(overlap)],
        // Replace the observed overlap, including its item discounts, as one
        // ordered span. Earlier discounts survive and repeated ones count once.
        financialRows: [
          ..._financialRows.take(oldPositions[productLines.length - overlap]),
          ...next._financialRows.skip(newPositions.first),
        ],
      ),
    );
  }

  bool get _observedCurrency => detectOcrCurrency(
    fragments.expand((f) => f.lines).map((l) => l.text).join('\n'),
    fallback: metadata.currencyCode ?? _currencyContext,
  ).codes.isNotEmpty;
}

List<int>? _productPositions(
  List<OcrLine> rows,
  List<ReceiptLineCandidate> products,
) {
  final positions = <int>[];
  var cursor = 0;
  for (final product in products) {
    while (cursor < rows.length &&
        _fold(rows[cursor].text) != _fold(product.rawText)) {
      cursor++;
    }
    if (cursor == rows.length) return null;
    positions.add(cursor++);
  }
  return positions;
}

String _fold(String text) => text
    .replaceAll('İ', 'i')
    .replaceAll('I', 'ı')
    .toLowerCase()
    .replaceAll('ı', 'i')
    .replaceAll('ş', 's')
    .replaceAll('ğ', 'g')
    .replaceAll('ü', 'u')
    .replaceAll('ö', 'o')
    .replaceAll('ç', 'c')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

String _overlapText(ReceiptLineCandidate line) => _fold(line.rawText);

bool _isDocumentMetadata(String text, String? store) {
  final folded = _fold(text);
  return store != null && folded == _fold(store) ||
      _date.hasMatch(text) &&
          (RegExp(r'^\d').hasMatch(folded) ||
              RegExp(r'^(?:tarih|date|satici|kasa|saat|time|satis\s+tarihi)\b')
                  .hasMatch(folded)) ||
      RegExp(r'^(?:saat|time)\b').hasMatch(folded) ||
      RegExp(r'^\d{1,2}:\d{2}(?::\d{2})?$').hasMatch(folded) ||
      _documentNumber.hasMatch(folded) ||
      RegExp(
        r'^(?:(?:e[ -]?arsiv|okc)\s+|e[ -]?)?'
        r'(?:fis|fatura|belge|receipt|invoice)\s*'
        r'(?:no(?:su)?|numarasi|numara|number|#)(?=\s|[:#.]|$)',
      ).hasMatch(folded) ||
      _totalLine.hasMatch(folded);
}

DateTime _minute(DateTime value) =>
    DateTime(value.year, value.month, value.day, value.hour, value.minute);

DateTime? _printedTime(DateTime? first, DateTime? next) =>
    first == null || first.second == 0 && next != null && next.second != 0
    ? next
    : first;

bool _conflicts(ReceiptMetadata a, ReceiptMetadata b) =>
    a.currencyCode == null ||
    b.currencyCode == null ||
    a.store != null && b.store != null && _fold(a.store!) != _fold(b.store!) ||
    a.documentNumber != null &&
        b.documentNumber != null &&
        a.documentNumber!.toUpperCase() != b.documentNumber!.toUpperCase() ||
    a.dateTime != null &&
        b.dateTime != null &&
        _minute(a.dateTime!) != _minute(b.dateTime!) ||
    a.currencyCode != null &&
        b.currencyCode != null &&
        a.currencyCode != b.currencyCode ||
    a.totalMinor != null &&
        b.totalMinor != null &&
        a.totalMinor != b.totalMinor;

final _documentNumber = RegExp(
  r'(?:^|\s)(?:(?:e[ -]?arsiv|okc)\s+|e[ -]?)?'
  r'(?:fis|fatura|belge|receipt|invoice)\s*'
  r'(?:no(?:su)?\.?|numarasi|numara|number|#)\s*[:#-]?\s*'
  r'([a-z0-9][a-z0-9/-]{0,63})(?=\s|$)',
);

String? _readDocumentNumber(List<String> lines) {
  final numbers = <String>{};
  for (final line in lines) {
    final match = _documentNumber.firstMatch(_fold(line));
    final number = match?.group(1);
    if (number != null && RegExp(r'\d').hasMatch(number)) {
      numbers.add(number.toUpperCase());
    }
  }
  return numbers.length == 1 ? numbers.single : null;
}

String? _readStore(List<String> lines) {
  final headerAnchor = lines.indexWhere(
    (line) => _documentNumber.hasMatch(_fold(line)) || _date.hasMatch(line),
  );
  for (var i = 0; i < lines.length && i < 8; i++) {
    final line = lines[i];
    final folded = _fold(line);
    if (RegExp(r'^(?:magaza|satici|store)\s*:\s*\p{L}', unicode: true).hasMatch(folded)) {
      return line.substring(line.indexOf(':') + 1).trim();
    }
    if (!RegExp(r'[A-Za-zÇĞİÖŞÜçğıöşü]{2}').hasMatch(line) ||
        RegExp(r'\d+[.,]\d+|\d{1,2}:\d{2}').hasMatch(line) ||
        RegExp(
          r'^(?:tarih|saat|fis|fatura|belge|kdv|vergi|vkn|tel|kasa|kasiyer|satis|sube|adres|satici|magaza|store|toplam|ara toplam|nakit|kart|kredi|banka|e[ -]?arsiv)\b',
        ).hasMatch(folded)) {
      continue;
    }
    if (RegExp(r'\b(?:mahallesi|mah|caddesi|cad|sokak|bulvari)\b')
        .hasMatch(folded)) {
      continue;
    }
    final namedMerchant = RegExp(
      r'\b(?:market|magaza|migros|carrefour|bim|sok|a101)\b',
    ).hasMatch(folded);
    if (namedMerchant ||
        headerAnchor > i &&
            line == line.toUpperCase() &&
            !_date.hasMatch(line)) {
      return line;
    }
  }
  return null;
}

final _date = RegExp(
  r'(?<!\d)(?:(\d{4})-(\d{1,2})-(\d{1,2})|'
  r'(\d{1,2})[./-](\d{1,2})[./-](\d{2}|\d{4}))(?!\d)',
);
final _time = RegExp(
  r'(?<![\d:])([01]?\d|2[0-3]):([0-5]\d)(?::([0-5]\d))?(?![\d:])',
);

DateTime? _readDateTime(List<String> lines) {
  DateTime? date;
  RegExpMatch? time;
  for (final line in lines) {
    final match = _date.firstMatch(line);
    if (date == null && match != null) {
      final yearFirst = match.group(1) != null;
      var year = int.parse(match.group(yearFirst ? 1 : 6)!);
      if (year < 100) year += 2000;
      final month = int.parse(match.group(yearFirst ? 2 : 5)!);
      final day = int.parse(match.group(yearFirst ? 3 : 4)!);
      final candidate = DateTime(year, month, day);
      if (candidate.year == year &&
          candidate.month == month &&
          candidate.day == day) {
        date = candidate;
      }
    }
    if (time == null &&
        (match != null ||
            RegExp(r'\b(?:saat|time)\b').hasMatch(_fold(line)) ||
            RegExp(r'^\d{1,2}:\d{2}(?::\d{2})?$').hasMatch(line))) {
      time = _time.firstMatch(line);
    }
  }
  if (date == null || time == null) return null;
  return DateTime(
    date.year,
    date.month,
    date.day,
    int.parse(time.group(1)!),
    int.parse(time.group(2)!),
    int.parse(time.group(3) ?? '0'),
  );
}

final _currencyToken =
    '(?:${Currency.all.map((currency) => currency.code.toLowerCase()).join('|')}'
    r'|tl|[₺€£$])';
final _totalLine = RegExp(
  r'^[*#\s]*(?:genel\s+toplam|toplam(?:\s+tutar)?|odenecek(?:\s+tutar)?|grand\s+total|total)'
  r'\s*[:=*]?\s*'
  '(?:$_currencyToken)?'
  r'\s*(\d+(?:[.,]\d+)*)\s*'
  '(?:$_currencyToken)?'
  r'\s*$',
);

int? _readTotal(List<String> lines, String currencyCode) {
  final totals = <int>{};
  final digits = Currency.fromCode(currencyCode).minorUnitDigits;
  for (final line in lines) {
    final raw = _totalLine.firstMatch(_fold(line))?.group(1);
    if (raw == null) continue;
    try {
      final separators = raw.lastIndexOf(',') > raw.lastIndexOf('.')
          ? MoneySeparators.tr
          : MoneySeparators.en;
      final amount = MoneyParser.parseDecimal(raw, separators: separators);
      if (amount.scale <= digits) totals.add(amount.toMinorUnits(digits));
    } on FormatException {
      // Malformed OCR totals remain unknown instead of being rounded/guessed.
    }
  }
  return totals.length == 1 ? totals.single : null;
}
