// Gizli degerler KODA YAZILMAZ; derlemede --dart-define ile verilir (1.2).
import 'package:drift/drift.dart' show QueryExecutor;
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart';

import 'package:napp_core/napp_core.dart';

import 'app/app.dart';
import 'app/language_controller.dart';
import 'data/db/app_database.dart';
import 'features/settings/settings_repository.dart';

/// Uygulama veritabanı: tüm platformlarda app dizininde tek dosya.
QueryExecutor openAppDatabase() => driftDatabase(name: 'nshoptor');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await SettingsStore.load();
  final languageController = LanguageController(store: store)..load();
  WidgetsBinding.instance.addObserver(SettingsLifecycleObserver(store));
  final db = AppDatabase(openAppDatabase());
  runApp(NShoptorApp(
    db: db,
    settingsRepository: SettingsRepository(db, NappSettingsStoreOps(store)),
    languageController: languageController,
  ));
}
