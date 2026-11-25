import 'dart:convert';

import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/quantity/unit_code.dart';
import '../../core/text/store_name.dart';
import '../../core/util/normalize_name.dart';
import '../ai/ai_client.dart';
import 'ai_image.dart';
import 'ocr_text_source.dart';
import 'parser/receipt_parse_result.dart';
import 'receipt_document.dart';
import 'receipt_read_failure.dart';
import 'shelf_label/mlkit_text_source.dart';

export 'receipt_read_failure.dart' show AiReceiptGap;

/// Where a receipt reading stands after one AI request.
sealed class AiReceiptRead {
  const AiReceiptRead();
}

/// Verified by the server and again here; ready for user review.
final class AiReceiptVerified extends AiReceiptRead {
  const AiReceiptVerified(this.document);
  final ReceiptDocument document;
}

/// The model saw only part of the receipt: guide the user to the missing part.
final class AiReceiptNeedsMore extends AiReceiptRead {
  const AiReceiptNeedsMore(
    this.gap, {
    this.store,
    this.date,
    this.currency,
    this.visibleItems = const [],
  });

  /// Product rows already readable on the visible part (F16): shown in the
  /// list right away, priced only when the whole receipt is saved.
  final List<({String name, String? quantity, String? unit})> visibleItems;
  final AiReceiptGap gap;

  /// The receipt's own currency when printed (the list is created in it).
  final String? currency;

  /// Header read from the visible part, if any. A receipt is only kept (and
  /// its list created) once store and date are known (F11-F12).
  final String? store;
  final DateTime? date;

  bool get hasHeader => store != null && date != null;
}

/// Not a receipt, unreadable, or rejected twice by validation: retake.
///
/// [reason] is always a [ReceiptReadFailure] code, never free text: the
/// model cannot answer with an arbitrary sentence the user has to interpret.
final class AiReceiptRetake extends AiReceiptRead {
  const AiReceiptRetake(this.reason);
  final String reason;

  /// The canonical failure this retake stands for.
  ReceiptReadFailure get failure => ReceiptReadFailure.fromCode(reason);
}

/// Offline, over quota, disabled or provider down: use the on-device path.
final class AiReceiptUnavailable extends AiReceiptRead {
  const AiReceiptUnavailable(this.result);
  final AiResult? result;
}

/// Protocol `receipt.v2`: photos of one receipt (top to bottom) go to the AI
/// proxy, which never stores them. The server accepts only a schema-valid,
/// exactly reconciled answer (retrying the model once at no extra charge).
/// This reader re-checks it, converts it into canonical rows and builds the
/// local [ReceiptDocument]; the rebuilt document must reproduce every line,
/// discount and total, otherwise the answer is discarded. The phone stays the
/// only store of photos and partial progress; the model has no session.
class AiReceiptReader {
  AiReceiptReader(
    this.ai, {
    this.localeCode = 'en',
    this.encode = encodeImageForAi,
  });

  final AiClient ai;
  final String localeCode;
  final Future<String?> Function(String path) encode;

  static const maxPhotos = kMaxReceiptPhotos;

  static const _unitSuffix = {
    'kilogram': 'KG',
    'gram': 'G',
    'litre': 'LT',
    'millilitre': 'ML',
    'piece': 'ADET',
  };

  Future<AiReceiptRead> read(
    List<String> photoPaths, {
    required String currencyCode,
  }) async {
    if (!ai.enabled) return const AiReceiptUnavailable(null);
    if (photoPaths.isEmpty || photoPaths.length > maxPhotos) {
      return const AiReceiptRetake('photo_count');
    }
    final images = <String>[];
    for (final path in photoPaths) {
      final encoded = await encode(path);
      if (encoded == null) return const AiReceiptRetake('image');
      images.add(encoded);
    }
    final AiResult response;
    try {
      response = await ai.request(
        'read_receipt_image',
        {'images': images, 'currency': currencyCode},
        locale: localeCode,
        timeout: const Duration(seconds: 220),
      );
    } catch (_) {
      return const AiReceiptUnavailable(AiFailed('request'));
    }
    return switch (response) {
      AiOk(:final result) => interpret(result, currencyCode: currencyCode),
      // The server answers 502 bad_model_output only after its corrective
      // retry also failed: the photos themselves need to be retaken.
      AiFailed(:final reason) when reason == 'bad_model_output' =>
        const AiReceiptRetake('rejected'),
      _ => AiReceiptUnavailable(response),
    };
  }

