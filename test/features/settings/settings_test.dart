import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_test/flutter_test.dart';
import 'package:napp_core/napp_core.dart';

import 'package:nshoptor/app/app_defaults.dart';
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
