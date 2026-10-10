# Current Architecture
## 2026-10-09 kaynak denetimi
- Mevcut sürüm pubspec.yaml: 1.1.4+6; aşağıdaki eski test/yayın/domain notlarının bir kısmı tarihsel ve STALE.
- PB-070 home/history/draft/completed tek ListDetailScreen açar; yeni liste editörü doğrudan açılır ve yeni kayıt detaya gider; ay kartı para kodunu korur. PB-071 form mevcut ID günceller; plan/gerçek bağımsız, kamera yalnız gerçek alanını doldurur, yazım atomic/hata görünür. Ortak removeItem bağlı alım/gözlemi kaldırır; PB-062 tek kanonik detayda satır CRUD, fiyat düzeltme, checkbox ve onaylı silme; ShoppingModeScreen uyumluluk kabuğudur.
- PB-063: recordPurchase ve fiş commit aynı transaction içinde; bağlı alımlar bir kez değiştirilir, controller tekrar/concurrent onay idempotenttir. purchaseEntryId mevcut ilişkisiyle gözlem düzeltme/undo güvenli. JPY/KWD ayrıştırıcı hassasiyeti Currency kaynağından gelir. PB-074 oturum sahipliği ve geç callback korumasıyla mikrofon ikinci init riski kapatıldı.
- PB-073 sonuç farkı yalnız bilinen tahmin+gerçek alımlardan; alınmayan/plansız ayrı. Bilinmeyen gerçek/tahmin —, ücretsiz 0 farklı; karma birim miktarı toplanmaz. Full suite 316 + son görünüm delta domain 20 passed; analyze 0.
- 71 ARB var; ilk kurulum country→currency main.dart içinde zaten var. Settings keepAwake kanonik listeye bağlı (PB-077).
- Server mevcut varsayılan: free15/pro200/max1000, Qwen Token Plan. PB-066 PDF yerel Android yazdırma ile var. PDF/ayarlar/AI geliştirmeleri açık görevlerdedir.
- Kullanıcı devralma/tamamlama yetkisi verdi; yalnız kanıtlanan checkpointler burada mevcut durumdur.
- PB-062 doğrulama: 321 full-suite passed, analyze 0; 320dp/2x tr/ar taşmasız, 48dp erişilebilir eylemler. Büyük yazıda başlık ürünlerle birlikte kayar. Tamamlanmış listede yeniden başlatma yok.
- PB-066 liste menüsü/sonuç PDF raporu: atomic snapshot, kaçırılmış HTML, null/para/birim dürüst; Android native print lifecycle. API36 emülatörde cancel→repeat→save→open 5 sayfa/Türkçe görsel kanıtlı; docs/audits/pdf-report-2026-10-09.md. 74 domain +2 son delta passed, debug APK, analyze 0.
- PB-067 system sayı biçimi cihaz ülke yerelinden (Latin dışı rakamda en), UI dili bağımsız; 71 dilde açıklama güncel. MoneyParser intl ayraç/gruplama (en_IN3/2, fr ince boşluk) ve büyük ondalık için ortak doğru yol. Limitler currency key ile saklanır; eski değer mevcut tercihe bir kez bağlanır, prefill hassasiyet/küsurat korunur, invalid kalır; plansız aylık kart/geri dönüş refresh testli. Full335 passed, analyze0. Wakelock PB-077 tamam; feedback PB-078 tamam.
- PB-074: 339 full-suite passed, analyze 0, Android debug APK built; actual API36 native bridge integration 1 passed. Speech partial/final/status/error, exact/same-language locale, second tap stop and disposal preserve text; physical audio remains unverified.
- PB-075: AI schema title/brand/category; editable title and product fields with price mode. Approval resolves/reuses category and saves selected items atomically; failure keeps draft, source change invalidates it. Home list creation and items share transaction. Local numeric/decimal quantities preserved. Full342 passed, server9 passed, analyze0. Worker schema source updated; live deployment still pending PB-065.
- PB-076: shared photo candidate carries productName/unit/actual price; selected €/kg and per-item values use the correct actual quantity/mode, estimate stays unchanged. Local name heuristic is editable; KWD3/free0 supported. Standalone Home receipt preview allocates list only on atomic approval; cancellation/error/concurrent retry leave no orphan/duplicates. Controllers disposed by route owners. Full348 passed, analyze0.
- PB-064 input acceptance: 93 voice/receipt/wiring/form checks and server9 passed, analyze0; single-item voice metadata/line-total approval covered. User explicitly retained the current Qwen Token account for this revision; provider replacement deferred (PB-065).
- PB-077 (2026-10-10): appRouteObserver includes modal sheets; canonical list reads keepAwake preference, selected control reflects native success, releases on covering route/pause/dispose, restores on pop/resume. Nested AdGate ownership preserved. 86 domain passed, analyze0; native Android flag still PB-069.
- PB-079: DecimalFixed.toMinorUnits uses checked int.parse at native signed storage boundary; large products no longer silently clamp. Overflow preview/save preserve manual input and replacement keeps existing purchase/observation. Full354 passed, analyze0.
- PB-080 country defaults BG→EUR, BY→BYN(2 digits); existing BGN remains readable and stored user choices unchanged. Official ECB/NBRB/CBR facts verified; money50 passed, analyze0.
- PB-078: all feature Snackbar callers replace queued messages and offer close; important errors remain until closed, Undo keeps native timeout/accessibility. Home assistant visibly busy; voice/assistant previews scroll with keyboard, voice actions wrap. Domain150+8 passed, analyze0.
- PB-081: shared Insights monthly get/watch SQL aggregates purchases before plans; variance includes only known complete item comparisons, null without samples. Home reuses query and shows neutral —; spending/budget totals preserved, currency/local month separate. Home/history31 passed, analyze0.
- PB-082 source: D1 batch reserves monthly/global together with conditional updates; paid identity SHA256 of verified token, legacy200/1000 retained, v2 policies supported. Canceled renewal valid through expiry. Stream byte bounds, task output ceilings, truncation/schema rejection and generic DB failure. Server21/full358/analyze0; live vars/deploy and replacement carry-forward remain PB-065.
## Scope

