import 'package:flutter/material.dart';

import '../../../app/app_defaults.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/format_locale.dart';
import '../../../core/money/money.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/money_parser.dart';
import '../../../data/db/app_database.dart';
import 'insights_repository.dart';

/// Harcamalar (PB-054): alışveriş günleri takvimi, haftalık/aylık grafik,
/// aylık limit. Varsayılan para biriminde; diğer para birimleri karışmaz.
class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key, required this.db, this.now, this.currencyCode});

  final AppDatabase db;

  /// Testlerde sabit "bugün".
  final DateTime? now;
  final String? currencyCode;

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
  late final DateTime _now = widget.now ?? DateTime.now();
  late DateTime _month = DateTime(_now.year, _now.month);
  late final String _currency = widget.currencyCode ?? AppDefaults.defaultCurrency();
  late final Future<List<SpendPoint>> _points = InsightsRepository(widget.db).completedSpend(_currency);
  late int? _limit = AppDefaults.monthlyLimitMinor(currencyCode: _currency);

  String _money(int minor) => formatMoney(
        Money.fromMinorUnits(minor, Currency.fromCode(_currency)),
        locale: formatLocaleCode(context),
      );

  Future<void> _editLimit() async {
    final l10n = AppLocalizations.of(context);
    final digits = Currency.fromCode(_currency).minorUnitDigits;
    final sep = MoneySeparators.forLocaleCode(formatLocaleCode(context));
    var text = _limit == null ? '' : DecimalFixed.fromMinorUnits(_limit!, digits).toDbString().replaceAll('.', sep.decimal);
    final form = GlobalKey<FormState>();
    int parse() {
      final minor = MoneyParser.parseDecimal(text, separators: sep, requirePositive: true).toMinorUnits(digits);
      if (minor <= 0) throw const FormatException('positive minor amount required');
      return minor;
    }
    final result = await showDialog<int?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.monthlyLimitTitle),
        content: Form(key: form, child: TextFormField(
          validator: (_) { try { parse(); return null; } on FormatException { return l10n.invalidPriceError; } },
          key: const Key('limit_field'),
          initialValue: text,
          onChanged: (value) => text = value,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(helperText: l10n.monthlyLimitHelp, suffixText: _currency),
        )),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, -1), child: Text(l10n.monthlyLimitRemove)),
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
    if (result == null || !mounted) return;
    AppDefaults.setMonthlyLimitMinor(result < 0 ? null : result, currencyCode: _currency);
    setState(() => _limit = result < 0 ? null : result);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.spendingTitle)),
      body: FutureBuilder<List<SpendPoint>>(
        future: _points,
        builder: (context, snap) {
          final points = snap.data;
          if (points == null) return const Center(child: CircularProgressIndicator());
          final days = SpendMath.byDay(points, _month.year, _month.month);
          final monthTotal = days.values.fold<int>(0, (s, v) => s + v);
          final weeks = SpendMath.byWeek(points, _now);
          final months = SpendMath.byMonth(points, _now);
          final ml = MaterialLocalizations.of(context);
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              _LimitCard(
                spentMinor: monthTotal,
                limitMinor: _limit,
                money: _money,
                onEdit: _editLimit,
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            key: const Key('month_prev'),
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () => setState(() => _month = DateTime(_month.year, _month.month - 1)),
                          ),
                          Expanded(
                            child: Text(ml.formatMonthYear(_month),
                                textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
                          ),
                          IconButton(
                            key: const Key('month_next'),
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () => setState(() => _month = DateTime(_month.year, _month.month + 1)),
                          ),
                        ],
                      ),
                      _MonthCalendar(month: _month, spendByDay: days, money: _money),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text('${l10n.spendingMonthTotal}: ${_money(monthTotal)}',
                            key: const Key('month_total')),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _BarChartCard(
                title: l10n.spendingWeekly,
                bars: [for (final (d, v) in weeks) ('${d.day}.${d.month}', v)],
                money: _money,
              ),
              const SizedBox(height: 8),
              _BarChartCard(
                title: l10n.spendingMonthly,
                bars: [for (final (d, v) in months) (ml.formatMonthYear(d).split(' ').first, v)],
                money: _money,
                limitMinor: _limit,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LimitCard extends StatelessWidget {
  const _LimitCard({required this.spentMinor, required this.limitMinor, required this.money, required this.onEdit});

  final int spentMinor;
  final int? limitMinor;
  final String Function(int) money;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final limit = limitMinor;
    final over = limit != null && spentMinor > limit;
    return Card(
      key: const Key('limit_card'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(l10n.monthlyLimitTitle, style: Theme.of(context).textTheme.titleMedium)),
                TextButton(key: const Key('limit_edit'), onPressed: onEdit, child: Text(limit == null ? l10n.monthlyLimitSet : l10n.monthlyLimitChange)),
              ],
            ),
            if (limit == null)
              Text(l10n.monthlyLimitNone)
            else ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  key: const Key('limit_progress'),
                  value: (spentMinor / limit).clamp(0, 1).toDouble(),
                  minHeight: 10,
                  color: over ? scheme.error : scheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                over
                    ? l10n.monthlyLimitOver(money(spentMinor - limit))
                    : l10n.monthlyLimitLeft(money(limit - spentMinor)),
                key: const Key('limit_text'),
                style: TextStyle(color: over ? scheme.error : null, fontWeight: FontWeight.w600),
              ),
              Text('${money(spentMinor)} / ${money(limit)}', style: Theme.of(context).textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}

class _MonthCalendar extends StatelessWidget {
  const _MonthCalendar({required this.month, required this.spendByDay, required this.money});

  final DateTime month;
  final Map<int, int> spendByDay;
  final String Function(int) money;

  @override
  Widget build(BuildContext context) {
    final ml = MaterialLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final first = ml.firstDayOfWeekIndex; // 0 = pazar
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leading = (DateTime(month.year, month.month, 1).weekday % 7 - first + 7) % 7;
    final headers = [for (var i = 0; i < 7; i++) ml.narrowWeekdays[(first + i) % 7]];
    final cells = <Widget>[
      for (final h in headers)
        Center(child: Text(h, style: Theme.of(context).textTheme.labelSmall)),
      for (var i = 0; i < leading; i++) const SizedBox.shrink(),
      for (var d = 1; d <= daysInMonth; d++)
        Tooltip(
          message: spendByDay[d] == null ? '' : money(spendByDay[d]!),
          child: Container(
            key: Key('cal_day_$d'),
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: spendByDay[d] == null ? null : scheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$d', style: TextStyle(fontWeight: spendByDay[d] == null ? null : FontWeight.w700)),
                if (spendByDay[d] != null)
                  Text(
                    '${spendByDay[d]! ~/ 100}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.onPrimaryContainer),
                  ),
              ],
            ),
          ),
        ),
    ];
    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.9,
      children: cells,
    );
  }
}

class _BarChartCard extends StatelessWidget {
  const _BarChartCard({required this.title, required this.bars, required this.money, this.limitMinor});

  final String title;
  final List<(String, int)> bars;
  final String Function(int) money;
  final int? limitMinor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxV = bars.fold<int>(0, (m, b) => b.$2 > m ? b.$2 : m);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final (label, v) in bars)
                    Expanded(
                      child: Tooltip(
                        message: money(v),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: FractionallySizedBox(
                                heightFactor: maxV == 0 ? 0.02 : (v / maxV).clamp(0.02, 1).toDouble(),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: limitMinor != null && v > limitMinor! ? scheme.error : scheme.primary,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(label, style: Theme.of(context).textTheme.labelSmall, maxLines: 1),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
