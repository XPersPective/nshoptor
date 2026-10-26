import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/core/money/format_locale.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/shopping_mode/summary/summary_screen.dart';

const _enabled = bool.fromEnvironment('UI_REVIEW');
const _captureKey = Key('ui_detail_review_capture');
const _captureDir = String.fromEnvironment(
  'UI_REVIEW_DIR',
  defaultValue: 'artifacts/qa/ui-review/detail',
);

typedef _Scenario = ({
  String name,
  Size size,
  Locale locale,
  ThemeMode theme,
  double textScale,
});

void main() {
  if (!_enabled) {
    test('detail UI review is opt-in', () {}, skip: 'Run with UI_REVIEW=true.');
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
    testWidgets('Detail UI ${scenario.name}', (tester) async {
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
        AppFormatLocale.attachReset();
      });

      final db = AppDatabase(NativeDatabase.memory());
      AppFormatLocale.attach(
        scenario.locale.languageCode == 'tr' ? 'tr' : 'en',
      );
      final title = scenario.locale.languageCode == 'ar'
          ? 'قائمة التسوق الأسبوعية الطويلة للعائلة'
          : 'Haftalık uzun aile market listesi';
      const names = [
        'Organik domates ve uzun ürün açıklaması',
        'Süt ve kahvaltılık ürünler',
        'Extra virgin zeytinyağı büyük şişe',
        'خبز عربي طازج للعائلة الكبيرة',
        'Temizlik kağıdı 12’li ekonomik paket',
        'Bulaşık deterjanı limon kokulu',
      ];
      late int listId;
      final itemIds = <int>[];
      await tester.runAsync(() async {
        listId = await db
            .into(db.shoppingLists)
            .insert(
              ShoppingListsCompanion.insert(
                title: Value(title),
                currencyCode: 'TRY',
              ),
            );
        for (final (index, name) in names.indexed) {
          itemIds.add(
            await db
                .into(db.plannedItems)
                .insert(
                  PlannedItemsCompanion.insert(
                    listId: listId,
                    name: name,
                    normalizedName: name.toLowerCase(),
                    plannedQuantity: '${index + 1}',
                    plannedUnitCode: index.isEven ? 'kilogram' : 'adet',
                    pricingInputMode: 'unitPrice',
                    plannedUnitPrice: Value('${10 + index}'),
                    plannedLineTotalMinorUnits: Value(
                      (index + 1) * (10 + index) * 100,
                    ),
                    sortOrder: Value(index),
                  ),
                ),
          );
        }
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
      await tester.tap(find.text(title).first);
      await _settle(tester);

      expect(find.byKey(const Key('detail_quick_entry')), findsOneWidget);
      expect(find.byKey(const Key('detail_quick_list')), findsOneWidget);
      expect(find.byKey(const Key('item_voice_button')), findsNothing);
      await _capture(tester, '${scenario.name}_detail');

      await tester.tap(find.text(names.first).first);
      await _settle(tester);
      expect(find.byKey(const Key('item_actual_price_field')), findsOneWidget);
      expect(find.byKey(const Key('item_actual_quantity_field')), findsNothing);
      expect(find.byKey(const Key('item_details_expand')), findsOneWidget);
      await _capture(tester, '${scenario.name}_item_form');

      await tester.enterText(
        find.byKey(const Key('item_actual_price_field')),
        'geçersiz',
      );
      await _tapVisible(tester, 'item_save_button');
      expect(find.byKey(const Key('item_actual_quantity_field')), findsNothing);
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('item_actual_price_field')))
            .controller!
            .text,
        'geçersiz',
      );
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('item_actual_price_field')))
            .decoration!
            .errorText,
        isNotNull,
      );
      await _capture(tester, '${scenario.name}_invalid_price');

      final details = find
          .descendant(
            of: find.byKey(const Key('item_details_expand')),
            matching: find.byType(ListTile),
          )
          .first;
      await _center(tester, details);
      await tester.tap(details);
      await _settle(tester);
      expect(find.byKey(const Key('item_brand_field')), findsOneWidget);
      expect(find.byKey(const Key('item_note_field')), findsOneWidget);
      expect(find.byKey(const Key('item_discount_field')), findsNothing);
      await _center(tester, find.byKey(const Key('item_note_field')));
      await _capture(tester, '${scenario.name}_item_details');
      await tester.enterText(
        find.byKey(const Key('item_actual_price_field')),
        '12',
      );
      await _keyboardActivate(tester, 'item_save_button');
      await _settle(tester);
      final entries = await tester.runAsync(
        () => db.select(db.purchaseEntries).get(),
      );
      expect(entries, hasLength(1));
      expect(entries!.single.plannedItemId, itemIds.first);
      expect(entries.single.actualLineTotalMinorUnits, 1200);
      await _center(tester, find.byKey(Key('detail_item_${itemIds.first}')));
      await _capture(tester, '${scenario.name}_priced_detail');

      final unchecked = find.byKey(Key('detail_check_${itemIds[1]}'));
      await _center(tester, unchecked);
      await tester.tap(unchecked);
      await _settle(tester);
      expect(find.byKey(const Key('item_actual_price_field')), findsOneWidget);
      await tester.binding.handlePopRoute();
      await _settle(tester);
      expect(tester.widget<Checkbox>(unchecked).value, isFalse);
      final finish = find.byKey(const Key('detail_finish_button'));
      await tester.scrollUntilVisible(
        finish,
        300,
        scrollable: find
            .descendant(
              of: find.byType(ListView).first,
              matching: find.byType(Scrollable),
            )
            .first,
        maxScrolls: 50,
      );
      await _center(tester, finish);
      expect(
        tester.getTopLeft(find.byKey(const Key('detail_finish_button'))).dy,
        greaterThan(
          tester
              .getBottomLeft(find.byKey(Key('detail_item_${itemIds.last}')))
              .dy,
        ),
      );
      await _capture(tester, '${scenario.name}_finish');

      await tester.tap(finish);
      await _settle(tester);
      expect(find.byType(AlertDialog), findsOneWidget);
      await _capture(tester, '${scenario.name}_completion_warning');
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(FilledButton),
        ),
      );
      await _settle(tester);
      expect(find.byType(SummaryScreen), findsOneWidget);
      expect(
        (await tester.runAsync(() => db.select(db.shoppingLists).get()))!
            .single
            .status,
        'completed',
      );

      await tester.binding.handlePopRoute();
      await _settle(tester);
      expect(find.byKey(const Key('detail_quick_entry')), findsNothing);
      expect(find.byKey(const Key('detail_finish_button')), findsNothing);
      expect(
        tester
            .widget<Checkbox>(find.byKey(Key('detail_check_${itemIds.first}')))
            .onChanged,
        isNull,
      );

      await tester.binding.handlePopRoute();
      await _settle(tester);
      await _tapTab(tester, 'lists_tab_completed');
      await _settle(tester);
      expect(find.text(title), findsOneWidget);
      await _capture(tester, '${scenario.name}_completed');

      await tester.pumpWidget(const SizedBox.shrink());
      final closing = db.close();
      await tester.pump(const Duration(milliseconds: 1));
      await closing;
      await tester.pump();
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

