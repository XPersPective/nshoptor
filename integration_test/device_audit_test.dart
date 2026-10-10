// Cihaz denetimi (PB-034/035): gerçek Android çalışma zamanında
// 1) premium arayüz ana ekranları kare çizerek açılır (pumpAndSettle)
// 2) tema tercihi (Koyu) MaterialApp'e CANLI uygulanır
// 3) hatırlatma akışı: alarm düğmesi → tarih/saat seçici → kuruldu
//    (bildirim izni test öncesi adb ile verilir; OS tarafı
//    `dumpsys notification` ile ayrıca doğrulanır)
//
// Koşum: flutter test integration_test/device_audit_test.dart -d <cihaz>
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:napp_core/napp_core.dart';

import 'package:nshoptor/app/app.dart';
import 'package:nshoptor/app/language_controller.dart';
import 'package:nshoptor/app/theme_mode_controller.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/lists/reminders/reminder_scheduler.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';

/// OS'suz zamanlayıcı: entegrasyon testi deterministik olsun (izin
/// diyaloğu yok). OS tarafı ayrıca dumpsys ile elle kanıtlandı.
class _StubScheduler implements ReminderScheduler {
  final List<ScheduledReminder> scheduled = [];

  @override
  Future<bool> ensurePermission() async => true;

  @override
  Future<void> schedule(ScheduledReminder reminder) async =>
      scheduled.add(reminder);

  @override
  Future<void> cancel(int id) async {}
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  late AppDatabase db;
  late SettingsStore store;
  late LanguageController language;
  late AppThemeModeController theme;

  Future<void> boot(WidgetTester tester) async {
    db = AppDatabase(NativeDatabase.memory());
    store = SettingsStore();
    language = LanguageController(store: store)..load();
    theme = AppThemeModeController(store: store)..load();
    await tester.pumpWidget(NShoptorApp(
      db: db,
      settingsRepository: SettingsRepository(db, NappSettingsStoreOps(store)),
      languageController: language,
      themeModeController: theme,
      fixedLocale: const Locale('en'),
      reminderScheduler: _StubScheduler(),
    ));
    await tester.pumpAndSettle();
  }

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

  testWidgets('cihaz: ana ekranlar çizilir + koyu tema canlı uygulanır',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1800));
    await boot(tester);
    addTearDown(() => disposeApp(tester));

    // 1) Ana ekran premium boş durum: başlık + gövde + slogan + CTA çizildi.
    expect(find.byKey(const Key('home_new_list_button')), findsOneWidget);
    // Boş-durum CTA + FAB: iki 'New list' beklenir (PB-036).
    expect(find.text('New list'), findsNWidgets(2));

    // 2) Ayarlar → tema Koyu → MaterialApp.themeMode anında değişir.
    await tester.tap(find.text('Settings'));
    await settle(tester);
    await tester.tap(find.byKey(const Key('settings_theme_dropdown')));
    await tester.pumpAndSettle(const Duration(milliseconds: 300));
    await tester.tap(find.text('Dark').last);
    await settle(tester);
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark,
        reason: 'tema tercihi canlı uygulanmalı (regresyon: ölü ayar)');
    expect(theme.mode, ThemeMode.dark);
    // Aynı anahtar kalıcıda da: repo okuması aynı değeri görür.
    expect(
        SettingsRepository(db, NappSettingsStoreOps(store)).themeMode, 'dark');

    // 3) Ana ekrana dön: koyu temada çizim (kareler üretildi).
    await tester.tap(find.text('Home'));
    await settle(tester);

  });

  testWidgets('cihaz: hatırlatma kurma akışı (izin önceden verildi)',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1800));
    await boot(tester);
    addTearDown(() => disposeApp(tester));

    // Liste oluştur ve detayına gir.
    await tester.tap(find.text('Lists'));
    await settle(tester);
    await tester.tap(find.byKey(const Key('lists_new_list_button')));
    await settle(tester);
    await tester.enterText(
        find.byKey(const Key('list_title_field')), 'Reminder list');
    await tester.tap(find.byKey(const Key('list_save_button')));
    await settle(tester);

    // Alarm düğmesi → tarih seçici → OK → saat seçici → OK.
    await tester.tap(find.byKey(const Key('detail_more_menu')));
    await settle(tester);
    await tester.tap(find.byKey(const Key('detail_set_reminder')));
    await settle(tester);
    final okFinder = find.text('OK');
    expect(okFinder, findsWidgets, reason: 'tarih seçici açılmalı');
    await tester.tap(okFinder.first);
    await settle(tester);
    await tester.tap(okFinder.first);
    await settle(tester);

    // Snackbar: hatırlatma kuruldu (OS tarafında dumpsys ile doğrulanır).
    expect(find.text('Reminder set.'), findsOneWidget);

  });
}
