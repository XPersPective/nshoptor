import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:napp_core/napp_core.dart';

// Gizli degerler KODA YAZILMAZ; derlemede --dart-define ile verilir (1.2).
const contactEmail = String.fromEnvironment('CONTACT_EMAIL');
const privacyUrl = String.fromEnvironment('PRIVACY_URL',
    defaultValue: 'https://example.com/privacy');
const sourceUrl = String.fromEnvironment('SOURCE_URL',
    defaultValue: 'https://github.com/XPersPective/nshoptor');
const otherAppsUrl = String.fromEnvironment('OTHER_APPS_URL');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await SettingsStore.load();
  final themeModeController = ThemeModeController(store: store)..load();
  final identity = AppIdentity(
    appName: 'NShoptor',
    packageName: 'com.example.nshoptor',
    sourceUrl: sourceUrl,
    privacyPolicyUrl: privacyUrl,
    contactEmail: contactEmail.isEmpty ? 'hello@example.com' : contactEmail,
    otherAppsUrl: otherAppsUrl.isEmpty ? null : otherAppsUrl,
    sloganKey: 'app.slogan',
  );
  WidgetsBinding.instance.addObserver(SettingsLifecycleObserver(store));
  runApp(NappApp(
    identity: identity,
    themeModeController: themeModeController,
  ));
}

class NappApp extends StatelessWidget {
  const NappApp({
    super.key,
    required this.identity,
    required this.themeModeController,
  });

  final AppIdentity identity;
  final ThemeModeController themeModeController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([themeModeController]),
      builder: (context, _) => MaterialApp(
        title: identity.appName,
        theme: AppTheme.light(brandColor: identity.brandColor),
        darkTheme: AppTheme.dark(brandColor: identity.brandColor),
        themeMode: themeModeController.mode,
        localizationsDelegates: [
          NappLocalizationsDelegate(NappTranslations({})),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('tr'), Locale('en')],
        home: HomePage(
          identity: identity,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.identity,
  });

  final AppIdentity identity;

  @override
  Widget build(BuildContext context) {
    final l10n = NappLocalizations.of(context);
    final body = Center(child: Text(l10n.aboutTitle));
    final actions = <Widget>[
    ];
    return Scaffold(
      appBar: AppBar(title: Text(identity.appName), actions: actions),
      body: body,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavigationBar(
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Ana sayfa',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
