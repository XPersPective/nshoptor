import 'package:flutter/material.dart';
import 'package:napp_ads/napp_ads.dart';

import '../../app/app_defaults.dart';
import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/money/format_locale.dart';
import '../../data/db/app_database.dart';
import 'insights/history_budget_card.dart';
import 'insights/insights_repository.dart';
import 'insights/spending_screen.dart';
import 'insights/value_bar_chart.dart';
import 'reports/report_document.dart';
import 'reports/report_groups.dart';
import 'reports/report_period.dart';
import 'reports/report_preview_screen.dart';
import 'reports/report_repository.dart';
import 'reports/report_share_menu.dart';

/// The three ways to read one History period (F30).
enum HistoryView { shopping, store, product }

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    super.key,
    required this.db,
    this.now,
    this.bannerController,
  });
  final AppDatabase db;
  final DateTime? now;
  final BannerAdController? bannerController;
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late ReportPeriod _period = _defaultPeriod;
  late final _completed = InsightsRepository(widget.db).watchCompleted();
  String _currency = AppDefaults.defaultCurrency();
  String _lastDefaultCurrency = AppDefaults.defaultCurrency();
  bool _followDefaultCurrency = true;
  HistoryView _view = HistoryView.shopping;

  DateTime get _now => widget.now ?? DateTime.now();
  ReportPeriod get _defaultPeriod =>
      ReportPeriod.forSpan(ReportSpan.week, _now);
  bool get _isDefault {
    final d = _defaultPeriod;
    return _period.span == d.span && _period.from == d.from;
  }

  @override
  void didUpdateWidget(covariant HistoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final before = oldWidget.now;
    final now = widget.now;
    if (before != null &&
        now != null &&
        before != now &&
        _period.span != ReportSpan.custom &&
        _period.contains(before)) {
      _period = ReportPeriod.forSpan(_period.span, now);
    }
  }

  String _label(BuildContext context) {
    final m = MaterialLocalizations.of(context);
    final end = DateTime(_period.to.year, _period.to.month, _period.to.day - 1);
    return _period.span == ReportSpan.day
        ? m.formatMediumDate(_period.from)
        : '${m.formatMediumDate(_period.from)} – ${m.formatMediumDate(end)}';
  }

  Future<void> _chooseDate({bool range = false}) async {
    if (range) {
      final selected = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1970),
        lastDate: DateTime(2200),
        initialDateRange: DateTimeRange(
          start: _period.from,
          end: DateTime(_period.to.year, _period.to.month, _period.to.day - 1),
        ),
      );
      if (selected != null && mounted) {
        setState(
          () => _period = ReportPeriod(
            span: ReportSpan.custom,
            from: selected.start,
            to: DateTime(
              selected.end.year,
              selected.end.month,
              selected.end.day + 1,
            ),
          ),
        );
      }
    } else {
      final date = await showDatePicker(
        context: context,
        initialDate: _period.from,
        firstDate: DateTime(1970),
        lastDate: DateTime(2200),
      );
      if (date != null && mounted) {
        setState(
          () => _period = ReportPeriod.forSpan(
            _period.span == ReportSpan.custom ? ReportSpan.day : _period.span,
            date,
          ),
        );
      }
    }
  }

  void _preview(PeriodReport report, {ShoppingReport? shopping}) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ReportPreviewScreen(
          document: ReportDocument(
            title: shopping == null
                ? _label(context)
                : shopping.list.title ??
                      shopping.list.generatedTitle ??
                      AppLocalizations.of(context).listsTitle,
            currencyCode: report.currencyCode,
            shopping: shopping == null ? report.shopping : [shopping],
          ),
        ),
      ),
    );
  }

  void _openSpending() => Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => SpendingScreen(db: widget.db, now: widget.now),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final defaultCurrency = AppDefaults.defaultCurrency();
    if (defaultCurrency != _lastDefaultCurrency) {
      if (_followDefaultCurrency) {
        _currency = defaultCurrency;
      }
      _lastDefaultCurrency = defaultCurrency;
    }
    final l = AppLocalizations.of(context);
    final labels = {
      ReportSpan.day: l.spanDay,
      ReportSpan.week: l.spanWeek,
      ReportSpan.month: l.spanMonth,
      ReportSpan.year: l.spanYear,
      ReportSpan.custom: l.spanCustom,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(l.navHistory),
        actions: [
          IconButton(
            tooltip: l.spendingOverview,
            icon: const Icon(Icons.insights_outlined),
            onPressed: _openSpending,
          ),
        ],
      ),
      body: StreamBuilder<List<ShoppingList>>(
        stream: _completed,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text(l.saveFailed));
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final currencies = {
            _currency,
            AppDefaults.defaultCurrency(),
            ...snapshot.data!.map((s) => s.currencyCode),
          }.toList()..sort();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                  spacing: 8,
                  children: [
                    for (final span in ReportSpan.values)
                      ChoiceChip(
                        key: Key('history_span_${span.name}'),
                        avatar: span == ReportSpan.custom
                            ? const Icon(Icons.date_range_outlined, size: 18)
                            : null,
                        label: Text(labels[span]!),
                        selected: _period.span == span,
                        onSelected: (_) {
                          if (span == ReportSpan.custom) {
                            _chooseDate(range: true);
                          } else {
                            setState(
                              () => _period = ReportPeriod.forSpan(
                                span,
                                _period.contains(_now) ? _now : _period.from,
                              ),
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: l.previousPeriodAction,
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () =>
                          setState(() => _period = _period.shift(-1)),
                    ),
                    Expanded(
                      child: OutlinedButton.icon(
                        key: const Key('history_calendar'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(48, 48),
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        onPressed: () => _chooseDate(
                          range: _period.span == ReportSpan.custom,
                        ),
                        icon: const Icon(Icons.calendar_month_outlined),
                        label: Text(
                          _label(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: l.nextPeriodAction,
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () =>
                          setState(() => _period = _period.shift(1)),
                    ),
                    if (!_isDefault)
                      IconButton(
                        key: const Key('history_period_reset'),
                        tooltip: l.historyResetPeriod,
                        icon: const Icon(Icons.restart_alt),
                        onPressed: () =>
                            setState(() => _period = _defaultPeriod),
                      ),
                  ],
                ),
              ),
              if (currencies.length > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButtonFormField<String>(
                    initialValue: _currency,
                    decoration: InputDecoration(labelText: l.currencyLabel),
                    items: [
                      for (final c in currencies)
                        DropdownMenuItem(value: c, child: Text(c)),
                    ],
                    onChanged: (c) {
                      if (c != null) {
                        setState(() {
                          _currency = c;
                          _followDefaultCurrency = false;
                        });
                      }
                    },
                  ),
                ),
              Expanded(
                child: _HistoryPeriodView(
                  key: ValueKey((
                    _period.from,
                    _period.to,
                    _currency,
                    snapshot.data,
                  )),
                  db: widget.db,
                  period: _period,
                  periodLabel: _label(context),
                  currency: _currency,
                  now: _now,
                  view: _view,
                  onView: (v) => setState(() => _view = v),
                  onPreview: _preview,
                  onBudget: _openSpending,
                  bannerController: widget.bannerController,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Export documents for each History view of one period (F30).
ReportDocument historyViewDocument(
  PeriodReport report,
  HistoryView? view,
  String title,
  AppLocalizations l,
) {
  ReportSummary store() => ReportSummary(
    kind: ReportSummaryKind.store,
    groups: groupByStore(report.shopping),
  );
  ReportSummary product() => ReportSummary(
    kind: ReportSummaryKind.product,
    groups: groupByProduct(report.shopping),
  );
  return switch (view) {
    HistoryView.shopping => ReportDocument(
      title: '${l.historyViewShopping} · $title',
      currencyCode: report.currencyCode,
      shopping: report.shopping,
    ),
    HistoryView.store => ReportDocument(
      title: '${l.historyViewStore} · $title',
      currencyCode: report.currencyCode,
      shopping: report.shopping,
      summaries: [store()],
      showShopping: false,
    ),
    HistoryView.product => ReportDocument(
      title: '${l.historyViewProduct} · $title',
      currencyCode: report.currencyCode,
      shopping: report.shopping,
      summaries: [product()],
      showShopping: false,
    ),
    // Everything together: each shopping, then by store and by product.
    null => ReportDocument(
      title: title,
      currencyCode: report.currencyCode,
      shopping: report.shopping,
      summaries: [store(), product()],
    ),
  };
}

class _HistoryPeriodView extends StatefulWidget {
  const _HistoryPeriodView({
    super.key,
    required this.db,
    required this.period,
    required this.periodLabel,
    required this.currency,
    required this.now,
    required this.view,
    required this.onView,
    required this.onPreview,
    required this.onBudget,
    this.bannerController,
  });
  final AppDatabase db;
  final ReportPeriod period;
  final String periodLabel;
  final String currency;
  final DateTime now;
  final HistoryView view;
  final ValueChanged<HistoryView> onView;
  final void Function(PeriodReport, {ShoppingReport? shopping}) onPreview;
  final VoidCallback onBudget;
  final BannerAdController? bannerController;
  @override
  State<_HistoryPeriodView> createState() => _HistoryPeriodViewState();
}

class _HistoryPeriodViewState extends State<_HistoryPeriodView> {
  late Future<PeriodReport> _data = ReportRepository(widget.db)
      .period(widget.period, widget.currency);

  String _title(ShoppingReport s, AppLocalizations l) =>
      s.list.title ?? s.list.generatedTitle ?? l.listsTitle;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = ReportText(l, formatLocaleCode(context), widget.currency);
    return FutureBuilder<PeriodReport>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l.saveFailed),
                TextButton(
                  onPressed: () => setState(() {
                    _data = ReportRepository(widget.db)
                        .period(widget.period, widget.currency);
                  }),
                  child: Text(l.retryAction),
                ),
              ],
            ),
          );
        }
        if (snapshot.connectionState != ConnectionState.done ||
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final report = snapshot.data!;
        final periodLimit = switch (widget.period.span) {
          ReportSpan.week => AppDefaults.weeklyLimitMinor(
            currencyCode: widget.currency,
            week: widget.period.from,
          ),
          ReportSpan.month => AppDefaults.monthlyLimitMinor(
            currencyCode: widget.currency,
            month: widget.period.from,
          ),
          _ => null,
        };
        final periodOver =
            periodLimit != null &&
                report.spent.known &&
                !report.spent.unknown &&
                report.spent.minor > periodLimit
            ? report.spent.minor - periodLimit
            : null;
        final viewLabels = {
          HistoryView.shopping: (l.historyViewShopping, Icons.receipt_long),
          HistoryView.store: (l.historyViewStore, Icons.storefront_outlined),
          HistoryView.product: (
            l.historyViewProduct,
            Icons.shopping_basket_outlined,
          ),
        };
        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            HistoryBudgetCard(
              db: widget.db,
              currencyCode: widget.currency,
              now: widget.now,
              money: text.money,
              onEdit: widget.onBudget,
            ),
            Card(
              key: const Key('history_period_total'),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.reportTotalSpent),
                    Text(
                      report.spent.display(text.money),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text('${l.listsTabCompleted}: ${report.shopping.length}'),
                    if (periodOver != null)
                      Text(
                        l.monthlyLimitOver(text.money(periodOver)),
                        key: const Key('history_period_over_limit'),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (widget.bannerController != null)
              Padding(
                key: const Key('history_sparse_banner'),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: BannerAdWidget(controller: widget.bannerController!),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final view in HistoryView.values)
                    ChoiceChip(
                      key: Key('history_view_${view.name}'),
                      avatar: Icon(viewLabels[view]!.$2, size: 18),
                      label: Text(viewLabels[view]!.$1),
                      selected: widget.view == view,
                      onSelected: (_) => widget.onView(view),
                    ),
                ],
              ),
            ),
            if (report.shopping.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (widget.view == HistoryView.shopping)
                      OutlinedButton.icon(
                        key: const Key('history_period_report'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(48, 48),
                        ),
                        onPressed: () => widget.onPreview(report),
                        icon: const Icon(Icons.preview_outlined),
                        label: Text(l.reportPreview),
                      ),
                    ReportShareButton(
                      key: const Key('history_share_view'),
                      document: () async => historyViewDocument(
                        report,
                        widget.view,
                        widget.periodLabel,
                        l,
                      ),
                    ),
                    ReportShareButton(
                      key: const Key('history_share_all'),
                      label: l.historyShareAll,
                      document: () async => historyViewDocument(
                        report,
                        null,
                        widget.periodLabel,
                        l,
                      ),
                    ),
                  ],
                ),
              ),
            if (report.shopping.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l.historyEmpty),
              )
            else
              ...switch (widget.view) {
                HistoryView.shopping => _shopping(context, report, text),
                HistoryView.store => _stores(context, report, text),
                HistoryView.product => _products(context, report, text),
              },
          ],
        );
      },
    );
  }

  String _day(BuildContext context, DateTime day) =>
      MaterialLocalizations.of(context).formatShortMonthDay(day);

  Widget _chart(
    Key key,
    String title,
    List<(String, SpendAmount)> bars,
    ReportText text,
  ) => ValueBarChartCard(
    key: key,
    title: title,
    bars: [
      for (final (label, s) in bars) (label, DecimalFixed.fromInt(s.minor)),
    ],
    valueLabels: [for (final (_, s) in bars) s.display(text.money)],
    valueText: (v) => text.money(v.toMinorUnits(0)),
  );

  List<Widget> _shopping(
    BuildContext context,
    PeriodReport report,
    ReportText text,
  ) {
    final l = AppLocalizations.of(context);
    final daily = widget.period.span != ReportSpan.day;
    return [
      // Daily totals over the period; within one day, one bar per shopping.
      _chart(
        const Key('history_shopping_chart'),
        daily ? l.historyDailySpending : l.historyViewShopping,
        daily
            ? [
                for (final d in spendByDay(report.shopping))
                  (_day(context, d.day), d.spent),
              ]
            : [for (final s in report.shopping) (_title(s, l), s.spent)],
        text,
      ),
      for (final shopping in report.shopping)
        Card(
          child: ListTile(
            key: Key('history_list_${shopping.list.id}'),
            minTileHeight: 56,
            title: Text(_title(shopping, l)),
            subtitle: Text(
              [
                text.date(shopping.list.completedAt),
                shopping.spent.display(text.money),
                if (shopping.list.budgetMinorUnits != null &&
                    shopping.spent.known &&
                    !shopping.spent.unknown &&
                    shopping.spent.minor > shopping.list.budgetMinorUnits!)
                  l.monthlyLimitOver(
                    text.money(
                      shopping.spent.minor - shopping.list.budgetMinorUnits!,
                    ),
                  ),
              ].join('\n'),
            ),
            isThreeLine: true,
            trailing: ReportShareButton(
              key: Key('history_share_list_${shopping.list.id}'),
              iconOnly: true,
              document: () async => ReportDocument(
                title: _title(shopping, l),
                currencyCode: report.currencyCode,
                shopping: [shopping],
              ),
            ),
            onTap: () => widget.onPreview(report, shopping: shopping),
          ),
        ),
    ];
  }

  List<Widget> _stores(
    BuildContext context,
    PeriodReport report,
    ReportText text,
  ) {
    final l = AppLocalizations.of(context);
    final groups = groupByStore(report.shopping);
    return [
      _chart(const Key('history_store_chart'), l.historyViewStore, [
        for (final g in groups) (text.groupLabel(g), g.spent),
      ], text),
      for (final (i, g) in groups.indexed)
        Card(
          child: ListTile(
            key: Key('history_store_$i'),
            minTileHeight: 56,
            leading: const Icon(Icons.storefront_outlined),
            title: Text(text.groupLabel(g)),
            subtitle: Text(
              '${g.spent.display(text.money)}\n${l.purchaseVisits}: ${g.count}',
            ),
            isThreeLine: true,
          ),
        ),
    ];
  }

  List<Widget> _products(
    BuildContext context,
    PeriodReport report,
    ReportText text,
  ) {
    final l = AppLocalizations.of(context);
    final groups = groupByProduct(report.shopping);
    final daily = widget.period.span != ReportSpan.day;
    return [
      _chart(const Key('history_product_chart'), l.historyViewProduct, [
        for (final g in groups.take(10)) (text.groupLabel(g), g.spent),
      ], text),
      if (groups.isEmpty)
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(l.noPurchasesNote),
        ),
      for (final (i, g) in groups.indexed)
        Card(
          child: ExpansionTile(
            key: Key('history_product_$i'),
            title: Text(text.groupLabel(g)),
            subtitle: Text(
              [
                '${l.purchasedQuantity}: ${text.groupQuantity(g)}',
                g.spent.display(text.money),
                '${l.purchaseVisits}: ${g.count}',
              ].join('\n'),
            ),
            childrenPadding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 4),
            children: [
              if (daily)
                _chart(
                  Key('history_product_chart_$i'),
                  l.historyDailySpending,
                  [for (final d in g.byDay) (_day(context, d.day), d.spent)],
                  text,
                ),
            ],
          ),
        ),
    ];
  }
}
