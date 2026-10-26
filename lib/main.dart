// Gizli degerler KODA YAZILMAZ; derlemede --dart-define ile verilir (1.2).
import 'dart:async';

import 'package:drift/drift.dart' show QueryExecutor;
import 'package:drift_flutter/drift_flutter.dart';

import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kReleaseMode, defaultTargetPlatform;

import 'features/ads/ad_startup.dart';

import 'package:napp_ads/napp_ads.dart';
import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';

import 'app/app.dart';
import 'features/ads/ad_units.dart';
import 'app/app_defaults.dart';
import 'app/language_controller.dart';
import 'app/theme_mode_controller.dart';
import 'core/config/env_config.dart';
import 'core/money/country_currency.dart';
import 'core/money/format_locale.dart';
import 'data/db/app_database.dart';
import 'features/ads/ad_gate.dart';
import 'features/engagement/review_moments.dart';
import 'features/assistant/assistant_bubble.dart';
import 'features/ai/ai_client.dart';
import 'features/subscription/subscription_purchase_adapter.dart';
import 'features/subscription/subscription_service.dart';
import 'features/settings/settings_repository.dart';
import 'features/receipts/receipt_image_store.dart';

/// Uygulama veritabanı: tüm platformlarda app dizininde tek dosya.
QueryExecutor openAppDatabase() => driftDatabase(name: 'nshoptor');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await SettingsStore.load();
  AppDefaults.attach(store);
  ReviewMoments.instance = ReviewMoments(store: store);
  // İlk açılış: para birimi cihaz ülkesinden (tablo dışı: Türkçe cihazda TRY, aksi USD).
  if (store.getString(SettingsRepository.currencyKey) == null) {
    final locale = PlatformDispatcher.instance.locale;
    store.setString(
      SettingsRepository.currencyKey,
      currencyForCountry(locale.countryCode) ??
          (locale.languageCode == 'tr' ? 'TRY' : 'USD'),
    );
  }
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
  // ProController yalnızca 24 saatlik geçici Pro ödülünü tutar; abonelik
  // mağaza akışı SubscriptionService tarafından yönetilir.
  final purchaseRepository = PurchaseRepository(
    adapter: const SubscriptionPurchaseAdapter(),
    productId: SubscriptionService.proId,
  );
  final proController = ProController(
    store: store,
    repository: purchaseRepository,
  )..load();

  // Pro/Max abonelikleri (ADR-004 §6); AI kotası sunucuda doğrulanır.
  final subscriptions = SubscriptionService(store: store)
    ..load()
    ..initializeTrial();
  SubscriptionService.instance = subscriptions;
  AiService.client = AiClient(
    store: store,
    baseUrl: EnvConfig.aiBaseUrl,
    credential: () => subscriptions.credential,
    appleTransaction: () => subscriptions.appleTransaction,
    trialFirstOpenedAt: () => subscriptions.trialFirstOpenedAt,
    onTrialWindow: (window) => subscriptions.observeTrialServer(
      endsAt: window.endsAt,
      serverNow: window.serverNow,
    ),
  );
  // İlk 7 gün tam Pro, abonelik ya da o günün ödüllü reklamsız hakkı (N055/N056).
  bool adFree() =>
      SubscriptionService.adFree(
        temporaryPro: proController.isPro,
        tier: subscriptions.tier,
      ) ||
      AdGate.isRewardedAdFree(store, DateTime.now());

  // Reklam (standart §5.2): kalıcı durum → oturum → onay/SDK → politika
  // Pro'yu izler; UMP onayı SDK başlatmasından ÖNCE.
  final adsAdapter = await SharedPreferencesAdapter.create();
  final policy = AdPolicy();
  final saved = AdGate.loadPolicy(adsAdapter);
  if (saved != null) policy.restore(saved);
  policy.setOnboardingCompleted(true);
  policy.setPro(adFree());
  policy.startSession(DateTime.now());
  AdPolicyPersistence.save(adsAdapter, policy);
  final bannerController = BannerAdController(policy: policy);
  final rewardedManager = RewardedAdManager(policy: policy);
  final hasRewardedUnit = adUnitEnabled(
    platform: defaultTargetPlatform,
    releaseMode: kReleaseMode,
    androidUnit: const String.fromEnvironment('ADMOB_REWARDED_ANDROID'),
    iosUnit: const String.fromEnvironment('ADMOB_REWARDED_IOS'),
  );
  final adStartup = AdStartup(
    isAdFree: adFree,
    initialize: ConsentManager.initialize,
    onReady: () => policy.setSdkReady(true),
    load: () async {
      policy.setPro(adFree());
      bannerController.load();
      if (hasRewardedUnit) await rewardedManager.load();
    },
  );
  var firstFrameReady = false;
  void syncAds() {
    policy.setPro(adFree());
    bannerController.onProChanged();
    AdPolicyPersistence.save(adsAdapter, policy);
    if (firstFrameReady) unawaited(adStartup.ensureReady());
  }

  proController.addListener(syncAds);
  subscriptions.addListener(syncAds);
  // N054: no automatic app-open or interstitial advertisement.
  AdGate.showInterstitial = null;
  AppLifecycleListener(onResume: syncAds);

  WidgetsBinding.instance.addObserver(SettingsLifecycleObserver(store));
  final db = AppDatabase(openAppDatabase());
  final receiptMedia = await ReceiptImageStore.directory();
  runApp(
    NShoptorApp(
      db: db,
      splash: Duration.zero,
      settingsRepository: SettingsRepository(
        db,
        NappSettingsStoreOps(store),
        mediaDir: receiptMedia,
      ),
      languageController: languageController,
      themeModeController: themeController,
      appIdentity: identity,
      appsCacheStore: store,
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
              onRewardEarned: () {
                AdGate.grantRewardedAdFreeDay(store, DateTime.now());
                syncAds();
              },
            ),
    ),
  );
  unawaited(
    WidgetsBinding.instance.waitUntilFirstFrameRasterized.then((_) {
      firstFrameReady = true;
      proController.startListening();
      subscriptions.start();
      WidgetsBinding.instance.addObserver(
        SubscriptionResumeObserver(subscriptions),
      );
      syncAds();
    }),
  );
}
