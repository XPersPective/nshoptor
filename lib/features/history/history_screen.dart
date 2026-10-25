import 'package:flutter/material.dart';

import '../../app/app_defaults.dart';
import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/format_locale.dart';
import '../../data/db/app_database.dart';
import 'insights/insights_repository.dart';
import 'insights/spending_screen.dart';
import 'reports/report_document.dart';
import 'reports/report_period.dart';
import 'reports/report_preview_screen.dart';
import 'reports/report_repository.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, required this.db, this.now});
  final AppDatabase db;
  final DateTime? now;
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late ReportPeriod _period = ReportPeriod.forSpan(
    ReportSpan.week,
    widget.now ?? DateTime.now(),
  );
  late final _completed = InsightsRepository(widget.db).watchCompleted();
  String _currency = AppDefaults.defaultCurrency();
  String _lastDefaultCurrency = AppDefaults.defaultCurrency();
  bool _followDefaultCurrency = true;

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
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => SpendingScreen(db: widget.db, now: widget.now),
              ),
            ),
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
                        label: Text(labels[span]!),
                        selected: _period.span == span,
                        onSelected: (_) {
                          if (span == ReportSpan.custom) {
                            _chooseDate(range: true);
                          } else {
                            setState(
                              () => _period = ReportPeriod.forSpan(
                                span,
                                _period.contains(widget.now ?? DateTime.now())
                                    ? widget.now ?? DateTime.now()
                                    : _period.from,
                              ),
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: l.previousPeriodAction,
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () =>
                        setState(() => _period = _period.shift(-1)),
                  ),
                  Expanded(
                    child: TextButton(
                      key: const Key('history_calendar'),
                      onPressed: () =>
                          _chooseDate(range: _period.span == ReportSpan.custom),
                      child: Text(_label(context), textAlign: TextAlign.center),
                    ),
                  ),
                  IconButton(
                    tooltip: l.nextPeriodAction,
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => setState(() => _period = _period.shift(1)),
                  ),
                ],
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
                  currency: _currency,
                  onPreview: _preview,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HistoryPeriodView extends StatefulWidget {
  const _HistoryPeriodView({
    super.key,
    required this.db,
    required this.period,
    required this.currency,
    required this.onPreview,
  });
  final AppDatabase db;
  final ReportPeriod period;
  final String currency;
  final void Function(PeriodReport, {ShoppingReport? shopping}) onPreview;
  @override
  State<_HistoryPeriodView> createState() => _HistoryPeriodViewState();
}

class _HistoryPeriodViewState extends State<_HistoryPeriodView> {
  late Future<PeriodReport> _data = ReportRepository(widget.db)
      .period(widget.period, widget.currency);
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
        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
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
                  ],
                ),
              ),
            ),
            if (report.shopping.isNotEmpty)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: OutlinedButton.icon(
                  key: const Key('history_period_report'),
                  onPressed: () => widget.onPreview(report),
                  icon: const Icon(Icons.preview_outlined),
                  label: Text(l.reportPreview),
                ),
              ),
            if (report.shopping.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l.historyEmpty),
              ),
            for (final shopping in report.shopping)
              Card(
                child: ListTile(
                  key: Key('history_list_${shopping.list.id}'),
                  title: Text(
                    shopping.list.title ??
                        shopping.list.generatedTitle ??
                        l.listsTitle,
                  ),
                  subtitle: Text(
                    '${text.date(shopping.list.completedAt)}\n${shopping.spent.display(text.money)}',
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => widget.onPreview(report, shopping: shopping),
                ),
              ),
          ],
        );
      },
    );
  }
}
