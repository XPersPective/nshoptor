// Mağaza ekran görüntüleri (Play, 1080x1920). Normal `flutter test` koşusunda
// atlanır; üretmek için:
//   flutter test test/store_capture_test.dart --update-goldens
//     --dart-define=STORE_LOCALE=<tr|en|de|fr|es|it|pt|ru|ar>
//     --dart-define=STORE_OUT=<klasör>
// Uygulama gerçek ekranlarını sürer (e2e akışı) ve her adımda görüntü alır.
import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';

import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/core/money/locale_conventions.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';

const _locale = String.fromEnvironment('STORE_LOCALE');
const _out = String.fromEnvironment('STORE_OUT');

/// Dil başına: liste adı, para birimi, bütçe, (ürün, tahmini), gerçek fiyatlar
/// ve takvim/grafik için geçmiş alışveriş tutarları (minor).
typedef _Data = ({
  String list,
  String currency,
  String budget,
  List<(String, String)> items,
  List<String> real,
  List<int> pastMinor,
});

const Map<String, _Data> _data = {
  'tr': (
    list: 'Haftalık market', currency: 'TRY', budget: '1000',
    items: [('Domates', '42,90'), ('Ekmek', '12,00'), ('Süt 1 L', '34,50'), ('Yumurta (10)', '78,00'), ('Zeytinyağı', '389,90'), ('Pirinç 1 kg', '64,00')],
    real: ['45,00', '12,00', '36,90', '78,00', '399,90', '62,50'],
    pastMinor: [58200, 31450, 74900, 22800, 66300, 81200],
  ),
  'en': (
    list: 'Weekly groceries', currency: 'USD', budget: '40',
    items: [('Tomatoes', '3.49'), ('Bread', '2.99'), ('Milk 1 gal', '3.79'), ('Eggs (12)', '4.29'), ('Olive oil', '9.99'), ('Rice 2 lb', '2.49')],
    real: ['3.99', '2.99', '4.19', '4.29', '10.49', '2.29'],
    pastMinor: [6420, 3810, 8890, 2750, 7120, 9430],
  ),
  'de': (
    list: 'Wocheneinkauf', currency: 'EUR', budget: '30',
    items: [('Tomaten', '2,49'), ('Brot', '2,19'), ('Milch 1 L', '1,15'), ('Eier (10)', '2,99'), ('Olivenöl', '8,99'), ('Reis 1 kg', '1,89')],
    real: ['2,79', '2,19', '1,25', '2,99', '9,49', '1,79'],
    pastMinor: [5230, 2940, 7180, 2210, 6050, 8320],
  ),
  'fr': (
    list: 'Courses de la semaine', currency: 'EUR', budget: '30',
    items: [('Tomates', '2,49'), ('Baguette', '1,10'), ('Lait 1 L', '1,05'), ('Œufs (12)', '3,49'), ("Huile d'olive", '8,99'), ('Riz 1 kg', '1,99')],
    real: ['2,79', '1,10', '1,15', '3,49', '9,49', '1,89'],
    pastMinor: [5480, 3120, 6890, 2430, 5960, 7740],
  ),
  'es': (
    list: 'Compra semanal', currency: 'EUR', budget: '30',
    items: [('Tomates', '2,29'), ('Pan', '1,20'), ('Leche 1 L', '0,99'), ('Huevos (12)', '2,89'), ('Aceite de oliva', '8,49'), ('Arroz 1 kg', '1,59')],
    real: ['2,59', '1,20', '1,09', '2,89', '8,99', '1,49'],
    pastMinor: [4870, 2760, 6420, 2180, 5530, 7110],
  ),
  'it': (
    list: 'Spesa settimanale', currency: 'EUR', budget: '30',
    items: [('Pomodori', '2,39'), ('Pane', '1,80'), ('Latte 1 L', '1,29'), ('Uova (10)', '2,79'), ("Olio d'oliva", '8,99'), ('Riso 1 kg', '1,99')],
    real: ['2,69', '1,80', '1,39', '2,79', '9,49', '1,89'],
    pastMinor: [5110, 2980, 6970, 2350, 5840, 7620],
  ),
  'pt': (
    list: 'Compras da semana', currency: 'EUR', budget: '30',
    items: [('Tomate', '2,19'), ('Pão', '1,50'), ('Leite 1 L', '0,89'), ('Ovos (12)', '2,99'), ('Azeite', '7,99'), ('Arroz 1 kg', '1,49')],
    real: ['2,49', '1,50', '0,99', '2,99', '8,49', '1,39'],
    pastMinor: [4690, 2610, 6230, 2040, 5370, 6980],
  ),
  'ru': (
    list: 'Покупки на неделю', currency: 'RUB', budget: '2500',
    items: [('Помидоры', '249,00'), ('Хлеб', '59,00'), ('Молоко 1 л', '99,00'), ('Яйца (10)', '129,00'), ('Оливковое масло', '899,00'), ('Рис 1 кг', '119,00')],
    real: ['279,00', '59,00', '109,00', '129,00', '949,00', '109,00'],
    pastMinor: [384000, 219000, 512000, 167000, 433000, 561000],
  ),
  'ar': (
    list: 'تسوّق الأسبوع', currency: 'USD', budget: '40',
    items: [('طماطم', '3.49'), ('خبز', '2.99'), ('حليب 1 لتر', '3.79'), ('بيض (12)', '4.29'), ('زيت زيتون', '9.99'), ('أرز 1 كغ', '2.49')],
    real: ['3.99', '2.99', '4.19', '4.29', '10.49', '2.29'],
    pastMinor: [6420, 3810, 8890, 2750, 7120, 9430],
  ),
};

