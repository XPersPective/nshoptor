import 'dart:math' as math;

import 'ocr_text_source.dart';

/// Deskew for photographed receipts (PB-207): ML Kit reports each line's
/// rotation; a few degrees of tilt make the price column sit higher than the
/// name column, so height-based row grouping pairs prices with the wrong
/// products. Rotating every box around the page centroid by the MEDIAN line
/// angle removes the tilt before rows are rebuilt.
///
/// Boxes stay axis-aligned (same width/height, rotated center): exact corner
/// geometry is not needed for row grouping, only stable row bands.
const double maxDeskewDegrees = 10;

double medianAngleDegrees(List<double?> angles) {
  final values = [
    for (final a in angles)
      if (a != null && a.isFinite && a.abs() <= maxDeskewDegrees) a,
  ]..sort();
  if (values.isEmpty) return 0;
  return values[values.length ~/ 2];
}

/// Rotates every box center around the centroid of all boxes by [degrees]
/// (counter to the measured tilt). Lines without geometry pass through.
List<OcrLine> deskewLines(List<OcrLine> lines, double degrees) {
  if (degrees == 0 || degrees.isNaN) return lines;
  final boxed = [
    for (final l in lines)
      if (l.boundingBoxLeft != null &&
          l.boundingBoxTop != null &&
          l.boundingBoxWidth != null &&
          l.boundingBoxHeight != null)
        l,
  ];
  if (boxed.length < 2) return lines;
  var minX = double.infinity, maxX = double.negativeInfinity;
  var minY = double.infinity, maxY = double.negativeInfinity;
  for (final l in boxed) {
    minX = math.min(minX, l.boundingBoxLeft!);
    maxX = math.max(maxX, l.boundingBoxLeft! + l.boundingBoxWidth!);
    minY = math.min(minY, l.boundingBoxTop!);
    maxY = math.max(maxY, l.boundingBoxTop! + l.boundingBoxHeight!);
  }
  final cx = (minX + maxX) / 2;
  final cy = (minY + maxY) / 2;
  final rad = degrees * math.pi / 180;
  final cos = math.cos(-rad), sin = math.sin(-rad);
  return [
    for (final l in lines)
      l.boundingBoxLeft == null ||
          l.boundingBoxTop == null ||
          l.boundingBoxWidth == null ||
          l.boundingBoxHeight == null
      ? l
      : () {
          final w = l.boundingBoxWidth!, h = l.boundingBoxHeight!;
          final px = l.boundingBoxLeft! + w / 2 - cx;
          final py = l.boundingBoxTop! + h / 2 - cy;
          final rx = cx + px * cos - py * sin;
          final ry = cy + px * sin + py * cos;
          return OcrLine(
            text: l.text,
            boundingBoxLeft: rx - w / 2,
            boundingBoxTop: ry - h / 2,
            boundingBoxWidth: w,
            boundingBoxHeight: h,
          );
        }(),
  ];
}
