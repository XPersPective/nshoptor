import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

/// Keeps monetary labels in normal, scalable text beside a drawing-only plot.
/// Amounts and tick calculation stay in integer minor units.
/// Compact formatting is presentation only; exact tick amounts remain visible.
class AmountAxisChart extends StatelessWidget {
  const AmountAxisChart({
    super.key,
    required this.minimum,
    required this.maximum,
    required this.formatAmount,
    required this.plot,
    required this.compactFormatAmount,
  });

  final int minimum;
  final int maximum;
  final String Function(int) formatAmount;
  final Widget plot;
  final String Function(int) compactFormatAmount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onSurface,
      fontWeight: FontWeight.w600,
    );
    final scaler = MediaQuery.textScalerOf(context);
    // Existing money formatting uses LTR digits even in RTL interfaces.
    const direction = TextDirection.ltr;
    final values = minimum == maximum
        ? [minimum]
        : {maximum, minimum + (maximum - minimum) ~/ 2, minimum}.toList();
    final exactLabels = values.map(formatAmount).toList();
    return LayoutBuilder(
      builder: (context, constraints) {
        Size measure(String label, {double maxWidth = double.infinity}) {
          final painter = TextPainter(
            text: TextSpan(text: label, style: style),
            textDirection: direction,
            textScaler: scaler,
            locale: Localizations.maybeLocaleOf(context),
          )..layout(maxWidth: maxWidth);
          final size = painter.size;
          painter.dispose();
          return size;
        }

        final naturalWidth = exactLabels
            .map((s) => measure(s).width)
            .reduce(math.max)
            .ceilToDouble();
        final compact = naturalWidth > constraints.maxWidth * .5;
        final labels = compact
            ? values.map(compactFormatAmount).toList()
            : exactLabels;
        final axisWidth = math.min(
          labels.map((s) => measure(s).width).reduce(math.max).ceilToDouble(),
          constraints.maxWidth * .6,
        );
        final heights = labels
            .map((s) => measure(s, maxWidth: axisWidth).height)
            .toList();
        final labelHeight = heights.reduce(math.max);
        final plotHeight = math.max(140.0, labelHeight * 2 + 24);
        final height = plotHeight + labelHeight;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: axisWidth,
                    child: Stack(
                      children: [
                        for (var i = 0; i < values.length; i++)
                          Positioned(
                            top:
                                labelHeight / 2 +
                                4 +
                                (minimum == maximum
                                        ? .5
                                        : (maximum - values[i]) /
                                              (maximum - minimum)) *
                                    (plotHeight - 8) -
                                heights[i] / 2,
                            left: 0,
                            right: 0,
                            child: Text(
                              labels[i],
                              style: style,
                              textDirection: direction,
                              semanticsLabel: exactLabels[i],
                              textAlign: TextAlign.end,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: labelHeight / 2),
                      child: CustomPaint(
                        painter: _AxisGrid(
                          color: theme.colorScheme.outlineVariant,
                          fractions: [
                            for (final value in values)
                              minimum == maximum
                                  ? .5
                                  : (maximum - value) / (maximum - minimum),
                          ],
                        ),
                        child: plot,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (compact) ...[
              const SizedBox(height: 8),
              for (var i = 0; i < exactLabels.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Semantics(
                    label: exactLabels[i],
                    textDirection: direction,
                    excludeSemantics: true,
                    child: Wrap(
                      textDirection: direction,
                      spacing: 4,
                      children: [
                        for (final part in exactLabels[i].split(RegExp(r'\s+')))
                          Text(
                            part,
                            style: style,
                            textDirection: direction,
                            softWrap: false,
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        );
      },
    );
  }
}

class _AxisGrid extends CustomPainter {
  const _AxisGrid({required this.color, required this.fractions});
  final Color color;
  final List<double> fractions;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (final fraction in fractions) {
      final y = 4 + fraction * (size.height - 8);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _AxisGrid oldDelegate) =>
      oldDelegate.color != color || oldDelegate.fractions != fractions;
}

/// Compact labels are approximate drawing aids; [AmountAxisChart] also shows
/// the authoritative fixed-point amount whenever it uses these labels.
String compactChartAmount(
  int value, {
  required int digits,
  required String locale,
}) =>
    intl.NumberFormat.compact(locale: locale)
        .format(value / math.pow(10, digits));
