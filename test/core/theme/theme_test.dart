import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/core/theme/semantic_colors.dart';

/// WCAG 2.x göreli parlaklık ve kontrast oranı.
double luminance(Color c) {
  double channel(double v) =>
      v <= 0.04045 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * channel(c.r) +
      0.7152 * channel(c.g) +
      0.0722 * channel(c.b);
}

double contrastRatio(Color a, Color b) {
  final la = luminance(a);
  final lb = luminance(b);
  final lighter = la > lb ? la : lb;
  final darker = la > lb ? lb : la;
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  group('tema üretimi', () {
    test('açık ve koyu tema oluşturulur; Material 3 etkin', () {
      final light = AppTheme.light();
      final dark = AppTheme.dark();
      expect(light.useMaterial3, isTrue);
      expect(dark.brightness, Brightness.dark);
      expect(light.colorScheme.primary, isNot(dark.colorScheme.primary));
    });

    test('dokunma hedefleri en az 48dp yükseklikte', () {
      for (final theme in [AppTheme.light(), AppTheme.dark()]) {
        final filled = theme.filledButtonTheme.style?.minimumSize?.resolve({});
        expect(filled?.height ?? 0, greaterThanOrEqualTo(48));
        final outlined =
            theme.outlinedButtonTheme.style?.minimumSize?.resolve({});
        expect(outlined?.height ?? 0, greaterThanOrEqualTo(48));
      }
    });
  });

  group('WCAG kontrast', () {
    test('gövde metni her iki temada ≥ 4.5:1', () {
      for (final theme in [AppTheme.light(), AppTheme.dark()]) {
        final scheme = theme.colorScheme;
        final ratio = contrastRatio(scheme.onSurface, scheme.surface);
        expect(ratio, greaterThanOrEqualTo(4.5),
            reason: '${theme.brightness}: onSurface/surface kontrastı $ratio');
      }
    });

    test('anlamsal renkler kendi tema zemininde ≥ 4.5:1', () {
      for (final direction in SpendingDirection.values) {
        final palette = SemanticDelta.palette(direction);
        final lightRatio =
            contrastRatio(palette.light, AppTheme.light().colorScheme.surface);
        final darkRatio =
            contrastRatio(palette.dark, AppTheme.dark().colorScheme.surface);
        expect(lightRatio, greaterThanOrEqualTo(4.5),
            reason: '$direction açık temada $lightRatio');
        expect(darkRatio, greaterThanOrEqualTo(4.5),
            reason: '$direction koyu temada $darkRatio');
      }
    });

    test('resolve, temaya uygun renk ve yön işareti verir', () {
      final under = SemanticDelta.resolve(
          direction: SpendingDirection.underPlan,
          brightness: Brightness.light);
      expect(under.marker, '↓');
      final overDark = SemanticDelta.resolve(
          direction: SpendingDirection.overPlan, brightness: Brightness.dark);
      expect(overDark.color,
          SemanticDelta.palette(SpendingDirection.overPlan).dark);
    });
  });
}