  /// Public for tests: the client-side half of the protocol.
  static AiReceiptRead interpret(
    Map<String, dynamic> data, {
    required String currencyCode,
  }) {
    if (data['schema'] != 2) return const AiReceiptRetake('schema');
    final store =
        data['store'] is String && (data['store'] as String).trim().isNotEmpty
        ? (data['store'] as String).trim()
        : null;
    final dateMatch = data['date'] is String
        ? RegExp(r'^(\d{4})-(\d{2})-(\d{2})$')
              .firstMatch(data['date'] as String)
        : null;
    final date = dateMatch == null
        ? null
        : DateTime(
            int.parse(dateMatch[1]!),
            int.parse(dateMatch[2]!),
            int.parse(dateMatch[3]!),
          );
    final partialCurrency =
        data['currency'] is String &&
            Currency.isKnownCode(data['currency'] as String)
        ? (data['currency'] as String).toUpperCase()
        : null;
    final visible = <({String name, String? quantity, String? unit})>[
      if (data['items'] is List)
        for (final item in data['items'] as List)
          if (item is Map &&
              item['name'] is String &&
              (item['name'] as String).trim().isNotEmpty)
            (
              name: (item['name'] as String).trim(),
              quantity: item['quantity'] is String
                  ? item['quantity'] as String
                  : null,
              unit: item['unit'] is String ? item['unit'] as String : null,
            ),
    ];
    switch (data['status']) {
      case 'complete':
        break;
      case 'top_missing':
        return AiReceiptNeedsMore(
          AiReceiptGap.top,
          store: store,
          date: date,
          currency: partialCurrency,
        );
      case 'bottom_missing':
        return AiReceiptNeedsMore(
          AiReceiptGap.bottom,
          store: store,
          date: date,
          currency: partialCurrency,
          visibleItems: visible,
        );
      case 'middle_gap':
        return AiReceiptNeedsMore(
          AiReceiptGap.middle,
          store: store,
          date: date,
          currency: partialCurrency,
          visibleItems: visible,
        );
      default:
        // The protocol names six statuses. Anything else becomes a canonical
        // code, never a free-text reason the user would have to interpret.
        return AiReceiptRetake(
          ReceiptReadFailure.fromAiStatus(data['status'] as String?).code,
        );
    }
    final code = data['currency'] is String
        ? (data['currency'] as String).toUpperCase()
        : currencyCode;
    if (!Currency.isKnownCode(code)) return const AiReceiptRetake('currency');
    final digits = Currency.fromCode(code).minorUnitDigits;
    final built = _canonical(data, code, digits);
    if (built == null) return const AiReceiptRetake('mismatch');
    // A complete reading without a readable store/date cannot be identified.
    if (built.store == null || built.dateTime == null) {
      return const AiReceiptNeedsMore(AiReceiptGap.top);
    }
    final document = ReceiptDocument.fromAiVerified(
      metadata: ReceiptMetadata(
        store: built.store,
        documentNumber: built.documentNumber,
        dateTime: built.dateTime,
        totalMinor: built.total,
        currencyCode: code,
      ),
      currencyContext: code,
      fragments: [
        OcrScanResult(lines: [for (final row in built.rows) OcrLine(text: row)]),
      ],
      productLines: built.lines,
      financialRows: const [],
      discountMinor: built.discount,
      taxMinor: built.tax,
      subtotalMinor: built.subtotal,
    );
    final parsed = document.toParseResult();
    final same =
        document.state == ReceiptDocumentState.complete &&
        parsed.withinReconciliationTolerance &&
        parsed.totalMinor == built.total &&
        (parsed.discountMinor ?? 0) == built.discount &&
        parsed.lines.length == built.lines.length;
    return same
        ? AiReceiptVerified(document)
        : const AiReceiptRetake('mismatch');
  }

