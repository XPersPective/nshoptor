# Current Architecture

## Scope

Repository-wide current architecture (NShoptor, single Flutter app).

## Map

- `lib/main.dart` — boot: settings, Pro/Ads (napp_kit), DB, runApp
- `lib/app/` — NShoptorApp, dil/tema denetleyicileri, varsayılanlar
- `lib/core/money|quantity|calc` — decimal para, birim, plan-gerçek hesapları (double yok)
- `lib/core/l10n/` — tr/en ARB + üretilmiş AppLocalizations
- `lib/core/theme/` — M3 tema, SemanticDelta renkleri
- `lib/core/config/env_config.dart` — AppIdentity, dart-define adresleri, Pro ürün kimliği
- `lib/data/db/` — drift şeması (14 tablo) + üretilmiş kod
- `lib/features/home/` — HomeShell (5 sekme), ana sayfa kartları
- `lib/features/lists/` — listeler, liste detayı, ürün formu, hatırlatma, şablonlar
- `lib/features/shopping_mode/` — alışveriş modu, sonuç ekranı (summary/)
- `lib/features/receipts/` — cihaz içi OCR (ML Kit), fiş ayrıştırma/eşleştirme, raf etiketi
- `lib/features/voice_input/` — speech_to_text + kural tabanlı komut ayrıştırıcı
- `lib/features/history/` — geçmiş, fiyat geçmişi, içgörüler
- `lib/features/settings/` — ayarlar, yedek/CSV
- `test/`, `integration_test/` — birim/widget/e2e; `test/store_capture_test.dart` mağaza görselleri
- `fastlane/` — Play yayın lane'leri (imza/kimlik yayın kökünde: D:\AppPublishingpps
shoptor)
- `docs/store/` — gizlilik politikası, Play beyan taslakları

## Runtime

**Status:** VERIFIED