Future<void> _tapVisible(
  WidgetTester tester,
  String key, {
  bool tap = true,
}) async {
  final target = find.byKey(Key(key));
  await _center(tester, target);
  if (tap) await tester.tap(target);
  await _settle(tester);
}

Future<void> _center(WidgetTester tester, Finder target) async {
  await Scrollable.ensureVisible(
    tester.element(target),
    alignment: .5,
    duration: Duration.zero,
  );
  await tester.pumpAndSettle();
}

Future<void> _keyboardActivate(WidgetTester tester, String key) async {
  final target = tester.element(find.byKey(Key(key)));
  bool focused() {
    if (Focus.maybeOf(target)?.hasPrimaryFocus ?? false) return true;
    final current = FocusManager.instance.primaryFocus?.context;
    if (current == null) return false;
    var inside = identical(current, target);
    current.visitAncestorElements((element) {
      if (identical(element, target)) inside = true;
      return !inside;
    });
    return inside;
  }

  for (var i = 0; i < 40 && !focused(); i++) {
    if (FocusManager.instance.primaryFocus is FocusScopeNode) {
      FocusScope.of(target).nextFocus();
    }
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
  }
  expect(focused(), isTrue, reason: '$key must be reachable with Tab');
  await tester.sendKeyEvent(LogicalKeyboardKey.enter);
  await tester.pumpAndSettle();
}

Future<void> _tapTab(WidgetTester tester, String key) async {
  final tab = find.byKey(Key(key));
  await tester.ensureVisible(tab);
  await tester.pumpAndSettle();
  await tester.tap(tab);
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
    final directory = Directory(_captureDir);
    await directory.create(recursive: true);
    await File('${directory.path}/$name.png')
        .writeAsBytes(data!.buffer.asUint8List());
    image.dispose();
  });
}
