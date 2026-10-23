import 'package:flutter/services.dart';

/// Uppercase only the first non-whitespace character, including Turkish i/ı.
/// Preserve the rest of the title and its leading whitespace while editing.
String capitalizeListTitle(String value, {String localeCode = 'tr'}) {
  final first = value.indexOf(RegExp(r'\S'));
  if (first < 0) return value;
  final rune = value.substring(first).runes.first;
  final character = String.fromCharCode(rune);
  final upper = switch (character) {
    'i' when localeCode.startsWith('tr') || localeCode.startsWith('az') => 'İ',
    'ı' => 'I',
    _ => character.toUpperCase(),
  };
  return value.replaceRange(first, first + character.length, upper);
}

String? normalizedListTitle(String? value, {String localeCode = 'tr'}) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty
      ? null
      : capitalizeListTitle(trimmed, localeCode: localeCode);
}

class ListTitleFormatter extends TextInputFormatter {
  const ListTitleFormatter({this.localeCode = 'tr'});
  final String localeCode;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Wait for the keyboard to commit an in-progress composition.
    if (newValue.composing.isValid && !newValue.composing.isCollapsed) {
      return newValue;
    }
    final text = capitalizeListTitle(newValue.text, localeCode: localeCode);
    if (text == newValue.text) return newValue;
    final start = newValue.text.indexOf(RegExp(r'\S'));
    final oldLength = String.fromCharCode(
      newValue.text.substring(start).runes.first,
    ).length;
    final delta = text.length - newValue.text.length;
    int offset(int value) => value < 0 || value <= start
        ? value
        : value < start + oldLength
        ? start + oldLength + delta
        : value + delta;
    return newValue.copyWith(
      text: text,
      selection: newValue.selection.copyWith(
        baseOffset: offset(newValue.selection.baseOffset),
        extentOffset: offset(newValue.selection.extentOffset),
      ),
      composing: TextRange.empty,
    );
  }
}
