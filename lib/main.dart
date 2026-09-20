// Gizli degerler KODA YAZILMAZ; derlemede --dart-define ile verilir (1.2).
import 'package:flutter/material.dart';

import 'package:napp_core/napp_core.dart';

import 'app/app.dart';
import 'app/language_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await SettingsStore.load();
  final languageController = LanguageController(store: store)..load();
  WidgetsBinding.instance.addObserver(SettingsLifecycleObserver(store));
  runApp(NShoptorApp(languageController: languageController));
}
