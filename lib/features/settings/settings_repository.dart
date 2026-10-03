import 'dart:io';

import 'package:path_provider/path_provider.dart';

// napp_core SettingsStore: bellek + SharedPreferences kalıcı anlatılığı.
import 'package:napp_core/napp_core.dart';

import '../../../data/db/app_database.dart';
import 'backup/backup_repository.dart';

/// Ayarlar ekranının veri depolaması + sistem eylemleri (spec §6.15, §12).
///
/// Kilit kurallar:
/// - Tüm verileri silme: kapsamını iki onayla açıklar, görselleri (media/)
///   de siler, DB tablolarını boşaltır, silinmiş dosyalar app dizininde
///   geride kalmaz.
/// - Yedekleme: tam yerel JSON (spec: sürümlenmiş JSON), paylaşılır.
/// - Fotoğraflar: [includePhotos] ile dahil edilebilir; büyük yedek bu durumda
///   uyarı verir.
/// - `double` parasal girişe girmemek için paradan bailout yok; burada
///   yalnız ayaralar ve dosya dizinleri yönetilir.
class SettingsRepository {
  /// `settings` bellek tier'ı: üretimde napp_core SettingsStore,
  /// testlerde in-memory taklit.
  SettingsRepository(this._db, this._settings,
      {BackupRepository? backup, this.mediaDir, this.exportDirOverride})
      : _backup = backup ?? BackupRepository(_db);

  final AppDatabase _db;
  final SettingsStoreOps _settings;
  final BackupRepository _backup;
  final Directory? mediaDir;

  /// Testlerde yol kanalısına gerek kalmadan provizyon için geçersiz kılma.
  final Directory? exportDirOverride;

  // ---- Ayarlar ----

  /// Kalıcı anahtarlar; okuma tarafı (AppDefaults) aynı sabitleri kullanır.
  static const String localeKey = 'app.locale';
  static const String formatLocaleKey = 'app.formatLocale';
  static const String themeKey = 'app.theme';
  static const String currencyKey = 'app.currency';
  static const String unitKey = 'app.unit';
  static const String keepAwakeKey = 'app.keepAwake';

  String get currentLanguage => _settings.getString(localeKey) ?? 'system';

  /// Sayı/para BİÇİMİ yereli ('system' | 'tr' | 'en'); dilden bağımsız
  /// (C-001, PB-042).
  String get formatLocale =>
      _settings.getString(formatLocaleKey) ?? 'system';

  void setFormatLocale(String code) =>
      _settings.setString(formatLocaleKey, code);
  void setLanguage(String code) =>
      _settings.setString(localeKey, code);

  String get themeMode => _settings.getString(themeKey) ?? 'system';
  void setThemeMode(String value) =>
      _settings.setString(themeKey, value);

  String get defaultCurrency =>
      _settings.getString(currencyKey) ?? 'TRY';
  void setDefaultCurrency(String code) =>
      _settings.setString(currencyKey, code);

  /// Varsayılan birimin enum adı (ör. `adet`, `kilogram`).
  String get defaultUnit => _settings.getString(unitKey) ?? 'adet';
  void setDefaultUnit(String unit) =>
      _settings.setString(unitKey, unit);

  bool get keepScreenAwake =>
      _settings.getBool(keepAwakeKey) ?? false;
  void setKeepScreenAwake(bool value) =>
      _settings.setBool(keepAwakeKey, value);

  // ---- Yedekleme (T21 backup katmanını kullanır) ----

  /// Tam yerel yedeğin JSON'unu paylaşılabilir geçici dizine yazar ve
  /// yolunu döndürür (spec §6.14: sürümlenmiş JSON). Foto dosyaları ayrı.
  Future<File> exportBackupToFile() async {
    final json = await _backup.exportBackup();
    final dir = exportDirOverride ?? await getTemporaryDirectory();
    final file = File(
        '${dir.path}${Platform.pathSeparator}nshoptor_backup_${DateTime.now().millisecondsSinceEpoch}.json');
    await file.writeAsString(json);
    return file;
  }

  /// JSON doğrulaması ve özet (içe aktarım öncesi; spec §6.14).
  BackupPreview validateBackup(String json) => _backup.validate(json);

  /// Tam yedeği içe aktarır (transaction içinde; hata olursa rollback).
  Future<void> importBackupJson(String json,
          {ImportMode mode = ImportMode.merge}) =>
      _backup.importBackup(json, mode);

  // ---- Tüm verileri silme (spec §6.15, §12) ----

  /// Yanlış veri silmeyi önler: çağıran taraf iki onaydan sorumludur
  /// ([confirmDeleteAll + [deleteAll]] ardışık çağrılmalı).
  bool _firstConfirmPending = false;

  /// İlk onayı hazırlar; ikinci onay sonra çağrılır.
  void confirmDeleteAll() {
    _firstConfirmPending = true;
  }

  /// İki onay tamamsa tüm verileri silmeden önce hata verir.
  Future<void> deleteAllData() async {
    if (!_firstConfirmPending) {
      throw StateError('double onay gerekli');
    }
    _firstConfirmPending = false;
    await _db.transaction(() async {
      for (final t in const [
        'receipt_candidate_lines', 'attachments', 'price_observations',
        'product_aliases', 'purchase_entries', 'planned_items',
        'reminders', 'product_memory', 'receipts', 'aisles',
        'categories', 'shopping_lists', 'stores',
      ]) {
        await _db.customStatement('DELETE FROM $t');
      }
      // Ayarlar tablosu da temizlenir; aktif kullanım "taze sonra" ile.
      await _db.customStatement('DELETE FROM app_settings');
    });
    await _clearMedia();
  }

  /// Fişler ve ürün fotoğraflarını (media dizini) siler; silinmiş dosya
  /// refhe komşu kalmasın (spec §12).
  Future<void> _clearMedia() async {
    final dir = mediaDir;
    if (dir == null || !await dir.exists()) return;
    await for (final entity in dir.list()) {
      if (entity is File) await entity.delete();
    }
  }

  /// Varsayılan günlükleri temizlemez; bellekteki napp SettingsStore'u da
  /// sıfırlar (anahtar kayıtları kaldırılır).
  Future<void> resetPreferences() async {
    for (final k in [
      'app.locale', 'app.theme', 'app.currency', 'app.unit', 'app.keepAwake',
    ]) {
      _settings.remove(k);
    }
  }
}

/// Ayar okuma/yazma arayüzü: üretimde napp SettingsStore, testte in-memory fake.
abstract class SettingsStoreOps {
  String? getString(String key);
  bool? getBool(String key);
  void setString(String key, String value);
  void setBool(String key, bool value);
  void remove(String key);
}

/// napp SettingsStore → SettingsStoreOps köprüsü.
class NappSettingsStoreOps implements SettingsStoreOps {
  NappSettingsStoreOps(this._inner);

  final SettingsStore _inner;

  @override
  String? getString(String key) => _inner.getString(key);

  @override
  bool? getBool(String key) => _inner.getBool(key);

  @override
  void setString(String key, String value) => _inner.setString(key, value);

  @override
  void setBool(String key, bool value) => _inner.setBool(key, value);

  @override
  void remove(String key) => _inner.remove(key);
}

