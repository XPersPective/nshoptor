import 'dart:convert';

import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/money/money_parser.dart';
import '../../core/quantity/unit_code.dart';
import '../../core/util/normalize_name.dart';
import 'ocr_number_view.dart';
import 'ocr_currency.dart';
import 'ocr_text_source.dart';
import 'parser/receipt_parse_result.dart';
import 'parser/receipt_parser.dart';

enum ReceiptDocumentState { incompleteHeader, incompleteTail, complete }

enum ReceiptHeaderField { store, documentNumber, dateTime, currency }

/// How many photos one receipt session may hold.
///
/// Shared by the reader (which refuses more), the capture flow (which stops
/// offering more) and the tray (which appends the photo that completes an
/// incomplete receipt), so the cap can never disagree between them.
const int kMaxReceiptPhotos = 4;

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
    this._verifiedDiscountMinor,
    this._verifiedTaxMinor,
    this._verifiedSubtotalMinor,
    this._isVerifiedAi = false,
  }) : fragments = List.unmodifiable(fragments),
       productLines = List.unmodifiable(productLines),
       _financialRows = List.unmodifiable(financialRows);

  /// Builds a document verified by the AI receipt protocol while retaining the
  /// canonical textual rows as [fragments] so persistence and replay never lose
  /// verified product lines or trigger false OCR keyword skips.
  factory ReceiptDocument.fromAiVerified({
    required ReceiptMetadata metadata,
    required String currencyContext,
    required List<OcrScanResult> fragments,
    required List<ReceiptLineCandidate> productLines,
    required List<OcrLine> financialRows,
    required int discountMinor,
    int? taxMinor,
    int? subtotalMinor,
  }) => ReceiptDocument._(
    metadata: metadata,
    currencyContext: Currency.fromCode(currencyContext).code,
    fragments: fragments,
    productLines: productLines,
    financialRows: financialRows,
    verifiedDiscountMinor: discountMinor,
    verifiedTaxMinor: taxMinor,
    verifiedSubtotalMinor: subtotalMinor,
    isVerifiedAi: true,
  );

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
  final int? _verifiedDiscountMinor;
  final int? _verifiedTaxMinor;
  final int? _verifiedSubtotalMinor;
  final bool _isVerifiedAi;

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
      if (_isVerifiedAi)
        'verified': {
          'store': metadata.store,
          'documentNumber': metadata.documentNumber,
          'dateTime': metadata.dateTime?.toIso8601String(),
          'totalMinor': metadata.totalMinor,
          'currencyCode': metadata.currencyCode,
          'discountMinor': _verifiedDiscountMinor ?? 0,
          'taxMinor': _verifiedTaxMinor,
          'subtotalMinor': _verifiedSubtotalMinor,
          'lines': [
            for (final line in productLines)
              {
                'rawText': line.rawText,
                'name': line.name,
                'normalizedName': line.normalizedName,
                if (line.quantity != null)
                  'quantity': line.quantity!.toDbString(),
                if (line.unitCode != null) 'unitCode': line.unitCode!.dbCode,
                if (line.unitPriceMinor != null)
                  'unitPriceMinor': line.unitPriceMinor,
                'lineTotalMinor': line.lineTotalMinor,
                if (line.discountMinor > 0) 'discountMinor': line.discountMinor,
                if (line.discountLabel != null)
                  'discountLabel': line.discountLabel,
                'confidence': line.confidence,
              },
          ],
        },
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
      final verified = json['verified'];
      if (verified is Map<String, dynamic>) {
        final rawLines = verified['lines'];
        if (rawLines is! List || rawLines.isEmpty) {
          throw const FormatException('Invalid verified receipt lines');
        }
        final lines = <ReceiptLineCandidate>[
          for (final entry in rawLines)
            if (entry is Map<String, dynamic>)
              ReceiptLineCandidate(
                rawText: entry['rawText'] as String,
                name: entry['name'] as String,
                normalizedName: entry['normalizedName'] as String,
                quantity: entry['quantity'] is String
                    ? DecimalFixed.parse(entry['quantity'] as String)
                    : null,
                unitCode: entry['unitCode'] is String
                    ? UnitCode.fromDbCode(entry['unitCode'] as String)
                    : null,
                unitPriceMinor: entry['unitPriceMinor'] as int?,
                lineTotalMinor: entry['lineTotalMinor'] as int,
                discountMinor: (entry['discountMinor'] as int?) ?? 0,
                discountLabel: entry['discountLabel'] as String?,
                confidence: entry['confidence'] as String,
              )
            else
              throw const FormatException('Invalid verified line'),
        ];
        return ReceiptDocument.fromAiVerified(
          metadata: ReceiptMetadata(
            store: verified['store'] as String?,
            documentNumber: verified['documentNumber'] as String?,
            dateTime: verified['dateTime'] is String
                ? DateTime.parse(verified['dateTime'] as String)
                : null,
            totalMinor: verified['totalMinor'] as int?,
            currencyCode: verified['currencyCode'] as String?,
          ),
          currencyContext: currency,
          fragments: fragments,
          productLines: lines,
          financialRows: const [],
          discountMinor: (verified['discountMinor'] as int?) ?? 0,
          taxMinor: verified['taxMinor'] as int?,
          subtotalMinor: verified['subtotalMinor'] as int?,
        );
      }
      var document = ReceiptDocument.fromScan(
        fragments.first,
        currencyCode: currency,
      );
      for (final fragment in fragments.skip(1)) {
        final result = document.append(fragment);
        if (result is ReceiptAppended) {
          document = result.document;
        } else {
          document = document.appendSequential(fragment);
        }
      }
      return document;
    } on FormatException {
      rethrow;
    } catch (_) {
      throw const FormatException('Invalid receipt capture');
    }
  }

  ReceiptParseResult toParseResult() {
    final int? discount;
    final int? subtotalMinor;
    final int? taxMinor;
    if (_isVerifiedAi) {
      discount = _verifiedDiscountMinor ?? 0;
      subtotalMinor = _verifiedSubtotalMinor;
      taxMinor = _verifiedTaxMinor;
    } else {
      final parsed = ReceiptParser(
        currency: metadata.currencyCode ?? _currencyContext,
      ).parse(OcrScanResult(lines: _financialRows));
      discount = parsed.discountMinor;
      subtotalMinor = parsed.subtotalMinor;
      taxMinor = parsed.taxMinor;
    }
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
      subtotalMinor: subtotalMinor,
      discountMinor: discount,
      taxMinor: taxMinor,
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

  /// Joins consecutive pages captured in a single multi-page receipt session
  /// (`Aynı fişe devam`), supporting exact overlap, longest/fuzzy overlap,
  /// duplicate page suppression, and non-overlapping sequential continuation
  /// (e.g. top half + bottom half or items + totals/footer).
  ReceiptDocument appendSequential(OcrScanResult fragment) {
    final strict = append(fragment);
    if (strict is ReceiptAppended) {
      final preferredStore = _chooseStore(
        strict.document.metadata.store,
        ReceiptDocument.fromScan(
          fragment,
          currencyCode: metadata.currencyCode ?? _currencyContext,
        ).metadata.store,
      );
      if (preferredStore == strict.document.metadata.store) {
        return strict.document;
      }
      return ReceiptDocument._(
        metadata: ReceiptMetadata(
          store: preferredStore,
          documentNumber: strict.document.metadata.documentNumber,
          dateTime: strict.document.metadata.dateTime,
          totalMinor: strict.document.metadata.totalMinor,
          currencyCode: strict.document.metadata.currencyCode,
        ),
        currencyContext: strict.document._currencyContext,
        fragments: strict.document.fragments,
        productLines: strict.document.productLines,
        financialRows: strict.document._financialRows,
      );
    }
    final next = ReceiptDocument.fromScan(
      fragment,
      currencyCode: metadata.currencyCode ?? _currencyContext,
    );
    return _appendSequentialDocument(next);
  }

  ReceiptAppendResult prepend(OcrScanResult fragment) =>
      ReceiptDocument.fromScan(
        fragment,
        currencyCode: metadata.currencyCode ?? _currencyContext,
      )._appendDocument(this);

  ReceiptDocument _appendSequentialDocument(ReceiptDocument next) {
    final nextCode = next.metadata.currencyCode;
    if (nextCode != null &&
        metadata.currencyCode != nextCode &&
        !_observedCurrency &&
        next._observedCurrency) {
      var replay = ReceiptDocument.fromScan(
        fragments.first,
        currencyCode: nextCode,
      );
      for (final frame in fragments.skip(1)) {
        replay = replay.appendSequential(frame);
      }
      return replay._appendSequentialDocument(next);
    }

    // 1. If `next` is already a contiguous sub-slice of `productLines` (e.g.,
    //    the user added the same receipt photo twice or re-captured a section
    //    already covered), keep existing product/financial rows without double
    //    counting while merging metadata and retaining the fragment.
    final bool fullyContained;
    if (next.productLines.isNotEmpty &&
        next.productLines.length <= productLines.length) {
      var foundSlice = false;
      final maxStart = productLines.length - next.productLines.length;
      for (var start = 0; start <= maxStart; start++) {
        var allMatch = true;
        for (var i = 0; i < next.productLines.length; i++) {
          if (!_sameProductLine(
            productLines[start + i],
            next.productLines[i],
          )) {
            allMatch = false;
            break;
          }
        }
        if (allMatch) {
          foundSlice = true;
          break;
        }
      }
      fullyContained = foundSlice;
    } else {
      fullyContained = false;
    }

    List<ReceiptLineCandidate> combinedProducts;
    List<OcrLine> combinedFinancial;

    if (fullyContained) {
      combinedProducts = productLines;
      combinedFinancial = _financialRows;
    } else {
      // 2. Find longest suffix-prefix overlap using fuzzy product-line equality.
      var overlap = 0;
      final limit = productLines.length < next.productLines.length
          ? productLines.length
          : next.productLines.length;
      for (var length = 1; length <= limit; length++) {
        var matches = true;
        for (var i = 0; i < length; i++) {
          if (!_sameProductLine(
            productLines[productLines.length - length + i],
            next.productLines[i],
          )) {
            matches = false;
            break;
          }
        }
        if (matches) overlap = length;
      }

      final oldPositions = _productPositions(_financialRows, productLines);
      final newPositions = _productPositions(
        next._financialRows,
        next.productLines,
      );

      if (overlap > 0) {
        combinedProducts = [
          ...productLines,
          ...next.productLines.skip(overlap),
        ];
        if (oldPositions != null && newPositions != null) {
          combinedFinancial = [
            ..._financialRows.take(oldPositions[productLines.length - overlap]),
            ...next._financialRows.skip(newPositions.first),
          ];
        } else {
          combinedFinancial = [..._financialRows, ...next._financialRows];
        }
      } else {
        // 3. No overlapping product line: concatenate sequentially.
        combinedProducts = [...productLines, ...next.productLines];
        combinedFinancial = [..._financialRows, ...next._financialRows];
      }
    }

    final mergedCurrency = metadata.currencyCode ?? next.metadata.currencyCode;
    final chosenTotal = _chooseTotalMinor(
      firstTotal: metadata.totalMinor,
      nextTotal: next.metadata.totalMinor,
      products: combinedProducts,
      financialRows: combinedFinancial,
      currencyCode: mergedCurrency ?? _currencyContext,
    );

    return ReceiptDocument._(
      metadata: ReceiptMetadata(
        store: _chooseStore(metadata.store, next.metadata.store),
        documentNumber: metadata.documentNumber ?? next.metadata.documentNumber,
        dateTime: _printedTime(metadata.dateTime, next.metadata.dateTime),
        totalMinor: chosenTotal,
        currencyCode: mergedCurrency,
      ),
      currencyContext: _currencyContext,
      fragments: [...fragments, ...next.fragments],
      productLines: combinedProducts,
      financialRows: combinedFinancial,
    );
  }

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

String _fold(String text) {
  final view = OcrNumberView(text);
  return (view.valid ? view.text : text)
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
}

String _overlapText(ReceiptLineCandidate line) => _fold(line.rawText);

bool _sameProductLine(ReceiptLineCandidate a, ReceiptLineCandidate b) {
  if (_overlapText(a) == _overlapText(b)) return true;
  final nameA = _fold(a.name);
  final nameB = _fold(b.name);
  if (nameA.isNotEmpty &&
      nameA == nameB &&
      a.lineTotalMinor == b.lineTotalMinor) {
    return true;
  }
  return false;
}

String? _chooseStore(String? first, String? next) {
  if (first == null || first.trim().isEmpty) return next;
  if (next == null || next.trim().isEmpty) return first;
  bool isKnownChain(String s) => RegExp(
    r'\b(?:market|magaza|migros|carrefour|bim|sok|a101)\b',
  ).hasMatch(_fold(s));
  final firstChain = isKnownChain(first);
  final nextChain = isKnownChain(next);
  if (nextChain && !firstChain) return next;
  return first;
}

int? _chooseTotalMinor({
  required int? firstTotal,
  required int? nextTotal,
  required List<ReceiptLineCandidate> products,
  required List<OcrLine> financialRows,
  required String currencyCode,
}) {
  if (firstTotal == null) return nextTotal;
  if (nextTotal == null || firstTotal == nextTotal) return firstTotal;
  if (products.isEmpty) return nextTotal;
  final parsed = ReceiptParser(
    currency: currencyCode,
  ).parse(OcrScanResult(lines: financialRows));
  final discount = parsed.discountMinor;
  final productSum = products.fold<int>(0, (n, l) => n + l.lineTotalMinor);
  int diffFor(int total) {
    final computed =
        productSum -
        receiptDiscountToApplyMinor(
          productSumMinor: productSum,
          observedDiscountMinor: discount,
          reportedTotalMinor: total,
        );
    return (computed - total).abs();
  }

  final dFirst = diffFor(firstTotal);
  final dNext = diffFor(nextTotal);
  if (dNext <= dFirst) return nextTotal;
  return firstTotal;
}

bool _isDocumentMetadata(String text, String? store) {
  final folded = _fold(text);
  if (RegExp(r'^ara\s+t[o0]plam\b').hasMatch(folded) ||
      RegExp(
        r'^(?:mal[./\s]*hizmet|topkdv|kdv\s+oran[ıi]|kdv\s+dahil|provizyon|ref\.?no|puan\s*:|ettn|yap[ıi]\s*kredi|nakit|kredi\s+kart[ıi]|banka\s+kart[ıi]|faturan[ıi]za|https?://)',
      ).hasMatch(folded) ||
      RegExp(r'^[*#•\s]*%\s*\d{1,2}(?:\s|$)').hasMatch(folded)) {
    return true;
  }
  return store != null && folded == _fold(store) ||
      _date.hasMatch(folded) &&
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
  String? domainMerchant() {
    for (final line in lines) {
      final f = _fold(line);
      if (f.contains('a101.com')) return 'A101';
      if (f.contains('sokmarket')) return 'ŞOK MARKET';
      if (f.contains('bim.com')) return 'BİM';
      if (f.contains('migros')) return 'MİGROS';
      if (f.contains('carrefour')) return 'CARREFOURSA';
    }
    return null;
  }

  final headerAnchor = lines.indexWhere(
    (line) =>
        _documentNumber.hasMatch(_fold(line)) || _date.hasMatch(_fold(line)),
  );
  for (var i = 0; i < lines.length && i < 8; i++) {
    final line = lines[i];
    final folded = _fold(line);
    if (RegExp(
      r'^(?:magaza|satici|store)\s*:\s*\p{L}',
      unicode: true,
    ).hasMatch(folded)) {
      final view = OcrNumberView(line);
      return view.originalSlice(view.text.indexOf(':') + 1).trim();
    }
    if (!RegExp(r'[A-Za-zÇĞİÖŞÜçğıöşü]{2}').hasMatch(line) ||
        folded.startsWith('http://') ||
        folded.startsWith('https://') ||
        RegExp(r'\d+[.,\u066b]\d+|\d{1,2}:\d{2}').hasMatch(folded) ||
        RegExp(
          r'^(?:tarih|saat|fis|fatura|faturan[ıi]za|belge|kdv|vergi|vkn|tel|kasa|kasiyer|satis|sube|adres|satici|magaza|store|toplam|ara toplam|nakit|kart|kredi|banka|e[ -]?arsiv)\b',
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
            !_date.hasMatch(folded)) {
      if (!namedMerchant && (line.contains('/') || RegExp(r'\d').hasMatch(line))) {
        final hinted = domainMerchant();
        if (hinted != null) return hinted;
      }
      return line;
    }
  }
  return domainMerchant();
}

final _date = RegExp(
  r'(?<!\d)(?:(\d{4})-(\d{1,2})-(\d{1,2})|'
  r'(\d{1,2})[./\u066b-](\d{1,2})[./\u066b-](\d{2}|\d{4}))(?!\d)',
);
final _time = RegExp(
  r'(?<![\d:])([01]?\d|2[0-3]):([0-5]\d)(?::([0-5]\d))?(?![\d:])',
);

DateTime? _readDateTime(List<String> lines) {
  DateTime? date;
  RegExpMatch? time;
  for (final line in lines) {
    final view = OcrNumberView(line);
    if (!view.valid) continue;
    final match = _date.firstMatch(view.text);
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
            RegExp(r'^\d{1,2}:\d{2}(?::\d{2})?$').hasMatch(view.text))) {
      time = _time.firstMatch(view.text);
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
  r'^[*#\s]*(?:genel\s+t[o0]plam|t[o0]plam(?:\s+tutar)?|fatura\s+tutar[ıi]|[o0]denecek(?:\s+t[^\s\d]{0,6}(?:\s+[^\s\d]{1,6})?)?|grand\s+t[o0]tal|t[o0]tal|amount\s+due|total\s+due|summe|gesamt)'
  r'\s*[:=*]?\s*'
  '(?:$_currencyToken)?'
  r'\s*[*]*\s*(\d+(?:[.,\u066b]\d+)*)\s*'
  '(?:$_currencyToken)?'
  r'\s*$',
  caseSensitive: false,
);

int? _readTotal(List<String> lines, String currencyCode) {
  final totals = <int>{};
  final digits = Currency.fromCode(currencyCode).minorUnitDigits;
  for (final line in lines) {
    final normalized = repairConfusableAmounts(_fold(line));
    final raw = _totalLine.firstMatch(normalized)?.group(1);
    if (raw == null) continue;
    if (digits == 0) {
      final amount = wholeOcrAmount(raw);
      if (amount != null) totals.add(amount);
      continue;
    }
    try {
      final separators = ocrAmountSeparators(raw, minorDigits: digits);
      final amount = MoneyParser.parseDecimal(raw, separators: separators);
      if (amount.scale <= digits) totals.add(amount.toMinorUnits(digits));
    } on FormatException {
      // Malformed OCR totals remain unknown instead of being rounded/guessed.
    }
  }
  return totals.length == 1 ? totals.single : null;
}
