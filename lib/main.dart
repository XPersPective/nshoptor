// Gizli degerler KODA YAZILMAZ; derlemede --dart-define ile verilir (1.2).
import 'dart:async';

import 'package:drift/drift.dart' show QueryExecutor;
import 'package:drift_flutter/drift_flutter.dart';
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:napp_ads/napp_ads.dart';
import 'package:napp_core/napp_core.dart';
import 'package:napp_pro/napp_pro.dart';

import 'app/app.dart';
import 'app/app_defaults.dart';
import 'app/language_controller.dart';
import 'app/theme_mode_controller.dart';
import 'core/config/env_config.dart';
import 'core/money/country_currency.dart';
import 'core/money/format_locale.dart';
import 'data/db/app_database.dart';
import 'features/ads/ad_gate.dart';
import 'features/assistant/assistant_bubble.dart';
import 'features/ai/ai_client.dart';
import 'features/subscription/no_lifetime_adapter.dart';
import 'features/subscription/subscription_service.dart';
import 'features/settings/settings_repository.dart';

/// Uygulama veritabanı: tüm platformlarda app dizininde tek dosya.
QueryExecutor openAppDatabase() => driftDatabase(name: 'nshoptor');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await SettingsStore.load();
  AppDefaults.attach(store);
  // İlk açılış: para birimi cihaz ülkesinden (tablo dışı: Türkçe cihazda TRY, aksi USD).
  if (store.getString(SettingsRepository.currencyKey) == null) {
    final locale = PlatformDispatcher.instance.locale;
    store.setString(
      SettingsRepository.currencyKey,
      currencyForCountry(locale.countryCode) ?? (locale.languageCode == 'tr' ? 'TRY' : 'USD'),
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
  // Ömür boyu satın alma yok: mağaza akışı ProController'a iletilmez.
  final purchaseRepository = PurchaseRepository(
    adapter: NoLifetimePurchaseAdapter(InAppPurchaseAdapter()),
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
  WidgetsBinding.instance.addObserver(SubscriptionResumeObserver(subscriptions));
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
  final saved = AdGate.loadPolicy(adsAdapter);
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
  // Persist first launch/session count: without it every launch looked like
  // day 0 and the 7-day/5-session guards never opened full-screen ads.
  AdPolicyPersistence.save(adsAdapter, policy);

  final bannerController = BannerAdController(policy: policy);
  final rewardedManager = RewardedAdManager(policy: policy);
  final appOpen = AppOpenAdManager(policy: policy);
  // Açılış reklamı: politika (≥4 saat, oturumda bir) + alışveriş modunda yok.
  Future<void> maybeShowAppOpen() async {
    policy.setPro(adFree());
    if (AdGate.shoppingModeActive) return;
    await appOpen.tryLoad(DateTime.now());
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!AdGate.shoppingModeActive && await appOpen.showIfAvailable()) {
      AdPolicyPersistence.save(adsAdapter, policy);
    }
  }
  // Ödüllü/geçiş birimi tanımlı değilse üretimde kapalı kalır (Google test
  // birimi yayında gösterilmez); debug/profile test birimleriyle çalışır.
  const hasRewardedUnit =
      !kReleaseMode || bool.hasEnvironment('ADMOB_REWARDED_ANDROID');
  const hasInterstitialUnit =
      !kReleaseMode || bool.hasEnvironment('ADMOB_INTERSTITIAL_ANDROID');

  // Geçiş reklamı: napp_ads yöneticisi show() çağırmadığı için burada.
  // ponytail: one preloaded ad; move into napp_ads once its manager calls show().
  InterstitialAd? interstitial;
  void loadInterstitial() {
    if (!hasInterstitialUnit || interstitial != null) return;
    InterstitialAd.load(
      adUnitId: AdsConfig.interstitialUnit,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => interstitial = ad,
        onAdFailedToLoad: (_) {},
      ),
    );
  }

  AdGate.showInterstitial = () async {
    policy.setPro(adFree());
    final ad = interstitial;
    if (ad == null || !policy.canShowInterstitial(DateTime.now())) return;
    interstitial = null;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        policy.recordFullscreen(DateTime.now(), isAppOpen: false);
        AdPolicyPersistence.save(adsAdapter, policy);
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        loadInterstitial();
      },
    );
    await ad.show();
  };

  unawaited(() async {
    final ready = await ConsentManager.initialize();
    if (!ready) return; // onay alınamadı: reklamsız devam
    policy.setSdkReady(true);
    bannerController.load();
    if (hasRewardedUnit) await rewardedManager.load();
    loadInterstitial();
    await maybeShowAppOpen();
  }());
  AppLifecycleListener(onResume: () => unawaited(maybeShowAppOpen()));

  WidgetsBinding.instance.addObserver(SettingsLifecycleObserver(store));
  final db = AppDatabase(openAppDatabase());
  runApp(
    NShoptorApp(
      db: db,
      splash: const Duration(milliseconds: 1600),
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
              onRewardEarned: () {
                proController.grantTemporaryPro(const Duration(hours: 24));
                AdPolicyPersistence.save(adsAdapter, policy); // once a day
              },
            ),
    ),
  );
}
