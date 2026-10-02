# Current Architecture

## Scope

Repository-wide current architecture (NShoptor, single Flutter app).

## Runtime

**Status:** VERIFIED

Flutter stable 3.47.x, Dart null safety, Material 3. Entry point `lib/main.dart`
→ `lib/app/` (NShoptorApp + LanguageController + AppThemeModeController +
AppDefaults). Boot: SettingsStore yüklenir, dil + tema tercihleri runApp'ten
önce okunur (ilk kare belirleyici; yerel çözümleme fallback'i tr). State:
stream-based repositories + StatefulWidget; no external state framework.
Persistence: drift 2.35 over sqlite (ADR-001).

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

**Status:** VERIFIED (2026-10-02, PB-035 checkpoint)

**Sources:** `lib/features/**`, `test/features/**`, `integration_test/**`

- `lists/`: ListStatus machine, ListRepository (undo snapshot), ListsScreen,
  ItemFormSheet (varsayılan birim AppDefaults'tan); `lists/suggestions/`
  (ProductMemory, paste_parser), `lists/taxonomy/` (store/category/aisle CRUD
  + 4 sort modes), `lists/templates/` (plan from previous actuals; Home
  completed-list tile "plan from this" marks template + opens new plan; Home
  Templates card), `lists/reminders/` (ReminderScheduler abstraction +
  LocalNotificationsScheduler: flutter_local_notifications üretim adaptörü —
  izin yalnız hatırlatma kurulurken istenir, tam alarm izni yoksa inexact
  fallback; cihaz doğrulaması PB-034'te bekliyor), `lists/attachments/`
  (file storage + orphan sweep).
- `shopping_mode/`: 5 item statuses, unplanned purchases, controlled returns,
  projection summary, wakelock; `shopping_mode/summary/`: ResultRepository +
  SummaryScreen (price vs quantity effect rows).
- `lists/list_detail_screen.dart`: hub for input helpers — item form gets
  voice (VoicePreviewSheet) + shelf-label (price_candidate_sheet) callbacks;
  AppBar receipt scan → ReceiptParser → ReceiptReviewScreen; item tap →
  PriceHistoryScreen (productId, else ProductMemory by normalizedName).
  SpeechService / OcrTextSource / image picker injectable for tests.
- `home/`: HomeShell (4 tabs), HomeScreen (monthly totals per currency — T33
  fix); premium boş-durum kartı (ikon dairesi + CTA).
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
- `settings/`: SettingsScreen + SettingsRepository (spec §6.15, delete-all
  double confirm; tema tercihi AppThemeModeController ile canlı uygulanır,
  anahtar sabitleri repo'da); `settings/backup/` BackupRepository (13-table
  export/import, CSV export).

### Platform shells & CI

**Status:** VERIFIED

Android: RECORD_AUDIO + RecognitionService query; hatırlatmalar için
POST_NOTIFICATIONS + SCHEDULE_EXACT_ALARM + RECEIVE_BOOT_COMPLETED ve
flutter_local_notifications alıcıları (bildirim izni yalnız hatırlatma
kurulurken istenir). iOS: camera/photo/mic/speech usage strings. Android:
cleartext off, backup/data-extraction rules, R8 minify+shrink release (ML Kit
non-Latin dontwarn), release signing from key.properties if present, else
debug key; AdMob placeholder removed; fat APK tüm ABI'ler (x86_64 kısıtı
emülatörde UnsatisfiedLinkError — bkz. docs/release-checklist.md). iOS:
display name NShoptor. CI (`.github/workflows/ci.yml`): analyze+test,
gitleaks, release APK build.

## External Dependencies

per `pubspec.yaml` (HEAD): drift 2.35, drift_flutter, flutter_localizations,
speech_to_text 7.5.0, google_mlkit_text_recognition 0.17.1, image_picker,
path_provider, flutter_local_notifications 22.3.1, timezone, wakelock_plus,
share_plus, file_picker.

Test totals: 234 unit/widget tests recorded green at legacy T28 close
(2026-09-22); T29 added `integration_test/perf_test.dart` (emulator: 200
lists + 5000 rows fluid). Full suite 247/247 green + analyze 0 at PB-033.
PB-035: 254/254 green + analyze 0; `integration_test/device_audit_test.dart`
(cihaz: premium ana ekranlar + canlı tema + hatırlatma akışı) eklendi;
release APK (fat, 92,5 MB) emülatörde görsel olarak doğrulandı.

## Known Unknowns

- Voice / camera flows verified only with fakes in widget tests; real
  device behaviour pending (PB-034, BLOCKED).
- Reminders: OS bildiriminin cihazda zamanında gelmesi ve exact/inexact
  davranışı yalnız kod + widget testi düzeyinde doğrulandı; gerçek cihaz
  doğrulaması PB-034'te bekliyor.
