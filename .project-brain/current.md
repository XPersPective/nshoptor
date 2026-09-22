# Current Architecture

## Scope

Repository-wide current architecture (NShoptor, single Flutter app).

## Runtime

**Status:** VERIFIED

Flutter stable 3.47.x, Dart null safety, Material 3. Entry point `lib/main.dart`
→ `lib/app/` (NShoptorApp + LanguageController). State: stream-based
repositories + StatefulWidget; no external state framework. Persistence: drift
2.35 over sqlite (ADR-001).

## Domains

### Core (para / birim / hesap / tema)

**Status:** VERIFIED (structure), test counts STALE (from legacy audit record)

**Sources:** `lib/core/**`, `test/core/**`

- `core/money/`: Currency, DecimalFixed (BigInt unscaled+scale), Money (minor
  units), MoneyParser (tr/en), formatMoney — no `double`.
- `core/quantity/`: UnitCode (13 units), UnitConversion, PackagingContent.
- `core/calc/`: LineCalc, EffectSplit (price/quantity effect separation),
  ListCalc, VarianceThreshold (%10 OR 200 minor).
- `core/l10n/`: tr/en ARB + generated AppLocalizations (`l10n.yaml`).
- `core/theme/`: AppTheme (M3, seed 0xFF0B8457), SemanticDelta (WCAG AA checked).
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

**Status:** VERIFIED (structure at committed HEAD); features/settings is
mid-flight — uncommitted WIP owned by PB-030, currently does not compile.

**Sources:** `lib/features/**`, `test/features/**`, `integration_test/**`

- `lists/`: ListStatus machine, ListRepository (undo snapshot), ListsScreen,
  ItemFormSheet; `lists/suggestions/` (ProductMemory, paste_parser),
  `lists/taxonomy/` (store/category/aisle CRUD + 4 sort modes),
  `lists/templates/` (plan from previous actuals), `lists/reminders/`
  (ReminderScheduler abstraction; OS adapter not yet implemented — see PB-032
  device list), `lists/attachments/` (file storage + orphan sweep).
- `shopping_mode/`: 5 item statuses, unplanned purchases, controlled returns,
  projection summary, wakelock; `shopping_mode/summary/`: ResultRepository +
  SummaryScreen (price vs quantity effect rows).
- `home/`: HomeShell (4 tabs), HomeScreen (monthly totals per currency — T33
  fix).
- `history/price_history/`: min/median/max, trend, cheapest store.
  `history/insights/`: monthly/category/store breakdowns, deviations.
- `voice_input/`: SpeechService abstraction + controller;
  `voice_input/parser/`: deterministic tr/en voice command parser. No mic
  button wired to UI yet (PB-033).
- `receipts/`: OcrTextSource + MlKitTextSource (bundled Latin, no model
  download), ShelfPriceExtractor; `receipts/parser/` ReceiptParser +
  ReceiptMatcher; `receipts/review/` ReceiptReviewController (no DB write
  before approval). Review/shelf-label UI screens not wired (PB-033).
- `settings/`: `settings/backup/` BackupRepository (13-table export/import,
  separate mode renumbers FK chain, CSV export) done; settings screen +
  repository are uncommitted WIP → PB-030.

### Platform shells & CI

**Status:** VERIFIED

Android: cleartext off, backup/data-extraction rules, R8 minify+shrink release,
key.properties signature placeholders. iOS: display name NShoptor. CI
(`.github/workflows/ci.yml`): analyze+test, gitleaks, release APK build.

## External Dependencies

per `pubspec.yaml` (HEAD): drift 2.35, drift_flutter, flutter_localizations,
speech_to_text 7.5.0, google_mlkit_text_recognition 0.17.1, image_picker,
path_provider, flutter_local_notifications 22.3.1, timezone, wakelock_plus.
Uncommitted WIP additionally adds share_plus + file_picker (PB-030).

Test totals: 234 unit/widget tests recorded green at legacy T28 close
(2026-09-22); T29 added `integration_test/perf_test.dart` (emulator: 200
lists + 5000 rows fluid). Settings suite (16 tests, uncommitted) passes now;
full-suite re-run not performed this session.

## Known Unknowns

- Whether WIP settings repository API (SettingsRepository taking
  SettingsStoreOps) matches the planned final wiring — main.dart/app.dart
  currently reference names that do not exist (see PB-030 resume notes).
- Remaining spec §6.15 rows implemented vs pending in WIP settings screen
  (assess at PB-030 resume).
