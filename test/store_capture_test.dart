// Mağaza ekran görüntüleri (Play, 1080x1920). Normal `flutter test` koşusunda
// atlanır; üretmek için:
//   flutter test test/store_capture_test.dart --update-goldens
//     --dart-define=STORE_LOCALE=en|tr --dart-define=STORE_OUT=<klasör>
// Uygulama gerçek ekranlarını sürer (e2e akışı) ve her adımda görüntü alır.
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/data/db/app_database.dart';

const _locale = String.fromEnvironment('STORE_LOCALE');
const _out = String.fromEnvironment('STORE_OUT');

const _items = {
  'en': [
    ('Tomatoes', '42.90'),
    ('Bread', '12.00'),
    ('Milk 1 L', '34.50'),
    ('Eggs (10)', '78.00'),
    ('Olive oil', '389.90'),
    ('Rice 1 kg', '64.00'),
  ],
  'tr': [
    ('Domates', '42,90'),
    ('Ekmek', '12,00'),
    ('Süt 1 L', '34,50'),
    ('Yumurta (10)', '78,00'),
    ('Zeytinyağı', '389,90'),
    ('Pirinç 1 kg', '64,00'),
  ],
};

/// Test ortamı yazı tipi taşımaz; SDK'nın Roboto/MaterialIcons'unu yükler
/// (aksi halde her glif dolu kutu çizilir).
Future<void> _loadFonts() async {
  final root = Platform.environment['FLUTTER_ROOT'] ?? 'C:/flutter';
  final dir = '$root/bin/cache/artifacts/material_fonts';
  Future<ByteData> bytes(String f) async => ByteData.sublistView(
    Uint8List.fromList(await File('$dir/$f').readAsBytes()),
  );
  final roboto = FontLoader('Roboto');
  for (final f in [
    'roboto-regular.ttf',
    'roboto-medium.ttf',
    'roboto-bold.ttf',
    'roboto-light.ttf',
    'roboto-italic.ttf',
  ]) {
    roboto.addFont(bytes(f));
  }
  await roboto.load();
  final icons = FontLoader('MaterialIcons')
    ..addFont(bytes('materialicons-regular.otf'));
  await icons.load();
}

void main() {
  if (_locale.isEmpty) return;
  late AppDatabase db;
  setUpAll(() async {
    // Test bağlayıcısı gölgeleri düz siyah çerçeve çizer; gerçek gölge istenir.
    debugDisableShadows = false;
    WidgetsApp.debugAllowBannerOverride = false;
    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTouch;
    await _loadFonts();
  });

  Future<void> settle(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  }

  Future<void> shot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$_out/$name.png'),
    );
  }

  testWidgets('mağaza görüntüleri ($_locale)', (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTouch;

    db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(NShoptorApp(db: db, fixedLocale: Locale(_locale)));
    await settle(tester);

    // Liste oluştur
    await tester.tap(find.byKey(const Key('home_new_list_button')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('lists_new_list_button')));
    await settle(tester);
    await tester.enterText(
      find.byKey(const Key('list_title_field')),
      _locale == 'tr' ? 'Haftalık market' : 'Weekly groceries',
    );
    await tester.enterText(find.byKey(const Key('list_budget_field')), '1000');
    await tester.tap(find.byKey(const Key('list_save_button')));
    await settle(tester);
    await tester.tap(
      find.text(_locale == 'tr' ? 'Haftalık market' : 'Weekly groceries'),
    );
    await settle(tester);

    // Ürünler
    var first = true;
    for (final (name, price) in _items[_locale]!) {
      await tester.tap(find.byKey(const Key('detail_add_item_button')));
      await settle(tester);
      await tester.enterText(find.byKey(const Key('item_name_field')), name);
      await tester.enterText(find.byKey(const Key('item_price_field')), price);
      await settle(tester);
      if (first) {
        await shot(tester, '03'); // ürün formu
        first = false;
      }
      await tester.tap(find.byKey(const Key('item_save_button')));
      await settle(tester);
    }
    await shot(tester, '02'); // liste detayı

    // Alışveriş modu: üç ürüne gerçek fiyat
    await tester.tap(find.byKey(const Key('detail_start_shopping')));
    await settle(tester);
    final real = _locale == 'tr'
        ? ['45,00', '12,00', '36,90', '78,00', '399,90', '62,50']
        : ['45.00', '12.00', '36.90', '78.00', '399.90', '62.50'];
    for (var i = 0; i < real.length; i++) {
      if (i == 3) {
        await tester.drag(find.byType(Scrollable).last, const Offset(0, 800));
        await shot(tester, '04'); // alışveriş modu (yarı yolda)
      }
      await tester.ensureVisible(find.byType(Checkbox).at(i));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Checkbox).at(i));
      await settle(tester);
      await tester.enterText(
        find.byKey(const Key('entry_price_field')),
        real[i],
      );
      await settle(tester);
      if (i == 0) await shot(tester, '05'); // hızlı fiyat girişi
      await tester.tap(find.byKey(const Key('entry_save_button')));
      await settle(tester);
    }

    // Sonuç
    await tester.tap(find.byType(BackButton).first);
    await settle(tester);
    await tester.tap(find.byKey(const Key('detail_finish_button')));
    await settle(tester);
    await shot(tester, '06');

    // Ana ekran, Geçmiş, Ayarlar
    while (find.byType(NavigationBar).evaluate().isEmpty) {
      await tester.tap(find.byType(BackButton).first);
      await settle(tester);
    }
    Future<void> tab(int i) async {
      await tester.tap(find.byType(NavigationDestination).at(i));
      await settle(tester);
    }

    await tab(0);
    await shot(tester, '01');
    await tab(2);
    await shot(tester, '07');
    await tab(4);
    await shot(tester, '08');

    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  });
}
