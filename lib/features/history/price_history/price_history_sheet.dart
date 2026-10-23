import '../../../core/money/format_locale.dart';

import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/quantity/unit_code.dart';
import '../../../core/quantity/unit_display.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/money.dart';

import '../../../data/db/app_database.dart';
import 'price_history_repository.dart';

typedef _PriceHistoryData = ({
  List<PriceObservation> rows,
  List<NormalizedPricePoint> actual,
  List<EstimatedPricePoint> estimated,
});

/// Fiyat geçmişi ekranı (spec §6.10): son gözlemlerin listesi ve özet.
/// Parasal değerler birim fiyatın minor unit'idir; hiçbir yerde `double` yok.
class PriceHistoryScreen extends StatelessWidget {
  const PriceHistoryScreen({
    super.key,
    required this.db,
    required this.productId,
    this.productName,
    this.currencyCode,
    this.unitCode,
  });

  final AppDatabase db;
  final int productId;
  final String? productName;
  final String? currencyCode;
  final String? unitCode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(productName ?? l10n.priceHistoryTitle)),
      body: FutureBuilder<_PriceHistoryData>(
        future: _loadData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text(l10n.saveFailed));
          final data = snapshot.data;
          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (data.rows.isEmpty && data.estimated.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.noObservations),
              ),
            );
          }
          final groups =
              <
                (String, String),
                ({
                  List<NormalizedPricePoint> actual,
                  List<EstimatedPricePoint> estimated,
                })
              >{};
          for (final point in data.actual) {
            (groups[(point.observation.currencyCode, point.unitCode)] ??= (
              actual: [],
              estimated: [],
            )).actual.add(point);
          }
          for (final point in data.estimated) {
            (groups[(point.currencyCode, point.unitCode)] ??= (
              actual: [],
              estimated: [],
            )).estimated.add(point);
          }
          final normalizedById = {
            for (final point in data.actual) point.observation.id: point,
          };
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (i, group) in groups.entries.indexed) ...[
                  _PriceChart(
                    points: group.value.actual,
                    estimates: group.value.estimated,
                    chartId: i == 0
                        ? 'price_history_chart'
                        : 'price_history_chart_${group.key.$1}_${group.key.$2}',
                  ),
                  const SizedBox(height: 12),
                ],
                if (groups.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(l10n.purchaseAnalyticsHint),
                    ),
                  ),
                for (final row in data.rows)
                  _ObservationCard(row: row, point: normalizedById[row.id]),
                for (final point in data.estimated.reversed)
                  _EstimatedCard(point: point),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<_PriceHistoryData> _loadData() => db.transaction(() async {
    final repo = PriceHistoryRepository(db);
    final baseUnit = _baseUnitCode(unitCode);
    final rows = (await repo.history(productId))
        .where(
          (row) =>
              (currencyCode == null || row.currencyCode == currencyCode) &&
              (baseUnit == null || _baseUnitCode(row.unitCode) == baseUnit),
        )
        .toList();
    final actual = await repo.normalizedHistory(
      productId,
      currencyCode: currencyCode,
      unitCode: baseUnit,
    );
    final estimated = await repo.estimatedHistory(
      productId,
      currencyCode: currencyCode,
      unitCode: baseUnit,
    );
    return (rows: rows, actual: actual, estimated: estimated);
  });

  String? _baseUnitCode(String? code) {
    if (code == null) return null;
    final unit = UnitCode.values
        .where(
          (candidate) => candidate.dbCode == code || candidate.name == code,
        )
        .firstOrNull;
    return switch (unit?.dimension) {
      UnitDimension.mass => UnitCode.kilogram.dbCode,
      UnitDimension.volume => UnitCode.litre.dbCode,
      UnitDimension.count => UnitCode.adet.dbCode,
      UnitDimension.length => UnitCode.metre.dbCode,
      _ => code,
    };
  }
}

class _ObservationCard extends StatelessWidget {
  const _ObservationCard({required this.row, this.point});

