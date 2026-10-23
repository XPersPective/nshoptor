import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';

/// Both meanings stay visible. A tap selects immediately, including when a
/// voice/OCR price needs explicit confirmation and neither meaning is selected.
class PriceModeSelector extends StatelessWidget {
  const PriceModeSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.unitLabel,
    this.semanticLabel,
    this.keyPrefix = 'price_mode',
    this.validator,
  });

  final bool? value;
  final ValueChanged<bool>? onChanged;
  final String? unitLabel;
  final String? semanticLabel;
  final String keyPrefix;
  final FormFieldValidator<bool>? validator;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FormField<bool>(
      key: ValueKey(value),
      initialValue: value,
      validator: validator,
      enabled: onChanged != null,
      builder: (field) => Semantics(
        container: true,
        label: semanticLabel ?? l10n.pricingModeLabel,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<bool>(
              expandedInsets: EdgeInsets.zero,
              emptySelectionAllowed: true,
              showSelectedIcon: false,
              style: const ButtonStyle(
                minimumSize: WidgetStatePropertyAll(Size(0, 48)),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                ),
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
              segments: [
                ButtonSegment(
                  value: false,
                  label: Text(
                    l10n.pricingModeLineTotal,
                    key: Key('${keyPrefix}_total'),
                    textAlign: TextAlign.center,
                  ),
                ),
                ButtonSegment(
                  value: true,
                  label: Text(
                    '${l10n.pricingModeUnitPrice}${unitLabel == null ? '' : ' / $unitLabel'}',
                    key: Key('${keyPrefix}_unit'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              selected: field.value == null ? const {} : {field.value!},
              onSelectionChanged: onChanged == null
                  ? null
                  : (values) {
                      if (values.isEmpty) return;
                      field.didChange(values.single);
                      onChanged!(values.single);
                    },
            ),
            if (field.errorText != null)
              Text(
                field.errorText!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
      ),
    );
  }
}
