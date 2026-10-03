# Current Architecture

## Scope

Repository-wide current architecture (NShoptor, single Flutter app).

## Runtime

**Status:** VERIFIED

Flutter stable 3.47.x, Dart null safety, Material 3. Entry point
`lib/main.dart` → `lib/app/` (NShoptorApp + LanguageController +
AppThemeModeController + AppDefaults) + napp_kit katmanı (ADR-002):
AppIdentity/env_config (dart-define), PurchaseRepository+ProController
(`nshoptor_pro_lifetime`), AdPolicy+UMP onayı (SDK'dan önce),
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
  download), ShelfPriceExtractor; `receipts/parser/` ReceiptParser +
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

Test totals: 259/259 green + analyze 0 (PB-036..045). Release APK
(fat, 97,8 MB) emülatörde uçtan uca doğrulandı (2026-10-03): 5 sekme,
Pro kilidi/paywall (dürüst: gerçek faydalar + restore, sahte fiyat yok),
Keşfet çevrimdışı boş-durumu, biçim-yereli satırı, "Sürüm 1.0.0"
(jargonsuz), koyu tema canlı geçiş, ikon launcher'da. Fiş korpusu:
market_tr_1.txt ile parser/matcher; "domates kg"→"domates" yüksek
güven.

## Known Unknowns

- Voice / camera flows: platform tanıyıcı/OCR emülatörde sınırlı
  (speech emülatörde genelde yok → manuel fallback kanıtlı); gerçek
  cihaz kontrolü kullanıcı deneyimine kalmıştır.
- Reminders: reboot sonrası alarm kaydı dumpsys'ta korundu; ancak
  emülatörün saat sıçraması nedeniyle reboot'tan SONRA tetiklenme anı
  gözlemlenemedi (kayıt + BOOT_COMPLETED alıcısı mevcut; cihazda
  doğrulanması önerilir).
- Reklam banner'ı: test kimliğiyle SDK hazır; gerçek AdMob kimliği ve
  paywall fiyatı Crazy Penguin'de; apps.json besleme repo adresi
  bilinmiyor (docs/store/apps-json-entry.md).
