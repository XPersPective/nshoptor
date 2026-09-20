import 'package:flutter/material.dart';

/// NShoptor Material 3 marka teması (spec §10): yeşil/turkuaz ailesi,
/// açık/koyu/sistem. Dinamik yazı boyutlarında taşmayacak esnek tipografi;
/// yoğun bilgi ekranları (fiş inceleme, karşılaştırma) için ekstra küçük
/// stiller tanımlıdır.
class AppTheme {
  AppTheme._();

  /// Marka tohum rengi: sakin yeşil-turkuaz.
  static const Color brandSeed = Color(0xFF0B8457);

  static ThemeData light() => _base(Brightness.light);

  static ThemeData dark() => _base(Brightness.dark);

  static ThemeData _base(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: brandSeed,
      brightness: brightness,
    );
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
    );
    // Uzun ürün/mağaza adlarında taşma yönetimi: gövde metinleri sarar.
    final textTheme = base.textTheme.copyWith(
      titleMedium: base.textTheme.titleMedium?.copyWith(height: 1.2),
      bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.35),
      bodySmall: base.textTheme.bodySmall?.copyWith(height: 1.3),
    );
    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        scrolledUnderElevation: 1,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        indicatorColor: scheme.secondaryContainer,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }
}