  static UnitCode? _parseUnit(Object? unit) {
    if (unit is! String) return null;
    for (final value in UnitCode.values) {
      if (value.dbCode == unit) return value;
    }
    return null;
  }

  static ({
    List<String> rows,
    List<ReceiptLineCandidate> lines,
    String? store,
    String documentNumber,
    DateTime? dateTime,
    int discount,
    int? tax,
    int? subtotal,
    int total,
  })?
  _canonical(Map<String, dynamic> data, String currency, int digits) {
    final items = data['items'];
    final discounts = data['discounts'];
    if (items is! List || items.isEmpty || discounts is! List) return null;
    String? one(Object? v, int max) {
      if (v is! String) return null;
      final t = v.replaceAll(RegExp(r'\s+'), ' ').trim();
      return t.isEmpty || t.length > max ? null : t;
    }

    final rows = <String>[];
    final store = one(data['store'], 80);
    final cleanedStore = store != null ? cleanStoreName(store) : null;
    if (cleanedStore != null) rows.add('STORE : $cleanedStore');
    final date = data['date'] is String
        ? RegExp(r'^(\d{4})-(\d{2})-(\d{2})$')
              .firstMatch(data['date'] as String)
        : null;
    DateTime? dateTime;
    if (date != null) {
      rows.add('TARİH : ${date[3]}.${date[2]}.${date[1]}');
    }
    final time = data['time'];
    final timeMatch = time is String
        ? RegExp(r'^(\d{2}):(\d{2})(?::(\d{2}))?$').firstMatch(time)
        : null;
    if (date != null) {
      dateTime = DateTime(
        int.parse(date[1]!),
        int.parse(date[2]!),
        int.parse(date[3]!),
        timeMatch != null ? int.parse(timeMatch[1]!) : 0,
        timeMatch != null ? int.parse(timeMatch[2]!) : 0,
        timeMatch?[3] != null ? int.parse(timeMatch![3]!) : 0,
      );
    }
    // A receipt that prints no time is keyed at midnight; never a dead end.
    rows.add(
      timeMatch != null
          ? 'SAAT : $time'
          : 'SAAT : 00:00',
    );

    final lineTotals = <int>[];
    final lines = <ReceiptLineCandidate>[];
    final productRows = <String>[];
    for (final item in items) {
      if (item is! Map) return null;
      final name = one(item['name'], 80);
      final total = _minor(item['lineTotal'], digits);
      if (name == null || total == null || total <= 0) return null;
      lineTotals.add(total);
      final quantity = item['quantity'];
      final unitPrice = _minor(item['unitPrice'], digits);
      final suffix = _unitSuffix[item['unit']] ?? '';
      DecimalFixed? parsedQty;
      if (quantity is String &&
          RegExp(r'^\d{1,9}(\.\d{1,3})?$').hasMatch(quantity) &&
          quantity != '1') {
        parsedQty = DecimalFixed.parse(quantity);
      }
      final rawRow =
          (parsedQty != null && unitPrice != null)
          ? '$name ${quantity.toString().replaceAll('.', ',')}$suffix '
                'X${_format(unitPrice, digits)} ${_format(total, digits)}'
          : '$name ${_format(total, digits)}';
      productRows.add(rawRow);
      lines.add(
        ReceiptLineCandidate(
          rawText: rawRow,
          name: name,
          normalizedName: normalizeName(name),
          quantity: parsedQty,
          unitCode: _parseUnit(item['unit']),
          unitPriceMinor: unitPrice,
          lineTotalMinor: total,
          confidence: 'high',
        ),
      );
    }
    var discount = 0;
    final discountRows = <String>[];
    final itemDiscounts = List<int>.filled(lines.length, 0);
    final itemDiscountLabels = List<List<String>>.generate(
      lines.length,
      (_) => <String>[],
    );
    final remainingBudget = List<int>.from(lineTotals);
    for (final d in discounts) {
      if (d is! Map) return null;
      final amount = _minor(d['amount'], digits);
      if (amount == null || amount < 0) return null;
      if (amount == 0) continue;
      discount += amount;
      final label = one(d['label'], 80);
      discountRows.add('İNDİRİM -${_format(amount, digits)}');
      final rawIdx = d['itemIndex'];
      var targetIdx =
          rawIdx is int &&
              rawIdx >= 0 &&
              rawIdx < lines.length &&
              remainingBudget[rawIdx] >= amount
          ? rawIdx
          : null;
      targetIdx ??= label == null
          ? null
          : _findDiscountTargetIndex(label, amount, lines, remainingBudget);
      if (targetIdx != null) {
        itemDiscounts[targetIdx] += amount;
        remainingBudget[targetIdx] -= amount;
        if (label != null && !itemDiscountLabels[targetIdx].contains(label)) {
          itemDiscountLabels[targetIdx].add(label);
        }
      }
    }
    final total = _minor(data['total'], digits);
    if (total == null) return null;
    final itemSum = lineTotals.fold<int>(0, (s, v) => s + v);
    if (itemSum != total && itemSum - discount != total) return null;
    final applyDiscount = itemSum != total;
    final attributedLines = [
      for (var i = 0; i < lines.length; i++)
        if (applyDiscount && itemDiscounts[i] > 0)
          ReceiptLineCandidate(
            rawText: lines[i].rawText,
            name: lines[i].name,
            normalizedName: lines[i].normalizedName,
            quantity: lines[i].quantity,
            unitCode: lines[i].unitCode,
            unitPriceMinor: lines[i].unitPriceMinor,
            lineTotalMinor: lines[i].lineTotalMinor,
            discountMinor: itemDiscounts[i],
            discountLabel: itemDiscountLabels[i].isEmpty
                ? null
                : itemDiscountLabels[i].join(', '),
            confidence: lines[i].confidence,
          )
        else
          lines[i],
    ];

    // A receipt without a printed number gets a stable content key so it can
    // still be saved once and recognised if scanned again.
    final number =
        one(
          data['documentNumber'],
          40,
        )?.replaceAll(RegExp(r'[^\p{L}\p{N}/-]', unicode: true), '') ??
        '';
    final ascii = RegExp(r'^[A-Za-z0-9][A-Za-z0-9/-]{0,63}$');
    final documentNumber =
        number.isNotEmpty && ascii.hasMatch(number) && RegExp(r'\d').hasMatch(number)
        ? number.toUpperCase()
        : _contentKey(store, data['date'], time, total, lineTotals);
    rows.add('FİŞ NO : $documentNumber');
    rows
      ..addAll(productRows)
      ..addAll(discountRows);
    final tax = _minor(data['tax'], digits);
    final subtotal = _minor(data['subtotal'], digits);
    if (tax != null) rows.add('KDV ${_format(tax, digits)}');
    rows.add('TOPLAM ${_format(total, digits)} $currency');
    return (
      rows: rows,
      lines: attributedLines,
      store: cleanedStore,
      documentNumber: documentNumber,
      dateTime: dateTime,
      discount: itemSum == total ? 0 : discount,
      tax: tax,
      subtotal: subtotal,
      total: total,
    );
  }

