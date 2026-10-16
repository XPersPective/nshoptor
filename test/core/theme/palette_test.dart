import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart' show SettingsStore;

import 'package:nshoptor/app/theme_mode_controller.dart';
import 'package:nshoptor/core/theme/app_theme.dart';

void main() {
  test('every palette builds light and dark themes from its own seed', () {
    for (final p in AppPalette.values) {
      final light = AppTheme.light(palette: p);
      final dark = AppTheme.dark(palette: p, black: false);
      expect(light.brightness, Brightness.light);
      expect(dark.brightness, Brightness.dark);
      expect(light.colorScheme.primary, isNot(dark.colorScheme.primary));
    }
    expect(AppTheme.light(palette: AppPalette.ocean).colorScheme.primary,
        isNot(AppTheme.light().colorScheme.primary));
  });

  test('black dark style uses pure black surfaces; dim style does not', () {
    expect(AppTheme.dark().colorScheme.surface, Colors.black);
    expect(AppTheme.dark(black: false).colorScheme.surface, isNot(Colors.black));
  });

  test('controller stores palette and black style', () {
    final store = SettingsStore();
    final c = AppThemeModeController(store: store)..load();
    expect(c.palette, AppPalette.forest);
    expect(c.black, isTrue);
    c.setPalette(AppPalette.sunset);
    c.setBlack(false);
    final reloaded = AppThemeModeController(store: store)..load();
    expect(reloaded.palette, AppPalette.sunset);
    expect(reloaded.black, isFalse);
  });
}
