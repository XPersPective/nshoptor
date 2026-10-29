import '../../core/money/number_glyphs.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/money/money_parser.dart';

/// Temporary numeric view for OCR extraction. Original evidence and product
/// names retain their glyphs; offsets also support supplementary-plane digits.
class OcrNumberView {
  OcrNumberView(this.original) {
    final out = StringBuffer();
    var offset = 0;
    for (final rune in original.runes) {
      final raw = String.fromCharCode(rune);
      // Keep the explicit Arabic decimal role until the amount boundary.
      final shaped = normalizeNumberGlyphs(raw).replaceAll('\u066c', ',');
      for (var i = 0; i < shaped.length; i++) {
        _offsets.add(offset + (shaped == raw ? i : 0));
      }
      out.write(shaped);
      offset += raw.length;
    }
    _offsets.add(original.length);
    final shapedText = out.toString();
    final glyphs = normalizeNumberGlyphs(original);
    final remove = <int>{};
    var acceptable = !RegExp(r'[0-9][\u200e\u200f\u061c]+[0-9]')
        .hasMatch(glyphs);
    for (final match in RegExp(
      r'[0-9][0-9.,\u066b\u066c\u00a0\u202f\u2009]*',
    ).allMatches(glyphs)) {
      final token = match.group(0)!.trimRight();
      final arabic = token.contains('\u066c');
      final spaces = RegExp(r'[\u00a0\u202f\u2009]').hasMatch(token);
      if (!arabic && !spaces) continue;
      final group = arabic ? r'\u066c' : r'[\u00a0\u202f\u2009]';
      final fraction = arabic ? r'[.\u066b]' : r'[.,\u066b]';
      final western = RegExp('^\\d{1,3}(?:$group\\d{3})+(?:$fraction\\d+)?\$');
      final indian = RegExp(
        '^\\d{1,2}(?:$group\\d{2})*$group\\d{3}(?:$fraction\\d+)?\$',
      );
      if (arabic && spaces ||
          !western.hasMatch(token) && !indian.hasMatch(token)) {
        acceptable = false;
        continue;
      }
      for (var i = 0; i < token.length; i++) {
        if (token.codeUnitAt(i) == 0x066c ||
            RegExp(r'[\u00a0\u202f\u2009]').hasMatch(token[i])) {
          remove.add(match.start + i);
        }
      }
    }
    final compact = StringBuffer();
    final offsets = <int>[];
    for (var i = 0; i < shapedText.length; i++) {
      if (remove.contains(i)) continue;
      compact.write(shapedText[i]);
      offsets.add(_offsets[i]);
    }
    _offsets
      ..clear()
      ..addAll(offsets)
      ..add(original.length);
    text = compact.toString();
    valid = acceptable;
  }

  final String original;
  final _offsets = <int>[];
  late final String text;
  late final bool valid;

  String originalSlice(int start, [int? end]) =>
      original.substring(_offsets[start], _offsets[end ?? text.length]);
}

/// Zero-minor-unit totals may use homogeneous three-digit grouping or an
/// explicit .00/,00. Never round a fractional amount or guess mixed grouping.
int? wholeOcrAmount(String raw) {
  raw = raw.replaceAll('\u066b', '.');
  if (RegExp(
    r'^(?:\d{1,3}(?:,\d{3})+|\d{1,3}(?:\.\d{3})+|\d{1,2}(?:,\d{2})+,\d{3}|\d{1,2}(?:\.\d{2})+\.\d{3})$',
  ).hasMatch(raw)) {
    return DecimalFixed.tryParse(raw.replaceAll(RegExp(r'[.,]'), ''))
        ?.toMinorUnits(0);
  }
  if (RegExp(r'^\d+$').hasMatch(raw)) {
    return DecimalFixed.tryParse(raw)?.toMinorUnits(0);
  }
  if (!RegExp(r'^\d[\d.,]*[.,]00$').hasMatch(raw)) return null;
  try {
    return MoneyParser.parseDecimal(
      raw,
      separators: ocrAmountSeparators(raw, minorDigits: 0),
    ).toMinorUnits(0);
  } on FormatException {
    return null;
  }
}

/// An observed decimal separator fixes the other grouping separator. Support
/// both CLDR Western and Indian grouping, without guessing malformed groups.
MoneySeparators ocrAmountSeparators(String raw, {int? minorDigits}) {
  if (ambiguousOcrAmount(raw, minorDigits)) {
    throw const FormatException('Ambiguous three-minor-unit OCR amount');
  }
  if (raw.contains('\u066b')) return const MoneySeparators('\u066b', ',');
  final wholeGrouping = RegExp(
    r'^(?:\d{1,3}(?:,\d{3})+|\d{1,3}(?:\.\d{3})+|\d{1,2}(?:,\d{2})+,\d{3}|\d{1,2}(?:\.\d{2})+\.\d{3})$',
  );
  if (wholeGrouping.hasMatch(raw) &&
      (minorDigits != 3 || RegExp(r'[.,]').allMatches(raw).length > 1)) {
    final group = raw.contains(',') ? ',' : '.';
    final pattern = RegExp.escape(group);
    final indian = RegExp('^\\d{1,2}(?:$pattern\\d{2})+$pattern\\d{3}\$')
        .hasMatch(raw);
    return MoneySeparators(
      group == ',' ? '.' : ',',
      group,
      secondaryGroupSize: indian ? 2 : 3,
    );
  }
  final decimal = raw.lastIndexOf(',') > raw.lastIndexOf('.') ? ',' : '.';
  final thousands = decimal == ',' ? '.' : ',';
  final integer = raw.split(decimal).first;
  final group = RegExp.escape(thousands);
  final indian = RegExp('^\\d{1,2}(?:$group\\d{2})+$group\\d{3}\$')
      .hasMatch(integer);
  return MoneySeparators(
    decimal,
    thousands,
    secondaryGroupSize: indian ? 2 : 3,
  );
}

/// A single ASCII separator can be either grouping or a three-place fraction.
/// Currency precision alone cannot establish the receipt's printed convention.
bool ambiguousOcrAmount(String raw, int? minorDigits) =>
    minorDigits == 3 && RegExp(r'^\d{1,3}[.,]\d{3}$').hasMatch(raw);
