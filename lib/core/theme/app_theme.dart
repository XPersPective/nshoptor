import 'package:flutter/material.dart';

/// NShoptor Material 3 marka teması (spec §10): yeşil/turkuaz ailesi,
/// açık/koyu/sistem. Dinamik yazı boyutlarında taşmayacak esnek tipografi;
/// yoğun bilgi ekranları (fiş inceleme, karşılaştırma) için ekstra küçük
/// stiller tanımlıdır.
///
/// Premium dokunuşlar: kademeli tipografi ağırlıkları, stadium eylem
/// butonları, yumuşak köşeli girişler/kartlar, alt sayfa tutamacı ve
/// FadeForwards sayfa geçişleri. Renk rolleri M3 varsayılanında kalır;
/// kontrast (WCAG AA) SemanticDelta testleriyle korunur.
/// Renk temaları: marka yeşili varsayılan; diğerleri aynı yapıyla.
enum AppPalette {
  forest(Color(0xFF0B8457)),
  ocean(Color(0xFF0B6E99)),
  sunset(Color(0xFFC2410C)),
  lavender(Color(0xFF6E56CF));

  const AppPalette(this.seed);
  final Color seed;

  static AppPalette fromName(String? name) =>
      values.firstWhere((p) => p.name == name, orElse: () => forest);
}

class AppTheme {
  AppTheme._();

  /// Marka tohum rengi: sakin yeşil-turkuaz.
  static const Color brandSeed = Color(0xFF0B8457);

  static ThemeData light({AppPalette palette = AppPalette.forest}) =>
      _base(Brightness.light, palette, black: false);

  /// [black]: koyu temada tam siyah yüzeyler (AMOLED); varsayılan şık koyu.
  static ThemeData dark({AppPalette palette = AppPalette.forest, bool black = true}) =>
      _base(Brightness.dark, palette, black: black);

  static ThemeData _base(Brightness brightness, AppPalette palette, {required bool black}) {
    var scheme = ColorScheme.fromSeed(
      seedColor: palette.seed,
      brightness: brightness,
    );
    if (black) {
      scheme = scheme.copyWith(
        surface: Colors.black,
        surfaceContainerLowest: Colors.black,
        surfaceContainerLow: const Color(0xFF0C0D0D),
        surfaceContainer: const Color(0xFF131414),
        surfaceContainerHigh: const Color(0xFF1B1C1C),
        surfaceContainerHighest: const Color(0xFF242525),
      );
    }
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
    );
    // Uzun ürün/mağaza adlarında taşma yönetimi: gövde metinleri sarar.
    // Başlık ailesi premium hiyerarşi için bir kademe ağırlaşır.
    final textTheme = base.textTheme.copyWith(
      displaySmall:
          base.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w600, height: 1.15),
      headlineSmall:
          base.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600, height: 1.2),
      headlineMedium:
          base.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600, height: 1.2),
      titleLarge:
          base.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium:
          base.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, height: 1.25),
      titleSmall:
          base.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      labelLarge:
          base.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.2),
      bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.4),
      bodySmall: base.textTheme.bodySmall?.copyWith(height: 1.35),
    );
    const stadium = StadiumBorder();
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
    );
    return base.copyWith(
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: scheme.onSurface,
        ),
        scrolledUnderElevation: 1,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        indicatorColor: scheme.secondaryContainer,
        elevation: 0,
        surfaceTintColor: scheme.surfaceContainerLow,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: stadium,
        ).copyWith(
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: stadium,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: stadium),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: inputBorder,
        enabledBorder: inputBorder.copyWith(borderSide: BorderSide(color: scheme.outlineVariant)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        dragHandleColor: scheme.onSurfaceVariant.withValues(alpha: 0.4),
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant),
      // Liste ögesindeki tik alanı, ekleme alanıyla aynı çizgi dilinde:
      // yumuşak köşe, ince kontur, işaretliyken marka dolgusu.
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(
            color: states.contains(WidgetState.selected) ? scheme.primary : scheme.outline,
            width: 1.6,
          ),
        ),
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.surfaceContainerHighest.withValues(alpha: 0.4),
        ),
        checkColor: WidgetStatePropertyAll(scheme.onPrimary),
      ),
    );
  }
}