/// Elle yazılmamış diller: test/store_samples.json'daki çevrilmiş adlar; fiyatlar
/// dilin ondalık yazımıyla (virgüllü dillerde EUR, diğerlerinde USD).
_Data _dataFor(String code) {
  final hand = _data[code];
  if (hand != null) return hand;
  final s = (jsonDecode(File('test/store_samples.json').readAsStringSync()) as Map)[code] as Map;
  final comma = usesCommaDecimal(code) && usesLatinDigits(code);
  String n(String v) => comma ? v.replaceAll('.', ',') : v;
  const est = ['2.49', '2.19', '1.15', '2.99', '8.99', '1.89'];
  return (
    list: s['list'] as String,
    currency: comma ? 'EUR' : 'USD',
    budget: '30',
    items: [for (var i = 0; i < 6; i++) (s['i$i'] as String, n(est[i]))],
    real: ['2.79', '2.19', '1.25', '2.99', '9.49', '1.79'].map(n).toList(),
    pastMinor: const [5230, 2940, 7180, 2210, 6050, 8320],
  );
}

/// Betik başına tek yazı tipi (Latin dahil) — test ortamında glif yedeği yok.
/// Dil → Windows yazı tipi dosyaları (kalın dosya ikinci sırada).
const _fonts = <String, List<String>>{
  'th': ['LeelawUI.ttf'], 'lo': ['LeelawUI.ttf'],
  'hi': ['Nirmala.ttc'], 'bn': ['Nirmala.ttc'], 'gu': ['Nirmala.ttc'], 'kn': ['Nirmala.ttc'],
  'ml': ['Nirmala.ttc'], 'mr': ['Nirmala.ttc'], 'ne': ['Nirmala.ttc'], 'pa': ['Nirmala.ttc'],
  'si': ['Nirmala.ttc'], 'ta': ['Nirmala.ttc'], 'te': ['Nirmala.ttc'],
  'ja': ['YuGothR.ttc', 'YuGothB.ttc'], 'ko': ['malgun.ttf', 'malgunbd.ttf'],
  'zh': ['msyh.ttc', 'msyhbd.ttc'], 'my': ['mmrtext.ttf', 'mmrtextb.ttf'],
  'ar': ['segoeui.ttf', 'segoeuib.ttf', 'seguisb.ttf'], 'fa': ['segoeui.ttf', 'segoeuib.ttf'],
  'ur': ['segoeui.ttf', 'segoeuib.ttf'], 'he': ['segoeui.ttf', 'segoeuib.ttf'],
  'ka': ['segoeui.ttf', 'segoeuib.ttf'], 'hy': ['segoeui.ttf', 'segoeuib.ttf'], 'ps': ['segoeui.ttf', 'segoeuib.ttf'],
};

/// Test ortamı yazı tipi taşımaz; SDK'nın Roboto/MaterialIcons'unu yükler
/// (aksi halde her glif dolu kutu çizilir). Arapça için Segoe UI.
Future<void> _loadFonts() async {
  final root = Platform.environment['FLUTTER_ROOT'] ?? 'C:/flutter';
  final dir = '$root/bin/cache/artifacts/material_fonts';
  Future<ByteData> bytes(String path) async =>
      ByteData.sublistView(Uint8List.fromList(await File(path).readAsBytes()));
  final roboto = FontLoader('Roboto');
  final win = _fonts[_locale];
  final files = win != null
      ? [for (final f in win) 'C:/Windows/Fonts/$f']
      : ['$dir/roboto-regular.ttf', '$dir/roboto-medium.ttf', '$dir/roboto-bold.ttf', '$dir/roboto-light.ttf', '$dir/roboto-italic.ttf'];
  for (final f in files) {
    if (File(f).existsSync()) roboto.addFont(bytes(f));
  }
  await roboto.load();
  final icons = FontLoader('MaterialIcons')..addFont(bytes('$dir/materialicons-regular.otf'));
  await icons.load();
}

String _past(DateTime now, int i) {
  final d = now.subtract(Duration(days: 3 + i * 7));
  return '${d.day}.${d.month}';
}

