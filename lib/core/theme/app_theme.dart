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
  sage(Color(0xFF2B7A67)),
  ocean(Color(0xFF16688A)),
  slate(Color(0xFF446275)),
  sunset(Color(0xFFA65138)),
  lavender(Color(0xFF6855B8));

  const AppPalette(this.seed);
  final Color seed;

  static AppPalette fromName(String? name) =>
      values.firstWhere((p) => p.name == name, orElse: () => forest);
}

typedef _SurfaceLadder = ({
  Color surface,
  Color lowest,
  Color low,
  Color container,
  Color high,
  Color highest,
});

class AppTheme {
  AppTheme._();

  /// Marka tohum rengi: sakin yeşil-turkuaz.
  static const Color brandSeed = Color(0xFF0B8457);

  /// Theme mode for a fresh install (F36): the brand dark-green slate look.
  /// Only applies while no choice is stored; a saved `app.theme` always wins.
  static const String defaultModeName = 'dark';

  /// Calm elevated pine-slate dark surface for the default [AppPalette.forest].
  /// Keeps green leading slightly (`g > r`, `g > b`) without pitch-black voids.
  /// Pure black stays an explicit AMOLED opt-in ([dark] `black: true`).
  static const Color brandDarkSurface = Color(0xFF141E19);

  static _SurfaceLadder _darkSurface(AppPalette palette) => switch (palette) {
        AppPalette.forest => const (
          surface: brandDarkSurface,
          lowest: Color(0xFF0F1713),
          low: Color(0xFF1A251F),
          container: Color(0xFF202D27),
          high: Color(0xFF27362F),
          highest: Color(0xFF2F4038),
        ),
        AppPalette.sage => const (
          surface: Color(0xFF151D1A),
          lowest: Color(0xFF101614),
          low: Color(0xFF1B2421),
          container: Color(0xFF212C28),
          high: Color(0xFF283531),
          highest: Color(0xFF303F3A),
        ),
        AppPalette.ocean => const (
          surface: Color(0xFF131B22),
          lowest: Color(0xFF0E141A),
          low: Color(0xFF19222B),
          container: Color(0xFF1F2A35),
          high: Color(0xFF263340),
          highest: Color(0xFF2E3D4B),
        ),
        AppPalette.slate => const (
          surface: Color(0xFF171B1F),
          lowest: Color(0xFF121518),
          low: Color(0xFF1E2328),
          container: Color(0xFF242A30),
          high: Color(0xFF2C333A),
          highest: Color(0xFF343C44),
        ),
        AppPalette.sunset => const (
          surface: Color(0xFF1C1715),
          lowest: Color(0xFF151110),
          low: Color(0xFF231D1B),
          container: Color(0xFF2A2321),
          high: Color(0xFF322A27),
          highest: Color(0xFF3B322E),
        ),
        AppPalette.lavender => const (
          surface: Color(0xFF181620),
          lowest: Color(0xFF121119),
          low: Color(0xFF1E1C28),
          container: Color(0xFF252331),
          high: Color(0xFF2D2A3B),
          highest: Color(0xFF353245),
        ),
      };

  static _SurfaceLadder _lightSurface(AppPalette palette) => switch (palette) {
        AppPalette.forest => const (
          surface: Color(0xFFF5F8F6),
          lowest: Color(0xFFFAFDFB),
          low: Color(0xFFEFF4F0),
          container: Color(0xFFE7EFEA),
          high: Color(0xFFDFE9E3),
          highest: Color(0xFFD7E3DC),
        ),
        AppPalette.sage => const (
          surface: Color(0xFFF5F7F5),
          lowest: Color(0xFFFAFDFB),
          low: Color(0xFFEEEFE9),
          container: Color(0xFFE6EBE6),
          high: Color(0xFFDEE4DE),
          highest: Color(0xFFD5DDD6),
        ),
        AppPalette.ocean => const (
          surface: Color(0xFFF4F7FA),
          lowest: Color(0xFFFAFCFE),
          low: Color(0xFFEBF1F6),
          container: Color(0xFFE3ECF3),
          high: Color(0xFFDBE5EE),
          highest: Color(0xFFD3DFE9),
        ),
        AppPalette.slate => const (
          surface: Color(0xFFF5F7F9),
          lowest: Color(0xFFFBFCFD),
          low: Color(0xFFEDF0F4),
          container: Color(0xFFE5E9EF),
          high: Color(0xFFDDE2E9),
          highest: Color(0xFFD5DBE3),
        ),
        AppPalette.sunset => const (
          surface: Color(0xFFFAF6F4),
          lowest: Color(0xFFFFFBFA),
          low: Color(0xFFF4ECE8),
          container: Color(0xFFECE2DC),
          high: Color(0xFFE5D9D2),
          highest: Color(0xFFDCD0C8),
        ),
        AppPalette.lavender => const (
          surface: Color(0xFFF7F6FA),
          lowest: Color(0xFFFCFBFD),
          low: Color(0xFFEFEDF5),
          container: Color(0xFFE7E4EF),
          high: Color(0xFFDFDCE9),
          highest: Color(0xFFD7D3E3),
        ),
      };

  static ThemeData light({AppPalette palette = AppPalette.forest}) =>
      _base(Brightness.light, palette, black: false);

  /// [black]: koyu temada tam siyah yüzeyler (AMOLED); varsayılan dengeli koyu tonlar.
  static ThemeData dark({AppPalette palette = AppPalette.forest, bool black = false}) =>
      _base(Brightness.dark, palette, black: black);

  static ThemeData _base(Brightness brightness, AppPalette palette, {required bool black}) {
    var scheme = ColorScheme.fromSeed(
      seedColor: palette.seed,
      brightness: brightness,
    );
    final ladder = brightness == Brightness.dark
        ? _darkSurface(palette)
        : _lightSurface(palette);
    final calmPrimary = brightness == Brightness.dark
        ? Color.lerp(scheme.primary, scheme.primaryContainer, 0.24)!
        : Color.lerp(scheme.primary, scheme.secondary, 0.20)!;
    final calmSecondaryContainer = Color.lerp(
      scheme.secondaryContainer,
      brightness == Brightness.dark ? ladder.high : ladder.container,
      brightness == Brightness.dark ? 0.24 : 0.16,
    );
    scheme = scheme.copyWith(
      primary: calmPrimary,
      surface: ladder.surface,
      surfaceContainerLowest: ladder.lowest,
      surfaceContainerLow: ladder.low,
      surfaceContainer: ladder.container,
      surfaceContainerHigh: ladder.high,
      surfaceContainerHighest: ladder.highest,
      secondaryContainer: calmSecondaryContainer,
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
    // Harmonious, low-glare button geometry/typography while letting FilledButton
    // use calm scheme.primary and FilledButton.tonal preserve scheme.secondaryContainer.
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
        shape: const CircleBorder(),
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

  /// Açılış ekranı arka planı: marka koyu yeşili (koyu orman yüzeyiyle aynı ton,
  /// #07140E). Android `@color/splash_dark` ve iOS LaunchScreen.storyboard ile aynı
  /// olmalı; yerel → Flutter splash → uygulama geçişi kesintisiz olur.
  static const Color splashBackground = Color(0xFF07140E);

  /// Açılış ekranındaki "N" ve slogan: koyu yeşil üstünde okunur açık marka yeşili.
  static const Color splashAccent = Color(0xFF7BD9A5);
}