  static const _genericDiscountTokens = {
    'indirim',
    'discount',
    'kampanya',
    'promosyon',
    'promo',
    'coupon',
    'kupon',
    'remise',
    'rabatt',
    'sconto',
    'kart',
    'puan',
  };

  static int? _findDiscountTargetIndex(
    String label,
    int amount,
    List<ReceiptLineCandidate> lines,
    List<int> remainingBudget,
  ) {
    final cleaned = label
        .replaceAll(
          RegExp(r'\d+(?:[.,]\d+)?\s*(?:TL|TRY|KR)?', caseSensitive: false),
          ' ',
        )
        .replaceAll(RegExp(r'[^A-Za-zÇĞİÖŞÜçğıöşü]+'), ' ');
    final tokens = normalizeName(cleaned)
        .split(' ')
        .where((t) => t.length >= 4 && !_genericDiscountTokens.contains(t))
        .toList();
    if (tokens.isEmpty) return null;
    final matchedIndices = <int>[];
    final matchedNames = <String>{};
    for (var i = 0; i < lines.length; i++) {
      if (remainingBudget[i] < amount) continue;
      final norm = lines[i].normalizedName;
      if (tokens.any((token) => norm.contains(token))) {
        matchedIndices.add(i);
        matchedNames.add(norm);
      }
    }
    if (matchedIndices.isEmpty || matchedNames.length != 1) return null;
    return matchedIndices.first;
  }

