import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/l10n/generated/app_localizations.dart';
import '../core/theme/app_theme.dart';
import '../data/db/app_database.dart';
import '../features/home/home_screen.dart';
import '../features/lists/list_repository.dart';
import '../features/settings/settings_repository.dart';
import 'language_controller.dart';
import 'theme_mode_controller.dart';

/// Uygulamanın kök bileşeni: l10n, tema ve dil tercihini birleştirir.
///
/// [fixedLocale] yalnız testlerde kullanılır; null iken dil tercihi
/// [LanguageController]'dan gelir (`system` → MaterialApp sistem dili).
/// [themeModeController] Ayarlar'daki tema tercihini canlı uygular;
/// verilmezse [themeMode] kullanılır.
class NShoptorApp extends StatelessWidget {
  NShoptorApp({
    super.key,
    required this.db,
    this.fixedLocale,
    this.settingsRepository,
    LanguageController? languageController,
    this.themeModeController,
    this.themeMode = ThemeMode.system,
  })  : languageController = languageController ?? LanguageController();

  final Locale? fixedLocale;
  final LanguageController languageController;
  final AppThemeModeController? themeModeController;
  final ThemeMode themeMode;

  /// Cihazda drift_flutter ile açılır; testlerde bellek-içi verilir.
  final AppDatabase db;

  /// Ayarlar ekranı ihtiyacı: dil/tema/birimler; testlerde in-memory fake.
  final SettingsRepository? settingsRepository;

  /// Desteklenen diller; yeni dil yalnız yeni ARB dosyasıyla eklenir.
  static const List<Locale> supportedLocales = [Locale('tr'), Locale('en')];

  /// Belirleyici yerel çözümleme: platform yeleri henüz iletilmemişse
  /// (emülatör ilk karesi) birinci desteklenen dile düşülür; dil kodu
  /// eşleşmezse de tr (ürünün birincil pazarı) varsayılır. Böylece ilk
  /// kare ile ikinci kare arasında dil sıçraması olmaz.
  Locale _resolveLocale(Locale? deviceLocale, Iterable<Locale> supported) {
    if (deviceLocale != null) {
      for (final l in supported) {
        if (l.languageCode == deviceLocale.languageCode) return l;
      }
    }
    return const Locale('tr');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
          Listenable.merge([languageController, ?themeModeController]),
      builder: (context, _) {
        return MaterialApp(
          title: 'NShoptor',
          locale: fixedLocale ?? languageController.locale,
          localeResolutionCallback: _resolveLocale,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode:
              themeModeController?.mode ?? themeMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: supportedLocales,
          home: _Home(
          db: db,
          listRepository: ListRepository(db),
          settingsRepository: settingsRepository ??
              SettingsRepository(db, _InMemorySettingsOps()),
          languageController: languageController,
          themeModeController: themeModeController,
        ),
        );
      },
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({
    required this.db,
    required this.listRepository,
    required this.languageController,
    this.settingsRepository,
    this.themeModeController,
  });

  final AppDatabase db;
  final ListRepository listRepository;
  final LanguageController languageController;
  final AppThemeModeController? themeModeController;
  final SettingsRepository? settingsRepository;

  @override
  Widget build(BuildContext context) {
    return HomeShell(
      db: db,
      listRepository: listRepository,
      settingsRepository: settingsRepository,
      languageController: languageController,
      themeModeController: themeModeController,
    );
  }
}

/// Test/ortamda SettingsStore olmadan kullanılabilen in-memory uygulaması.
class _InMemorySettingsOps implements SettingsStoreOps {
  final Map<String, Object> _values = {};

  @override
  String? getString(String key) => _values[key] as String?;
  @override
  bool? getBool(String key) => _values[key] as bool?;
  @override
  void setString(String key, String value) => _values[key] = value;
  @override
  void setBool(String key, bool value) => _values[key] = value;
  @override
  void remove(String key) => _values.remove(key);
}
