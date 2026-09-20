import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/money.dart';
import '../../../core/theme/semantic_colors.dart';
import 'result_repository.dart';

/// Alışveriş bitiş/sonuç ekranı (spec §6.11).
///
/// [items] boş değilse tamamlama öncesi uyarı gösterilir: engellemez,
/// açıklayıcıdır (spec: tamamlamayı engellemek yerine uyar).
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({
    super.key,
    required this.repository,
    required this.listId,
    this.unverifiedCount = 0,
    this.unpurchasedCount = 0,
  });

  final ResultRepository repository;
  final int listId;
  final int unverifiedCount;
  final int unpurchasedCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.resultTitle)),
      body: FutureBuilder<ListResult>(
        future: repository.compute(listId),
        builder: (context, snapshot) {
          final result = snapshot.data;
          if (result == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              if (unverifiedCount > 0 || unpurchasedCount > 0)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline),
                        const SizedBox(width: 8),
                        Expanded(child: Text(l10n.completionWarning)),
                      ],
                    ),
                  ),
                ),
              _SummarySection(result: result),
              const SizedBox(height: 12),
              Text(l10n.groupsSection,
                  style: Theme.of(context).textTheme.titleMedium),
              for (final row in result.rows)
                _ItemResultTile(result: result, row: row),
            ],
          );
        },
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({required this.result});

  final ListResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(result.currencyCode);
    String money(int minor) => formatMoney(Money.fromMinorUnits(minor, currency),
        locale: Localizations.localeOf(context).languageCode);
    final direction = result.varianceMinor == 0
        ? SpendingDirection.nearPlan
        : result.varianceMinor < 0
            ? SpendingDirection.underPlan
            : SpendingDirection.overPlan;
    final delta = SemanticDelta.resolve(
        direction: direction, brightness: Theme.of(context).brightness);
    final varianceText = result.variancePercent == null
        ? l10n.varianceNotComputable
        : '${delta.marker} ${money(result.varianceMinor.abs())}'
            ' (${_formatPercent(result.variancePercent!)}%)';
    final accuracyText = result.accuracy == null
        ? l10n.varianceNotComputable
        : '%${result.accuracy!.toDbString()}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.summarySection,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _Row(label: l10n.plannedTotalLabel, value: money(result.plannedTotalMinor)),
            _Row(label: l10n.actualTotalLabel, value: money(result.actualTotalMinor)),
            _Row(
              label: l10n.varianceLabel,
              value: varianceText,
              valueColor: result.varianceMinor == 0 ? null : delta.color,
              icon: Icon(delta.icon,
                  size: 18, color: delta.color,
                  semanticLabel: delta.marker),
            ),
            if (result.unplannedTotalMinor > 0)
              _Row(label: l10n.unplannedTotalLabel,
                  value: money(result.unplannedTotalMinor)),
            if (result.unpurchasedPlannedMinor > 0)
              _Row(label: l10n.unpurchasedLabel,
                  value: money(result.unpurchasedPlannedMinor)),
            if (result.totalDiscountMinor > 0)
              _Row(label: l10n.totalDiscountLabel,
                  value: money(result.totalDiscountMinor)),
            _Row(label: l10n.accuracyLabel, value: accuracyText),
          ],
        ),
      ),
    );
  }

  String _formatPercent(DecimalFixed percent) {
    final s = percent.toDbString();
    return s.endsWith('000000') ? s.substring(0, s.length - 7) : s;
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.valueColor, this.icon});

  final String label;
  final String value;
  final Color? valueColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          ?icon,
          Text(value,
              style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w600,
                  fontFeatures: const [])),
        ],
      ),
    );
  }
}

class _ItemResultTile extends StatelessWidget {
  const _ItemResultTile({required this.result, required this.row});

  final ListResult result;
  final ItemResultRow row;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(result.currencyCode);
    String money(int minor) => formatMoney(Money.fromMinorUnits(minor, currency),
        locale: Localizations.localeOf(context).languageCode);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(row.name,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              children: [
                for (final g in row.groups)
                  Chip(label: Text(_groupLabel(l10n, g), style: const TextStyle(fontSize: 11))),
              ],
            ),
            if (!row.isUnplanned) ...[
              _Row(label: l10n.plannedQtyLabel,
                  value: row.plannedQuantity?.toDbString() ?? '-'),
              _Row(label: l10n.actualQtyLabel,
                  value: row.notTaken ? l10n.notBoughtMark : row.actualQuantity?.toDbString() ?? '-'),
            ],
            if (row.plannedUnitPrice != null)
              _Row(label: l10n.plannedUnitPriceLabel,
                  value: money(_toMinor(row.plannedUnitPrice!, currency))),
            if (row.actualUnitPrice != null)
              _Row(label: l10n.actualUnitPriceLabel,
                  value: money(_toMinor(row.actualUnitPrice!, currency))),
            if (row.discountMinor > 0)
              _Row(label: l10n.discountEffectLabel, value: money(row.discountMinor)),
            _Row(label: l10n.lineVarianceLabel, value: money(row.lineVarianceMinor)),
          ],
        ),
      ),
    );
  }

  int _toMinor(DecimalFixed value, Currency currency) =>
      value.toMinorUnits(currency.minorUnitDigits);

  String _groupLabel(AppLocalizations l10n, ItemResultGroup g) => switch (g) {
        ItemResultGroup.pricier => l10n.groupPricier,
        ItemResultGroup.cheaper => l10n.groupCheaper,
        ItemResultGroup.close => l10n.groupClose,
        ItemResultGroup.notTaken => l10n.groupNotTaken,
        ItemResultGroup.unplanned => l10n.groupUnplanned,
        ItemResultGroup.quantityChanged => l10n.groupQuantityChanged,
        ItemResultGroup.unverified => l10n.groupUnverified,
      };
}
