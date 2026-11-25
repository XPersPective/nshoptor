import 'package:flutter/material.dart';

import '../../../app/app_defaults.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../data/db/app_database.dart';
import 'insights_repository.dart';

/// Weekly and monthly budget progress at the top of History (PB-199, F33).
/// Hidden when no limit is set; limits are edited on the Spending screen.
class HistoryBudgetCard extends StatefulWidget {
  const HistoryBudgetCard({
    super.key,
    required this.db,
    required this.currencyCode,
    required this.now,
    required this.money,
    this.onEdit,
  });

  final AppDatabase db;
  final String currencyCode;
  final DateTime now;
  final String Function(int minor) money;
  final VoidCallback? onEdit;

  /// Share of a limit at which the bar turns to the warning colour.
  static const warnRatio = 0.8;

  @override
  State<HistoryBudgetCard> createState() => _HistoryBudgetCardState();
}

class _HistoryBudgetCardState extends State<HistoryBudgetCard> {
  late final int? _week = AppDefaults.weeklyLimitMinor(
    currencyCode: widget.currencyCode,
    week: widget.now,
  );
  late final int? _month = AppDefaults.monthlyLimitMinor(
    currencyCode: widget.currencyCode,
    month: DateTime(widget.now.year, widget.now.month),
  );
  late final Future<List<SpendPoint>>? _points = _week == null && _month == null
      ? null
      : InsightsRepository(widget.db).completedSpend(widget.currencyCode);

  @override
  Widget build(BuildContext context) {
    final points = _points;
    if (points == null) return const SizedBox.shrink();
    final l = AppLocalizations.of(context);
    return FutureBuilder<List<SpendPoint>>(
      future: points,
      builder: (context, snap) {
        final data = snap.data;
        if (data == null) return const SizedBox.shrink();
        SpendAmount spent(SpendSpan span) {
          final r = span.range(widget.now);
          return SpendMath.amount(data, r.from, r.to);
        }

        return Card(
          key: const Key('history_budget_card'),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_week != null)
                  _BudgetRow(
                    key: const Key('history_budget_week'),
                    title: l.weeklyLimitTitle,
                    spent: spent(SpendSpan.week),
                    limit: _week,
                    money: widget.money,
                    left: l.weeklyLimitLeft,
                  ),
                if (_week != null && _month != null) const SizedBox(height: 16),
                if (_month != null)
                  _BudgetRow(
                    key: const Key('history_budget_month'),
                    title: l.monthlyLimitTitle,
                    spent: spent(SpendSpan.month),
                    limit: _month,
                    money: widget.money,
                    left: l.monthlyLimitLeft,
                  ),
                if (widget.onEdit != null)
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      key: const Key('history_budget_edit'),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(48, 48),
                      ),
                      onPressed: widget.onEdit,
                      child: Text(l.monthlyLimitChange),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BudgetRow extends StatelessWidget {
  const _BudgetRow({
    super.key,
    required this.title,
    required this.spent,
    required this.limit,
    required this.money,
    required this.left,
  });

  final String title;
  final SpendAmount spent;
  final int limit;
  final String Function(int) money;
  final String Function(String) left;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final exact = spent.known && !spent.unknown;
    final ratio = limit <= 0 ? 1.0 : spent.minor / limit;
    final over = exact && spent.minor > limit;
    final warn = exact && ratio >= HistoryBudgetCard.warnRatio;
    final color = over
        ? scheme.error
        : warn
        ? scheme.tertiary
        : scheme.primary;
    final status = !exact
        ? '—'
        : over
        ? l.monthlyLimitOver(money(spent.minor - limit))
        : left(money(limit - spent.minor));
    final amounts = '${spent.display(money)} / ${money(limit)}';
    return Semantics(
      container: true,
      label: '$title: $amounts. $status',
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(amounts, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: exact ? ratio.clamp(0, 1).toDouble() : 0,
              minHeight: 10,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(
              color: over ? scheme.error : null,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
