import 'package:flutter/material.dart';

import '../../../app/app_defaults.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/format_locale.dart';
import '../../../core/money/money_parser.dart';

/// Shared amount dialog for spending limits (Spending screen and Settings).
/// Returns null when cancelled, -1 when the limit is removed, otherwise the
/// new positive limit in minor units of [currency].
Future<int?> showLimitEditor(
  BuildContext context, {
  required String title,
  required String help,
  required int? current,
  required String currency,
}) {
  final l10n = AppLocalizations.of(context);
  final digits = Currency.fromCode(currency).minorUnitDigits;
  final sep = MoneySeparators.forLocaleCode(formatLocaleCode(context));
  var text = current == null
      ? ''
      : sep.formatInput(
          DecimalFixed.fromMinorUnits(current, digits).toDbString(),
        );
  final form = GlobalKey<FormState>();
  int parse() {
    final minor = MoneyParser.parseDecimal(
      text,
      separators: sep,
      requirePositive: true,
    ).toMinorUnits(digits);
    if (minor <= 0) {
      throw const FormatException('positive minor amount required');
    }
    return minor;
  }

  return showDialog<int?>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Form(
        key: form,
        child: TextFormField(
          validator: (_) {
            try {
              parse();
              return null;
            } on FormatException {
              return l10n.invalidPriceError;
            }
          },
          key: const Key('limit_field'),
          initialValue: text,
          onChanged: (value) => text = value,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(helperText: help, suffixText: currency),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, -1),
          child: Text(l10n.monthlyLimitRemove),
        ),
        FilledButton(
          key: const Key('limit_save'),
          onPressed: () {
            if (form.currentState!.validate()) Navigator.pop(ctx, parse());
          },
          child: Text(l10n.saveButton),
        ),
      ],
    ),
  );
}

/// Spending limits in the default currency, editable from Settings. Weekly and
/// monthly values set the default and the current period, exactly as the
/// Spending screen does for the current week and month.
class SpendingLimitTiles extends StatefulWidget {
  const SpendingLimitTiles({super.key, required this.formatMoney, this.now});

  final String Function(int minor, String currency) formatMoney;

  /// Fixed "today" for tests.
  final DateTime? now;

  @override
  State<SpendingLimitTiles> createState() => _SpendingLimitTilesState();
}

enum _Kind { week, month, shopping }

class _SpendingLimitTilesState extends State<SpendingLimitTiles> {
  DateTime get _now => widget.now ?? DateTime.now();
  String get _currency => AppDefaults.defaultCurrency();

  int? _value(_Kind kind) => switch (kind) {
    _Kind.week => AppDefaults.weeklyLimitMinor(
      currencyCode: _currency,
      week: _now,
    ),
    _Kind.month => AppDefaults.monthlyLimitMinor(
      currencyCode: _currency,
      month: DateTime(_now.year, _now.month),
    ),
    _Kind.shopping => AppDefaults.shoppingLimitMinor(currencyCode: _currency),
  };

  Future<void> _edit(_Kind kind, String title, String help) async {
    final currency = _currency;
    final result = await showLimitEditor(
      context,
      title: title,
      help: help,
      current: _value(kind),
      currency: currency,
    );
    if (result == null || !mounted) return;
    final value = result < 0 ? null : result;
    switch (kind) {
      case _Kind.week:
        AppDefaults.setWeeklyLimitMinor(value, currencyCode: currency);
        AppDefaults.setWeeklyLimitMinor(
          value,
          currencyCode: currency,
          week: _now,
        );
      case _Kind.month:
        AppDefaults.setMonthlyLimitMinor(value, currencyCode: currency);
        AppDefaults.setMonthlyLimitMinor(
          value,
          currencyCode: currency,
          month: DateTime(_now.year, _now.month),
        );
      case _Kind.shopping:
        AppDefaults.setShoppingLimitMinor(value, currencyCode: currency);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget tile(_Kind kind, IconData icon, String title, String help) {
      final value = _value(kind);
      return ListTile(
        key: Key('settings_limit_${kind.name}'),
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(
          value == null ? help : widget.formatMoney(value, _currency),
        ),
        trailing: const Icon(Icons.edit_outlined),
        onTap: () => _edit(kind, title, help),
      );
    }

    return Column(
      children: [
        tile(
          _Kind.week,
          Icons.date_range_outlined,
          l10n.weeklyLimitTitle,
          l10n.weeklyLimitHelp,
        ),
        tile(
          _Kind.month,
          Icons.calendar_month_outlined,
          l10n.monthlyLimitTitle,
          l10n.monthlyLimitHelp,
        ),
        tile(
          _Kind.shopping,
          Icons.shopping_cart_outlined,
          l10n.shoppingLimitTitle,
          l10n.shoppingLimitHelp,
        ),
      ],
    );
  }
}
