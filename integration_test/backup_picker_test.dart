// Real Android SAF bridge, explicitly fake in-memory Pro entitlement.
// flutter test integration_test/backup_picker_test.dart -d emulator-5564
// ADB operator: export cancel, retry/save owned QA filename; import cancel,
// retry/select that file. The fixture itself confirms separate copy.
import 'dart:io';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';
import 'package:nshoptor/app/language_controller.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';
import 'package:nshoptor/features/settings/settings_screen.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  testWidgets('real SAF backup cancel/retry/save/pick and approved copy', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final temporary = await Directory.systemTemp.createTemp('nshoptor_picker_qa');
    final store = SettingsStore()..setBool(ProSettingsKeys.proLifetime, true);
    final pro = ProController(store: store,
      repository: PurchaseRepository(adapter: InAppPurchaseAdapter(), productId: 'owned-test'))..load();
    final settings = SettingsRepository(db, NappSettingsStoreOps(store), exportDirOverride: temporary);
    try {
      final list = await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(
        title: const Value('Backup_Native_QA'), currencyCode: 'KWD'));
      await db.into(db.plannedItems).insert(PlannedItemsCompanion.insert(listId: list,
        name: 'Owned item', normalizedName: 'owned item', plannedQuantity: '1.5',
        plannedUnitCode: 'kilogram', pricingInputMode: 'unitPrice',
        plannedUnitPrice: const Value('0.001'), plannedLineTotalMinorUnits: const Value(2)));
      await tester.pumpWidget(MaterialApp(locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        home: SettingsScreen(repository: settings, languageController: LanguageController(store: store)..load(), proController: pro)));
      await tester.pumpAndSettle();
      Future<void> tap(String key) async {
        final finder = find.byKey(Key(key));
        await tester.scrollUntilVisible(finder, 250, scrollable: find.byType(Scrollable).first);
        await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
        await tester.pumpAndSettle(); await tester.tap(finder);
      }
      Future<void> idle() async {
        final deadline = DateTime.now().add(const Duration(minutes: 3));
        do {
          // Native SAF pauses Flutter frames; fullyLive renders again on resume.
          await Future<void>.delayed(const Duration(milliseconds: 200));
          if (DateTime.now().isAfter(deadline)) fail('native backup operation did not return');
        } while (binding.lifecycleState != AppLifecycleState.resumed ||
            tester.widget<ListTile>(find.byKey(const Key('export_backup_button'))).onTap == null);
        await tester.pumpAndSettle();
      }
      debugPrint('BACKUP_NATIVE_CANCEL_SAVE'); await tap('export_backup_button'); await idle();
      expect(find.byType(SnackBar), findsNothing);
      debugPrint('BACKUP_NATIVE_SAVE_QA'); await tap('export_backup_button'); await idle();
      expect(find.text('Backup exported successfully.'), findsOneWidget);
      expect(await temporary.list().toList(), isEmpty);
      debugPrint('BACKUP_NATIVE_CANCEL_PICK'); await tap('import_backup_button'); await idle();
      expect(find.byKey(const Key('backup_import_dialog')), findsNothing);
      debugPrint('BACKUP_NATIVE_PICK_QA'); await tap('import_backup_button');
      final deadline = DateTime.now().add(const Duration(minutes: 3));
      while (find.byKey(const Key('backup_import_dialog')).evaluate().isEmpty) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        if (DateTime.now().isAfter(deadline)) fail('native JSON selection did not validate');
      }
      await tester.pumpAndSettle(); await tester.tap(find.byKey(const Key('backup_separate'))); await idle();
      expect(await db.select(db.shoppingLists).get(), hasLength(2));
      final items = await db.select(db.plannedItems).get();
      expect(items, hasLength(2)); expect(items.last.listId, isNot(list));
      expect(items.last.plannedQuantity, '1.5'); expect(items.last.plannedLineTotalMinorUnits, 2);
      expect(find.text('Backup imported successfully.'), findsOneWidget);
      binding.reportData = {'nativeSafRoundtrip': true, 'mainDatabaseTouched': false, 'realPurchaseTested': false};
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      pro.dispose(); await db.close(); await temporary.delete(recursive: true);
    }
  }, timeout: const Timeout(Duration(minutes: 10)));
}