Repository-wide current architecture (NShoptor, single Flutter app).
## Map

- `lib/main.dart` — boot: settings, Pro/Ads (napp_kit), DB, runApp
- `lib/app/` — NShoptorApp, dil/tema denetleyicileri, varsayılanlar
- `lib/core/money|quantity|calc` — decimal para, birim, plan-gerçek hesapları (double yok)
- `lib/core/l10n/` — 71 ARB + üretilmiş AppLocalizations
- `lib/core/theme/` — M3 tema, SemanticDelta renkleri
- `lib/core/config/env_config.dart` — AppIdentity, dart-define adresleri, Pro ürün kimliği
- `lib/data/db/` — drift şeması (14 tablo) + üretilmiş kod
- `lib/features/home/` — HomeShell (5 sekme), ana sayfa kartları
- `lib/features/lists/` — listeler, liste detayı, ürün formu, hatırlatma, şablonlar
- `lib/features/shopping_mode/` — alışveriş modu, sonuç ekranı (summary/)
- `lib/features/receipts/` — cihaz içi OCR (ML Kit), fiş ayrıştırma/eşleştirme, raf etiketi
- `lib/features/voice_input/` — Android cihaz içi MethodChannel ses + kural tabanlı komut ayrıştırıcı
- `lib/features/history/` — geçmiş, fiyat geçmişi, içgörüler
- `lib/features/settings/` — ayarlar, yedek/CSV, AI anahtarı
- `lib/features/ai/ai_client.dart` — AI vekiline tek kapı (AiService.client, kurulum kimliği, AiResult)
- `lib/features/subscription/` — Pro/Max abonelik servisi, planlar ekranı, ömür boyu akış süzgeci
- `tool/play/subscriptions.rb`, `tool/ai_economics.py` — Play catalog setup/read-only prices, Decimal cost scenarios/self-check
- `test/`, `integration_test/` — birim/widget/e2e; `test/store_capture_test.dart` mağaza görselleri
- `fastlane/` — Play yayın lane'leri (imza/kimlik yayın kökünde: D:\AppPublishing\apps\nshoptor)
- `docs/store/` — gizlilik politikası, Play beyan taslakları
- `server/` — Cloudflare Worker AI vekili (`nshoptor-api.devx8585.workers.dev`), D1 kota, Play doğrulama
## Runtime

**Status:** VERIFIED (2026-10-09 boot/defaults/format checkpoint)

**Sources:** `lib/main.dart`, `lib/app/**`, `pubspec.yaml`, `pubspec.lock`

