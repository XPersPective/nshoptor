import 'package:flutter/material.dart';

import '../../app/app_defaults.dart';
import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/format_locale.dart';
import '../../core/money/money.dart';
import '../../core/money/money_format.dart';
import '../../core/quantity/unit_display.dart';
import '../../data/db/app_database.dart';
import '../lists/list_detail_screen.dart';
import '../lists/list_repository.dart';
import 'insights/insights_repository.dart';
import 'insights/monthly_report.dart';
import 'insights/spending_screen.dart';
import 'product_history_screen.dart';

typedef _Period = ({String label, DateTime from, DateTime to, bool month});

/// Geçmiş sekmesi: üstte kaydırılan dönemler (bu hafta, bu ay, önceki aylar),
/// açılır takvim, dönemde alınan ürünler ve tamamlanan alışverişler.
/// Varsayılan para biriminde; diğer para birimleri karışmaz.
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, required this.db, this.now});

  final AppDatabase db;

  /// Testlerde sabit "bugün".
  final DateTime? now;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  static const _months = 12;

  // The tab lives in an IndexedStack: refresh when a list is completed.
  late final Stream<List<ShoppingList>> _completed = InsightsRepository(
    widget.db,
  ).watchCompleted();

  List<_Period> _periods(BuildContext context, DateTime today) {
    final ml = MaterialLocalizations.of(context);
    final day = DateTime(today.year, today.month, today.day);
    final monday = DateTime(day.year, day.month, day.day - (day.weekday - 1));
    return [
      (
        label: ml.currentDateLabel,
        from: day,
        to: DateTime(day.year, day.month, day.day + 1),
        month: false,
      ),
      (
        label: AppLocalizations.of(context).historyThisWeek,
        from: monday,
        to: DateTime(monday.year, monday.month, monday.day + 7),
        month: false,
      ),
      for (var m = 0; m < _months; m++)
        (
          label: ml.formatMonthYear(DateTime(today.year, today.month - m)),
          from: DateTime(today.year, today.month - m),
          to: DateTime(today.year, today.month - m + 1),
          month: true,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final db = widget.db;
    final now = widget.now ?? DateTime.now();
    final day = DateTime(now.year, now.month, now.day);
    final periods = _periods(context, now);
    return DefaultTabController(
      length: periods.length + 1,
      initialIndex: 0, // genel bakış
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.navHistory),
          bottom: TabBar(
            key: const Key('history_periods'),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(key: const Key('history_overview_tab'), text: l10n.spendingOverview),
              for (final (i, p) in periods.indexed)
                Tab(key: i == 0 ? const Key('history_today_tab') : Key('history_period_tab_${i - 1}'), text: p.label),
            ],
          ),
        ),
        body: StreamBuilder<List<ShoppingList>>(
          stream: _completed,
          builder: (context, snap) {
            // The query emits a fresh list for price/receipt changes too.
            // Hashing only list IDs/dates left those snapshots stale.
            final version = snap.data;
            return TabBarView(
              children: [
                // İlk bakışta genel görünüm: harcama özeti, limitler, grafikler.
                SpendingScreen(key: ValueKey((version, AppDefaults.defaultCurrency(), day)), db: db, now: now, embedded: true),
                for (final p in periods)
                  _PeriodView(
                    key: ValueKey(Object.hash(p.from, p.to, version, AppDefaults.defaultCurrency())),
                    db: db,
                    period: p,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PeriodView extends StatefulWidget {
  const _PeriodView({super.key, required this.db, required this.period});

  final AppDatabase db;
  final _Period period;

  @override
  State<_PeriodView> createState() => _PeriodViewState();
}

class _PeriodViewState extends State<_PeriodView>
    with AutomaticKeepAliveClientMixin {
  bool _reportBusy = false;
  late final String _currency = AppDefaults.defaultCurrency();
  late final _data = widget.db.transaction(() async {
    final repo = InsightsRepository(widget.db);
    final from = widget.period.from.toUtc(), to = widget.period.to.toUtc();
    final points = (await repo.completedSpend(_currency))
        .where((p) => !p.at.isBefore(from) && p.at.isBefore(to))
        .toList();
    final products = await repo.purchaseStats(_currency, from: from, to: to);
    final lists = await (widget.db.select(widget.db.shoppingLists)
          ..where((t) => t.id.isIn([for (final p in points) p.listId])))
        .get();
    lists.sort((a, b) => b.completedAt!.compareTo(a.completedAt!));
    return (points: points, products: products, lists: lists);
  });

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(_currency);
    String money(int minor) => formatMoney(
      Money.fromMinorUnits(minor, currency),
      locale: formatLocaleCode(context),
    );
    return FutureBuilder(
      future: _data,
      builder: (context, snap) {
        if (snap.hasError) return Center(child: Text(l10n.saveFailed));
        final data = snap.data;
        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final total = SpendMath.amount(data.points, widget.period.from, widget.period.to);
        final month = widget.period.from;
        final ml = MaterialLocalizations.of(context);
        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Card(
              key: const Key('history_period_total'),
              child: ListTile(
                title: Text(
                  total.display(money),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                subtitle: Text(
                  '${l10n.listsTabCompleted}: ${data.points.length}',
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: OutlinedButton.icon(
                key: const Key('history_period_report'),
                onPressed: _reportBusy ? null : () async {
                  setState(() => _reportBusy = true);
                  await showPeriodReport(context, widget.db,
                    widget.period.from, widget.period.to, _currency,
                    periodLabel: widget.period.label);
                  if (mounted) setState(() => _reportBusy = false);
                },
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: Text(l10n.reportPdfAction),
              ),
            ),
            Card(
              child: ExpansionTile(
                key: const Key('history_calendar'),
                leading: const Icon(Icons.calendar_month_outlined),
                title: Text(ml.formatMonthYear(month)),
                childrenPadding: const EdgeInsets.all(8),
                children: [
                  MonthCalendar(
                    month: DateTime(month.year, month.month),
                    spendByDay: SpendMath.byDay(
                      data.points,
                      month.year,
                      month.month,
                    ),
                    money: money,
                    amounts: SpendMath.amountsByDay(data.points, month.year, month.month),
                  ),
                ],
              ),
            ),
            _Section(l10n.historyProductsSection),
            if (data.products.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(l10n.noPurchasesNote),
              ),
            for (final p in data.products)
              Card(
                child: ListTile(
                  key: Key('history_product_${p.normalizedName}'),
                  leading: const Icon(Icons.shopping_basket_outlined),
                  title: Text(p.name),
                  subtitle: Text(
                    '${p.quantity.toDbString()} ${unitDisplayNameFromDb(p.unitCode, l10n)}'
                    ' · ${p.visits.length}×',
                  ),
                  trailing: Text(
                    p.amount.display(money),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  onTap: p.normalizedName == null
                      ? null
                      : () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => ProductHistoryScreen(
                              db: widget.db,
                              name: p.name,
                              normalizedName: p.normalizedName!,
                              currencyCode: _currency,
                              productId: p.productId,
                              unitCode: p.unitCode,
                            ),
                          ),
                        ),
                ),
              ),
            _Section(l10n.listsTabCompleted),
            if (data.lists.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(l10n.historyEmpty),
              ),
            for (final list in data.lists)
              ListTile(
                key: Key('history_list_${list.id}'),
                leading: const Icon(Icons.check_circle_outline),
                title: Text(
                  list.title ?? list.generatedTitle ?? l10n.listsTitle,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  list.completedAt == null
                      ? ''
                      : ml.formatMediumDate(list.completedAt!.toLocal()),
                ),
                trailing: Text(
                  SpendMath.amount(data.points.where((p) => p.listId == list.id),
                    widget.period.from, widget.period.to).display(money),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => ListDetailScreen(
                      db: widget.db,
                      listRepository: ListRepository(widget.db),
                      listId: list.id,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
    child: Text(label, style: Theme.of(context).textTheme.titleMedium),
  );
}
