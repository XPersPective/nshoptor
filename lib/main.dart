// Gizli degerler KODA YAZILMAZ; derlemede --dart-define ile verilir (1.2).
import 'dart:async';

import 'package:drift/drift.dart' show QueryExecutor;
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart';

import 'package:napp_ads/napp_ads.dart';
import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';

import 'app/app.dart';
import 'app/app_defaults.dart';
import 'app/language_controller.dart';
import 'app/theme_mode_controller.dart';
import 'core/config/env_config.dart';
import 'data/db/app_database.dart';
import 'features/settings/settings_repository.dart';

/// Uygulama veritabanı: tüm platformlarda app dizininde tek dosya.
QueryExecutor openAppDatabase() => driftDatabase(name: 'nshoptor');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await SettingsStore.load();
  AppDefaults.attach(store);
  final languageController = LanguageController(store: store)..load();
  final themeController = AppThemeModeController(store: store)..load();
  final identity = EnvConfig.identity;
  // napp ortak sayfaları (Hakkında/Keşfet/paywall) kendi sözlüğünü kullanır;
  // uygulama dizgeleri ARB'de kalır (ADR-003) — iki sistem yan yana.
  final nappTranslations = await ProLocalization.load(
    base: await NappTranslations.loadCore(),
  );

  // Pro (standart §5.1): durum önce cihazdan; dinleme satın alma/geri
  // yükleme olaylarını uygular.
  final purchaseRepository = PurchaseRepository(
    adapter: InAppPurchaseAdapter(),
    productId: EnvConfig.proProductId,
  );
  final proController = ProController(
    store: store,
    repository: purchaseRepository,
  )..load();
  proController.startListening();

  // Reklam (standart §5.2): kalıcı durum → oturum → onay/SDK → politika
  // Pro'yu izler; UMP onayı SDK başlatmasından ÖNCE.
  final adsAdapter = await SharedPreferencesAdapter.create();
  final policy = AdPolicy();
  final saved = AdPolicyPersistence.load(adsAdapter);
  if (saved != null) policy.restore(saved);
  policy.setOnboardingCompleted(true);
  policy.setPro(proController.isPro);
  proController.addListener(() {
    policy.setPro(proController.isPro);
    AdPolicyPersistence.save(adsAdapter, policy);
  });
  policy.startSession(DateTime.now());

  final bannerController = BannerAdController(policy: policy);
  final rewardedManager = RewardedAdManager(policy: policy);

  unawaited(() async {
    final ready = await ConsentManager.initialize();
    if (!ready) return; // onay alınamadı: reklamsız devam
    policy.setSdkReady(true);
    bannerController.load();
    await rewardedManager.load();
  }());

  WidgetsBinding.instance.addObserver(SettingsLifecycleObserver(store));
  final db = AppDatabase(openAppDatabase());
  runApp(NShoptorApp(
    db: db,
    settingsRepository: SettingsRepository(db, NappSettingsStoreOps(store)),
    languageController: languageController,
    themeModeController: themeController,
    appIdentity: identity,
    nappTranslations: nappTranslations,
    proController: proController,
    purchaseRepository: purchaseRepository,
    bannerController: bannerController,
    giftFlow: GiftFlow(
      policy: policy,
      rewardedManager: rewardedManager,
      onRewardEarned: () =>
          proController.grantTemporaryPro(const Duration(hours: 24)),
    ),
  ));
}
