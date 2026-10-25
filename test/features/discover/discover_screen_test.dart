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
  final identity = AppIdentity(
    appName: 'NShoptor',
    packageName: 'com.crazypenguin.nshoptor',
    sourceUrl: 'https://example.com/source',
    privacyPolicyUrl: 'https://example.com/privacy',
    contactEmail: 'qa@example.com',
  );
  final records = [
    {
      'id': 'android',
      'androidPackage': 'com.example.android',
      'name': {'en': 'Android only', 'tr': 'Android uygulaması'},
      'description': {'en': 'Planning'},
    },
    {
      'id': 'ios',
      'appStoreId': '1234567890',
      'name': {'en': 'iOS only'},
      'description': {'en': 'Planning'},
    },
    {
      'id': 'own',
      'androidPackage': identity.packageName,
      'name': {'en': 'Own app'},
      'description': {'en': 'Planning'},
    },
  ];
  tearDown(() => debugDefaultTargetPlatformOverride = null);

  test('catalog keeps only valid current-platform store identities', () {
    final apps = [
      for (final record in records) OtherApp.tryParse(record)!,
      const OtherApp(
        id: 'bad',
        androidPackage: 'bad&link=1',
        appStoreId: '123?url=other',
        name: {'en': 'bad'},
        description: {'en': 'bad'},
      ),
    ];
    expect(DiscoverScreen.forPlatform(apps, isIos: true).map((a) => a.id), [
      'ios',
    ]);
    expect(DiscoverScreen.forPlatform(apps, isIos: false).map((a) => a.id), [
      'android',
      'own',
    ]);
  });

  test('explicit catalog refresh bypasses a fresh cache and keeps the last payload on network failure', () async {
    final cache = SettingsStore();
    var calls = 0;
    var offline = false;
    var current = records.take(1).toList();
    final client = MockClient((_) async {
      calls++;
      if (offline) throw http.ClientException('offline');
      return http.Response(
        jsonEncode({'schema': 1, 'apps': current}),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
    addTearDown(client.close);
    final repository = OtherAppsRepository(
      appsUrl: 'https://example.com/apps.json',
      cacheStore: cache,
      client: client,
    );
    expect(
      (await loadDiscoveryApps(
        repository,
        ownPackage: identity.packageName,
      )).length,
      1,
    );
    current = records.take(2).toList();
    expect(
      (await loadDiscoveryApps(
        repository,
        ownPackage: identity.packageName,
      )).length,
      1,
    );
    expect(calls, 1);
    expect(
      (await loadDiscoveryApps(
        repository,
        ownPackage: identity.packageName,
        forceRefresh: true,
      )).length,
      2,
    );
    expect(calls, 2);
    final saved = cache.getString('napp.other_apps_cache');
    offline = true;
    expect(
      (await loadDiscoveryApps(
        repository,
        ownPackage: identity.packageName,
        forceRefresh: true,
      )).length,
      2,
    );
    expect(calls, 3);
    expect(cache.getString('napp.other_apps_cache'), saved);
  });

  for (final empty in [false, true]) {
    testWidgets(
      '${empty ? 'Retry' : 'Pull refresh'} fetches current catalog despite a fresh cache',
      (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        final cache = SettingsStore();
        var calls = 0;
        var current = empty
            ? <Map<String, Object>>[]
            : records.take(1).toList();
        final client = MockClient((_) async {
          calls++;
          return http.Response(
            jsonEncode({'schema': 1, 'apps': current}),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        });
        addTearDown(client.close);
        final repository = OtherAppsRepository(
          appsUrl: 'https://example.com/apps.json',
          client: client,
          cacheStore: cache,
        );
        await tester.runAsync(
          () => repository.load(ownPackage: identity.packageName),
        );
        current = [
          {
            'id': 'new',
            'androidPackage': 'com.example.new',
            'name': {'en': 'New catalog app'},
            'description': {'en': 'New description'},
          },
        ];
        final translations = NappTranslations({
          'en': {
            'common.errorGeneric': 'Please try again.',
            'otherApps.empty': 'No apps yet',
          },
        });
        await tester.pumpWidget(
          MaterialApp(
            locale: const Locale('en'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: [
              AppLocalizations.delegate,
              NappLocalizationsDelegate(translations),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: DiscoverScreen(identity: identity, repository: repository),
          ),
        );
        await tester.pumpAndSettle();
        expect(calls, 1);
        expect(find.text('New catalog app'), findsNothing);
        if (empty) {
          await tester.tap(find.byKey(const Key('discover_retry')));
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 30)),
          );
        } else {
          final refresh = tester
              .widget<RefreshIndicator>(find.byType(RefreshIndicator))
              .onRefresh;
          await tester.runAsync(refresh);
        }
        await tester.pump();
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 30)),
        );
        await tester.pumpAndSettle();
        expect(calls, 2);
        expect(find.text('New catalog app'), findsOneWidget);
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
        debugDefaultTargetPlatformOverride = null;
      },
    );
  }

  for (final isIos in [false, true]) {
    testWidgets(
      '${isIos ? 'iOS' : 'Android'} opens matching store, handles launch failure at 320dp 2x',
      (tester) async {
        debugDefaultTargetPlatformOverride = isIos
            ? TargetPlatform.iOS
            : TargetPlatform.android;
        await tester.binding.setSurfaceSize(const Size(320, 700));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final client = MockClient(
          (_) async => http.Response(
            jsonEncode({'schema': 1, 'apps': records}),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          ),
        );
        addTearDown(client.close);
        final opened = <Uri>[];
        final translations = NappTranslations({
          'en': {
            'common.errorGeneric': 'Please try again.',
            'otherApps.empty': 'No apps yet',
          },
        });
        await tester.pumpWidget(
          MaterialApp(
            locale: const Locale('en'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: [
              AppLocalizations.delegate,
              NappLocalizationsDelegate(translations),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(2)),
              child: child!,
            ),
            home: DiscoverScreen(
              identity: identity,
              repository: OtherAppsRepository(
                appsUrl: 'https://example.com/apps.json',
                client: client,
              ),
              launcher: (uri) async {
                opened.add(uri);
                return false;
              },
            ),
          ),
        );
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 30)),
        );
        await tester.pumpAndSettle();
        expect(find.text('Own app'), findsNothing);
        expect(find.text(isIos ? 'Android only' : 'iOS only'), findsNothing);
        final card = find.byKey(Key('discover_${isIos ? 'ios' : 'android'}'));
        expect(card, findsOneWidget);
        await tester.tap(card);
        await tester.pumpAndSettle();
        expect(
          opened.single.host,
          isIos ? 'apps.apple.com' : 'play.google.com',
        );
        expect(find.text('Please try again.'), findsOneWidget);
        expect(tester.takeException(), isNull);
        debugDefaultTargetPlatformOverride = null;
      },
    );
  }
}
