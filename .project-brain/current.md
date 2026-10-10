# Current Architecture
## Final verified state — 2026-10-10
- Source/pubspec/About1.2.1+8; Google Play internal8 completed, production1 unchanged. Final publisher AAB signed by existing certificate and external-secret literal scan passed. Detailed evidence: docs/audits/release-1.2.1-2026-10-10.md and internal-release-2026-10-10.md.
- Final Flutter383/server25/analyze0/configured debug APK passed. Native JSON FilePicker fixture1 and normal optimized main8 CSV cancel/retry/save/pull/numeric/cold-reopen checks passed. GitHub final code/fixture/helper CI38074516588 allgreen (analysis/tests/gitleaks/release APK).
- Canonical checklist/independent plan-actual quantities/prices, atomic receipt replacement, rollback/undo, editable local speech/OCR and optional AI preview, precise decimal/currency, large-text RTL and native wake lifecycle are verified by source/domain/full/native checks; release-2026-10-10.md maps SC1–SC8 and preserves historical7 proof.
- PDF/CSV free; Pro JSON native save/select/approval validates bounded16MiB UTF8 and preserves v1/relationships. No photo binary archive. JSON main customer DB never used by QA fixture.
- New quotas10/100/300 monthly, grandfathered200/1000; actual Play v2 prices/catalog and live atomic Worker/D1 verification complete. Current Qwen remains by explicit user choice; DeepSeek comparison is a pricing scenario, actual provider cost/profit unknown.
- Shared production list/Delete all paths now cancel active native reminders before deleting rows; cancellation failure preserves records and shows existing localized retry feedback. Calendar complete date/marker fits7 columns at large type; tests no longer rely on Windows fonts.
- 71 application ARBs,73 store locales/584PNG/73feature validated. Global metadata/images and Data Safety Console publication are deferred from internal scope. Physical transcript/camera and real tester purchase remain explicit external verification limits, not claims of successful execution.
- User storage correction honored: publishing/source stay D, build target and SDK/AVD on C. Native flutter clean removed old generated caches (PB096); owned temporary QA AVD removed after proof. Permanent evidence under D:/AppPublishing/apps/nshoptor/artifacts/.
## Scope

Repository-wide current architecture (NShoptor, single Flutter app).
## Map

- `lib/main.dart` — boot: settings, Pro/Ads (napp_kit), DB, runApp
- `lib/app/` — NShoptorApp, dil/tema denetleyicileri, varsayılanlar
- `lib/core/money|quantity|calc` — decimal para, birim, plan-gerçek hesapları (double yok)
- `lib/core/l10n/` — 71 ARB + üretilmiş AppLocalizations
- `lib/core/theme/` — M3 tema, SemanticDelta renkleri
- `lib/core/config/env_config.dart`, `lib/core/app_version.dart` — AppIdentity, dart-define adresleri, Pro ürün kimliği, pubspec/About sürümü
- `lib/data/db/` — drift şeması (14 tablo) + üretilmiş kod
- `lib/features/home/` — HomeShell (5 sekme), ana sayfa kartları
- `lib/features/lists/` — listeler, liste detayı, ürün formu, hatırlatma, şablonlar
- `lib/features/shopping_mode/` — alışveriş modu, sonuç ekranı (summary/)
- `lib/features/receipts/` — cihaz içi OCR (ML Kit), fiş ayrıştırma/eşleştirme, raf etiketi
- `lib/features/voice_input/` — Android cihaz içi MethodChannel ses + kural tabanlı komut ayrıştırıcı
- `lib/features/history/` — geçmiş, fiyat geçmişi, içgörüler
- `lib/features/settings/` — ayarlar, yedek/CSV, AI aç/kapat
- `lib/features/ai/ai_client.dart` — AI vekiline tek kapı (AiService.client, kurulum kimliği, AiResult)
- `lib/features/subscription/` — Pro/Max abonelik servisi, planlar ekranı, ömür boyu akış süzgeci
- `tool/play/subscriptions.rb`, `tool/ai_economics.py`, `tool/ai_rollout_check.py` — Play catalog, Decimal scenarios, live owned-quota check
- `test/`, `integration_test/` — birim/widget/e2e; `test/store_capture_test.dart` mağaza görselleri
- `fastlane/` — Play yayın lane'leri (imza/kimlik yayın kökünde: D:\AppPublishing\apps\nshoptor)
- `docs/`, `README.md`, `CHANGELOG.md`, `THIRD_PARTY_LICENSES.md` — architecture, privacy/Play drafts, release audits, usage/version/licenses
- `tool/store/`, `tool/i18n/`, `tool/release_device_check.py` — permanent D store generation/validation, translations, isolated native QA
- `.github/`, `.gitleaksignore`, `AGENTS.md` — CI/private-kit access, exact historical scanner exceptions, working protocol
- `server/` — Cloudflare Worker AI vekili (`nshoptor-api.devx8585.workers.dev`), D1 kota, Play doğrulama
## Runtime

