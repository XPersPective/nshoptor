import '../../../core/money/format_locale.dart';

import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/quantity/unit_code.dart';
import '../../../core/quantity/unit_display.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/money.dart';

import 'package:drift/drift.dart' show OrderingTerm, Constant;

import '../../../data/db/app_database.dart';
import 'price_history_repository.dart';

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
      body: FutureBuilder<List<PriceObservation>>(
        future: _load(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text(l10n.saveFailed));
          final rows = snapshot.data;
          if (rows == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (rows.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.noObservations),
              ),
            );
          }
          return FutureBuilder<List<NormalizedPricePoint>>(
            future: _normalized(),
            builder: (context, normalizedSnapshot) {
              final points =
                  normalizedSnapshot.data ?? const <NormalizedPricePoint>[];
              final normalizedById = {
                for (final point in points) point.observation.id: point,
              };
              return SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (points.isNotEmpty) ...[
                      _PriceChart(points: points),
                      const SizedBox(height: 12),
                    ] else
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(l10n.purchaseAnalyticsHint),
                        ),
                      ),
                    for (final r in rows)
                      _ObservationCard(row: r, point: normalizedById[r.id]),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<PriceObservation>> _load() =>
      (db.select(db.priceObservations)
            ..where((t) => t.productId.equals(productId))
            ..where(
              (t) => currencyCode == null
                  ? const Constant(true)
                  : t.currencyCode.equals(currencyCode!),
            )
            ..where(
              (t) => unitCode == null
                  ? const Constant(true)
                  : t.unitCode.isIn([
                      unitCode!,
                      ...UnitCode.values
                          .where((u) => u.dbCode == unitCode)
                          .map((u) => u.name),
                    ]),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.observedAt)]))
          .get();

  Future<List<NormalizedPricePoint>> _normalized() {
    final normalizedUnit = _baseUnitCode(unitCode);
    return PriceHistoryRepository(db).normalizedHistory(
      productId,
      currencyCode: currencyCode,
      unitCode: normalizedUnit,
    );
  }

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
        .formatMediumDate(row.observedAt);
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

class _PriceChart extends StatelessWidget {
  const _PriceChart({required this.points});

  final List<NormalizedPricePoint> points;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(points.first.observation.currencyCode);
    final values = [
      for (final point in points)
        point.unitPrice.toMinorUnits(currency.minorUnitDigits),
    ];
    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    final unit = unitDisplayNameFromDb(points.first.unitCode, l10n);
    final summary = '${l10n.priceHistoryTitle}: ${values.length} · $unit';
    return Card(
      key: const Key('price_history_chart'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Semantics(
          container: true,
          label: '$summary · $min–$max',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(summary, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                width: double.infinity,
                child: CustomPaint(
                  painter: _PriceChartPainter(
                    values: values,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Text(
                '$min–$max · $unit',
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
  const _PriceChartPainter({required this.values, required this.color});

  final List<int> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    final span = (max - min).toDouble();
    final line = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final fill = Paint()..color = color.withValues(alpha: .14);
    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = values.length == 1
          ? size.width / 2
          : size.width * i / (values.length - 1);
      final y = span == 0
          ? size.height / 2
          : size.height - (values[i] - min) / span * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final area = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(area, fill);
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant _PriceChartPainter oldDelegate) =>
      oldDelegate.values != values || oldDelegate.color != color;
}
