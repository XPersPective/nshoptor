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
import 'core/money/format_locale.dart';
import 'data/db/app_database.dart';
import 'features/ads/ad_gate.dart';
import 'features/assistant/assistant_bubble.dart';
import 'features/ai/ai_client.dart';
import 'features/subscription/lifetime_only_adapter.dart';
import 'features/subscription/subscription_service.dart';
import 'features/settings/settings_repository.dart';

/// Uygulama veritabanı: tüm platformlarda app dizininde tek dosya.
QueryExecutor openAppDatabase() => driftDatabase(name: 'nshoptor');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await SettingsStore.load();
  AppDefaults.attach(store);
  AssistantPrefs.attach(store);
  final formatSetting = store.getString(SettingsRepository.formatLocaleKey);
  AppFormatLocale.attach(
    formatSetting == 'tr' || formatSetting == 'en' ? formatSetting : null,
  );
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
  // Ömür boyu ürün akışı süzülür: abonelik olayları ProController'ı
  // kalıcı Pro yapmasın (PB-055).
  final purchaseRepository = PurchaseRepository(
    adapter: LifetimeOnlyAdapter(InAppPurchaseAdapter(), productId: EnvConfig.proProductId),
    productId: EnvConfig.proProductId,
  );
  final proController = ProController(
    store: store,
    repository: purchaseRepository,
  )..load();
  proController.startListening();

  // Pro/Max abonelikleri (ADR-004 §6); AI kotası sunucuda doğrulanır.
  final subscriptions = SubscriptionService(store: store)..load();
  subscriptions.start();
  SubscriptionService.instance = subscriptions;
  AiService.client = AiClient(
    store: store,
    baseUrl: EnvConfig.aiBaseUrl,
    credential: () => subscriptions.credential,
  );
  // İlk 7 gün reklamsız (AdGate), ömür boyu/geçici Pro ya da abonelik.
  bool adFree() =>
      AdGate.inGrace(store, DateTime.now()) ||
      SubscriptionService.adFree(
          lifetimeOrTemp: proController.isPro, tier: subscriptions.tier);

  // Reklam (standart §5.2): kalıcı durum → oturum → onay/SDK → politika
  // Pro'yu izler; UMP onayı SDK başlatmasından ÖNCE.
  final adsAdapter = await SharedPreferencesAdapter.create();
  final policy = AdPolicy();
  final saved = AdPolicyPersistence.load(adsAdapter);
  if (saved != null) policy.restore(saved);
  policy.setOnboardingCompleted(true);
  policy.setPro(adFree());
  void syncAds() {
    policy.setPro(adFree());
    AdPolicyPersistence.save(adsAdapter, policy);
  }
  proController.addListener(syncAds);
  subscriptions.addListener(syncAds);
  policy.startSession(DateTime.now());

  final bannerController = BannerAdController(policy: policy);
  final rewardedManager = RewardedAdManager(policy: policy);
  final appOpen = AppOpenAdManager(policy: policy);
  // Açılış reklamı: politika (≥4 saat, oturumda bir) + alışveriş modunda yok.
  Future<void> maybeShowAppOpen() async {
    policy.setPro(adFree());
    if (AdGate.shoppingModeActive) return;
    await appOpen.tryLoad(DateTime.now());
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!AdGate.shoppingModeActive) await appOpen.showIfAvailable();
  }
  // Ödüllü reklam birimi tanımlı değilse (standart: yalnız banner) hediye akışı
  // kapalı kalır; üretimde Google test birimi gösterilmez.
  const hasRewardedUnit = bool.hasEnvironment('ADMOB_REWARDED_ANDROID');

  unawaited(() async {
    final ready = await ConsentManager.initialize();
    if (!ready) return; // onay alınamadı: reklamsız devam
    policy.setSdkReady(true);
    bannerController.load();
    if (hasRewardedUnit) await rewardedManager.load();
    await maybeShowAppOpen();
  }());
  AppLifecycleListener(onResume: () => unawaited(maybeShowAppOpen()));

  WidgetsBinding.instance.addObserver(SettingsLifecycleObserver(store));
  final db = AppDatabase(openAppDatabase());
  runApp(
    NShoptorApp(
      db: db,
      settingsRepository: SettingsRepository(db, NappSettingsStoreOps(store)),
      languageController: languageController,
      themeModeController: themeController,
      appIdentity: identity,
      nappTranslations: nappTranslations,
      proController: proController,
      purchaseRepository: purchaseRepository,
    subscriptions: subscriptions,
      bannerController: bannerController,
      giftFlow: !hasRewardedUnit
          ? null
          : GiftFlow(
              policy: policy,
              rewardedManager: rewardedManager,
              onRewardEarned: () =>
                  proController.grantTemporaryPro(const Duration(hours: 24)),
            ),
    ),
  );
}
