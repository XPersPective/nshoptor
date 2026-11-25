import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:napp_core/napp_core.dart' show SettingsStore;
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/core/money/decimal_fixed.dart';
import 'package:nshoptor/core/theme/app_theme.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/home/home_screen.dart';
import 'package:nshoptor/features/lists/item_repository.dart';
import 'package:nshoptor/features/lists/list_detail_screen.dart';
import 'package:nshoptor/features/lists/list_repository.dart';
import 'package:nshoptor/features/onboarding/first_run_guide.dart';

const _delegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

Widget _app(
  Widget home, {
  String language = 'tr',
  double scale = 1,
  bool dark = false,
  bool reduceMotion = false,
}) => MaterialApp(
  locale: Locale(language),
  theme: dark ? AppTheme.dark() : AppTheme.light(),
  localizationsDelegates: _delegates,
  supportedLocales: AppLocalizations.supportedLocales,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(
      textScaler: TextScaler.linear(scale),
      disableAnimations: reduceMotion,
    ),
    child: child!,
  ),
  home: home,
);

final _next = find.byKey(const Key('first_run_guide_next'));
final _skip = find.byKey(const Key('first_run_guide_close'));
final _back = find.byKey(const Key('first_run_guide_back'));
final _card = find.byKey(const Key('first_run_guide'));
final _highlight = find.byKey(const Key('coach_tour_highlight'));

/// The highlight hole surrounds the target control.
void _expectHighlights(WidgetTester tester, Finder target) {
  expect(_highlight, findsOneWidget);
  final hole = tester.getRect(_highlight);
  final rect = tester.getRect(target);
  expect(hole.inflate(1).contains(rect.topLeft), isTrue, reason: '$hole $rect');
  expect(
    hole.inflate(1).contains(rect.bottomRight),
    isTrue,
    reason: '$hole $rect',
  );
}

