import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/data/db/app_database.dart';

const _enabled = bool.fromEnvironment('UI_REVIEW');
const _captureKey = Key('ui_review_capture');

typedef _Scenario = ({
  String name,
  Size size,
  Locale locale,
  ThemeMode theme,
  double textScale,
});

void main() {
  if (!_enabled) {
    test('UI review is opt-in', () {}, skip: 'Run with UI_REVIEW=true.');
    return;
  }

  const scenarios = <_Scenario>[
    (
      name: '412_light_tr',
      size: Size(412, 860),
      locale: Locale('tr'),
      theme: ThemeMode.light,
      textScale: 1,
    ),
    (
      name: '800_dark_tr',
      size: Size(800, 1000),
      locale: Locale('tr'),
      theme: ThemeMode.dark,
      textScale: 1,
    ),
    (
      name: '320_text2_ar',
      size: Size(320, 800),
      locale: Locale('ar'),
      theme: ThemeMode.light,
      textScale: 2,
    ),
  ];

  setUpAll(() async {
    WidgetsApp.debugAllowBannerOverride = false;
    await _loadFonts();
  });

  for (final scenario in scenarios) {
    testWidgets('SA-004 ${scenario.name}', (tester) async {
      debugDisableShadows = false;
      tester.view.physicalSize = scenario.size;
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = scenario.textScale;
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTouch;
      addTearDown(() {
        debugDisableShadows = true;
        tester.view.reset();
        tester.platformDispatcher.clearTextScaleFactorTestValue();
      });

      final db = AppDatabase(NativeDatabase.memory());
      const longTitle =
          'Haftalık aile marketi ve uzun mutfak ihtiyaçları listesi';
      await tester.runAsync(() async {
        await db
            .into(db.shoppingLists)
            .insert(
              ShoppingListsCompanion.insert(
                title: const Value(longTitle),
                currencyCode: 'TRY',
              ),
            );
        await db
            .into(db.shoppingLists)
            .insert(
              ShoppingListsCompanion.insert(
                title: const Value('Tamamlanan uzun alışveriş listesi'),
                currencyCode: 'TRY',
                status: const Value('completed'),
                completedAt: Value(DateTime(2026, 10, 14)),
              ),
            );
        await db
            .into(db.shoppingLists)
            .insert(
              ShoppingListsCompanion.insert(
                title: const Value('Arşivlenen uzun alışveriş listesi'),
                currencyCode: 'TRY',
                status: const Value('archived'),
                archivedAt: Value(DateTime(2026, 10, 13)),
              ),
            );
      });

      await tester.pumpWidget(
        RepaintBoundary(
          key: _captureKey,
          child: NShoptorApp(
            db: db,
            fixedLocale: scenario.locale,
            themeMode: scenario.theme,
          ),
        ),
      );
      await _settle(tester);
      expect(find.byKey(const Key('lists_new_list_button')), findsOneWidget);
      expect(find.byKey(const Key('lists_receipt_button')), findsOneWidget);
      await _capture(tester, '${scenario.name}_list');

      await tester.tap(find.byKey(const Key('lists_new_list_button')));
      await _settle(tester);
      expect(find.byKey(const Key('list_title_field')), findsOneWidget);
      expect(find.byKey(const Key('list_currency_field')), findsNothing);
      await _capture(tester, '${scenario.name}_form_collapsed');
      await tester.tap(find.byKey(const Key('list_cancel_button')));
      await _settle(tester);
      expect(await db.select(db.shoppingLists).get(), hasLength(3));
      await tester.tap(find.byKey(const Key('lists_new_list_button')));
      await _settle(tester);
      await tester.tap(find.byKey(const Key('list_title_field')));
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      expect(FocusManager.instance.primaryFocus, isNotNull);

      await tester.tap(find.byKey(const Key('list_details_expand')));
      await _settle(tester);
      expect(find.byKey(const Key('list_currency_field')), findsOneWidget);
      await _capture(tester, '${scenario.name}_form_details');
      await tester.enterText(
        find.byKey(const Key('list_title_field')),
        'Yeni uzun market listesi',
      );
      await _keyboardActivate(tester, 'list_save_button');
      await _settle(tester);
      expect(tester.takeException(), isNull);
      await tester.binding.handlePopRoute();
      await _settle(tester);
      expect(find.text('Yeni uzun market listesi'), findsOneWidget);

      await _keyboardActivate(tester, 'lists_tab_completed');
      await _settle(tester);
      expect(find.text('Tamamlanan uzun alışveriş listesi'), findsOneWidget);
      await _tapTab(tester, 'lists_tab_archived');
      await _settle(tester);
      expect(find.text('Arşivlenen uzun alışveriş listesi'), findsOneWidget);
      await _tapTab(tester, 'lists_tab_active');
      await _settle(tester);

      await tester.tap(find.byKey(const Key('lists_search_button')));
      await _settle(tester);
      await tester.enterText(
        find.byKey(const Key('lists_search_field')),
        'Yeni uzun',
      );
      await _settle(tester);
      expect(find.text('Yeni uzun market listesi'), findsOneWidget);
      expect(find.text(longTitle), findsNothing);
      expect(find.byKey(const Key('lists_new_list_button')), findsOneWidget);
      await _capture(tester, '${scenario.name}_search');

      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 1));
      await closing;
      debugDisableShadows = true;
    });
  }
}

