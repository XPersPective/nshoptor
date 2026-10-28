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
import 'limit_editor.dart';
import '../reports/report_document.dart';
import '../reports/report_period.dart';
import '../reports/report_repository.dart';
import '../reports/report_share_menu.dart';
import '../../../core/quantity/unit_display.dart';
import '../../../core/quantity/unit_code.dart';
import '../../lists/starter_categories.dart';
import '../price_history/price_history_sheet.dart';

/// Harcamalar (PB-054): alışveriş günleri takvimi, haftalık/aylık grafik,
/// aylık limit. Varsayılan para biriminde; diğer para birimleri karışmaz.
class SpendingScreen extends StatefulWidget {
  const SpendingScreen({
    super.key,
    required this.db,
    this.now,
    this.currencyCode,
    this.embedded = false,
  });

  final AppDatabase db;

  /// Testlerde sabit "bugün".
  final DateTime? now;
  final String? currencyCode;

  /// Geçmiş sekmesinin içinde: kendi uygulama çubuğu olmadan.
  final bool embedded;

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
  late final DateTime _now = widget.now ?? DateTime.now();
  late DateTime _month = DateTime(_now.year, _now.month);
  late final String _currency =
      widget.currencyCode ?? AppDefaults.defaultCurrency();
  late final Future<List<SpendPoint>> _points = InsightsRepository(
    widget.db,
  ).completedSpend(_currency);
  late final _analytics = (() async {
    final repo = InsightsRepository(widget.db);
    return (
      categories: await repo.spendingByCategory(_currency),
      stores: await repo.spendingByStore(_currency),
      products: await repo.purchaseStats(_currency),
      categoryProducts: await repo.purchaseStats(_currency, byCategory: true),
    );
  })();
  late final _data = (() async =>
      (points: await _points, analytics: await _analytics))();
  DateTime get _nextWeek =>
      AppDefaults.weekStart(_now).add(const Duration(days: 7));
  DateTime get _nextMonth => DateTime(_now.year, _now.month + 1);
  late int? _limit = AppDefaults.monthlyLimitMinor(
    currencyCode: _currency,
    month: _month,
  );
  late int? _weekLimit = AppDefaults.weeklyLimitMinor(
    currencyCode: _currency,
    week: _now,
  );
  late int? _nextWeekLimit = AppDefaults.weeklyLimitMinor(
    currencyCode: _currency,
    week: _nextWeek,
    explicitOnly: true,
  );
  late int? _nextMonthLimit = AppDefaults.monthlyLimitMinor(
    currencyCode: _currency,
    month: _nextMonth,
    explicitOnly: true,
  );
  late int? _shoppingLimit = AppDefaults.shoppingLimitMinor(
    currencyCode: _currency,
  );
  SpendSpan _span = SpendSpan.month;
  late Future<List<PurchaseStats>> _spanStats = _loadSpan(_span);

  Future<List<PurchaseStats>> _loadSpan(SpendSpan span) {
    final r = span.range(_now);
    return InsightsRepository(
      widget.db,
    ).purchaseStats(_currency, from: r.from.toUtc(), to: r.to.toUtc());
  }

  String _money(int minor) => formatMoney(
    Money.fromMinorUnits(minor, Currency.fromCode(_currency)),
    locale: formatLocaleCode(context),
  );

