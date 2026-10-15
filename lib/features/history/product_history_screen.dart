import 'package:flutter/material.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../core/money/currency.dart';
import '../../core/money/decimal_fixed.dart';
import '../../core/money/format_locale.dart';
import '../../core/money/money.dart';
import '../../core/money/money_format.dart';
import '../../core/quantity/unit_display.dart';
import '../../data/db/app_database.dart';
import 'insights/insights_repository.dart';
import 'price_history/price_history_sheet.dart';

/// Bir ürünün alım geçmişi: Evdeki ve Çarşıdaki birim fiyat çizgisi, her
/// alışverişte ödenen tutar. Tek para biriminde (karışık para toplanmaz).
class ProductHistoryScreen extends StatelessWidget {
  const ProductHistoryScreen({
    super.key,
    required this.db,
    required this.name,
    required this.normalizedName,
    required this.currencyCode,
    this.productId,
    this.unitCode,
  });

  final AppDatabase db;
  final String name;
  final String normalizedName;
  final String currencyCode;
  final int? productId;
  final String? unitCode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = Currency.fromCode(currencyCode);
    String money(DecimalFixed? value) => value == null
        ? '—'
        : formatMoney(
            Money.fromMinorUnits(
              value.toMinorUnits(currency.minorUnitDigits),
              currency,
            ),
            locale: formatLocaleCode(context),
          );
    String paid(int minor) => formatMoney(
      Money.fromMinorUnits(minor, currency),
      locale: formatLocaleCode(context),
    );
    final ml = MaterialLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: FutureBuilder<List<ProductPurchase>>(
        future: InsightsRepository(
          db,
        ).productPurchases(normalizedName, currencyCode),
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text(l10n.saveFailed));
          final rows = snap.data;
          if (rows == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (rows.isEmpty) {
            return Center(child: Text(l10n.noPurchasesNote));
          }
          final total = rows.fold<int>(0, (s, r) => s + r.paidMinor);
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                key: const Key('product_history_chart'),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${l10n.actualTotalLabel}: ${paid(total)}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      _TwoLineChart(rows: rows.reversed.toList()),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 16,
                        children: [
                          _Legend(
                            color: Theme.of(context).colorScheme.outline,
                            label: l10n.compareEstimated,
                          ),
                          _Legend(
                            color: Theme.of(context).colorScheme.primary,
                            label: l10n.compareActual,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              for (final r in rows)
                Card(
                  child: ListTile(
                    // Paid amount stays in the text flow: no fixed trailing
                    // column to overflow at large text sizes.
                    title: Text(
                      '${ml.formatMediumDate(r.at.toLocal())} · ${paid(r.paidMinor)}',
                    ),
                    subtitle: Text(
                      '${r.quantity.toDbString()} ${unitDisplayNameFromDb(r.unitCode, l10n)}\n'
                      '${l10n.compareEstimated}: ${money(r.plannedUnitPrice)}'
                      ' · ${l10n.compareActual}: ${money(r.actualUnitPrice)}'
                      ' / ${unitDisplayNameFromDb(r.unitCode, l10n)}',
                    ),
                  ),
                ),
              if (productId != null)
                TextButton.icon(
                  key: const Key('product_price_history'),
                  icon: const Icon(Icons.show_chart),
                  label: Text(l10n.priceHistoryAction),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => PriceHistoryScreen(
                        db: db,
                        productId: productId!,
                        productName: name,
                        currencyCode: currencyCode,
                        unitCode: unitCode,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 16, height: 3, color: color),
      const SizedBox(width: 6),
      Flexible(
        child: Text(label, style: Theme.of(context).textTheme.bodySmall),
      ),
    ],
  );
}

/// Evdeki (kesikli renk) ve Çarşıdaki birim fiyat, eskiden yeniye.
class _TwoLineChart extends StatelessWidget {
  const _TwoLineChart({required this.rows});
  final List<ProductPurchase> rows;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // ponytail: minor-unit ints are exact enough for drawing; labels stay authoritative.
    int? minor(DecimalFixed? v) => v?.toMinorUnits(6);
    return Semantics(
      label: AppLocalizations.of(context).priceHistoryTitle,
      child: SizedBox(
        height: 140,
        width: double.infinity,
        child: CustomPaint(
          painter: _LinesPainter(
            planned: [for (final r in rows) minor(r.plannedUnitPrice)],
            actual: [for (final r in rows) minor(r.actualUnitPrice)],
            plannedColor: scheme.outline,
            actualColor: scheme.primary,
          ),
        ),
      ),
    );
  }
}

class _LinesPainter extends CustomPainter {
  const _LinesPainter({
    required this.planned,
    required this.actual,
    required this.plannedColor,
    required this.actualColor,
  });

  final List<int?> planned;
  final List<int?> actual;
  final Color plannedColor;
  final Color actualColor;

  @override
  void paint(Canvas canvas, Size size) {
    final all = [...planned, ...actual].whereType<int>().toList();
    if (all.isEmpty) return;
    final min = all.reduce((a, b) => a < b ? a : b);
    final max = all.reduce((a, b) => a > b ? a : b);
    final span = (max - min).toDouble();
    void draw(List<int?> values, Color color) {
      final paint = Paint()
        ..color = color
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      final dot = Paint()..color = color;
      Path? path;
      for (var i = 0; i < values.length; i++) {
        final v = values[i];
        if (v == null) continue;
        final x = values.length == 1
            ? size.width / 2
            : size.width * i / (values.length - 1);
        final y = span == 0
            ? size.height / 2
            : size.height - (v - min) / span * size.height;
        canvas.drawCircle(Offset(x, y), 4, dot);
        if (path == null) {
          path = Path()..moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      if (path != null) canvas.drawPath(path, paint);
    }

    draw(planned, plannedColor);
    draw(actual, actualColor);
  }

  @override
  bool shouldRepaint(covariant _LinesPainter old) =>
      old.planned != planned || old.actual != actual;
}