Flutter stable 3.47.x, Dart null safety, Material 3. Entry point
`lib/main.dart` → `lib/app/` (NShoptorApp + LanguageController +
AppThemeModeController + AppDefaults) + napp_kit katmanı (ADR-002):
AppIdentity/env_config (dart-define), PurchaseRepository+ProController
(`com.crazypenguin.nshoptor.pro_lifetime`), AdPolicy+UMP onayı (SDK'dan önce),
BannerAdController, napp sözlük delegesi. Boot: SettingsStore yüklenir,
ModalRoute observer in app/navigation.dart drives list ownership.
dil + tema + biçim-yereli (AppFormatLocale: dil'den BAĞIMSIZ, C-001)
runApp'ten önce okunur. State: stream-based repositories +
StatefulWidget; no external state framework. Persistence: drift 2.35
over sqlite (ADR-001).
## Domains
### Core

**Status:** VERIFIED (structure), test counts STALE (from legacy audit record)

**Sources:** `lib/core/**`, `test/core/**`

- `core/money/`: Currency, DecimalFixed (BigInt unscaled+scale), Money (minor
  units), MoneyParser/formatter same intl separators and primary/secondary grouping, ungrouped large decimals valid; system device region, explicit tr/en independent; no `double`.
- `core/quantity/`: UnitCode (13 units), UnitConversion, PackagingContent,
  unit_display (görünen ad l10n'dan; DB'de kanonik kod — tek kaynak).
- `core/calc/`: LineCalc, EffectSplit (price/quantity effect separation),
  ListCalc, VarianceThreshold (%10 OR 200 minor).
- `core/l10n/`: 71 ARB + generated AppLocalizations (`l10n.yaml`); PB-072 ortak hata/onay/PDF/istatistik metinlerini bütün dillere ekler. Anahtar/placeholder/İngilizce fallback kontrolü testlidir; çeviriler insan dil denetimi değildir.
- `core/theme/`: M3 AppTheme (seed 0xFF0B8457), SemanticDelta (WCAG AA checked), responsive premium widgets.
- `core/util/`: normalizeName (Unicode harf/rakam korunur, Türkçe katlama), combineLatest3 (no rxdart).
### Data

**Status:** VERIFIED

**Sources:** `lib/data/db/**`, `test/data/**`

drift schema v1, 14 tables (spec §8 entities: ShoppingList, PlannedItem,
PurchaseEntry, ProductMemory, ProductAlias, PriceObservation, Store, Category,
Aisle, Receipt, ReceiptCandidateLine, Attachment, Reminder, AppSettings), FK
cascade/set-null, PRAGMA foreign_keys, migration v0→v1, transaction rollback
tested. Generated `app_database.g.dart` committed to repo (ADR-001).
### Features

**Status:** VERIFIED (2026-10-09 canonical lists, native voice, approved AI draft checkpoint)

**Sources:** `lib/features/**`, `test/features/**`, `integration_test/**`

- `lists/`: ListStatus machine, ListRepository (undo snapshot), ListsScreen,
  ItemFormSheet (iki kademeli: ad-odaklı + tahmini fiyat + miktar; marka/
  kategori/birim-modu/min-max/not/zorunlu "Ayrıntılar" altında katlanır —
  C-004); `lists/suggestions/` (ProductMemory, paste_parser), `lists/
  taxonomy/` (store/category/aisle CRUD + 4 sort modes), `lists/templates/`
  (plan from previous actuals; Home completed-list tile "plan from this"
  marks template + opens new plan; Home Templates card), `lists/reminders/`
  (ReminderScheduler abstraction + LocalNotificationsScheduler:
  flutter_local_notifications üretim adaptörü — izin yalnız hatırlatma
  kurulurken istenir, tam alarm izni yoksa inexact fallback; cihaz
  doğrulaması PB-043'te bekliyor), `lists/attachments/` (file storage +
  orphan sweep). `list_detail_screen.dart`: canonical checkbox rows for every status, unknown price —, independent planned/actual edit+scan, confirmation for delete/undo, fixed bottom input/receipt/finish actions; header scrolls at large type. Completed lists have no restart.
- `shopping_mode/`: 5 item statuses, unplanned purchases, controlled returns,
  projection summary; canonical RouteAware/lifecycle wakelock with global serialized owner updates (PB-077); satıra dokunuş → hızlı giriş alt sayfası
  (fiyat alanı ilk + autofocus; indirim/alternatif katlanır) — C-004;
  `shopping_mode/summary/`: ResultRepository + SummaryScreen (price vs
  quantity effect rows; comparable known prices only).
- `lists/list_detail_screen.dart`: hub for input helpers — item form gets
  voice (VoicePreviewSheet) + shelf-label (price_candidate_sheet) callbacks;
  AppBar receipt scan → ReceiptParser → ReceiptReviewScreen; item tap →
  PriceHistoryScreen (productId, else ProductMemory by normalizedName).
  SpeechService / OcrTextSource / image picker injectable for tests.
- `home/`: HomeShell (5 tabs: + Keşfet/OtherAppsPage, apps.json
  protokolü; banner bottom bar'ın ALTINDA), HomeScreen (monthly totals
  per currency — T33 fix); premium boş-durum kartı (ikon dairesi + CTA).
- `history/price_history/`: min/median/max, trend, cheapest store
  (repository); `price_history_sheet.dart` PriceHistoryScreen lists
  observations only (stats not yet shown), optional currency/unit filters and localized large-text rows.
  `history/insights/`: confirmed currency-filtered spending; exact unit net quantities and distinct purchase visits/intervals (PB-084). PB-068 graphs/category-store breakdowns and product/category cards in SpendingScreen, filtered price history, all71 time/returns hint; 320dp2x en/ar, history+l10n31/analyze0.
- `voice_input/`: SpeechService abstraction + controller; SttSpeechService
  (native on-device channel, session ownership); VoicePreviewSheet (editable transcript, manual
  fallback when service unavailable); `voice_input/parser/`: deterministic
  tr/en voice command parser.
- `receipts/`: OcrTextSource + MlKitTextSource (bundled Latin, no model
  download), ShelfPriceExtractor; `receipts/parser/` ReceiptParser
  (_reconstructRows: ML Kit kolon-bölünmesini görsel satırlara geri
  kurar — top ±8px gruplama; korpus market_tr_1.png CİHAZ OCR'ıyla
  uçtan uca kanıtlandı) +
  ReceiptMatcher; `receipts/review/` ReceiptReviewController (no DB write
  before approval) + ReceiptReviewScreen (accept/ignore/link/split/merge,
  total diff; nullable new-list controller, create+purchase transaction and retry ownership). Shelf label: no crop/rotate UI — ML Kit reads any
  orientation and user picks among all candidates (C-040: no crop package).
  ReceiptMatcher auto-suggestion not used by the screen (manual link only).
- `subscription/`: source offers *_v2 Pro100/Max300, legacy200/1000 retained, free/lifetime10; matching native owner, latest-query guards and pending purchase/restore deduplication. Legacy rights note and quotas all71; domain24 + subscription11 passed, analyze0. Live catalog remains old SKUs until PB-065.
- `settings/`: SettingsScreen + SettingsRepository (spec §6.15,
  delete-all double confirm; tema + formatLocale anahtarları repo'da);
  Pro satırı (PaywallPage) + yedek dışa/içe PRO-GATE (standart §3.8:
  kilit + paywall; Pro değişince kilit anında kalkar); Hakkında
  (AboutPage: açık kaynak/GPL-3.0), Lisanslar, Paylaş, Puan ver
  (napp_core); `settings/backup/` BackupRepository (13-table
  export/import, CSV export — CSV serbest).
### Platform

**Status:** VERIFIED (native PDF/speech 2026-10-09; other shell notes historical)

**Sources:** `android/**`, `.github/**`, `tool/pdf_probe.dart`, `docs/audits/pdf-report-2026-10-09.md`

Android: PDF MethodChannel → no-network/no-JS WebView → PrintManager; adapter finish/timeout/destroy cleanup, no false saved message. API36 5-page save/open evidence.
Android: native speech channel, API31+ on-device only; permission/language/manual fallback, per-session + recognizer generation callback guards, stop final-result await and lifecycle destroy. API36 native bridge integration passed without recording.
Android: RECORD_AUDIO + RecognitionService query; hatırlatma izinleri
+ flutter_local_notifications alıcıları; AdMob APPLICATION_ID manifest
placeholder'ı key.properties'ten (yoksa Google TEST kimliği; gerçek
kimlik repoya GİRMEZ). Gerçek uygulama ikonu: marka yeşili sepet
(tool/brand/make_source_icon.py → adaptive + monochrome + splash;
emülatör launcher kanıtı). cleartext off, backup rules, R8
minify+shrink, key.properties imza, fat APK tüm ABI'ler. iOS: ertelendi
(C-033). CI: analyze+test, gitleaks, release APK build. Uygulama
gerçeğiyle yasal taslaklar (docs/store/) çapraz kontrolü tamam.
## External Dependencies

per `pubspec.yaml` (HEAD): drift 2.35, drift_flutter, flutter_localizations,
google_mlkit_text_recognition 0.17.1, image_picker,
path_provider, flutter_local_notifications 22.3.1, timezone, wakelock_plus,
share_plus, file_picker.

## Known Unknowns

- Voice: native köprünün API36 emülatörde init/cancel/reopen testi geçti; fiziksel cihazda gerçek transcript henüz doğrulanmadı (PB-069).
- ADR-006/PB-074: yalnız createOnDeviceSpeechRecognizer (API31+); installed languages (API33+), ağ/model indirme fallback yok. Eski paket kaldırıldı; gerçek ses tanıma fiziksel cihazda henüz doğrulanmadı.
- Reklam/Pro: test kimlikleriyle tam akış canlı; gerçek AdMob kimliği
  ve paywall fiyatı Crazy Penguin'de; apps.json besleme repo adresi
  bilinmiyor (docs/store/apps-json-entry.md).

## Yayın durumu (VERIFIED 2026-10-08)

- Play Console uygulaması com.crazypenguin.nshoptor (hesap crazypenguin). Üretim: 1.0.0 (1). Dahili test: 1.1.1 (3) completed (71 dil, PB-061), test listesi "teste" seçili, katılım https://play.google.com/apps/internaltest/4700463295417403444.
- Yayın kökü `D:\AppPublishing\apps\nshoptor` (imza, kimlikler, 73 Play dili mağaza metni/görselleri). Metin kaynağı `tool/store/listing.py` (+ `listing_extra.json`, `listing_translate.py`); toplu görsel `tool/store/capture_all.py`; uygulama çevirisi `tool/i18n/translate.py`. 71 uygulama dili (ARB), napp_pro/napp_ads kendi metinleri tr/en (diğerlerinde İngilizce). 1.1 mağaza metni/görselleri henüz Play'e yüklenmedi (üretime alırken `push_metadata`).
- Ürünler: `nshoptor_pro`, `nshoptor_max` (abonelik), `com.crazypenguin.nshoptor.pro_lifetime` (ömür boyu reklamsız). Ödüllü reklam birimi app-ids.env'de (ADMOB_REWARDED_ANDROID).
### Server

**Status:** VERIFIED (2026-10-09 source schema/worker; live configuration historical)

**Sources:** `server/**`, `tool/play/subscriptions.rb`, `tool/ai_economics.py`, `docs/audits/ai-economics.md`

Cloudflare Worker `nshoptor-api` (workers.dev) + D1 `nshoptor`. `POST /v1/ai`
görevleri `parse_list`, `match_receipt`, `read_label`; parse_list title/brand/category bounded metadata (PB-075); çıktı `tasks.js`'te
şemaya göre temizlenir; eksik/kesik çıktı reddedilir (bilinmeyen kimlik/birim null). Source quota atomic batch, paid verified-token lineage identity; live rollout PB-065. Kota aylık
(free 15 / pro 200 / max 1000) + günlük global tavan; Pro/Max yalnız
Play `subscriptionsv2` doğrulamasıyla (invalid credential → free; verified lineage failure → busy). Sağlayıcı OpenAI
uyumlu; şu an Qwen Token Plan `qwen3.6-flash` (kullanıcı şimdilik Qwen hesabını korudu). Sırlar: `AI_KEY`, `GOOGLE_SA_JSON` (Worker
secret; kaynak D:\AppPublishing). Testler: `cd server && npm test`. PB-086 canonical cache ownership persists across verified linkedPurchaseToken replacements and expiry; bounded lineage failures yield generic503 before quota. Server25/full369/analyze0. PB-083 verified read-only Play catalog and reproducible Decimal scenarios; current Qwen invoice/credits unknown, comparator cost is not actual profit.
