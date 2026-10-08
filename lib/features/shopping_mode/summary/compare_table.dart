import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/format_locale.dart';
import '../../../core/money/money.dart';
import '../../../core/money/money_format.dart';
import '../../../core/theme/semantic_colors.dart';
import 'result_repository.dart';

/// Tek bakışta plan ↔ gerçek (PB-053): "elma 20 → 30, +10". Satır başına
/// ürün | tahmini | gerçek | fark; altta toplam ve (varsa) bütçe satırı.
/// Ayrıntı için dokunmak gerekmez.
class CompareTable extends StatelessWidget {
  const CompareTable({super.key, required this.result});

  final ListResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currency = Currency.fromCode(result.currencyCode);
    final locale = formatLocaleCode(context);
    String money(int minor) =>
        formatMoney(Money.fromMinorUnits(minor, currency), locale: locale);
    final muted = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    Widget diffCell(int diff, {Key? key}) {
      if (diff == 0) return Text('0', key: key, textAlign: TextAlign.end, style: muted);
      final delta = SemanticDelta.resolve(
        direction: diff > 0 ? SpendingDirection.overPlan : SpendingDirection.underPlan,
        brightness: theme.brightness,
      );
      return Row(
        key: key,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(delta.icon, size: 14, color: delta.color, semanticLabel: delta.marker),
          Text(
            '${diff > 0 ? '+' : '−'}${money(diff.abs())}',
            style: TextStyle(color: delta.color, fontWeight: FontWeight.w600),
          ),
        ],
      );
    }

    TableRow row(List<Widget> cells, {Decoration? decoration}) => TableRow(
          decoration: decoration,
          children: [
            for (final (i, c) in cells.indexed)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                // Tutarlar kaymasın: dar ekranda satır kırmak yerine küçülür.
                child: i == 0
                    ? c
                    : FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerEnd,
                        child: c,
                      ),
              ),
          ],
        );

    final header = theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    final bold = theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700);
    final budget = result.budgetMinor;

    return Card(
      key: const Key('compare_table'),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2.2),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.6),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            row([
              Text(l10n.compareItem, style: header),
              Text(l10n.compareEstimated, style: header, textAlign: TextAlign.end),
              Text(l10n.compareActual, style: header, textAlign: TextAlign.end),
              Text(l10n.compareDiff, style: header, textAlign: TextAlign.end),
            ]),
            for (final (i, r) in result.rows.indexed)
              row(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.name, key: Key('compare_name_$i'), maxLines: 2, overflow: TextOverflow.ellipsis),
                      if (r.notTaken) Text(l10n.compareNotBought, style: muted),
                      if (r.isUnplanned) Text(l10n.compareUnplanned, style: muted),
                    ],
                  ),
                  Text(r.isUnplanned ? '—' : money(r.plannedLineTotalMinor), textAlign: TextAlign.end),
                  Text(r.notTaken ? '—' : money(r.actualLineTotalMinor), textAlign: TextAlign.end),
                  r.notTaken
                      ? Text('—', textAlign: TextAlign.end, style: muted)
                      : diffCell(r.lineVarianceMinor, key: Key('compare_diff_$i')),
                ],
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: theme.colorScheme.outlineVariant)),
                ),
              ),
            row(
              [
                Text(l10n.compareTotal, style: bold),
                Text(money(result.plannedTotalMinor), style: bold, textAlign: TextAlign.end),
                Text(money(result.actualTotalMinor), style: bold, textAlign: TextAlign.end),
                diffCell(result.varianceMinor, key: const Key('compare_diff_total')),
              ],
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: theme.colorScheme.outline, width: 1.5)),
              ),
            ),
            if (budget != null)
              row([
                Text(l10n.compareBudget, style: bold),
                Text(money(budget), textAlign: TextAlign.end),
                Text(money(result.actualTotalMinor), textAlign: TextAlign.end),
                diffCell(result.actualTotalMinor - budget, key: const Key('compare_diff_budget')),
              ]),
          ],
        ),
      ),
    );
  }
}

/// "Pahalı çıkanlar" / "Ucuza aldıkların" — en büyük 3 fark (PB-053).
class PriceMovers extends StatelessWidget {
  const PriceMovers({super.key, required this.result});

  final ListResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(result.currencyCode);
    final locale = formatLocaleCode(context);
    String money(int minor) =>
        formatMoney(Money.fromMinorUnits(minor, currency), locale: locale);
    final planned = result.rows.where((r) => !r.notTaken && !r.isUnplanned).toList();
    final pricier = (planned.where((r) => r.lineVarianceMinor > 0).toList()
          ..sort((a, b) => b.lineVarianceMinor.compareTo(a.lineVarianceMinor)))
        .take(3)
        .toList();
    final cheaper = (planned.where((r) => r.lineVarianceMinor < 0).toList()
          ..sort((a, b) => a.lineVarianceMinor.compareTo(b.lineVarianceMinor)))
        .take(3)
        .toList();
    if (pricier.isEmpty && cheaper.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    Widget group(String title, List<ItemResultRow> rows, SpendingDirection dir, Key key) {
      final delta = SemanticDelta.resolve(direction: dir, brightness: theme.brightness);
      return Expanded(
        child: Card(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(delta.icon, size: 18, color: delta.color),
                  const SizedBox(width: 6),
                  Expanded(child: Text(title, style: theme.textTheme.titleSmall)),
                ]),
                const SizedBox(height: 6),
                if (rows.isEmpty) Text('—', style: theme.textTheme.bodySmall),
                for (final r in rows)
                  Text('${r.name}  ${r.lineVarianceMinor > 0 ? '+' : '−'}${money(r.lineVarianceMinor.abs())}',
                      maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        group(l10n.pricierItems, pricier, SpendingDirection.overPlan, const Key('movers_pricier')),
        group(l10n.cheaperItems, cheaper, SpendingDirection.underPlan, const Key('movers_cheaper')),
      ],
    );
  }
}
