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
import '../../../core/quantity/unit_display.dart';
import '../../../core/quantity/unit_code.dart';
import '../../lists/starter_categories.dart';
import '../price_history/price_history_sheet.dart';

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
  late final _analytics = (() async {
    final repo = InsightsRepository(widget.db);
    return (categories: await repo.spendingByCategory(_currency), stores: await repo.spendingByStore(_currency),
      products: await repo.purchaseStats(_currency), categoryProducts: await repo.purchaseStats(_currency, byCategory: true));
  })();
  late final _data = (() async => (points: await _points, analytics: await _analytics))();
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
      body: FutureBuilder(
        future: _data,
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text(l10n.saveFailed));
          final points = snap.data?.points;
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
                bars: [for (final (d, v) in weeks) ('${d.day}.${d.month}', DecimalFixed.fromInt(v))],
                valueText: (v) => _money(v.toMinorUnits(0)),
              ),
              const SizedBox(height: 8),
              _BarChartCard(
                title: l10n.spendingMonthly,
                bars: [for (final (d, v) in months) (ml.formatMonthYear(d).split(' ').first, DecimalFixed.fromInt(v))],
                valueText: (v) => _money(v.toMinorUnits(0)),
                limitMinor: _limit,
              ),
              Padding(padding: const EdgeInsets.all(16), child: Text('$_currency · ${l10n.purchaseAnalyticsHint}\n${l10n.purchaseHistoryHint}')),
              Builder(builder: (context) {
                final data = snap.data!.analytics;
                String category(String label) => StarterCategories().labelOf(l10n, label);
                String quantity(DecimalFixed value) => value.toDbString().replaceAll('.', MoneySeparators.forLocaleCode(formatLocaleCode(context)).decimal);
                final children = <Widget>[
                  _BarChartCard(title: '${l10n.categoryLabel} · ${l10n.actualTotalLabel}', horizontal: true,
                    bars: [for (final s in data.categories) (category(s.label ?? 'other'), DecimalFixed.fromInt(s.actualMinor))],
                    valueText: (v) => _money(v.toMinorUnits(0))),
                  _BarChartCard(title: '${l10n.storeLabel} · ${l10n.actualTotalLabel}', horizontal: true,
                    bars: [for (final s in data.stores) (s.label ?? category('other'), DecimalFixed.fromInt(s.actualMinor))],
                    valueText: (v) => _money(v.toMinorUnits(0))),
                ];
                for (final byCategory in [false, true]) {
                  final stats = byCategory ? data.categoryProducts : data.products;
                  final title = byCategory ? l10n.categoryLabel : l10n.groupsSection;
                  for (final unit in stats.map((p) => p.unitCode).toSet()) {
                    if (unit == 'custom' || !UnitCode.standard().any((u) => u.dbCode == unit)) continue;
                    final group = stats.where((p) => p.unitCode == unit).toList();
                    final unitLabel = unitDisplayNameFromDb(unit, l10n);
                    children.add(_BarChartCard(title: '$title · ${l10n.purchasedQuantity} ($unitLabel)', horizontal: true,
                      bars: [for (final p in group) (byCategory ? category(p.name) : p.name, p.quantity)],
                      valueText: (v) => '${quantity(v)} $unitLabel'));
                  }
                  if (stats.isEmpty) children.add(Padding(padding: const EdgeInsets.all(16), child: Text(l10n.noPurchasesNote)));
                  for (final p in stats) {
                    children.add(Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(byCategory ? category(p.name) : p.name, style: Theme.of(context).textTheme.titleMedium),
                        Text('${l10n.purchasedQuantity}: ${quantity(p.quantity)} ${unitDisplayNameFromDb(p.unitCode, l10n)}'),
                        Text('${l10n.actualTotalLabel}: ${_money(p.actualMinor)}'),
                        Text('${l10n.purchaseVisits}: ${p.visits.length}'),
                        Text('${l10n.purchaseInterval}: ${p.intervalDays == null ? '—' : quantity(p.intervalDays!)}'),
                        if (p.firstAt != null) Text('${ml.formatMediumDate(p.firstAt!.toLocal())} – ${ml.formatMediumDate(p.lastAt!.toLocal())}'),
                        if (p.productId != null) TextButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (_) => PriceHistoryScreen(db: widget.db, productId: p.productId!, productName: p.name,
                            currencyCode: _currency, unitCode: p.unitCode))), child: Text(l10n.priceHistoryAction)),
                      ],
                    ))));
                  }
                }
                return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
              }),
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
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$d', style: TextStyle(fontWeight: spendByDay[d] == null ? null : FontWeight.w700)),
                  if (spendByDay[d] != null)
                    const Icon(Icons.circle, size: 6),
                ],
              ),
            ),
          ),
        ),
    ];
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7,
        mainAxisExtent: MediaQuery.textScalerOf(context).scale(14) * 1.5 + 24),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: cells,
    );
  }
}

class _BarChartCard extends StatelessWidget {
  const _BarChartCard({required this.title, required this.bars, required this.valueText, this.limitMinor, this.horizontal = false});
  final String title;
  final List<(String, DecimalFixed)> bars;
  final String Function(DecimalFixed) valueText;
  final int? limitMinor;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxV = bars.fold<DecimalFixed>(DecimalFixed.zero(), (m, b) => b.$2.abs() > m ? b.$2.abs() : m);
    // ponytail: nonzero bars have a 2% visual floor; exact labels remain authoritative.
    // Use a zoomable axis if very small differences need visual comparison.
    double fraction(DecimalFixed v) => v.isZero || maxV.isZero ? 0 :
      (v.abs().divide(maxV, scale: 6).toMinorUnits(6) / 1000000).clamp(0.02, 1);
    Color color(DecimalFixed v) => v.isNegative || limitMinor != null && v > DecimalFixed.fromInt(limitMinor!) ? scheme.error : scheme.primary;
    final rows = horizontal || MediaQuery.sizeOf(context).width < 400 || MediaQuery.textScalerOf(context).scale(14) > 18;
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        if (bars.isEmpty) Text(AppLocalizations.of(context).noPurchasesNote)
        else if (rows) ...[
          for (final (label, value) in bars) Padding(padding: const EdgeInsets.only(bottom: 12), child: Semantics(
            label: '$label: ${valueText(value)}', excludeSemantics: true,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('$label: ${valueText(value)}'),
              const SizedBox(height: 4),
              LinearProgressIndicator(value: fraction(value), minHeight: 8, color: color(value)),
            ]),
          )),
        ] else SizedBox(height: 120, child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          for (final (label, value) in bars) Expanded(child: Tooltip(message: '$label: ${valueText(value)}', child: Column(
            mainAxisAlignment: MainAxisAlignment.end, children: [
              Flexible(child: FractionallySizedBox(heightFactor: fraction(value), child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(color: color(value),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6))),
              ))),
              const SizedBox(height: 4),
              Text(label, style: Theme.of(context).textTheme.labelSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ))),
        ])),
      ],
    )));
  }
}
