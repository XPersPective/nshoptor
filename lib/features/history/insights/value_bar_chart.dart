import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/decimal_fixed.dart';

/// Horizontal bars whose exact value is always printed beside the label, so
/// amounts are readable without tooltips at 320dp and 2x text (F31).
class ValueBarChartCard extends StatelessWidget {
  const ValueBarChartCard({
    super.key,
    required this.title,
    required this.bars,
    required this.valueText,
    this.limitMinor,
    this.valueLabels,
  });
  final String title;
  final List<(String, DecimalFixed)> bars;
  final String Function(DecimalFixed) valueText;
  final int? limitMinor;

  /// Exact display per bar (e.g. "25,00 ₺ + —"); falls back to [valueText].
  final List<String>? valueLabels;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    String display(int index, DecimalFixed value) =>
        valueLabels?[index] ?? valueText(value);
    final maxV = bars.fold<DecimalFixed>(
      DecimalFixed.zero(),
      (m, b) => b.$2.abs() > m ? b.$2.abs() : m,
    );
    // ponytail: nonzero bars have a 2% visual floor; exact labels remain authoritative.
    // Keep every amount in the text flow at all screen widths.
    double fraction(DecimalFixed v) => v.isZero || maxV.isZero
        ? 0
        : (v.abs().divide(maxV, scale: 6).toMinorUnits(6) / 1000000).clamp(
            0.02,
            1,
          );
    Color color(DecimalFixed v) =>
        v.isNegative ||
            limitMinor != null && v > DecimalFixed.fromInt(limitMinor!)
        ? scheme.error
        : scheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 12),
            if (bars.isEmpty)
              Text(AppLocalizations.of(context).noPurchasesNote)
            else ...[
              for (final (index, (label, value)) in bars.indexed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Semantics(
                    label: '$label: ${display(index, value)}',
                    excludeSemantics: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('$label: ${display(index, value)}'),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: fraction(value),
                          minHeight: 8,
                          color: color(value),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
