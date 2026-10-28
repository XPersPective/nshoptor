import '../../core/money/currency.dart';
import '../ai/ai_client.dart';
import 'ocr_currency.dart';
import 'ocr_text_source.dart';
import 'parser/receipt_parser.dart';

/// Protocol `receipt.v1` between the app, the AI proxy and this reader.
///
/// The model only ever sees OCR text. Its JSON is validated by the server
/// (schema, amounts printed on the receipt, arithmetic) and again here
/// (currency, exact reconciliation). A verified answer is rendered back into
/// canonical receipt rows, which the deterministic parser/document pipeline
/// consumes exactly like OCR text. A receipt that cannot be verified is never
/// altered: the caller keeps the raw OCR scan.
class AiReceiptReader {
  AiReceiptReader(this.ai, {this.localeCode = 'tr'});

  final AiClient ai;
  final String localeCode;

  /// Why the last [normalize] returned null; null after a success or when AI
  /// was not attempted.
  AiResult? lastResult;

  static const maxChars = 4500;
  static const maxRows = 220;

  static const _unitSuffix = {
    'kilogram': 'KG',
    'gram': 'G',
    'litre': 'LT',
    'millilitre': 'ML',
    'piece': 'ADET',
  };

  /// Returns canonical rows for a verified receipt, otherwise null.
  Future<OcrScanResult?> normalize(
    OcrScanResult scan, {
    required String currencyCode,
  }) async {
    lastResult = null;
    if (!ai.enabled) return null;
    final rows = ReceiptParser(currency: currencyCode)
        .readingRows(scan)
        .map((r) => r.text.trim())
        .where((t) => t.isNotEmpty);
    final text = rows.join('\n');
    if (text.isEmpty || text.length > maxChars || rows.length > maxRows) {
      return null;
    }
    final evidence = detectOcrCurrency(text, fallback: currencyCode);
    if (evidence.conflictsWith(currencyCode)) return null;
    final AiResult response;
    try {
      response = await ai.request('read_receipt', {
        'text': text,
        'currency': currencyCode,
      }, locale: localeCode);
    } catch (_) {
      lastResult = const AiFailed('request');
      return null;
    }
    lastResult = response;
    if (response is! AiOk) return null;
    final canonical = _canonicalRows(response.result, currencyCode);
    if (canonical == null) {
      lastResult = const AiFailed('unverified');
      return null;
    }
    return OcrScanResult(lines: [for (final r in canonical) OcrLine(text: r)]);
  }

  List<String>? _canonicalRows(Map<String, dynamic> data, String currency) {
    if (data['schema'] != 1 || data['reconciles'] != true) return null;
    final code = data['currency'];
    if (code is String && code != currency) return null;
    final int digits;
    try {
      digits = Currency.fromCode(currency).minorUnitDigits;
    } catch (_) {
      return null;
    }
    final items = data['items'];
    final discounts = data['discounts'];
    if (items is! List || items.isEmpty || discounts is! List) return null;

    final rows = <String>[];
    String? one(Object? v, int max) {
      if (v is! String) return null;
      final t = v.replaceAll(RegExp(r'\s+'), ' ').trim();
      return t.isEmpty || t.length > max ? null : t;
    }

    final store = one(data['store'], 80);
    if (store != null) rows.add(store);
    final date = data['date'];
    final parsedDate = date is String
        ? RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(date)
        : null;
    if (parsedDate != null) {
      rows.add('TARİH : ${parsedDate[3]}.${parsedDate[2]}.${parsedDate[1]}');
    }
    final time = data['time'];
    if (time is String && RegExp(r'^\d{2}:\d{2}(?::\d{2})?$').hasMatch(time)) {
      rows.add('SAAT : $time');
    }
    final documentNumber = one(data['documentNumber'], 40);
    if (documentNumber != null) rows.add('FİŞ NO : $documentNumber');

    var itemSum = 0;
    for (final item in items) {
      if (item is! Map) return null;
      final name = one(item['name'], 80);
      final total = _minor(item['lineTotal'], digits);
      if (name == null || total == null) return null;
      itemSum += total;
      final quantity = item['quantity'];
      final unitPrice = _minor(item['unitPrice'], digits);
      final suffix = _unitSuffix[item['unit']] ?? '';
      if (quantity is String &&
          RegExp(r'^\d{1,9}(\.\d{1,3})?$').hasMatch(quantity) &&
          quantity != '1' &&
          unitPrice != null) {
        rows.add(
          '$name ${quantity.replaceAll('.', ',')}$suffix '
          'X${_format(unitPrice, digits)} ${_format(total, digits)}',
        );
      } else {
        rows.add('$name ${_format(total, digits)}');
      }
    }

    var discountSum = 0;
    for (final discount in discounts) {
      if (discount is! Map) return null;
      final amount = _minor(discount['amount'], digits);
      if (amount == null) return null;
      discountSum += amount;
      final label = one(discount['label'], 80) ?? '';
      rows.add(
        'İNDİRİM $label -${_format(amount, digits)}'.replaceAll('  ', ' '),
      );
    }

    final subtotal = _minor(data['subtotal'], digits);
    if (subtotal != null) rows.add('ARA TOPLAM ${_format(subtotal, digits)}');
    final tax = _minor(data['tax'], digits);
    if (tax != null) rows.add('KDV ${_format(tax, digits)}');
    final total = _minor(data['total'], digits);
    if (total == null) return null;
    // The server already flagged `reconciles`; never trust it alone.
    if (itemSum != total && itemSum - discountSum != total) return null;
    rows.add('TOPLAM ${_format(total, digits)}');
    return rows;
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
    fraction = fraction.padRight(digits, '0');
    return int.parse('${match[1]}$fraction');
  }

  static String _format(int minor, int digits) {
    if (digits == 0) return '$minor';
    final text = minor.toString().padLeft(digits + 1, '0');
    final cut = text.length - digits;
    return '${text.substring(0, cut)},${text.substring(cut)}';
  }
}