  static String _contentKey(
    String? store,
    Object? date,
    Object? time,
    int total,
    List<int> lines,
  ) {
    // FNV-1a over the receipt's own content; deterministic across devices.
    var hash = 0x811c9dc5;
    for (final unit in utf8.encode(
      '$store|$date|$time|$total|${lines.join(',')}',
    )) {
      hash ^= unit;
      hash = (hash * 0x01000193) & 0xffffffff;
    }
    return 'AUTO-${hash.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  /// Decimal string with at most [digits] fractional digits → minor units.
  static int? _minor(Object? value, int digits) {
    if (value is! String) return null;
    final match = RegExp(r'^(\d{1,9})(?:\.(\d{1,3}))?$').firstMatch(value);
    if (match == null) return null;
    var fraction = match[2] ?? '';
    while (fraction.length > digits && fraction.endsWith('0')) {
      fraction = fraction.substring(0, fraction.length - 1);
    }
    if (fraction.length > digits) return null;
    return int.parse('${match[1]}${fraction.padRight(digits, '0')}');
  }

  static String _format(int minor, int digits) {
    if (digits == 0) return '$minor';
    final text = minor.toString().padLeft(digits + 1, '0');
    final cut = text.length - digits;
    // Synthetic rows retain an explicit decimal role through document replay.
    // The model's input schema remains canonical ASCII with a dot decimal.
    final separator = digits == 3 ? '\u066b' : ',';
    return '${text.substring(0, cut)}$separator${text.substring(cut)}';
  }
}

/// Outcome of the unified receipt-parsing pipeline where Server Vision AI is
/// primary and on-device ML Kit executes solely as offline/AI-disabled fallback.
sealed class ReceiptParseOutcome {
  const ReceiptParseOutcome();
}

final class ReceiptParsedDocument extends ReceiptParseOutcome {
  const ReceiptParsedDocument(
    this.document, {
    required this.usedAi,
    this.unavailableResult,
  });