void main() {
  if (_locale.isEmpty) return;
  final data = _dataFor(_locale);
  late AppDatabase db;
  setUpAll(() async {
    // Test bağlayıcısı gölgeleri düz siyah çerçeve çizer; gerçek gölge istenir.
    debugDisableShadows = false;
    WidgetsApp.debugAllowBannerOverride = false;
    await _loadFonts();
    // Alışveriş modu ekranı açık tutar; test ortamında eklenti yok.
    const pigeon = 'dev.flutter.pigeon.wakelock_plus_platform_interface.WakelockPlusApi';
    for (final (name, reply) in [('toggle', null), ('isEnabled', false)]) {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
          '$pigeon.$name', (_) async => const StandardMessageCodec().encodeMessage(<Object?>[reply]));
    }
  });

  Future<void> settle(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    // Taşma/yerleşim hatası görüntüyü bozar: dil başına yakalanır.
    expect(tester.takeException(), isNull);
  }

  Future<void> shot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('$_out/$name.png'));
  }

  testWidgets('mağaza görüntüleri ($_locale)', (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    FocusManager.instance.highlightStrategy = FocusHighlightStrategy.alwaysTouch;

    final store = SettingsStore()..setString(SettingsRepository.currencyKey, data.currency);
    AppDefaults.attach(store);
    db = AppDatabase(NativeDatabase.memory());

    // Takvim ve grafikler dolu görünsün: geçmiş tamamlanmış alışverişler.
    await tester.runAsync(() async {
      final now = DateTime.now();
      for (final (i, minor) in data.pastMinor.indexed) {
        final id = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(
              currencyCode: data.currency,
              status: const Value('completed'),
              completedAt: Value(now.subtract(Duration(days: 3 + i * 7, hours: 2))),
              title: Value('${data.list} · ${_past(now, i)}'),
            ));
        await db.into(db.purchaseEntries).insert(PurchaseEntriesCompanion.insert(
              listId: id, name: '-', normalizedName: '-', actualQuantity: '1',
              actualUnitCode: 'piece', actualLineTotalMinorUnits: minor));
      }
    });

    await tester.pumpWidget(NShoptorApp(db: db, fixedLocale: Locale(_locale)));
    await settle(tester);

    // Liste oluştur
    await tester.tap(find.byKey(const Key('home_new_list_button')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('lists_new_list_button')));
    await settle(tester);
    await tester.enterText(find.byKey(const Key('list_title_field')), data.list);
    await tester.enterText(find.byKey(const Key('list_budget_field')), data.budget);
    await tester.tap(find.byKey(const Key('list_save_button')));
    await settle(tester);
    await tester.tap(find.text(data.list).last);
    await settle(tester);

    // Ürünler
    var first = true;
    for (final (name, price) in data.items) {
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

    // Ana sayfa: etkin liste + aylık kart + asistan
    await tester.tap(find.byType(BackButton).first);
    await settle(tester);
    await tester.tap(find.byType(NavigationDestination).at(0));
    await settle(tester);
    await shot(tester, '01');
    await tester.tap(find.byType(NavigationDestination).at(1));
    await settle(tester);
    await tester.tap(find.text(data.list).last);
    await settle(tester);

    // Alışveriş modu: gerçek fiyatlar
    await tester.tap(find.byKey(const Key('detail_start_shopping')));
    await settle(tester);
    for (var i = 0; i < data.real.length; i++) {
      if (i == 3) {
        await tester.drag(find.byType(Scrollable).last, const Offset(0, 800));
        await shot(tester, '04'); // alışveriş modu (yarı yolda)
      }
      // Liste tembeldir: dil/yazı tipi yüksekliğine göre görünen satır sayısı değişir.
      final box = find.descendant(
          of: find.widgetWithText(ListTile, data.items[i].$1), matching: find.byType(Checkbox));
      await tester.scrollUntilVisible(box, 120, scrollable: find.byType(Scrollable).last);
      await tester.pumpAndSettle();
      await tester.tap(box);
      await settle(tester);
      await tester.enterText(find.byKey(const Key('entry_price_field')), data.real[i]);
      await settle(tester);
      if (i == 0) await shot(tester, '05'); // hızlı fiyat girişi
      await tester.tap(find.byKey(const Key('entry_save_button')));
      await settle(tester);
    }

    // Sonuç: tek bakışta karşılaştırma tablosu
    await tester.tap(find.byType(BackButton).first);
    await settle(tester);
    await tester.tap(find.byKey(const Key('detail_finish_button')));
    await settle(tester);
    await shot(tester, '06');

    while (find.byType(NavigationBar).evaluate().isEmpty) {
      await tester.tap(find.byType(BackButton).first);
      await settle(tester);
    }
    Future<void> tab(int i) async {
      await tester.tap(find.byType(NavigationDestination).at(i));
      await settle(tester);
    }

    // Harcamalar: takvim, grafikler
    await tab(2);
    await tester.tap(find.byKey(const Key('history_spending')));
    await settle(tester);
    await shot(tester, '07');
    await tester.tap(find.byType(BackButton).first);
    await settle(tester);

    // Asistan
    await tab(0);
    await tester.tap(find.byKey(const Key('assistant_bubble')));
    await settle(tester);
    await shot(tester, '08');

    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
    debugDisableShadows = true; // test bağlayıcısının değişmezi
  });
}
