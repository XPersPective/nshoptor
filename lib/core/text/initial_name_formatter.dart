import 'package:flutter/services.dart';

import 'list_title.dart';

/// Applies the default only to the first committed, nonempty product name.
/// Later edits, including an intentional lowercase initial, remain verbatim.
class InitialNameFormatter extends TextInputFormatter {
  InitialNameFormatter({this.localeCode = 'tr', bool alreadyEntered = false})
    : _entered = alreadyEntered;

  final String localeCode;
  bool _entered;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_entered ||
        newValue.text.trim().isEmpty ||
        newValue.composing.isValid && !newValue.composing.isCollapsed) {
      return newValue;
    }
    _entered = true;
    return ListTitleFormatter(localeCode: localeCode)
        .formatEditUpdate(oldValue, newValue);
  }
}