  final ReceiptDocument document;
  final bool usedAi;
  final AiResult? unavailableResult;
}

final class ReceiptParseNeedsMoreOrRetake extends ReceiptParseOutcome {
  const ReceiptParseNeedsMoreOrRetake(this.read);
  final AiReceiptRead read;
}

final class ReceiptParseFailed extends ReceiptParseOutcome {
  const ReceiptParseFailed({this.unavailableResult});
  final AiResult? unavailableResult;
}

/// Runs Server Vision AI (`read_receipt_image`) first whenever [ai] is
/// enabled, invoking on-device ML Kit (`MlKitTextSource` or injected
/// [ocrFallback]) whenever AI is disabled, offline, unavailable, or returns an
/// incomplete/unverified result that local OCR can recover.
Future<ReceiptParseOutcome> parseReceiptImages({
  required List<String> photoPaths,
  required String currencyCode,
  AiClient? ai,
  String localeCode = 'en',
  Future<String?> Function(String path) encode = encodeImageForAi,
  OcrTextSource? ocrFallback,
}) async {
  AiResult? unavailableResult;
  AiReceiptRead? aiRejectedRead;
  if (ai != null && ai.enabled) {
    final reader = AiReceiptReader(
      ai,
      localeCode: localeCode,
      encode: encode,
    );
    final aiOutcome = await reader.read(
      photoPaths,
      currencyCode: currencyCode,
    );
    switch (aiOutcome) {
      case AiReceiptVerified(:final document):
        return ReceiptParsedDocument(document, usedAi: true);
      case AiReceiptNeedsMore():
      case AiReceiptRetake():
        aiRejectedRead = aiOutcome;
      case AiReceiptUnavailable(:final result):
        unavailableResult = result;
    }
  }

  // Fallback to on-device OCR when AI is disabled, unavailable, or rejected/partial.
  final doc = await scanReceiptOfflineFallback(
    photoPaths: photoPaths,
    currencyCode: currencyCode,
    ocrFallback: ocrFallback,
  );

  if (doc != null &&
      doc.state == ReceiptDocumentState.complete &&
      doc.toParseResult().withinReconciliationTolerance) {
    return ReceiptParsedDocument(
      doc,
      usedAi: false,
      unavailableResult: unavailableResult,
    );
  }

  // When a multi-page batch call (`images.length > 1`) was rejected or marked
  // partial by the vision model (some providers struggle with multi-image
  // arrays) and on-device OCR did not already produce a reconciled document,
  // try single-page AI reads and combine them sequentially.
  if (ai != null &&
      ai.enabled &&
      unavailableResult == null &&
      photoPaths.length > 1) {
    final reader = AiReceiptReader(
      ai,
      localeCode: localeCode,
      encode: encode,
    );
    ReceiptDocument? aiCombined;
    for (final path in photoPaths) {
      final single = await reader.read([path], currencyCode: currencyCode);
      if (single case AiReceiptVerified(document: final pageDoc)) {
        if (aiCombined == null) {
          aiCombined = pageDoc;
        } else {
          for (final fragment in pageDoc.fragments) {
            aiCombined = aiCombined!.appendSequential(fragment);
          }
        }
      }
    }
    if (aiCombined != null && aiCombined.productLines.isNotEmpty) {
      return ReceiptParsedDocument(aiCombined, usedAi: true);
    }
  }

  if (doc != null &&
      aiRejectedRead == null &&
      (doc.productLines.isNotEmpty || doc.metadata.totalMinor != null)) {
    return ReceiptParsedDocument(
      doc,
      usedAi: false,
      unavailableResult: unavailableResult,
    );
  }
  if (aiRejectedRead != null) {
    return ReceiptParseNeedsMoreOrRetake(aiRejectedRead);
  }
  return ReceiptParseFailed(unavailableResult: unavailableResult);
}

/// Reads [photoPaths] with on-device ML Kit (or an injected [ocrFallback])
/// strictly as an offline/AI-disabled fallback and disposes owned native
/// recognizers cleanly.
Future<ReceiptDocument?> scanReceiptOfflineFallback({
  required List<String> photoPaths,
  required String currencyCode,
  OcrTextSource? ocrFallback,
}) async {
  if (photoPaths.isEmpty) return null;
  final owned = ocrFallback == null ? MlKitTextSource() : null;
  final source = ocrFallback ?? owned!;
  ReceiptDocument? doc;
  try {
    for (final path in photoPaths) {
      final OcrScanResult scan;
      try {
        scan = await source.scan(path);
      } catch (_) {
        continue;
      }
      if (!scan.lines.any((line) => line.text.trim().isNotEmpty)) continue;
      if (doc == null) {
        doc = ReceiptDocument.fromScan(scan, currencyCode: currencyCode);
      } else {
        doc = doc.appendSequential(scan);
      }
    }
  } finally {
    try {
      await owned?.dispose();
    } catch (_) {}
  }
  return doc;
}
