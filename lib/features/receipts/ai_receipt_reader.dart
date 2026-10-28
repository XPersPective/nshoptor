import 'dart:convert';

import '../../core/money/currency.dart';
import '../ai/ai_client.dart';
import 'ai_image.dart';
import 'ocr_text_source.dart';
import 'receipt_document.dart';

/// Where a receipt reading stands after one AI request.
sealed class AiReceiptRead {
  const AiReceiptRead();
}

/// Verified by the server and again here; ready for user review.
final class AiReceiptVerified extends AiReceiptRead {
  const AiReceiptVerified(this.document);
  final ReceiptDocument document;
}

enum AiReceiptGap { top, bottom, middle }

/// The model saw only part of the receipt: guide the user to the missing part.
final class AiReceiptNeedsMore extends AiReceiptRead {
  const AiReceiptNeedsMore(this.gap);
  final AiReceiptGap gap;
}

/// Not a receipt, unreadable, or rejected twice by validation: retake.
final class AiReceiptRetake extends AiReceiptRead {
  const AiReceiptRetake(this.reason);
  final String reason;
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

  static const maxPhotos = 4;

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
        timeout: const Duration(seconds: 150),
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
    switch (data['status']) {
      case 'complete':
        break;
      case 'top_missing':
        return const AiReceiptNeedsMore(AiReceiptGap.top);
      case 'bottom_missing':
        return const AiReceiptNeedsMore(AiReceiptGap.bottom);
      case 'middle_gap':
        return const AiReceiptNeedsMore(AiReceiptGap.middle);
      default:
        return AiReceiptRetake('${data['status']}');
    }
    final code = data['currency'] is String
        ? data['currency'] as String
        : currencyCode;
    if (!Currency.isKnownCode(code)) return const AiReceiptRetake('currency');
    final digits = Currency.fromCode(code).minorUnitDigits;
    final built = _canonical(data, code, digits);
    if (built == null) return const AiReceiptRetake('mismatch');
    final document = ReceiptDocument.fromScan(
      OcrScanResult(lines: [for (final row in built.rows) OcrLine(text: row)]),
      currencyCode: code,
    );
    // A complete reading without a readable store/date cannot be identified.
    if (document.metadata.store == null || document.metadata.dateTime == null) {
      return const AiReceiptNeedsMore(AiReceiptGap.top);
    }
    final parsed = document.toParseResult();
    final same =
        document.state == ReceiptDocumentState.complete &&
        parsed.withinReconciliationTolerance &&
        parsed.totalMinor == built.total &&
        (parsed.discountMinor ?? 0) == built.discount &&
        parsed.lines.length == built.lineTotals.length &&
        [
          for (var i = 0; i < built.lineTotals.length; i++)
            parsed.lines[i].lineTotalMinor == built.lineTotals[i],
        ].every((ok) => ok);
    return same
        ? AiReceiptVerified(document)
        : const AiReceiptRetake('mismatch');
  }

  static ({List<String> rows, List<int> lineTotals, int discount, int total})?
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
    if (store != null) rows.add('STORE : $store');
    final date = data['date'] is String
        ? RegExp(r'^(\d{4})-(\d{2})-(\d{2})$')
              .firstMatch(data['date'] as String)
        : null;
    if (date != null) rows.add('TARİH : ${date[3]}.${date[2]}.${date[1]}');
    final time = data['time'];
    // A receipt that prints no time is keyed at midnight; never a dead end.
    rows.add(
      time is String && RegExp(r'^\d{2}:\d{2}(?::\d{2})?$').hasMatch(time)
          ? 'SAAT : $time'
          : 'SAAT : 00:00',
    );

    final lineTotals = <int>[];
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
      if (quantity is String &&
          RegExp(r'^\d{1,9}(\.\d{1,3})?$').hasMatch(quantity) &&
          quantity != '1' &&
          unitPrice != null) {
        productRows.add(
          '$name ${quantity.replaceAll('.', ',')}$suffix '
          'X${_format(unitPrice, digits)} ${_format(total, digits)}',
        );
      } else {
        productRows.add('$name ${_format(total, digits)}');
      }
    }
    var discount = 0;
    final discountRows = <String>[];
    for (final d in discounts) {
      if (d is! Map) return null;
      final amount = _minor(d['amount'], digits);
      if (amount == null || amount <= 0) return null;
      discount += amount;
      discountRows.add('İNDİRİM -${_format(amount, digits)}');
    }
    final total = _minor(data['total'], digits);
    if (total == null) return null;
    final itemSum = lineTotals.fold<int>(0, (s, v) => s + v);
    if (itemSum != total && itemSum - discount != total) return null;

    // A receipt without a printed number gets a stable content key so it can
    // still be saved once and recognised if scanned again.
    final number =
        one(
          data['documentNumber'],
          40,
        )?.replaceAll(RegExp(r'[^\p{L}\p{N}/-]', unicode: true), '') ??
        '';
    final ascii = RegExp(r'^[A-Za-z0-9][A-Za-z0-9/-]{0,63}$');
    rows.add(
      'FİŞ NO : ${number.isNotEmpty && ascii.hasMatch(number) && RegExp(r'\d').hasMatch(number) ? number : _contentKey(store, data['date'], time, total, lineTotals)}',
    );
    rows
      ..addAll(productRows)
      ..addAll(discountRows);
    final tax = _minor(data['tax'], digits);
    if (tax != null) rows.add('KDV ${_format(tax, digits)}');
    rows.add('TOPLAM ${_format(total, digits)} $currency');
    return (
      rows: rows,
      lineTotals: lineTotals,
      discount: itemSum == total ? 0 : discount,
      total: total,
    );
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
    return '${text.substring(0, cut)},${text.substring(cut)}';
  }
}