  final PriceObservation row;
  final NormalizedPricePoint? point;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final displayPrice = point?.unitPrice ?? DecimalFixed.parse(row.unitPrice);
    final minor = displayPrice.toMinorUnits(
      Currency.fromCode(row.currencyCode).minorUnitDigits,
    );
    final money = formatMoney(
      Money.fromMinorUnits(minor, Currency.fromCode(row.currencyCode)),
      locale: formatLocaleCode(context),
    );
    final date = MaterialLocalizations.of(context)
        .formatMediumDate(row.observedAt.toLocal());
    return Card(
      key: Key('price_obs_${row.id}'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(money, style: Theme.of(context).textTheme.titleMedium),
            Text(unitDisplayNameFromDb(point?.unitCode ?? row.unitCode, l10n)),
            Text(date, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _EstimatedCard extends StatelessWidget {
  const _EstimatedCard({required this.point});
  final EstimatedPricePoint point;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(point.currencyCode);
    final money = formatMoney(
      Money.fromMinorUnits(
        point.unitPrice.toMinorUnits(currency.minorUnitDigits),
        currency,
      ),
      locale: formatLocaleCode(context),
    );
    return Card(
      key: Key('price_estimate_${point.item.id}'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.compareEstimated}: $money',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(unitDisplayNameFromDb(point.unitCode, l10n)),
            Text(
              MaterialLocalizations.of(context)
                  .formatMediumDate(point.at.toLocal()),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceChart extends StatelessWidget {
  const _PriceChart({
    required this.points,
    required this.estimates,
    required this.chartId,
  });
  final List<NormalizedPricePoint> points;
  final List<EstimatedPricePoint> estimates;
  final String chartId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(
      points.firstOrNull?.observation.currencyCode ??
          estimates.first.currencyCode,
    );
    final actual = [
      for (final point in points)
        (
          at: point.observation.observedAt,
          minor: point.unitPrice.toMinorUnits(currency.minorUnitDigits),
        ),
    ];
    final estimated = [
      for (final point in estimates)
        (
          at: point.at,
          minor: point.unitPrice.toMinorUnits(currency.minorUnitDigits),
        ),
    ];
    final values = [
      for (final p in [...actual, ...estimated]) p.minor,
    ];
    final min = values.reduce((a, b) => a < b ? a : b),
        max = values.reduce((a, b) => a > b ? a : b);
    String money(int value) => formatMoney(
      Money.fromMinorUnits(value, currency),
      locale: formatLocaleCode(context),
    );
    final range = min == max ? money(min) : '${money(min)}–${money(max)}';
    final unit = unitDisplayNameFromDb(
      points.firstOrNull?.unitCode ?? estimates.first.unitCode,
      l10n,
    );
    final summary =
        '${l10n.priceHistoryTitle}: ${l10n.compareActual} ${actual.length} · ${l10n.compareEstimated} ${estimated.length} · $unit';
    final dates = [...actual, ...estimated].map((p) => p.at.toLocal()).toList()
      ..sort();
    final material = MaterialLocalizations.of(context);
    final dateRange = DateUtils.isSameDay(dates.first, dates.last)
        ? material.formatMediumDate(dates.first)
        : '${material.formatMediumDate(dates.first)} – ${material.formatMediumDate(dates.last)}';
    final scheme = Theme.of(context).colorScheme;
    return Card(
      key: Key(chartId),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Semantics(
          container: true,
          label: '$summary · $range · $dateRange',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(summary, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  if (actual.isNotEmpty)
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.circle,
                              size: 12,
                              color: scheme.primary,
                            ),
                          ),
                          TextSpan(text: ' ${l10n.compareActual}'),
                        ],
                      ),
                      style: TextStyle(color: scheme.primary),
                    ),
                  if (estimated.isNotEmpty)
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.radio_button_unchecked,
                              size: 12,
                              color: scheme.secondary,
                            ),
                          ),
                          TextSpan(text: ' ${l10n.compareEstimated}'),
                        ],
                      ),
                      style: TextStyle(color: scheme.secondary),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                width: double.infinity,
                child: CustomPaint(
                  painter: _PriceChartPainter(
                    actual: actual,
                    estimated: estimated,
                    actualColor: scheme.primary,
                    estimatedColor: scheme.secondary,
                  ),
                ),
              ),
              Text(dateRange, style: Theme.of(context).textTheme.bodySmall),
              Text(
                '$range · $unit',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceChartPainter extends CustomPainter {
  const _PriceChartPainter({
    required this.actual,
    required this.estimated,
    required this.actualColor,
    required this.estimatedColor,
  });
  final List<({DateTime at, int minor})> actual, estimated;
  final Color actualColor, estimatedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final all = [...actual, ...estimated];
    if (all.isEmpty) return;
    final min = all.map((p) => p.minor).reduce((a, b) => a < b ? a : b);
    final max = all.map((p) => p.minor).reduce((a, b) => a > b ? a : b);
    final first = all
        .map((p) => p.at.millisecondsSinceEpoch)
        .reduce((a, b) => a < b ? a : b);
    final last = all
        .map((p) => p.at.millisecondsSinceEpoch)
        .reduce((a, b) => a > b ? a : b);
    Offset position(({DateTime at, int minor}) p) => Offset(
      first == last
          ? size.width / 2
          : 4 +
                (p.at.millisecondsSinceEpoch - first) /
                    (last - first) *
                    (size.width - 8),
      min == max
          ? size.height / 2
          : 4 + (max - p.minor) / (max - min) * (size.height - 8),
    );
    void draw(
      List<({DateTime at, int minor})> series,
      Color color,
      bool dotted,
    ) {
      if (series.isEmpty) return;
      final paint = Paint()
        ..color = color
        ..strokeWidth = dotted ? 2 : 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      final path = Path();
      for (var i = 0; i < series.length; i++) {
        final p = position(series[i]);
        if (i == 0) {
          path.moveTo(p.dx, p.dy);
        } else {
          path.lineTo(p.dx, p.dy);
        }
        canvas.drawCircle(
          p,
          dotted ? 4 : 3,
          Paint()
            ..color = color
            ..style = dotted ? PaintingStyle.stroke : PaintingStyle.fill
            ..strokeWidth = 2,
        );
      }
      canvas.drawPath(path, paint);
    }

    draw(estimated, estimatedColor, true);
    draw(actual, actualColor, false);
  }

  @override
  bool shouldRepaint(covariant _PriceChartPainter oldDelegate) =>
      oldDelegate.actual != actual ||
      oldDelegate.estimated != estimated ||
      oldDelegate.actualColor != actualColor ||
      oldDelegate.estimatedColor != estimatedColor;
}
