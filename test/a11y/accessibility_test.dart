import 'dart:ui' show SemanticsFlag;

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/core/theme/semantic_colors.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/lists/lists_screen.dart';

void main() {
  group('erişilebilirlik kontrolleri (spec §10)', () {
    testWidgets('ana ekranın temel semantiği vardır', (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      await tester.pumpWidget(
        NShoptorApp(db: db, fixedLocale: const Locale('tr')),
      );
      await tester.pumpAndSettle();

      // Keşfet üst araç çubuğundan erişilebilir; altta üç sekme vardır.
      final navBar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(navBar.destinations.length, 3);
      expect(find.byKey(const Key('home_nav_discover')), findsOneWidget);
      expect(find.byKey(const Key('lists_search_button')), findsOneWidget);
      expect(find.byKey(const Key('lists_tab_active')), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 1));
      await closing;
    });

    for (final width in [320.0, 412.0]) {
      for (final themeMode in [ThemeMode.light, ThemeMode.dark]) {
        for (final locale in [const Locale('tr'), const Locale('ar')]) {
          testWidgets('home/list ${width.toInt()}dp ${themeMode.name} '
              '${locale.languageCode} 2x semantics and interaction', (
            tester,
          ) async {
            final semantics = tester.ensureSemantics();
            tester.view
              ..devicePixelRatio = 1
              ..physicalSize = Size(width, 800);
            tester.platformDispatcher.textScaleFactorTestValue = 2;

            final db = AppDatabase(NativeDatabase.memory());
            try {
              await ListRepository(db).createList(
                title: 'Haftalık aile marketi ve uzun mutfak ihtiyaçları',
                currencyCode: 'TRY',
              );

              await tester.pumpWidget(
                NShoptorApp(db: db, fixedLocale: locale, themeMode: themeMode),
              );
              await tester.pumpAndSettle();
              expect(
                tester.takeException(),
                isNull,
                reason: 'initial layout at $width/$themeMode/$locale',
              );

              final search = find.byKey(const Key('lists_search_button'));
              final newList = find.byKey(const Key('lists_new_list_button'));
              expect(find.byType(NavigationBar), findsOneWidget);
              expect(find.byKey(const Key('lists_tab_active')), findsOneWidget);
              expect(search, findsOneWidget);
              expect(newList, findsOneWidget);
              expect(
                tester.getSemantics(search).hasFlag(SemanticsFlag.isButton),
                isTrue,
                reason: 'search must be a button at $width/$themeMode/$locale',
              );
              expect(
                tester.getSemantics(newList).hasFlag(SemanticsFlag.isButton),
                isTrue,
                reason:
                    'new-list action must be a button at $width/$themeMode/$locale',
              );
              final searchHint = AppLocalizations.of(tester.element(search))
                  .searchListHint;
              final searchData = tester.getSemantics(search).getSemanticsData();
              expect(
                searchData.label == searchHint ||
                    searchData.tooltip == searchHint,
                isTrue,
                reason:
                    'search needs a spoken label or tooltip at $width/$themeMode/$locale',
              );
              expect(
                find.bySemanticsLabel(
                  AppLocalizations.of(tester.element(newList)).newListButton,
                ),
                findsOneWidget,
                reason:
                    'new-list action needs a spoken label at $width/$themeMode/$locale',
              );

              await tester.tap(search);
              await tester.pumpAndSettle();
              expect(
                find.byKey(const Key('lists_search_field')),
                findsOneWidget,
              );
              expect(
                tester.takeException(),
                isNull,
                reason: 'search open at $width/$themeMode/$locale',
              );
              await tester.tap(search);
              await tester.pumpAndSettle();
              expect(find.byKey(const Key('lists_search_field')), findsNothing);
              expect(
                tester.takeException(),
                isNull,
                reason: 'search close at $width/$themeMode/$locale',
              );
            } finally {
              await tester.pumpWidget(const SizedBox.shrink());
              final closing = db.close();
              await tester.pump(const Duration(milliseconds: 1));
              await closing;
              semantics.dispose();
              tester.view.reset();
              tester.platformDispatcher.clearTextScaleFactorTestValue();
            }
          });
        }
      }
    }

    testWidgets('renk tek bilgi taşıyıcısı DEĞİLDİR: fark göstergelerinde '
        '"işaret + renk" birlikte bulunur', (tester) async {
      final delta = SemanticDelta.resolve(
        direction: SpendingDirection.overPlan,
        brightness: Brightness.light,
      );
      // Anlamlı marker var (yalnız renk yok).
      expect(delta.marker, isNotEmpty);
    });

    testWidgets('büyük yazıda liste ekranı taşmıyor (taşma yok)', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(800, 1400));
      final db = AppDatabase(NativeDatabase.memory());
      final repo = ListRepository(db);
      await repo.createList(
        title: 'Çok Uzun Bir Liste Başlığı Net Görünür',
        currencyCode: 'TRY',
      );
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('tr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(1.6)),
            child: ListsScreen(repository: repo),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Taşma yoksa exception olmaz; metin bulunur.
      expect(
        find.text('Çok Uzun Bir Liste Başlığı Net Görünür'),
        findsOneWidget,
      );

      await tester.binding.setSurfaceSize(null);
      await db.close();
    });

    testWidgets('kontrast pairleri müzikli (T7 AA hedefi)', (tester) async {
      for (final theme in [AppTheme.light(), AppTheme.dark()]) {
        final body = theme.textTheme.bodyMedium!;
        final surface = theme.colorScheme.surface;
        final onSurface = theme.colorScheme.onSurface;
        expect(onSurface != surface, isTrue);
        // WCAG hesabı T7 testlerinde; burada boş stiller yok.
        expect(body.color, isNotNull);
      }
    });

    testWidgets('RTL destekli ekran: lists ekranı sağdan-sola bozulmaz', (
      tester,
    ) async {
      final db = AppDatabase(NativeDatabase.memory());
      final repo = ListRepository(db);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('tr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: ListsScreen(repository: repo),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // RTL akışında hata atmamalı.
      expect(find.byKey(const Key('lists_search_button')), findsOneWidget);

      await db.close();
    });
  });
}