**Status:** VERIFIED (2026-10-10 final source/defaults/native release checkpoint)

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

**Status:** VERIFIED (2026-10-10 final source/full checks)

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

**Status:** VERIFIED (2026-10-10 final source/full/native checks)

**Sources:** `lib/features/**`, `test/features/**`, `integration_test/**`

- `lists/`: ListStatus machine, ListRepository (undo snapshot; default native reminder cancellation before deletion), ListsScreen,
  ItemFormSheet (iki kademeli: ad-odaklı + tahmini fiyat + miktar; marka/
  kategori/birim-modu/min-max/not/zorunlu "Ayrıntılar" altında katlanır —
  C-004); `lists/suggestions/` (ProductMemory, paste_parser), `lists/
  taxonomy/` (store/category/aisle CRUD + 4 sort modes), `lists/templates/`
  (plan from previous actuals; Home completed-list tile "plan from this"
  marks template + opens new plan; Home Templates card), `lists/reminders/`
  (ReminderScheduler abstraction + LocalNotificationsScheduler:
  flutter_local_notifications üretim adaptörü — izin yalnız hatırlatma
  kurulurken istenir, tam alarm izni yoksa inexact fallback; cihaz
  native release doğrulaması PB-069’da), `lists/attachments/` (file storage +
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
  `history/insights/`: confirmed currency-filtered spending; exact unit net quantities and distinct purchase visits/intervals (PB-084). PB-068 graphs/category-store breakdowns and product/category cards in SpendingScreen, filtered price history, all71 time/returns hint. PB099 calendar fits complete day/marker within seven columns; no Windows-only font in analytics/paywall checks,320dp2x en/ar +375dp/landscape/light/dark/reduced-motion; full382/server25/analyze0 passed.
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
  ReceiptReviewScreen prefillSuggestions uses enabled AI first, high-confidence local ReceiptMatcher fallback; all links remain editable and require approval.
- `subscription/`: source offers *_v2 Pro100/Max300, legacy200/1000 retained, free/lifetime10; matching native owner, latest-query guards and pending purchase/restore deduplication. Legacy rights note and quotas all71; domain24 + subscription11 passed, analyze0. PB-065 new v2 catalog active (10 October), legacy unchanged; native release QA PB-069. PB-088 Android debug app_e2e3/device_audit2 passed; canonical store en/tr/ar24 images verified.
- `settings/`: SettingsScreen + SettingsRepository (spec §6.15,
  delete-all double confirm; active OS reminders cancelled before deleting DB rows, cancellation failure preserves records; tema + formatLocale anahtarları repo'da);
  Pro satırı (PaywallPage) + yedek dışa/içe PRO-GATE (standart §3.8:
  kilit + paywall; Pro değişince kilit anında kalkar); Hakkında
  (AboutPage: açık kaynak/GPL-3.0), Lisanslar, Paylaş, Puan ver
  (napp_core); `settings/backup/` BackupRepository (13-table
  export/import: atomic snapshot, merge upsert preserves newer children; separate remaps all13 table IDs/FKs/attachment owners, typed receipt imagePaths roundtrip. Shared v1 preflight reuses Drift type/length and checks decimals/overflow, IDs/FKs/owners before writes; attachment deletion requires resolved owned media parent (Windows junction tested). CSV free in Summary details; Pro JSON UI saves user-selected native destination, validates bounded16MiB strict UTF8 stream and confirms merge/separate; quiet cancel, busy/entitlement/mounted guards, no photo binaries (71 languages). Domain36/full380/analyze0; final native binary proof PB091).
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
(C-033). CI: analyze+test, gitleaks, release APK build allgreen on final app source (PB098). Private napp_kit uses dedicated read-only deploy key/Actions secret, strict pinned GitHub host and kit-only URL rewrite. Uygulama
gerçeğiyle yasal taslaklar (docs/store/) çapraz kontrolü tamam.
## External Dependencies

per `pubspec.yaml` (HEAD): drift 2.35, drift_flutter, flutter_localizations,
google_mlkit_text_recognition 0.17.1, image_picker,
path_provider, flutter_local_notifications 22.3.1, timezone, wakelock_plus,
share_plus, file_picker.

## Known Unknowns

- Voice: native köprünün API36 emülatörde init/cancel/reopen testi geçti; fiziksel cihazda gerçek transcript henüz doğrulanmadı (PB-069).
- ADR-006/PB-074: yalnız createOnDeviceSpeechRecognizer (API31+); installed languages (API33+), ağ/model indirme fallback yok. Eski paket kaldırıldı; gerçek ses tanıma fiziksel cihazda henüz doğrulanmadı.
- Reklam/Pro: publisher8 gerçek AdMob kimlikleriyle doğrulandı; aktif Play v2 ürün/fiyat SDK kanıtı PB065/083. Gerçek satın alma henüz denenmedi.
- PB089 docs kaynakla eşleşir:71 dil/native speech/isteğe bağlı metin vekili; sağlayıcı saklaması doğrulanmadı, kota sahipliği süresiz. Veri güvenliği Console taslağıdır.

## Yayın durumu (VERIFIED 2026-10-10, read-only Play tracks)

- Play Console uygulaması com.crazypenguin.nshoptor (hesap crazypenguin). Üretim: 1.0.0 (1). Dahili test: 1.2.1 (8) completed (10October SDK read-only); PB-061 store73 locales/584 PNG+73feature validated, test listesi "teste" seçili, katılım https://play.google.com/apps/internaltest/4700463295417403444.
- Yayın kökü `D:\AppPublishing\apps\nshoptor` (imza, kimlikler, 73 Play dili mağaza metni/görselleri). Metin kaynağı `tool/store/listing.py` (+ `listing_extra.json`, `listing_translate.py`); toplu görsel `tool/store/capture_all.py`; uygulama çevirisi `tool/i18n/translate.py`. 71 uygulama dili (ARB), napp_pro/napp_ads kendi metinleri tr/en (diğerlerinde İngilizce). 1.2 mağaza metinleri73 locale için doğrulandı; 584 ekran/73 tanıtım görseli doğrulandı; Play'e yüklenmedi (üretime alırken `push_metadata`).
- Ürünler: `nshoptor_pro_v2`100, `nshoptor_max_v2`300 (yeni abonelik); eski `nshoptor_pro`200 / `nshoptor_max`1000 korunur, `com.crazypenguin.nshoptor.pro_lifetime` (ömür boyu reklamsız). Ödüllü reklam birimi app-ids.env'de (ADMOB_REWARDED_ANDROID).
### Server

**Status:** VERIFIED (2026-10-09 source schema/worker; live rollout2026-10-10)

**Sources:** `server/**`, `tool/play/subscriptions.rb`, `tool/ai_economics.py`, `docs/audits/ai-economics.md`

Cloudflare Worker `nshoptor-api` (workers.dev) + D1 `nshoptor`. `POST /v1/ai`
görevleri `parse_list`, `match_receipt`, `read_label`; parse_list title/brand/category bounded metadata (PB-075); çıktı `tasks.js`'te
şemaya göre temizlenir; eksik/kesik çıktı reddedilir (bilinmeyen kimlik/birim null). Source quota atomic batch, paid verified-token lineage identity; live rollout verified PB-065 (health/parallel final-slot real D1). Kota aylık
(free10 / new Pro100 / new Max300; legacy200/1000) + günlük global tavan; Pro/Max yalnız
Play `subscriptionsv2` doğrulamasıyla (invalid credential → free; verified lineage failure → busy). Sağlayıcı OpenAI
uyumlu; şu an Qwen Token Plan `qwen3.6-flash` (kullanıcı şimdilik Qwen hesabını korudu). Sırlar: `AI_KEY`, `GOOGLE_SA_JSON` (Worker
secret; kaynak D:\AppPublishing). Testler: `cd server && npm test`. PB-086 canonical cache ownership persists across verified linkedPurchaseToken replacements and expiry; bounded lineage failures yield generic503 before quota. Server25/full369/analyze0. PB-083 verified read-only Play catalog and reproducible Decimal scenarios; PB-065 new v2 products ACTIVE, exact USD1.99/19.99 and3.99/39.99, app-wide Pro trial; legacy snapshot unchanged; audit ai-rollout-2026-10-10.md. PB-087 CLI default DeepSeek-V4.1-Flash peak/no-cache by user request; proposed-plan/free subsidy/margin/annual stress calculations and self-check verified. Current Qwen invoice/credits unknown; scenarios are not actual profit.