void main() {
  setUp(() => AppDefaults.attach(SettingsStore()));

  group('standalone guide (no anchors on screen)', () {
    Future<void> open(WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                key: const Key('open_guide'),
                onPressed: () => showFirstRunGuide(context),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('open_guide')));
      await tester.pumpAndSettle();
    }

    testWidgets('finishes, records seen, queues the list part and reopens', (
      tester,
    ) async {
      expect(AppDefaults.guideSeen(), isFalse);
      await open(tester);
      for (var i = 1; i <= 4; i++) {
        expect(find.text('$i / 4'), findsOneWidget);
        expect(_highlight, findsNothing);
        expect(AppDefaults.guideSeen(), isFalse);
        await tester.tap(_next);
        await tester.pumpAndSettle();
      }
      expect(_card, findsNothing);
      expect(AppDefaults.guideSeen(), isTrue);
      expect(AppDefaults.detailTourPending(), isTrue);
      await tester.tap(find.byKey(const Key('open_guide')));
      await tester.pumpAndSettle();
      expect(find.text('1 / 4'), findsOneWidget);
    });

    testWidgets('back, skip and system back', (tester) async {
      await open(tester);
      expect(_back, findsNothing);
      await tester.tap(_next);
      await tester.pumpAndSettle();
      expect(find.text('2 / 4'), findsOneWidget);
      // The receipt flow step explains top-first capture with a diagram.
      expect(find.byKey(const Key('scan_guide_visual')), findsOneWidget);
      await tester.tap(_back);
      await tester.pumpAndSettle();
      expect(find.text('1 / 4'), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(_card, findsNothing);
      expect(AppDefaults.guideSeen(), isFalse);

      await tester.tap(find.byKey(const Key('open_guide')));
      await tester.pumpAndSettle();
      await tester.tap(_skip);
      await tester.pumpAndSettle();
      expect(_card, findsNothing);
      expect(AppDefaults.guideSeen(), isTrue);
      expect(AppDefaults.detailTourPending(), isFalse);
    });

    testWidgets('step text is announced for screen readers', (tester) async {
      final handle = tester.ensureSemantics();
      await open(tester);
      expect(
        tester.getSemantics(find.byKey(const Key('coach_tour_title'))),
        isNotNull,
      );
      expect(
        find.bySemanticsLabel(RegExp('How to use|Nasıl kullanılır')),
        findsWidgets,
      );
      handle.dispose();
    });
  });

  group('lists home', () {
    late AppDatabase db;
    late ListRepository repository;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repository = ListRepository(db);
    });

    Future<void> close(WidgetTester tester) async {
      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 1));
      await closing;
    }

    Widget shell({bool firstRun = true}) => HomeShell(
      db: db,
      listRepository: repository,
      pickImage: () async => null,
      firstRunGuide: firstRun,
    );

    testWidgets('first launch tours the real controls with highlights', (
      tester,
    ) async {
      await tester.pumpWidget(_app(shell()));
      await tester.pumpAndSettle();
      expect(_card, findsOneWidget);
      final targets = <Finder?>[
        find.byKey(const Key('lists_new_list_button')),
        find.byKey(const Key('lists_receipt_button')),
        null,
        find.byKey(const Key('lists_tab_active')),
        find.byKey(const Key('home_nav_discover')),
        find.byKey(const Key('home_plan_badge')),
        find.byKey(const Key('lists_help_button')),
      ];
      for (final (i, target) in targets.indexed) {
        expect(find.text('${i + 1} / ${targets.length}'), findsOneWidget);
        if (target == null) {
          expect(_highlight, findsNothing);
        } else {
          _expectHighlights(tester, target);
        }
        await tester.tap(_next);
        await tester.pumpAndSettle();
      }
      expect(_card, findsNothing);
      expect(AppDefaults.guideSeen(), isTrue);
      await close(tester);
    });

    testWidgets('seen guide stays closed; help button and Settings reopen', (
      tester,
    ) async {
      AppDefaults.markGuideSeen();
      await tester.pumpWidget(_app(shell()));
      await tester.pumpAndSettle();
      expect(_card, findsNothing);

      await tester.tap(find.byKey(const Key('lists_help_button')));
      await tester.pumpAndSettle();
      expect(find.text('1 / 7'), findsOneWidget);
      _expectHighlights(tester, find.byKey(const Key('lists_new_list_button')));
      await tester.tap(_skip);
      await tester.pumpAndSettle();
      expect(_card, findsNothing);
      await close(tester);
    });

    testWidgets('Settings "How to use" switches to lists and tours them', (
      tester,
    ) async {
      AppDefaults.markGuideSeen();
      await tester.pumpWidget(_app(shell()));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const Key('lists_help_button')).hitTestable(),
        findsNothing,
      );
      // SettingsPlaceholder has no guide row in this shell, so call the same
      // entry the Settings row uses from a context below the host.
      final settingsContext = tester.element(find.byType(SettingsPlaceholder));
      final opened = showFirstRunGuide(settingsContext);
      await tester.pumpAndSettle();
      expect(find.text('1 / 7'), findsOneWidget);
      _expectHighlights(tester, find.byKey(const Key('lists_new_list_button')));
      expect(
        find.byKey(const Key('lists_new_list_button')).hitTestable(),
        findsNothing, // covered by the tour while it runs
      );
      await tester.tap(_skip);
      await tester.pumpAndSettle();
      await opened;
      expect(
        find.byKey(const Key('lists_help_button')).hitTestable(),
        findsOneWidget,
      );
      await close(tester);
    });

    for (final language in ['tr', 'en', 'ar', 'de']) {
      for (final dark in [false, true]) {
        testWidgets('tour fits 320dp at 2x text $language dark=$dark', (
          tester,
        ) async {
          tester.view.physicalSize = const Size(320, 640);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          await tester.pumpWidget(
            _app(shell(), language: language, scale: 2, dark: dark),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          final brand = find.ancestor(
            of: find.byKey(const Key('brand_title')),
            matching: find.byType(FittedBox),
          );
          expect(tester.getSize(brand).width, greaterThan(60));
          if (language == 'ar') {
            // RTL: at 320dp the help button sits beside sort, at the start
            // (left) end of the tabs row.
            expect(
              tester.getCenter(find.byKey(const Key('lists_help_button'))).dx,
              lessThan(160),
            );
          }
          var steps = 0;
          while (_card.evaluate().isNotEmpty) {
            steps++;
            expect(tester.takeException(), isNull);
            expect(_next.hitTestable(), findsOneWidget);
            final next = tester.getSize(_next);
            expect(next.height, greaterThanOrEqualTo(48));
            final card = tester.getRect(_card);
            expect(card.left, greaterThanOrEqualTo(0));
            expect(card.right, lessThanOrEqualTo(320));
            await tester.tap(_next);
            await tester.pumpAndSettle();
          }
          expect(steps, 7);
          expect(tester.takeException(), isNull);
          await close(tester);
        });
      }
    }

    for (final width in [320.0, 400.0]) {
      testWidgets('brand stays readable at ${width}dp in every language', (
        tester,
      ) async {
        AppDefaults.markGuideSeen();
        tester.view.physicalSize = Size(width, 640);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        for (final locale in AppLocalizations.supportedLocales) {
          await tester.pumpWidget(
            _app(shell(firstRun: false), language: locale.languageCode),
          );
          await tester.pumpAndSettle();
          // Locales without Material translations only log a warning.
          final error = tester.takeException();
          expect(
            error == null || '$error'.startsWith('Warning'),
            isTrue,
            reason: '$locale $error',
          );
          final brand = find.ancestor(
            of: find.byKey(const Key('brand_title')),
            matching: find.byType(FittedBox),
          );
          expect(
            tester.getSize(brand).width,
            greaterThan(60),
            reason: '$locale',
          );
          // The help button is in the app bar when there is room, else in
          // the tabs row; it is always a 48dp target.
          final help = find.byKey(const Key('lists_help_button'));
          expect(tester.getSize(help).height, greaterThanOrEqualTo(48));
          final helpY = tester.getCenter(help).dy;
          final tabY = tester
              .getCenter(find.byKey(const Key('lists_sort_button')))
              .dy;
          expect((helpY - tabY).abs() < 1, width < 380, reason: '$locale');
        }
        await close(tester);
      });
    }

    testWidgets('reduced motion still runs the tour', (tester) async {
      await tester.pumpWidget(_app(shell(), reduceMotion: true));
      await tester.pump();
      await tester.pump();
      await tester.pump();
      expect(_card, findsOneWidget);
      await tester.tap(_skip);
      await tester.pump();
      await tester.pump();
      expect(_card, findsNothing);
      expect(AppDefaults.guideSeen(), isTrue);
      await close(tester);
    });
  });

  group('list detail', () {
    late AppDatabase db;
    late ListRepository lists;
    late int listId;

    Future<void> seed(WidgetTester tester, {bool withItem = true}) async {
      db = AppDatabase(NativeDatabase.memory());
      lists = ListRepository(db);
      await tester.runAsync(() async {
        listId = await lists.createList(title: 'Tour', currencyCode: 'TRY');
        if (withItem) {
          await ItemRepository(db).addItem(
            listId: listId,
            name: 'Elma',
            quantity: DecimalFixed.fromInt(1),
            unitCode: 'piece',
            priceIsUnitPrice: false,
          );
        }
      });
    }

    Future<void> close(WidgetTester tester) async {
      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 1));
      await closing;
    }

    Widget detail() =>
        ListDetailScreen(db: db, listRepository: lists, listId: listId);

    testWidgets('continues once after the lists tour, highlighting controls', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await seed(tester);
      AppDefaults.setDetailTourPending(true);
      await tester.pumpWidget(_app(detail()));
      await tester.pumpAndSettle();
      expect(find.text('1 / 4'), findsOneWidget);
      expect(AppDefaults.detailTourPending(), isFalse);
      final targets = [
        find.byKey(const Key('detail_totals')),
        find.byKey(const Key('detail_products_header')),
        find.byKey(const Key('detail_quick_entry')),
        find.byKey(const Key('detail_receipt_button')),
      ];
      for (final (i, target) in targets.indexed) {
        expect(find.text('${i + 1} / 4'), findsOneWidget);
        _expectHighlights(tester, target);
        await tester.tap(_next);
        await tester.pumpAndSettle();
      }
      expect(_card, findsNothing);
      await close(tester);
    });

    testWidgets('not shown unless queued; reopens from the menu', (
      tester,
    ) async {
      await seed(tester, withItem: false);
      await tester.pumpWidget(_app(detail(), language: 'ar'));
      await tester.pumpAndSettle();
      expect(_card, findsNothing);
      await tester.tap(find.byKey(const Key('detail_more_menu')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('detail_how_to_use')));
      await tester.pumpAndSettle();
      // Empty list: no Items row, so its optional step is dropped.
      expect(find.text('1 / 3'), findsOneWidget);
      expect(Directionality.of(tester.element(_card)), TextDirection.rtl);
      await tester.tap(_skip);
      await tester.pumpAndSettle();
      expect(_card, findsNothing);
      expect(tester.takeException(), isNull);
      await close(tester);
    });
  });

  testWidgets('camera help dialog renders visual guide diagram and closes', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => Scaffold(
            body: Row(
              children: [
                IconButton(
                  key: const Key('open_receipt_help'),
                  onPressed: () => showScanHelpDialog(context, isReceipt: true),
                  icon: const Icon(Icons.help_outline),
                ),
                IconButton(
                  key: const Key('open_shelf_help'),
                  onPressed: () =>
                      showScanHelpDialog(context, isReceipt: false),
                  icon: const Icon(Icons.help_outline),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byKey(const Key('open_receipt_help')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('scan_help_dialog')), findsOneWidget);
    expect(find.byKey(const Key('scan_guide_visual')), findsOneWidget);
    await tester.tap(find.byKey(const Key('scan_help_close')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('scan_help_dialog')), findsNothing);

    await tester.tap(find.byKey(const Key('open_shelf_help')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('scan_help_dialog')), findsOneWidget);
    expect(find.byKey(const Key('scan_guide_visual')), findsOneWidget);
    await tester.tap(find.byKey(const Key('scan_help_close')));
    await tester.pumpAndSettle();
  });
}