Flutter stable 3.47.x, Dart null safety, Material 3. Entry point
`lib/main.dart` → `lib/app/` (NShoptorApp + LanguageController +
AppThemeModeController + AppDefaults) + napp_kit katmanı (ADR-002):
AppIdentity/env_config (dart-define), PurchaseRepository+ProController
(`com.crazypenguin.nshoptor.pro_lifetime`), AdPolicy+UMP onayı (SDK'dan önce),
BannerAdController, napp sözlük delegesi. Boot: SettingsStore yüklenir,
dil + tema + biçim-yereli (AppFormatLocale: dil'den BAĞIMSIZ, C-001)
runApp'ten önce okunur. State: stream-based repositories +
StatefulWidget; no external state framework. Persistence: drift 2.35
over sqlite (ADR-001).

## Domains

### Core (para / birim / hesap / tema)

**Status:** VERIFIED (structure), test counts STALE (from legacy audit record)

**Sources:** `lib/core/**`, `test/core/**`

- `core/money/`: Currency, DecimalFixed (BigInt unscaled+scale), Money (minor
  units), MoneyParser (tr/en), formatMoney — no `double`.
- `core/quantity/`: UnitCode (13 units), UnitConversion, PackagingContent,
  unit_display (görünen ad l10n'dan; DB'de kanonik kod — tek kaynak).
- `core/calc/`: LineCalc, EffectSplit (price/quantity effect separation),
  ListCalc, VarianceThreshold (%10 OR 200 minor).
- `core/l10n/`: tr/en ARB + generated AppLocalizations (`l10n.yaml`).
- `core/theme/`: AppTheme (M3, seed 0xFF0B8457), premium görsel katman
  (kademeli tipografi ağırlıkları, stadium butonlar, 14r girişler, 16r
  kartlar, alt sayfa tutamacı, FadeForwards geçişler), SemanticDelta
  (WCAG AA checked).
- `core/util/`: normalizeName, combineLatest3 (no rxdart).

### Data

**Status:** VERIFIED

**Sources:** `lib/data/db/**`, `test/data/**`

drift schema v1, 14 tables (spec §8 entities: ShoppingList, PlannedItem,
PurchaseEntry, ProductMemory, ProductAlias, PriceObservation, Store, Category,
Aisle, Receipt, ReceiptCandidateLine, Attachment, Reminder, AppSettings), FK
cascade/set-null, PRAGMA foreign_keys, migration v0→v1, transaction rollback
tested. Generated `app_database.g.dart` committed to repo (ADR-001).

### Features

**Status:** VERIFIED (2026-10-03, PB-036..045 checkpoint)

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
  orphan sweep). `list_detail_screen.dart`: özet kartı ("Planlanan ₺X ·
  n ürün" + durum çipi), fiyatsız ürün satırında soluk "—", altta
  "Alışverişe başla" CTA + FAB "Ürün ekle".
- `shopping_mode/`: 5 item statuses, unplanned purchases, controlled returns,
  projection summary, wakelock; satıra dokunuş → hızlı giriş alt sayfası
  (fiyat alanı ilk + autofocus; indirim/alternatif katlanır) — C-004;
  `shopping_mode/summary/`: ResultRepository + SummaryScreen (price vs
  quantity effect rows).
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
  observations only (stats not yet shown).
  `history/insights/`: monthly/category/store breakdowns, deviations.
- `voice_input/`: SpeechService abstraction + controller; SttSpeechService
  (speech_to_text adapter); VoicePreviewSheet (editable transcript, manual
  fallback when service unavailable); `voice_input/parser/`: deterministic
  tr/en voice command parser.
- `receipts/`: OcrTextSource + MlKitTextSource (bundled Latin, no model
  download), ShelfPriceExtractor; `receipts/parser/` ReceiptParser
  (_reconstructRows: ML Kit kolon-bölünmesini görsel satırlara geri
  kurar — top ±8px gruplama; korpus market_tr_1.png CİHAZ OCR'ıyla
  uçtan uca kanıtlandı) +
  ReceiptMatcher; `receipts/review/` ReceiptReviewController (no DB write
  before approval) + ReceiptReviewScreen (accept/ignore/link/split/merge,
  total diff). Shelf label: no crop/rotate UI — ML Kit reads any
  orientation and user picks among all candidates (C-040: no crop package).
  ReceiptMatcher auto-suggestion not used by the screen (manual link only).
- `settings/`: SettingsScreen + SettingsRepository (spec §6.15,
  delete-all double confirm; tema + formatLocale anahtarları repo'da);
  Pro satırı (PaywallPage) + yedek dışa/içe PRO-GATE (standart §3.8:
  kilit + paywall; Pro değişince kilit anında kalkar); Hakkında
  (AboutPage: açık kaynak/GPL-3.0), Lisanslar, Paylaş, Puan ver
  (napp_core); `settings/backup/` BackupRepository (13-table
  export/import, CSV export — CSV serbest).

### Platform shells & CI

**Status:** VERIFIED

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
speech_to_text 7.5.0, google_mlkit_text_recognition 0.17.1, image_picker,
path_provider, flutter_local_notifications 22.3.1, timezone, wakelock_plus,
share_plus, file_picker.

Test totals: 259 unit/widget green + 3 integration (device_audit 2/2,
receipt_flow 1/1) + analyze 0. Release APK (fat, 97,8 MB) emülatörde
uçtan uca (2026-10-03/04): 5 sekme, Pro kilidi/paywall, Keşfet,
biçim-yereli, "Sürüm 1.0.0", koyu tema canlı, ikon launcher'da,
BANNER bottom bar altında test-ad ile canlı (UMP gdprApplies:0),
bildirim reboot sonrası panelde görüntülendi. Fiş korpusu:
market_tr_1.txt ile parser/matcher; "domates kg"→"domates" yüksek
güven.

## Known Unknowns

- Voice: gerçek tanıma cihazda denenmedi (emülatörde platform tanıyıcı
  yok → manuel fallback kanıtlı); cihazda tek kontrol önerilir.
- Reklam/Pro: test kimlikleriyle tam akış canlı; gerçek AdMob kimliği
  ve paywall fiyatı Crazy Penguin'de; apps.json besleme repo adresi
  bilinmiyor (docs/store/apps-json-entry.md).


## Yayın durumu (VERIFIED 2026-10-06)

- Play Console uygulaması com.crazypenguin.nshoptor (hesap crazypenguin). İç test + üretim sürümü 1.0.0 (1) yüklü; 12 değişiklik incelemeye gönderildi (ön kontroller sürüyor).
- Yayın kökü D:\AppPublishingpps
shoptor (imza, kimlikler, mağaza metni/görselleri); kaynak projede fastlane/ lane'leri; test/store_capture_test.dart ekran görüntülerini üretir.
- Pro ürünü com.crazypenguin.nshoptor.pro_lifetime Play'de etkin. Ödüllü reklam birimi yok → hediye akışı kapalı.