Future<void> _loadFonts() async {
  final root = Platform.environment['FLUTTER_ROOT'] ?? 'C:/flutter';
  final materialFonts = '$root/bin/cache/artifacts/material_fonts';
  Future<ByteData> bytes(String path) async =>
      ByteData.sublistView(Uint8List.fromList(await File(path).readAsBytes()));

  final roboto = FontLoader('Roboto');
  for (final path in [
    'C:/Windows/Fonts/segoeui.ttf',
    'C:/Windows/Fonts/segoeuib.ttf',
  ]) {
    if (File(path).existsSync()) roboto.addFont(bytes(path));
  }
  await roboto.load();
  final icons = FontLoader('MaterialIcons')
    ..addFont(bytes('$materialFonts/materialicons-regular.otf'));
  await icons.load();
}

Future<void> _settle(WidgetTester tester) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull);
}

Future<void> _tapTab(WidgetTester tester, String key) async {
  final tab = find.byKey(Key(key));
  await tester.ensureVisible(tab);
  await tester.pumpAndSettle();
  await tester.tap(tab);
}

Future<void> _keyboardActivate(WidgetTester tester, String key) async {
  var target = tester.element(find.byKey(Key(key)));
  if (target.widget is Tab) {
    target.visitAncestorElements((element) {
      if (element.widget is InkWell) {
        target = element;
        return false;
      }
      return true;
    });
  }
  bool insideTarget() {
    if (Focus.maybeOf(target)?.hasPrimaryFocus ?? false) return true;
    final focused = FocusManager.instance.primaryFocus?.context;
    if (focused == null) return false;
    var inside = identical(focused, target);
    focused.visitAncestorElements((element) {
      if (identical(element, target)) inside = true;
      return !inside;
    });
    return inside;
  }

  for (var i = 0; i < 40 && !insideTarget(); i++) {
    if (FocusManager.instance.primaryFocus is FocusScopeNode) {
      FocusScope.of(target).nextFocus();
    }
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
  }
  expect(insideTarget(), isTrue, reason: '$key must be reachable with Tab');
  await tester.sendKeyEvent(LogicalKeyboardKey.enter);
  await tester.pumpAndSettle();
}

Future<void> _capture(WidgetTester tester, String name) async {
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull);
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(_captureKey),
  );
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 1);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    final directory = Directory('.store-automation/evidence/SA-004');
    await directory.create(recursive: true);
    await File('${directory.path}/$name.png')
        .writeAsBytes(data!.buffer.asUint8List());
    image.dispose();
  });
}
