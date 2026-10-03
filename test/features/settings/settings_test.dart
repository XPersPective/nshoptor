import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';

import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/app/language_controller.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/settings/settings_screen.dart';
import 'package:nshoptor/app/theme_mode_controller.dart';
import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository settings;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    settings = SettingsRepository(
      db,
      FakeSettingsStore(),
      exportDirOverride: Directory.systemTemp.createTempSync('nshoptor_export'),
    );
  });

  tearDown(() => db.close());

  group('ayarlar: dil, para birimi, birim, ekran açık tutma', () {
    test('dil tercihi kalır ve uygulama ona girer', () async {
      settings.setLanguage('tr');
      expect(settings.currentLanguage, 'tr');
      settings.setLanguage('en');
      expect(settings.currentLanguage, 'en');
    });

    test('varsayılanlar: TRY ve adet', () {
      expect(settings.defaultCurrency, 'TRY');
      expect(Currency.fromCode(settings.defaultCurrency).minorUnitDigits, 2);
      expect(settings.defaultUnit, 'adet');
    });

    test('varsayılanları değiştir', () async {
      settings.setDefaultCurrency('USD');
      expect(settings.defaultCurrency, 'USD');
      settings.setDefaultUnit('kilogram');
      expect(settings.defaultUnit, 'kilogram');
    });

    test('ekranı açık tutma toggle', () async {
      expect(settings.keepScreenAwake, isFalse);
      settings.setKeepScreenAwake(true);
      expect(settings.keepScreenAwake, isTrue);
    });
  });

  group('tema tercihi canlı uygulanır (regresyon: ölü ayar)', () {
    test('controller ile ayar ekranı aynı anahtarı okur/yazar', () {
      final store = SettingsStore();
      final repo = SettingsRepository(db, NappSettingsStoreOps(store));
      final controller = AppThemeModeController(store: store)..load();
      expect(controller.mode, ThemeMode.system);

      repo.setThemeMode('dark');
      controller.load(); // yeniden başlatma davranışı
      expect(controller.mode, ThemeMode.dark);

      controller.set('light');
      expect(repo.themeMode, 'light');
    });
  });

  group('varsayılanlar tüketim tarafına bağlanır (regresyon)', () {
    test('varsayılan birim/para birimi AppDefaults üzerinden okunur', () {
      final store = SettingsStore();
      AppDefaults.attach(store);
      expect(AppDefaults.defaultUnit(), UnitCode.adet);
      expect(AppDefaults.defaultCurrency(), 'TRY');

      store.setString(SettingsRepository.unitKey, 'kilogram');
      store.setString(SettingsRepository.currencyKey, 'USD');
      expect(AppDefaults.defaultUnit(), UnitCode.kilogram);
      expect(AppDefaults.defaultCurrency(), 'USD');

      // Geçersiz değerler güvenli varsayılana döner.
      store.setString(SettingsRepository.unitKey, 'yok-boyle-birim');
      store.setString(SettingsRepository.currencyKey, 'XXX');
      expect(AppDefaults.defaultUnit(), UnitCode.adet);
      expect(AppDefaults.defaultCurrency(), 'TRY');
    });
  });

  group('yedekleme (spec §6.14-6.15)', () {
    test('export dosyası JSON döner; içe aktar denemesi işlevsel kalır',
        () async {
      await db.into(db.shoppingLists).insert(
            ShoppingListsCompanion.insert(
                title: const Value('Bakkal'), currencyCode: 'TRY'),
          );

      final file = await settings.exportBackupToFile();
      expect(await file.exists(), isTrue);
      final preview = settings.validateBackup(
          await file.readAsString());
      expect(preview.listCount, 1);
    });

    test('geçersiz dosya doğrulaması atılır, veri değişmez', () async {
      const broken = '{"format":"other"}';
      expect(() => settings.validateBackup(broken), throwsFormatException);
    });
  });

  group('tüm verileri sil (spec §6.15, §12)', () {
    test('çift onay olmadan silme: veri korunur', () async {
      await db.into(db.shoppingLists).insert(
            ShoppingListsCompanion.insert(
                title: const Value('Bakkal'), currencyCode: 'TRY'),
          );

      expect(() => settings.deleteAllData(), throwsStateError);
      expect(await db.select(db.shoppingLists).get(), hasLength(1));
      await db.close();
    });

    test('çift onay sonrası tüm satırlar temizlenir', () async {
      final listId = await db.into(db.shoppingLists).insert(
            ShoppingListsCompanion.insert(
                title: const Value('Bakkal'), currencyCode: 'TRY'),
          );
      await db.into(db.plannedItems).insert(
            PlannedItemsCompanion.insert(
              listId: listId,
              name: 'Ekmek',
              normalizedName: 'ekmek',
              plannedQuantity: '1',
              plannedUnitCode: 'adet',
              pricingInputMode: 'unitPrice',
            ),
          );

      settings.confirmDeleteAll();
      await settings.deleteAllData();

      expect(await db.select(db.shoppingLists).get(), isEmpty);
      expect(await db.select(db.plannedItems).get(), isEmpty);
    });
  });

  testWidgets('yedekleme kilidi: Pro değilken kilitli, Pro ile açık (§3.8)',
      (tester) async {
    final store = SettingsStore();
    final language = LanguageController(store: store)..load();
    final pro = ProController(
      store: store,
      repository: PurchaseRepository(
        adapter: InAppPurchaseAdapter(),
        productId: 'nshoptor_pro_lifetime',
      ),
    )..load(); // startListening YOK: test ortamında mağaza kanalı yok.

    // Uzun ayarlar listesinde ekran dışı satırlar inşa edilmez.
    await tester.binding.setSurfaceSize(const Size(800, 1800));
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('tr'), Locale('en')],
      home: SettingsScreen(
        repository: settings,
        languageController: language,
        proController: pro,
      ),
    ));
    await tester.pumpAndSettle();

    // Pro değil: yedek satırlarında kilit + "NShoptor Pro" satırı.
    expect(find.byIcon(Icons.lock_outline), findsNWidgets(2));
    expect(find.byKey(const Key('settings_pro_row')), findsOneWidget);

    // Geçici Pro (ödüllü reklam eşdeğeri): kilitler kalkar.
    pro.grantTemporaryPro(const Duration(hours: 1));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.lock_outline), findsNothing);
  });

}

/// Bellekte çalışan ayar deposu (test için).
class FakeSettingsStore extends SettingsStoreOps {
  final Map<String, Object> _values = {};

  @override
  String? getString(String key) => _values[key] as String?;

  @override
  bool? getBool(String key) => _values[key] as bool?;

  @override
  void setString(String key, String value) => _values[key] = value;

  @override
  void setBool(String key, bool value) => _values[key] = value;

  @override
  void remove(String key) => _values.remove(key);
}
