import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:napp_core/napp_core.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/discover/discover_screen.dart';

void main() {
  final identity = AppIdentity(appName: 'NShoptor', packageName: 'com.crazypenguin.nshoptor',
    sourceUrl: 'https://example.com/source', privacyPolicyUrl: 'https://example.com/privacy', contactEmail: 'qa@example.com');
  final records = [
    {'id': 'android', 'androidPackage': 'com.example.android', 'name': {'en': 'Android only', 'tr': 'Android uygulaması'}, 'description': {'en': 'Planning'}},
    {'id': 'ios', 'appStoreId': '1234567890', 'name': {'en': 'iOS only'}, 'description': {'en': 'Planning'}},
    {'id': 'own', 'androidPackage': identity.packageName, 'name': {'en': 'Own app'}, 'description': {'en': 'Planning'}},
  ];
  tearDown(() => debugDefaultTargetPlatformOverride = null);

  test('catalog keeps only valid current-platform store identities', () {
    final apps = [
      for (final record in records) OtherApp.tryParse(record)!,
      const OtherApp(id: 'bad', androidPackage: 'bad&link=1', appStoreId: '123?url=other', name: {'en': 'bad'}, description: {'en': 'bad'}),
    ];
    expect(DiscoverScreen.forPlatform(apps, isIos: true).map((a) => a.id), ['ios']);
    expect(DiscoverScreen.forPlatform(apps, isIos: false).map((a) => a.id), ['android', 'own']);
  });

  for (final isIos in [false, true]) {
    testWidgets('${isIos ? 'iOS' : 'Android'} opens matching store, handles launch failure at 320dp 2x', (tester) async {
      debugDefaultTargetPlatformOverride = isIos ? TargetPlatform.iOS : TargetPlatform.android;
      await tester.binding.setSurfaceSize(const Size(320, 700));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final client = MockClient((_) async => http.Response(jsonEncode({'schema': 1, 'apps': records}), 200,
        headers: {'content-type': 'application/json; charset=utf-8'}));
      addTearDown(client.close);
      final opened = <Uri>[];
      final translations = NappTranslations({'en': {'common.errorGeneric': 'Please try again.', 'otherApps.empty': 'No apps yet'}});
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('en'), supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: [AppLocalizations.delegate, NappLocalizationsDelegate(translations),
          GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(2)), child: child!),
        home: DiscoverScreen(identity: identity,
          repository: OtherAppsRepository(appsUrl: 'https://example.com/apps.json', client: client),
          launcher: (uri) async { opened.add(uri); return false; }),
      ));
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 30)));
      await tester.pumpAndSettle();
      expect(find.text('Own app'), findsNothing);
      expect(find.text(isIos ? 'Android only' : 'iOS only'), findsNothing);
      final card = find.byKey(Key('discover_${isIos ? 'ios' : 'android'}'));
      expect(card, findsOneWidget);
      await tester.tap(card);
      await tester.pumpAndSettle();
      expect(opened.single.host, isIos ? 'apps.apple.com' : 'play.google.com');
      expect(find.text('Please try again.'), findsOneWidget);
      expect(tester.takeException(), isNull);
      debugDefaultTargetPlatformOverride = null;
    });
  }
}