  Future<void> _editLimit([_LimitKind kind = _LimitKind.month]) async {
    final l10n = AppLocalizations.of(context);
    final (title, help, current) = switch (kind) {
      _LimitKind.week => (
        l10n.weeklyLimitTitle,
        l10n.weeklyLimitHelp,
        _weekLimit,
      ),
      _LimitKind.month => (
        l10n.monthlyLimitTitle,
        l10n.monthlyLimitHelp,
        _limit,
      ),
      _LimitKind.nextWeek => (
        '${l10n.weeklyLimitTitle} (+1)',
        l10n.weeklyLimitHelp,
        _nextWeekLimit,
      ),
      _LimitKind.nextMonth => (
        '${l10n.monthlyLimitTitle} (+1)',
        l10n.monthlyLimitHelp,
        _nextMonthLimit,
      ),
      _LimitKind.shopping => (
        l10n.shoppingLimitTitle,
        l10n.shoppingLimitHelp,
        _shoppingLimit,
      ),
    };
    final result = await showLimitEditor(
      context,
      title: title,
      help: help,
      current: current,
      currency: _currency,
    );
    if (result == null || !mounted) return;
    final value = result < 0 ? null : result;
    switch (kind) {
      case _LimitKind.week:
        AppDefaults.setWeeklyLimitMinor(value, currencyCode: _currency);
        AppDefaults.setWeeklyLimitMinor(
          value,
          currencyCode: _currency,
          week: _now,
        );
        setState(() => _weekLimit = value);
      case _LimitKind.month:
        final isCurrentMonth =
            _month.year == _now.year && _month.month == _now.month;
        if (isCurrentMonth) {
          AppDefaults.setMonthlyLimitMinor(value, currencyCode: _currency);
        }
        AppDefaults.setMonthlyLimitMinor(
          value,
          currencyCode: _currency,
          month: _month,
        );
        setState(() {
          _limit = AppDefaults.monthlyLimitMinor(
            currencyCode: _currency,
            month: _month,
          );
          _nextMonthLimit = AppDefaults.monthlyLimitMinor(
            currencyCode: _currency,
            month: _nextMonth,
            explicitOnly: true,
          );
        });
      case _LimitKind.nextWeek:
        AppDefaults.setWeeklyLimitMinor(
          value,
          currencyCode: _currency,
          week: _nextWeek,
        );
        setState(() => _nextWeekLimit = value);
      case _LimitKind.nextMonth:
        AppDefaults.setMonthlyLimitMinor(
          value,
          currencyCode: _currency,
          month: _nextMonth,
        );
        setState(() {
          _nextMonthLimit = value;
          if (_month.year == _nextMonth.year &&
              _month.month == _nextMonth.month) {
            _limit = AppDefaults.monthlyLimitMinor(
              currencyCode: _currency,
              month: _month,
            );
          }
        });
      case _LimitKind.shopping:
        AppDefaults.setShoppingLimitMinor(value, currencyCode: _currency);
        setState(() => _shoppingLimit = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: widget.embedded ? null : AppBar(title: Text(l10n.spendingTitle)),
      body: FutureBuilder(
        future: _data,
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text(l10n.saveFailed));
          final points = snap.data?.points;
          if (points == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final days = SpendMath.byDay(points, _month.year, _month.month);
          final monthTotal = days.values.fold<int>(0, (s, v) => s + v);
          final monthAmount = SpendMath.amount(
            points,
            DateTime(_month.year, _month.month),
            DateTime(_month.year, _month.month + 1),
          );
          final weeks = SpendMath.byWeek(points, _now);
          final months = SpendMath.byMonth(points, _now);
          final years = SpendMath.byYear(points, _now);
          SpendAmount spent(SpendSpan span) {
            final r = span.range(_now);
            return SpendMath.amount(points, r.from, r.to);
          }

          final ml = MaterialLocalizations.of(context);
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              _OverviewCard(
                week: spent(SpendSpan.week),
                month: spent(SpendSpan.month),
                year: spent(SpendSpan.year),
                weekLimit: _weekLimit,
                monthLimit: _limit,
                money: _money,
              ),
              const SizedBox(height: 8),
              _LimitCard(
                spentMinor: spent(SpendSpan.week).minor,
                spentKnown: spent(SpendSpan.week).known,
                spentUnknown: spent(SpendSpan.week).unknown,
                limitMinor: _weekLimit,
                money: _money,
                onEdit: () => _editLimit(_LimitKind.week),
                keyPrefix: 'weekly_',
                title: l10n.weeklyLimitTitle,
                noneText: l10n.weeklyLimitNone,
                leftText: l10n.weeklyLimitLeft,
              ),
              const SizedBox(height: 8),
              _LimitCard(
                spentMinor: monthTotal,
                spentKnown: monthAmount.known,
                spentUnknown: monthAmount.unknown,
                limitMinor: _limit,
                money: _money,
                onEdit: _editLimit,
                title: l10n.monthlyLimitTitle,
                noneText: l10n.monthlyLimitNone,
                leftText: l10n.monthlyLimitLeft,
              ),
              const SizedBox(height: 8),
              Card(
                key: const Key('shopping_limit_card'),
                child: ListTile(
                  leading: const Icon(Icons.shopping_basket_outlined),
                  title: Text(l10n.shoppingLimitTitle),
                  subtitle: Text(
                    _shoppingLimit == null
                        ? l10n.shoppingLimitNone
                        : '${_money(_shoppingLimit!)} · ${l10n.shoppingLimitHelp}',
                  ),
                  trailing: TextButton(
                    key: const Key('shopping_limit_edit'),
                    onPressed: () => _editLimit(_LimitKind.shopping),
                    child: Text(
                      _shoppingLimit == null
                          ? l10n.monthlyLimitSet
                          : l10n.monthlyLimitChange,
                    ),
                  ),
                ),
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
                            tooltip: l10n.previousMonthAction,
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () => setState(() {
                              _month = DateTime(_month.year, _month.month - 1);
                              _limit = AppDefaults.monthlyLimitMinor(
                                currencyCode: _currency,
                                month: _month,
                              );
                            }),
                          ),
                          Expanded(
                            child: Text(
                              ml.formatMonthYear(_month),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          IconButton(
                            key: const Key('month_next'),
                            tooltip: l10n.nextMonthAction,
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () => setState(() {
                              _month = DateTime(_month.year, _month.month + 1);
                              _limit = AppDefaults.monthlyLimitMinor(
                                currencyCode: _currency,
                                month: _month,
                              );
                            }),
                          ),
                        ],
                      ),
                      MonthCalendar(
                        month: _month,
                        spendByDay: days,
                        money: _money,
                        amounts: SpendMath.amountsByDay(
                          points,
                          _month.year,
                          _month.month,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '${l10n.spendingMonthTotal}: ${monthAmount.display(_money)}',
                          key: const Key('month_total'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ReportShareButton(
                          key: const Key('monthly_report'),
                          label: l10n.monthlyReportAction,
                          document: () async {
                            final month = _month;
                            final report = await ReportRepository(widget.db).period(
                              ReportPeriod.forSpan(ReportSpan.month, month),
                              _currency,
                            );
                            return ReportDocument(
                              title: '${l10n.monthlyReportAction} · ${ml.formatMonthYear(month)}',
                              currencyCode: report.currencyCode,
                              shopping: report.shopping,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                key: const Key('future_limits_card'),
                child: ExpansionTile(
                  key: const Key('future_limits_tile'),
                  leading: const Icon(Icons.event_repeat_outlined),
                  title: Text(
                    '${l10n.nextPeriodAction} · ${l10n.budgetLabel}',
                  ),
                  children: [
                    ListTile(
                      key: const Key('next_weekly_limit_tile'),
                      title: Text(
                        '${l10n.weeklyLimitTitle} (${ml.formatShortDate(_nextWeek)})',
                      ),
                      subtitle: Text(
                        _nextWeekLimit == null
                            ? l10n.weeklyLimitNone
                            : _money(_nextWeekLimit!),
                      ),
                      trailing: TextButton(
                        key: const Key('next_weekly_limit_edit'),
                        onPressed: () => _editLimit(_LimitKind.nextWeek),
                        child: Text(
                          _nextWeekLimit == null
                              ? l10n.monthlyLimitSet
                              : l10n.monthlyLimitChange,
                        ),
                      ),
                    ),
                    ListTile(
                      key: const Key('next_monthly_limit_tile'),
                      title: Text(
                        '${l10n.monthlyLimitTitle} (${ml.formatMonthYear(_nextMonth)})',
                      ),
                      subtitle: Text(
                        _nextMonthLimit == null
                            ? l10n.monthlyLimitNone
                            : _money(_nextMonthLimit!),
                      ),
                      trailing: TextButton(
                        key: const Key('next_monthly_limit_edit'),
                        onPressed: () => _editLimit(_LimitKind.nextMonth),
                        child: Text(
                          _nextMonthLimit == null
                              ? l10n.monthlyLimitSet
                              : l10n.monthlyLimitChange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _BarChartCard(
                title: l10n.spendingWeekly,
                bars: [
                  for (final (d, v) in weeks)
                    ('${d.day}.${d.month}', DecimalFixed.fromInt(v)),
                ],
                valueLabels: [
                  for (final (d, _) in weeks)
                    SpendMath.amount(
                      points,
                      d,
                      DateTime(d.year, d.month, d.day + 7),
                    ).display(_money),
                ],
                valueText: (v) => _money(v.toMinorUnits(0)),
              ),
              const SizedBox(height: 8),
              _BarChartCard(
                title: l10n.spendingMonthly,
                bars: [
                  for (final (d, v) in months)
                    (
                      ml.formatMonthYear(d).split(' ').first,
                      DecimalFixed.fromInt(v),
                    ),
                ],
                valueLabels: [
                  for (final (d, _) in months)
                    SpendMath.amount(
                      points,
                      d,
                      DateTime(d.year, d.month + 1),
                    ).display(_money),
                ],
                valueText: (v) => _money(v.toMinorUnits(0)),
                limitMinor: _limit,
              ),
              const SizedBox(height: 8),
              _BarChartCard(
                title: l10n.spendingYearly,
                bars: [
                  for (final (d, v) in years)
                    ('${d.year}', DecimalFixed.fromInt(v)),
                ],
                valueLabels: [
                  for (final (d, _) in years)
                    SpendMath.amount(
                      points,
                      d,
                      DateTime(d.year + 1),
                    ).display(_money),
                ],
                valueText: (v) => _money(v.toMinorUnits(0)),
              ),
              const SizedBox(height: 8),
              Card(
                key: const Key('product_spending'),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.productSpending,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<SpendSpan>(
                        key: const Key('product_spending_span'),
                        segments: [
                          ButtonSegment(
                            value: SpendSpan.week,
                            label: Text(l10n.spanWeek),
                          ),
                          ButtonSegment(
                            value: SpendSpan.month,
                            label: Text(l10n.spanMonth),
                          ),
                          ButtonSegment(
                            value: SpendSpan.year,
                            label: Text(l10n.spanYear),
                          ),
                        ],
                        selected: {_span},
                        onSelectionChanged: (s) => setState(() {
                          _span = s.first;
                          _spanStats = _loadSpan(_span);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<PurchaseStats>>(
                future: _spanStats,
                builder: (context, s) {
                  if (s.connectionState != ConnectionState.done) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: LinearProgressIndicator(),
                    );
                  }
                  final top = [...?s.data]
                    ..removeWhere((p) => p.actualMinor <= 0)
                    ..sort((a, b) => b.actualMinor.compareTo(a.actualMinor));
                  return _BarChartCard(
                    key: const Key('product_spending_chart'),
                    title: switch (_span) {
                      SpendSpan.week => l10n.historyThisWeek,
                      SpendSpan.month => l10n.spendingMonthTotal,
                      SpendSpan.year => l10n.spendingThisYear,
                    },
                    bars: [
                      for (final p in top.take(10))
                        (p.name, DecimalFixed.fromInt(p.actualMinor)),
                    ],
                    valueText: (v) => _money(v.toMinorUnits(0)),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '$_currency · ${l10n.purchaseAnalyticsHint}\n${l10n.purchaseHistoryHint}',
                ),
              ),
              Builder(
                builder: (context) {
                  final data = snap.data!.analytics;
                  String category(String label) =>
                      StarterCategories().labelOf(l10n, label);
                  String quantity(DecimalFixed value) =>
                      value.toDbString().replaceAll(
                        '.',
                        MoneySeparators.forLocaleCode(
                          formatLocaleCode(context),
                        ).decimal,
                      );
                  final children = <Widget>[
                    _BarChartCard(
                      title: '${l10n.categoryLabel} · ${l10n.actualTotalLabel}',
                      bars: [
                        for (final s in data.categories)
                          (
                            category(s.label ?? 'other'),
                            DecimalFixed.fromInt(s.actualMinor),
                          ),
                      ],
                      valueText: (v) => _money(v.toMinorUnits(0)),
                    ),
                    _BarChartCard(
                      title: '${l10n.storeLabel} · ${l10n.actualTotalLabel}',
                      bars: [
                        for (final s in data.stores)
                          (
                            s.label ?? category('other'),
                            DecimalFixed.fromInt(s.actualMinor),
                          ),
                      ],
                      valueText: (v) => _money(v.toMinorUnits(0)),
                    ),
                  ];
                  for (final byCategory in [false, true]) {
                    final stats = byCategory
                        ? data.categoryProducts
                        : data.products;
                    final title = byCategory
                        ? l10n.categoryLabel
                        : l10n.groupsSection;
                    for (final unit in stats.map((p) => p.unitCode).toSet()) {
                      if (unit == 'custom' ||
                          !UnitCode.standard().any((u) => u.dbCode == unit)) {
                        continue;
                      }
                      final group = stats
                          .where((p) => p.unitCode == unit)
                          .toList();
                      final unitLabel = unitDisplayNameFromDb(unit, l10n);
                      children.add(
                        _BarChartCard(
                          title:
                              '$title · ${l10n.purchasedQuantity} ($unitLabel)',
                          bars: [
                            for (final p in group)
                              (
                                byCategory ? category(p.name) : p.name,
                                p.quantity,
                              ),
                          ],
                          valueText: (v) => '${quantity(v)} $unitLabel',
                        ),
                      );
                    }
                    if (stats.isEmpty) {
                      children.add(
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(l10n.noPurchasesNote),
                        ),
                      );
                    }
                    for (final p in stats) {
                      children.add(
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  byCategory ? category(p.name) : p.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  '${l10n.purchasedQuantity}: ${quantity(p.quantity)} ${unitDisplayNameFromDb(p.unitCode, l10n)}',
                                ),
                                Text(
                                  '${l10n.actualTotalLabel}: ${p.amount.display(_money)}',
                                ),
                                Text(
                                  '${l10n.purchaseVisits}: ${p.visits.length}',
                                ),
                                Text(
                                  '${l10n.purchaseInterval}: ${p.intervalDays == null ? '—' : quantity(p.intervalDays!)}',
                                ),
                                if (p.firstAt != null)
                                  Text(
                                    '${ml.formatMediumDate(p.firstAt!.toLocal())} – ${ml.formatMediumDate(p.lastAt!.toLocal())}',
                                  ),
                                if (p.productId != null)
                                  TextButton(
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (_) => PriceHistoryScreen(
                                          db: widget.db,
                                          productId: p.productId!,
                                          productName: p.name,
                                          currencyCode: _currency,
                                          unitCode: p.unitCode,
                                        ),
                                      ),
                                    ),
                                    child: Text(l10n.priceHistoryAction),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

enum _LimitKind { week, month, nextWeek, nextMonth, shopping }

/// Bir bakışta harcama: bu hafta, bu ay, bu yıl; limit varsa ilerleme çubuğu.
class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.week,
    required this.month,
    required this.year,
    required this.weekLimit,
    required this.monthLimit,
    required this.money,
  });

  final SpendAmount week, month, year;
  final int? weekLimit, monthLimit;
  final String Function(int) money;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    Widget tile(String label, SpendAmount amount, int? limit, Key key) {
      final over = limit != null && amount.known && amount.minor > limit;
      return Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(
            amount.display(money),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: over ? theme.colorScheme.error : null,
            ),
          ),
          if (limit != null && amount.known && !amount.unknown) ...[
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (amount.minor / limit).clamp(0, 1).toDouble(),
                minHeight: 6,
                color: over
                    ? theme.colorScheme.error
                    : theme.colorScheme.primary,
              ),
            ),
          ],
        ],
      );
    }

    final tiles = [
      tile(l10n.historyThisWeek, week, weekLimit, const Key('overview_week')),
      tile(
        l10n.spendingMonthTotal,
        month,
        monthLimit,
        const Key('overview_month'),
      ),
      tile(l10n.spendingThisYear, year, null, const Key('overview_year')),
    ];
    final wide =
        MediaQuery.sizeOf(context).width >= 360 &&
        MediaQuery.textScalerOf(context).scale(14) <= 18;
    return Card(
      key: const Key('spending_overview'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.spendingOverview, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final (i, t) in tiles.indexed) ...[
                    if (i > 0) const SizedBox(width: 12),
                    Expanded(child: t),
                  ],
                ],
              )
            else
              for (final (i, t) in tiles.indexed) ...[
                if (i > 0) const SizedBox(height: 12),
                t,
              ],
          ],
        ),
      ),
    );
  }
}

class _LimitCard extends StatelessWidget {
  const _LimitCard({
    required this.spentMinor,
    required this.limitMinor,
    required this.money,
    required this.onEdit,
    required this.title,
    required this.noneText,
    required this.leftText,
    this.keyPrefix = '',
    this.spentKnown = true,
    this.spentUnknown = false,
  });

  final int spentMinor;
  final bool spentKnown, spentUnknown;
  final int? limitMinor;
  final String Function(int) money;
  final VoidCallback onEdit;
  final String title;
  final String noneText;
  final String Function(String amount) leftText;

  /// Aylık kart eski anahtarları korur (limit_*); haftalık "weekly_limit_*".
  final String keyPrefix;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final limit = limitMinor;
    final over = limit != null && spentMinor > limit;
    return Card(
      key: Key('${keyPrefix}limit_card'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TextButton(
                  key: Key('${keyPrefix}limit_edit'),
                  onPressed: onEdit,
                  child: Text(
                    limit == null
                        ? l10n.monthlyLimitSet
                        : l10n.monthlyLimitChange,
                  ),
                ),
              ],
            ),
            if (limit == null)
              Text(noneText)
            else ...[
              if (spentKnown && !spentUnknown)
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    key: Key('${keyPrefix}limit_progress'),
                    value: (spentMinor / limit).clamp(0, 1).toDouble(),
                    minHeight: 10,
                    color: over ? scheme.error : scheme.primary,
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                !spentKnown || spentUnknown
                    ? '—'
                    : over
                    ? l10n.monthlyLimitOver(money(spentMinor - limit))
                    : leftText(money(limit - spentMinor)),
                key: Key('${keyPrefix}limit_text'),
                style: TextStyle(
                  color: over ? scheme.error : null,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${SpendAmount(spentMinor, known: spentKnown, unknown: spentUnknown).display(money)} / ${money(limit)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({
    super.key,
    required this.month,
    required this.spendByDay,
    required this.money,
    this.amounts,
  });

  final DateTime month;
  final Map<int, int> spendByDay;
  final String Function(int) money;
  final Map<int, SpendAmount>? amounts;

  @override
  Widget build(BuildContext context) {
    final ml = MaterialLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final first = ml.firstDayOfWeekIndex; // 0 = pazar
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leading =
        (DateTime(month.year, month.month, 1).weekday % 7 - first + 7) % 7;
    final headers = [
      for (var i = 0; i < 7; i++) ml.narrowWeekdays[(first + i) % 7],
    ];
    final cells = <Widget>[
      for (final h in headers)
        Center(child: Text(h, style: Theme.of(context).textTheme.labelSmall)),
      for (var i = 0; i < leading; i++) const SizedBox.shrink(),
      for (var d = 1; d <= daysInMonth; d++)
        Tooltip(
          message: spendByDay[d] == null
              ? ''
              : amounts?[d]?.display(money) ?? money(spendByDay[d]!),
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
                  Text(
                    '$d',
                    style: TextStyle(
                      fontWeight: spendByDay[d] == null
                          ? null
                          : FontWeight.w700,
                    ),
                  ),
                  if (spendByDay[d] != null) const Icon(Icons.circle, size: 6),
                ],
              ),
            ),
          ),
        ),
    ];
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisExtent: MediaQuery.textScalerOf(context).scale(14) * 1.5 + 24,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: cells,
    );
  }
}

class _BarChartCard extends StatelessWidget {
  const _BarChartCard({
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
            Text(title, style: Theme.of(context).textTheme.titleMedium),
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
