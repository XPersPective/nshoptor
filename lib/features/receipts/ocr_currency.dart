import '../../core/money/currency.dart';

/// Explicit OCR evidence. Ambiguous symbols are accepted only when the list
/// already uses that symbol; foreign and mixed currencies require review.
class OcrCurrencyEvidence {
  const OcrCurrencyEvidence(this.codes, {this.unresolvedSymbol = false});
  final Set<String> codes;
  final bool unresolvedSymbol;
  String? get code => codes.length == 1 && !unresolvedSymbol ? codes.single : null;
  bool get needsConfirmation => codes.length > 1 || unresolvedSymbol;
  bool conflictsWith(String expected) => needsConfirmation || codes.any((c) => c != expected);
}

OcrCurrencyEvidence detectOcrCurrency(String text, {required String fallback}) {
  final codes = <String>{};
  for (final currency in Currency.all) {
    final code = currency.code;
    if (RegExp('(?<![A-Z])$code(?![A-Z])').hasMatch(text) &&
        (RegExp('(?:[0-9]\\s*$code|$code\\s*[: ]?\\s*[0-9])').hasMatch(text) ||
         text.split('\n').any((line) => line.trim() == code))) {
      codes.add(code);
    }
  }
  if (RegExp(r'(?<![A-Za-z])(?:TL|TRY|lira)(?![A-Za-z])', caseSensitive: false).hasMatch(text) || text.contains('₺')) codes.add('TRY');
  if (text.contains('€')) codes.add('EUR');
  if (text.contains('£') && !text.contains('E£')) codes.add('GBP');
  var unresolved = false;
  for (final symbol in const [r'$', '¥', 'kr']) {
    if (symbol == 'kr' ? !RegExp(r'(?<![A-Za-z])kr(?![A-Za-z])', caseSensitive: false).hasMatch(text) : !text.contains(symbol)) continue;
    final possible = Currency.all.where((c) => c.symbol == symbol).map((c) => c.code).toSet();
    if (codes.any(possible.contains)) continue;
    if (possible.contains(fallback)) {
      codes.add(fallback);
    } else {
      unresolved = true;
    }
  }
  return OcrCurrencyEvidence(codes, unresolvedSymbol: unresolved);
}
