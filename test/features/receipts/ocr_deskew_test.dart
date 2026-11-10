import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/receipts/ocr_deskew.dart';
import 'package:nshoptor/features/receipts/ocr_text_source.dart';

OcrLine box(String text, double left, double top, double w, double h) =>
    OcrLine(
      text: text,
      boundingBoxLeft: left,
      boundingBoxTop: top,
      boundingBoxWidth: w,
      boundingBoxHeight: h,
    );

void main() {
  test('median ignores outliers and missing angles', () {
    expect(medianAngleDegrees([2.0, 2.5, 1.5]), 2.0);
    expect(medianAngleDegrees([null, 45, 2.0, -80, 2.0]), 2.0);
    expect(medianAngleDegrees([]), 0);
  });

  test('a tilted receipt is straightened so rows align again', () {
    // Straight rows, then the whole page rotated ~3°: the price column now
    // sits clearly higher than the name column of the same visual row.
    final straight = [
      box('EKMEK', 10, 104, 200, 20),
      box('*12,50', 420, 104, 90, 20),
      box('SÜT', 10, 154, 200, 20),
      box('*32,90', 420, 154, 90, 20),
    ];
    // deskewLines rotates BY -degrees, so tilt the page with -3.2.
    final tilted = deskewLines(straight, -3.2);
    double rowDelta(OcrLine a, OcrLine b) =>
        (a.boundingBoxTop! - b.boundingBoxTop!).abs();
    expect(rowDelta(tilted[0], tilted[1]), greaterThan(15));
    // OCR reports the median tilt; deskew restores the shared baseline.
    final fixed = deskewLines(tilted, medianAngleDegrees([3.2, 3.2, 3.1]));
    expect(rowDelta(fixed[0], fixed[1]), lessThan(1.5));
    expect(rowDelta(fixed[2], fixed[3]), lessThan(1.5));
    // Names stay above prices; order and sizes survive.
    expect(fixed[0].boundingBoxTop!, lessThan(fixed[2].boundingBoxTop!));
    expect(fixed.map((l) => l.text), tilted.map((l) => l.text));
    expect(fixed[0].boundingBoxWidth, 200);
  });

  test('zero angle, geometry-less lines and single lines pass through', () {
    final lines = [
      box('A', 1, 2, 3, 4),
      const OcrLine(text: 'no geometry'),
    ];
    expect(deskewLines(lines, 0), same(lines));
    final one = [box('A', 1, 2, 3, 4)];
    expect(deskewLines(one, 5), same(one));
    final mixed = deskewLines([...one, const OcrLine(text: 'x')], 4);
    expect(mixed[1].boundingBoxLeft, isNull);
  });
}
