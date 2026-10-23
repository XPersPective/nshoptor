import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';

import 'package:nshoptor/app/app_defaults.dart';
import 'package:nshoptor/app/language_controller.dart';
import 'package:nshoptor/core/l10n/generated/app_localizations.dart';
import 'package:nshoptor/features/settings/settings_screen.dart';
import 'package:nshoptor/features/ai/ai_client.dart';
import 'package:nshoptor/app/theme_mode_controller.dart';
import 'package:nshoptor/core/money/currency.dart';
import 'package:nshoptor/core/quantity/unit_code.dart';
import 'package:nshoptor/data/db/app_database.dart';
import 'package:nshoptor/features/settings/settings_repository.dart';
import 'package:nshoptor/features/subscription/subscription_service.dart';

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

  tearDown(() async {
    await db.close();
    await settings.exportDirOverride!.delete(recursive: true);
  });

  for (final ios in [false, true]) {
    testWidgets('safe platform share and rating actions ios=$ios', (tester) async {
      debugDefaultTargetPlatformOverride = ios ? TargetPlatform.iOS : TargetPlatform.android;
      addTearDown(() => debugDefaultTargetPlatformOverride = null);
      await tester.binding.setSurfaceSize(const Size(800, 5000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final identity = AppIdentity(appName: 'NShoptor', packageName: 'com.crazypenguin.nshoptor',
        sourceUrl: 'https://example.com/source', privacyPolicyUrl: 'https://example.com/privacy', contactEmail: 'qa@example.com');
      final shared = <ShareParams>[];
      var rateCalls = 0;
      await tester.pumpWidget(MaterialApp(locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        home: SettingsScreen(repository: settings, languageController: LanguageController(store: SettingsStore())..load(),
          appIdentity: identity,
          shareApp: (params) async { shared.add(params); throw StateError('share_unavailable'); },
          openRatePage: () async { rateCalls++; throw StateError('store_unavailable'); }),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('settings_share_row')));
      await tester.pumpAndSettle();
      expect(shared, hasLength(1));
      expect(shared.single.text, contains(ios ? 'https://xperspective.github.io/nshoptor/' : 'play.google.com'));
      expect(shared.single.sharePositionOrigin!.size.isEmpty, isFalse);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(tester.takeException(), isNull);
      final rate = find.byKey(const Key('settings_rate_row'));
      if (ios) {
        expect(rate, findsNothing);
      } else {
        await tester.tap(rate);
        await tester.pumpAndSettle();
        expect(rateCalls, 1);
        expect(tester.takeException(), isNull);
      }
      await tester.pumpWidget(const SizedBox.shrink());
      debugDefaultTargetPlatformOverride = null;
    });
  }

  testWidgets('help and AI are separate from final deletion; guide reopens; deletion needs two confirmations', (tester) async {
    await tester.runAsync(() async {
      await tester.binding.setSurfaceSize(const Size(1000, 5000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final store = SettingsStore();
      AppDefaults.attach(store);
      AppDefaults.markGuideSeen();
      final previousAi = AiService.client;
      AiService.client = AiClient(store: store, baseUrl: 'https://example.invalid');
      addTearDown(() => AiService.client = previousAi);
      final language = LanguageController(store: store)..load();
      await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(
          title: const Value('Keep unless confirmed'), currencyCode: 'TRY'));
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate],
        home: SettingsScreen(repository: settings, languageController: language),
      ));
      await tester.pumpAndSettle();
      final guide = find.byKey(const Key('settings_guide_row'));
      final assistant = find.byKey(const Key('assistant_toggle'));
      final ai = find.byKey(const Key('ai_toggle'));
      final deletion = find.byKey(const Key('delete_all_button'));
      expect(find.text('Help and support'), findsOneWidget);
      expect(find.text('Danger zone'), findsNothing);
      expect(tester.getTopLeft(guide).dy, lessThan(tester.getTopLeft(assistant).dy));
      expect(tester.getTopLeft(assistant).dy, lessThan(tester.getTopLeft(ai).dy));
      expect(tester.getTopLeft(ai).dy, lessThan(tester.getTopLeft(deletion).dy));
      expect(tester.widget<ListTile>(deletion).onTap, isNotNull);
      final list = tester.widget<ListView>(find.byType(ListView).first);
      final children = (list.childrenDelegate as SliverChildListDelegate).children;
      expect(children.last.key, const Key('delete_all_button'));
      await tester.tap(ai);
      await tester.pumpAndSettle();
      expect(AiService.client!.enabled, isFalse);
      expect(find.byKey(const Key('delete_all_dialog_1')), findsNothing);
      await tester.tap(guide);
      await tester.pumpAndSettle();
      expect(find.text('1 / 7'), findsOneWidget);
      await tester.tap(find.byKey(const Key('first_run_guide_close')));
      await tester.pumpAndSettle();
      expect(AppDefaults.guideSeen(), isTrue);
      await tester.tap(guide);
      await tester.pumpAndSettle();
      expect(find.text('1 / 7'), findsOneWidget);
      await tester.tap(find.byKey(const Key('first_run_guide_close')));
      await tester.pumpAndSettle();
      Future<void> answer(bool yes) async {
        await tester.tap(find.descendant(of: find.byType(AlertDialog),
            matching: find.byType(yes ? FilledButton : TextButton)));
        await tester.pumpAndSettle();
      }
      await tester.tap(deletion);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('delete_all_dialog_1')), findsOneWidget);
      await answer(false);
      expect(await db.select(db.shoppingLists).get(), hasLength(1));
      await tester.tap(deletion);
      await tester.pumpAndSettle();
      await answer(true);
      expect(find.byKey(const Key('delete_all_dialog_2')), findsOneWidget);
      await answer(false);
      expect(await db.select(db.shoppingLists).get(), hasLength(1));
      await tester.tap(deletion);
      await tester.pumpAndSettle();
      await answer(true);
      await answer(true);
      expect(await db.select(db.shoppingLists).get(), isEmpty);
      expect(tester.takeException(), isNull);
    });
  });

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
        productId: 'nshoptor_pro_v2',
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

  for (final locale in ['en', 'ar']) {
    testWidgets('backup native boundaries, approval/cancel/busy and 320dp2x ($locale)', (tester) async {
      await tester.runAsync(() async {
        tester.view.physicalSize = const Size(320, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        final picker = _BackupPicker();
        final previous = FilePickerPlatform.instance;
        FilePickerPlatform.instance = picker;
        addTearDown(() => FilePickerPlatform.instance = previous);
        final store = SettingsStore();
        final pro = ProController(store: store,
          repository: PurchaseRepository(adapter: InAppPurchaseAdapter(), productId: 'owned-test'))..load();
        addTearDown(pro.dispose);
        final language = LanguageController(store: store)..load();
        await db.into(db.shoppingLists).insert(ShoppingListsCompanion.insert(title: const Value('Owned QA'), currencyCode: 'TRY'));
        await tester.pumpWidget(MaterialApp(locale: Locale(locale), supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
          builder: (ctx, child) => MediaQuery(data: MediaQuery.of(ctx).copyWith(textScaler: TextScaler.linear(2)), child: child!),
          home: SettingsScreen(repository: settings, languageController: language, proController: pro)));
        await tester.pumpAndSettle();
        Future<void> tap(String key) async {
          final finder = find.byKey(Key(key));
          await tester.scrollUntilVisible(finder, 250, scrollable: find.byType(Scrollable).first);
          await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
          await tester.pumpAndSettle(); await tester.tap(finder); await tester.pumpAndSettle();
        }
        Future<void> idle() async {
          final deadline = DateTime.now().add(const Duration(seconds: 5));
          while (tester.widget<ListTile>(find.byKey(const Key('import_backup_button'))).onTap == null) {
            if (DateTime.now().isAfter(deadline)) fail('backup operation did not finish');
            await Future<void>.delayed(const Duration(milliseconds: 5));
            await tester.pumpAndSettle();
          }
        }
        await tap('export_backup_button'); await tap('import_backup_button');
        expect((picker.saves, picker.picks), (0, 0));
        pro.grantTemporaryPro(const Duration(hours: 1)); await tester.pumpAndSettle();
        final pending = Completer<Uri?>(); picker.saving = () => pending.future;
        picker.saveStarted = Completer<void>();
        await tap('export_backup_button');
        await picker.saveStarted!.future.timeout(const Duration(seconds: 5)); await tester.pumpAndSettle();
        expect(picker.saves, 1);
        expect((picker.fileName, picker.mimeType), ('NShoptor-backup.json', 'application/json'));
        final snapshot = utf8.decode(picker.bytes!);
        expect(settings.validateBackup(snapshot).listCount, 1);
        await tap('import_backup_button'); expect(picker.picks, 0);
        pending.complete(null); await tester.pumpAndSettle(); await idle();
        expect(find.byType(SnackBar), findsNothing);
        expect(await settings.exportDirOverride!.list().toList(), isEmpty);
        picker.saving = () async => Uri.parse('content://owned-test/saved');
        picker.saveStarted = Completer<void>();
        await tap('export_backup_button');
        await picker.saveStarted!.future.timeout(const Duration(seconds: 5)); await tester.pumpAndSettle(); await idle();
        expect(find.byType(SnackBar), findsOneWidget);
        expect(await settings.exportDirOverride!.list().toList(), isEmpty);
        picker.saving = () => Future.error(PlatformException(code: 'owned-save-error'));
        picker.saveStarted = Completer<void>();
        await tap('export_backup_button');
        await picker.saveStarted!.future.timeout(const Duration(seconds: 5)); await tester.pumpAndSettle(); await idle();
        expect(tester.widget<SnackBar>(find.byType(SnackBar)).showCloseIcon, isTrue);
        ScaffoldMessenger.of(tester.element(find.byType(SettingsScreen))).clearSnackBars(); await tester.pumpAndSettle();
        picker.picking = () async => null;
        await tap('import_backup_button'); expect(find.byKey(const Key('backup_import_dialog')), findsNothing);
        final valid = _BackupFile(Uint8List.fromList(utf8.encode(snapshot)));
        picker.picking = () async => valid;
        await tap('import_backup_button');
        expect(find.byKey(const Key('backup_import_dialog')), findsOneWidget);
        await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextButton)).first);
        await tester.pumpAndSettle(); expect(await db.select(db.shoppingLists).get(), hasLength(1));
        for (final (key, count) in [('backup_merge', 1), ('backup_separate', 2)]) {
          await tap('import_backup_button'); await tester.tap(find.byKey(Key(key))); await tester.pumpAndSettle();
          expect(await db.select(db.shoppingLists).get(), hasLength(count));
        }
        final badUtf8 = Uint8List.fromList(utf8.encode(snapshot));
        badUtf8[badUtf8.indexOf(0x4f)] = 0xff; // Corrupt title bytes, leaving otherwise valid JSON.
        for (final invalid in [_BackupFile(Uint8List.fromList(utf8.encode('{broken'))), _BackupFile(badUtf8),
            _BackupFile(Uint8List(1), reportedSize: 16 * 1024 * 1024 + 1),
            _BackupFile(Uint8List(16 * 1024 * 1024 + 1))]) {
          picker.picking = () async => invalid;
          await tap('import_backup_button');
          expect(find.byKey(const Key('backup_import_dialog')), findsNothing);
          expect(tester.widget<SnackBar>(find.byType(SnackBar)).showCloseIcon, isTrue);
          expect(await db.select(db.shoppingLists).get(), hasLength(2));
          if (invalid.reportedSize != null) expect(invalid.reads, 0);
        }
        final waiting = Completer<PlatformFile?>(); picker.picking = () => waiting.future;
        await tap('import_backup_button');
        final beforeBusy = (picker.saves, picker.picks);
        await tap('export_backup_button'); await tap('import_backup_button');
        expect((picker.saves, picker.picks), beforeBusy);
        expect(tester.widget<ListTile>(find.byKey(const Key('import_backup_button'))).onTap, isNull);
        pro.debugReset(); waiting.complete(valid); await tester.pumpAndSettle();
        expect(find.byKey(const Key('backup_import_dialog')), findsNothing);
        expect(await db.select(db.shoppingLists).get(), hasLength(2));
        pro.grantTemporaryPro(const Duration(hours: 1));
        picker.picking = () async => valid;
        await tap('import_backup_button'); pro.debugReset();
        await tester.tap(find.byKey(const Key('backup_merge'))); await tester.pumpAndSettle();
        expect(await db.select(db.shoppingLists).get(), hasLength(2));
        pro.grantTemporaryPro(const Duration(hours: 1));
        final unmount = Completer<PlatformFile?>(); picker.picking = () => unmount.future;
        await tap('import_backup_button'); await tester.pumpWidget(const SizedBox.shrink());
        unmount.complete(valid); await tester.pumpAndSettle();
        expect(await db.select(db.shoppingLists).get(), hasLength(2));
        expect(tester.takeException(), isNull);
      });
    });
  }


  testWidgets('plan badge shows free, trial and max; fits 320dp 2x', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final store = SettingsStore();
    final language = LanguageController(store: store)..load();
    final pro = ProController(
      store: store,
      repository: PurchaseRepository(
        adapter: InAppPurchaseAdapter(),
        productId: 'nshoptor_pro_v2',
      ),
    )..load();
    final subs = SubscriptionService(store: SettingsStore());
    var scale = 2.0;
    Future<String> badge() async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('tr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(scale)),
            child: child!,
          ),
          home: SettingsScreen(
            key: UniqueKey(),
            repository: settings,
            languageController: language,
            proController: pro,
            subscriptions: subs,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      // The tooltip starts with the plan name, then the plan-page description.
      final badge = tester.widget<Tooltip>(find.byKey(const Key('settings_plan_badge')));
      return badge.message!.split(' · ').first;
    }

    expect(await badge(), 'Ücretsiz');
    subs.applyOwned([(productId: SubscriptionService.proId, token: 't')]);
    subs.markTrialStarted(DateTime.now());
    expect(subs.inTrial(), isTrue);
    expect(
      subs.inTrial(DateTime.now().add(const Duration(days: 8))),
      isFalse,
    );
    expect(await badge(), 'Pro');
    expect(find.byIcon(Icons.hourglass_top), findsOneWidget);
    subs.applyOwned([(productId: SubscriptionService.maxId, token: 'm')]);
    expect(await badge(), 'Max');
    subs.applyOwned([]);
    expect(subs.inTrial(), isFalse);
    expect(await badge(), 'Ücretsiz');
    scale = 1;
    subs.applyOwned([(productId: SubscriptionService.proId, token: 't')]);
    subs.markTrialStarted(DateTime.now());
    expect(await badge(), 'Pro');
    expect(find.byIcon(Icons.hourglass_top), findsOneWidget);
    subs.dispose();
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

final class _BackupFile extends PlatformFile {
  _BackupFile(this.bytes, {this.reportedSize});
  final Uint8List bytes;
  final int? reportedSize;
  int reads = 0;
  @override String get name => 'owned.json';
  @override Uri get uri => Uri.parse('content://owned-test/input');
  @override get xFile => throw UnimplementedError('not used by bounded import');
  @override int? lengthSync() => reportedSize;
  @override Future<int?> length() => throw UnimplementedError('must not read unbounded metadata');
  @override Future<Uint8List> readAsBytes() => throw UnimplementedError('must use bounded stream');
  @override Stream<Uint8List> readAsByteStream() async* { reads++; yield bytes; }
}

class _BackupPicker extends FilePickerPlatform {
  int saves = 0, picks = 0;
  String? fileName, mimeType;
  Uint8List? bytes;
  Future<Uri?> Function()? saving;
  Future<PlatformFile?> Function()? picking;
  Completer<void>? saveStarted;
  @override
  Future<Uri?> saveFile({required String fileName, required Uint8List bytes, required String mimeType,
    String? dialogTitle, String? initialDirectory, Function(FilePickerStatus)? onFileSaving,
    WindowsOptions windowsOptions = const WindowsOptions(), LinuxOptions linuxOptions = const LinuxOptions(),
    WebOptions webOptions = const WebOptions()}) {
    saves++; this.fileName = fileName; this.mimeType = mimeType; this.bytes = bytes;
    saveStarted?.complete();
    return saving?.call() ?? Future.value(null);
  }
  @override
  Future<PlatformFile?> pickFile({String? dialogTitle, String? initialDirectory, FileType type = FileType.any,
    List<String>? allowedExtensions, Function(FilePickerStatus)? onFileLoading, int compressionQuality = 0,
    AndroidOptions androidOptions = const AndroidOptions(), DarwinOptions darwinOptions = const DarwinOptions(),
    WindowsOptions windowsOptions = const WindowsOptions(), LinuxOptions linuxOptions = const LinuxOptions(),
    WebOptions webOptions = const WebOptions()}) {
    picks++; return picking?.call() ?? Future.value(null);
  }
}
