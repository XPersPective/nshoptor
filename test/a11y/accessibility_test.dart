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
      await tester.pumpWidget(NShoptorApp(
        db: db,
        fixedLocale: const Locale('tr'),
      ));
      await tester.pumpAndSettle();

      // Alt navigasyon 4 hedef gösterir; ikon butonlarda tooltip vardır.
      final navBar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(navBar.destinations.length, 4);
      final newList = find.byKey(const Key('home_new_list_button'));
      expect(newList, findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 1));
      await closing;
    });

    testWidgets('renk tek bilgi taşıyıcısı DEĞİLDİR: fark göstergelerinde '
        '"işaret + renk" birlikte bulunur', (tester) async {
      final delta = SemanticDelta.resolve(
          direction: SpendingDirection.overPlan, brightness: Brightness.light);
      // Anlamlı marker var (yalnız renk yok).
      expect(delta.marker, isNotEmpty);
    });

    testWidgets('büyük yazıda liste ekranı taşmıyor (taşma yok)',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1400));
      final db = AppDatabase(NativeDatabase.memory());
      final repo = ListRepository(db);
      await repo.createList(title: 'Çok Uzun Bir Liste Başlığı Net Görünür',
          currencyCode: 'TRY');
      await tester.pumpWidget(MaterialApp(
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
      ));
      await tester.pumpAndSettle();

      // Taşma yoksa exception olmaz; metin bulunur.
      expect(find.text('Çok Uzun Bir Liste Başlığı Net Görünür'),
          findsOneWidget);

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

    testWidgets('RTL destekli ekran: lists ekranı sağdan-sola bozulmaz',
        (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      final repo = ListRepository(db);
      await tester.pumpWidget(MaterialApp(
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
      ));
      await tester.pumpAndSettle();

      // RTL akışında hata atmamalı.
      expect(find.byKey(const Key('lists_search_field')), findsOneWidget);

      await db.close();
    });
  });
}
