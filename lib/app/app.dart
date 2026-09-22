import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/l10n/generated/app_localizations.dart';
import '../core/theme/app_theme.dart';
import '../data/db/app_database.dart';
import '../features/home/home_screen.dart';
import '../features/lists/list_repository.dart';
import '../features/settings/settings_repository.dart';
import 'language_controller.dart';

/// Uygulamanın kök bileşeni: l10n, tema ve dil tercihini birleştirir.
///
/// [fixedLocale] yalnız testlerde kullanılır; null iken dil tercihi
/// [LanguageController]'dan gelir (`system` → MaterialApp sistem dili).
class NShoptorApp extends StatelessWidget {
  NShoptorApp({
    super.key,
    required this.db,
    this.fixedLocale,
    this.settingsRepository,
    LanguageController? languageController,
    this.themeMode = ThemeMode.system,
  }) : languageController = languageController ?? LanguageController();

  final Locale? fixedLocale;
  final LanguageController languageController;
  final ThemeMode themeMode;

  /// Cihazda drift_flutter ile açılır; testlerde bellek-içi verilir.
  final AppDatabase db;

  /// Ayarlar ekranı ihtiyacı: dil/tema/birimler; testlerde in-memory fake.
  final SettingsRepository? settingsRepository;

  /// Desteklenen diller; yeni dil yalnız yeni ARB dosyasıyla eklenir.
  static const List<Locale> supportedLocales = [Locale('tr'), Locale('en')];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: languageController,
      builder: (context, _) {
        return MaterialApp(
          title: 'NShoptor',
          locale: fixedLocale ?? languageController.locale,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
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
  });

  final AppDatabase db;
  final ListRepository listRepository;
  final LanguageController languageController;
  final SettingsRepository? settingsRepository;

  @override
  Widget build(BuildContext context) {
    return HomeShell(
      db: db,
      listRepository: listRepository,
      settingsRepository: settingsRepository,
      languageController: languageController,
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
