import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart' show SettingsStore;
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/home/home_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';

void main() {
  late AppDatabase db;
  late ListRepository repository;

  setUp(() {
    AppDefaults.attach(SettingsStore());
    db = AppDatabase(NativeDatabase.memory());
    repository = ListRepository(db);
  });

  Widget app({
    String locale = 'tr',
    Brightness brightness = Brightness.light,
    double textScale = 1,
    Future<String?> Function()? pickImage,
  }) => MaterialApp(
    locale: Locale(locale),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    theme: brightness == Brightness.light ? AppTheme.light() : AppTheme.dark(),
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: TextScaler.linear(textScale)),
      child: child!,
    ),
    home: HomeShell(db: db, listRepository: repository, pickImage: pickImage),
  );

  Future<void> settle(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  }

  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  for (final width in [320.0, 800.0]) {
    for (final brightness in Brightness.values) {
      for (final locale in ['tr', 'ar']) {
        testWidgets('home controls fit $width $brightness $locale at 2x text', (
          tester,
        ) async {
          tester.view.physicalSize = Size(width, 900);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          await tester.pumpWidget(
            app(locale: locale, brightness: brightness, textScale: 2),
          );
          await settle(tester);

          expect(tester.takeException(), isNull);
          expect(
            tester
                .widget<NavigationBar>(find.byType(NavigationBar))
                .destinations,
            hasLength(3),
          );
          final creation = tester.getRect(
            find.byKey(const Key('lists_new_list_button')),
          );
          final receipt = tester.getRect(
            find.byKey(const Key('lists_receipt_button')),
          );
          expect(creation.width, closeTo(receipt.width, 1));
          expect(creation.height, receipt.height);
          expect(creation.height, greaterThanOrEqualTo(48));
          expect(creation.overlaps(receipt), isFalse);
          for (final key in [
            'lists_search_button',
            'lists_sort_button',
            'home_nav_discover',
          ]) {
            final control = find.byKey(Key(key));
            expect(
              tester.getSize(control).shortestSide,
              greaterThanOrEqualTo(48),
            );
            expect(tester.widget<IconButton>(control).tooltip, isNotEmpty);
          }
          expect(find.byKey(const Key('lists_tools_button')), findsNothing);
          expect(
            receipt.bottom,
            lessThanOrEqualTo(tester.getTopLeft(find.byType(NavigationBar)).dy),
          );
          await close(tester);
        });
      }
    }
  }

  testWidgets(
    'home new list cancels safely and search filters the saved lists',
    (tester) async {
      await repository.createList(title: 'Market', currencyCode: 'TRY');
      await repository.createList(title: 'Pazar', currencyCode: 'TRY');
      await tester.pumpWidget(app());
      await settle(tester);
      await tester.tap(find.byKey(const Key('lists_new_list_button')));
      await settle(tester);
      expect(find.text('Alışveriş tarihi'), findsOneWidget);
      expect(find.text('Tarih belirlenmedi'), findsNothing);
      await tester.tap(find.byKey(const Key('list_cancel_button')));
      await settle(tester);
      expect(await db.select(db.shoppingLists).get(), hasLength(2));
      await tester.tap(find.byKey(const Key('lists_search_button')));
      await settle(tester);
      await tester.enterText(
        find.byKey(const Key('lists_search_field')),
        'Market',
      );
      await tester.pump();
      expect(
        find.descendant(of: find.byType(Card), matching: find.text('Market')),
        findsOneWidget,
      );
      expect(find.text('Pazar'), findsNothing);
      await tester.tap(find.byKey(const Key('lists_search_button')));
      await settle(tester);
      expect(find.text('Pazar'), findsOneWidget);
      await close(tester);
    },
  );

  testWidgets(
    'receipt action stays in place and deduplicates capture while pending',
    (tester) async {
      final picked = Completer<String?>();
      var captures = 0;
      await tester.pumpWidget(
        app(
          pickImage: () {
            captures++;
            return picked.future;
          },
        ),
      );
      await settle(tester);
      final button = find.byKey(const Key('lists_receipt_button'));
      final before = tester.getRect(button);
      await tester.tap(button);
      await tester.pump();
      expect(tester.widget<FilledButton>(button).onPressed, isNull);
      await tester.tap(button);
      await tester.pump();
      expect(captures, 1);
      expect(tester.getRect(button), before);
      picked.complete(null);
      await settle(tester);
      expect(tester.widget<FilledButton>(button).onPressed, isNotNull);
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      await close(tester);
    },
  );
}
