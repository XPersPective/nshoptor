// Uçtan uca ana akış (spec §13, T14):
// liste oluştur → ondalıklı ürün ekle → alışverişi başlat → gerçek fiyat gir
// → tamamla → sonuç ekranı → dil değişimi → yeniden başlatma sonrası kalıcılık.
//
// `flutter test integration_test/app_e2e_test.dart` ile host üzerinde koşar.
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/data/db/app_database.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  late AppDatabase db;

  Future<void> disposeApp(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    final closing = db.close();
    await tester.pump(const Duration(milliseconds: 1));
    await closing;
  }

  Future<void> settle(WidgetTester tester) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
  }

  testWidgets('uçtan uca: planla → alışveriş → sonuç → kalıcılık',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1800));
    // E2E için ayrı bellek-içi veritabanı (cihaz DB'sine dokunmaz).
    db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(NShoptorApp(
      db: db,
      fixedLocale: const Locale('tr'),
    ));
    await tester.pumpAndSettle();

    // 1) Yeni liste ana eylemi → Listeler sekmesi → liste oluştur.
    await tester.tap(find.byKey(const Key('home_new_list_button')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('lists_new_list_button')));
    await settle(tester);
    await tester.enterText(
        find.byKey(const Key('list_title_field')), 'E2E Market');
    await tester.tap(find.byKey(const Key('list_save_button')));
    await settle(tester);
    expect(find.text('E2E Market'), findsOneWidget);

    // 2) Liste kartı → detay → ondalıklı ürün ekle.
    await tester.tap(find.text('E2E Market'));
    await settle(tester);
    await tester.tap(find.byKey(const Key('detail_add_item_button')));
    await settle(tester);
    await tester.enterText(find.byKey(const Key('item_name_field')), 'Domates');
    await tester.enterText(
        find.byKey(const Key('item_quantity_field')), '1,5');
    await tester.tap(find.byKey(const Key('item_unit_field')));
    await settle(tester);
    await tester.tap(find.text('kg').last);
    await settle(tester);
    await tester.enterText(find.byKey(const Key('item_price_field')), '42,90');
    await settle(tester);
    await tester.tap(find.byKey(const Key('item_save_button')));
    await settle(tester);
    expect(find.text('Domates'), findsOneWidget);
    expect(find.text('64,35 ₺'), findsOneWidget); // 1,5 × 42,90

    // 3) Alışverişi başlat → alışveriş modu.
    await tester.tap(find.byKey(const Key('detail_start_shopping')));
    await settle(tester);
    expect(find.byKey(const Key('summary_strip')), findsOneWidget);

    // 4) Gerçek fiyat gir: 1,5 kg × 45,00 = 67,50.
    await tester.tap(find.byType(Checkbox).first);
    await settle(tester);
    await tester.enterText(
        find.byKey(const Key('entry_price_field')), '45,00');
    await settle(tester);
    await tester.tap(find.byKey(const Key('entry_save_button')));
    await settle(tester);
    expect(find.text('67,50 ₺'), findsWidgets); // sepet + tahmini kasa

    // 5) Geri dön → bitir → sonuç ekranı.
    await tester.tap(find.byType(BackButton).first);
    await settle(tester);
    await tester.tap(find.byKey(const Key('detail_finish_button')));
    await settle(tester);
    // Sonuç: plan 64,35; gerçek 67,50; fark +3,15 (₺ farkı, %4,9).
    expect(find.text('64,35 ₺'), findsWidgets);
    expect(find.text('67,50 ₺'), findsWidgets);
    expect(find.textContaining('3,15'), findsWidgets);

    await disposeApp(tester);
  });

  testWidgets('tr → en dil değişimi sloganı değiştirir', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1800));
    db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(NShoptorApp(
      db: db,
      fixedLocale: const Locale('tr'),
    ));
    await settle(tester);
    expect(find.text('Evdeki hesap çarşıya uyar.'), findsOneWidget);

    await tester.pumpWidget(NShoptorApp(
      db: db,
      fixedLocale: const Locale('en'),
    ));
    await settle(tester);
    expect(find.text('Plan at home. Shop as planned.'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('uygulama yeniden başlatıldıktan sonra veri korunur',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1800));
    // Gerçek kalıcılık: dosya temelli veritabanı, iki ayrı oturum.
    // Gerçek dosya I/O'su FakeAsync'te kilitlenir; runAsync ile çalışır.
    late final Directory tmpDir;
    await tester.runAsync(() async {
      tmpDir = await Directory.systemTemp.createTemp('nshoptor_e2e');
    });
    final dbFile = File('${tmpDir.path}${Platform.pathSeparator}e2e.db');
    addTearDown(() => tmpDir.deleteSync(recursive: true));

    db = AppDatabase(NativeDatabase(dbFile));
    await tester.pumpWidget(NShoptorApp(
      db: db,
      fixedLocale: const Locale('tr'),
    ));
    await settle(tester);
    await tester.tap(find.byKey(const Key('home_new_list_button')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('lists_new_list_button')));
    await settle(tester);
    await tester.enterText(
        find.byKey(const Key('list_title_field')), 'Kalıcı liste');
    await tester.tap(find.byKey(const Key('list_save_button')));
    await settle(tester);
    await disposeApp(tester);

    // Yeniden başlatma: aynı dosyadan yeni AppDatabase.
    db = AppDatabase(NativeDatabase(dbFile));
    await tester.pumpWidget(NShoptorApp(
      db: db,
      fixedLocale: const Locale('tr'),
    ));
    await settle(tester);
    // Ana ekranda aktif liste kartı görünür.
    expect(find.text('Kalıcı liste'), findsOneWidget);

    await disposeApp(tester);
  });
}
