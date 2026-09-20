import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:napp_core/napp_core.dart';

import '../core/l10n/generated/app_localizations.dart';
import 'language_controller.dart';

/// Uygulamanın kök bileşeni: l10n, tema ve dil tercihini birleştirir.
///
/// [fixedLocale] yalnız testlerde kullanılır; null iken dil tercihi
/// [LanguageController]'dan gelir (`system` → MaterialApp sistem dili).
class NShoptorApp extends StatelessWidget {
  NShoptorApp({
    super.key,
    this.fixedLocale,
    LanguageController? languageController,
    this.themeMode = ThemeMode.system,
  }) : languageController = languageController ?? LanguageController();

  final Locale? fixedLocale;
  final LanguageController languageController;
  final ThemeMode themeMode;

  /// Desteklenen diller; yeni dil yalnız yeni ARB dosyasıyla eklenir.
  static const List<Locale> supportedLocales = [Locale('tr'), Locale('en')];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: languageController,
      builder: (context, _) {
        final identity = AppIdentity(
          appName: 'NShoptor',
          packageName: 'com.example.nshoptor',
          sourceUrl: 'https://github.com/XPersPective/nshoptor',
          privacyPolicyUrl: 'https://example.com/privacy',
          contactEmail: 'hello@example.com',
          sloganKey: 'slogan',
        );
        return MaterialApp(
          title: 'NShoptor',
          locale: fixedLocale ?? languageController.locale,
          theme: AppTheme.light(brandColor: identity.brandColor),
          darkTheme: AppTheme.dark(brandColor: identity.brandColor),
          themeMode: themeMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: supportedLocales,
          home: const _HomePlaceholder(),
        );
      },
    );
  }
}

/// Geçici ana ekran: yalnız marka + slogan gösterir. T13 gerçek ana
/// ekranla değiştirir; sahte buton içermez.
class _HomePlaceholder extends StatelessWidget {
  const _HomePlaceholder();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            l10n.slogan,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
