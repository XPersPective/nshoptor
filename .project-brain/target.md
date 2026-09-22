# Target Architecture

## Objective

NShoptor: Crazy Penguin's multilingual (tr/en), offline-first, accountless
shopping planning and budget comparison app. User plans items with quantity +
estimated price before shopping; records real quantity/price in store
(manually; optional voice, shelf-label and receipt OCR — always behind an
editable confirmation screen); after shopping sees the estimate-vs-actual
difference split into price / quantity / unplanned-item effects; past price
observations feed later plans.

Binding full specification: `docs/spec/master-prompt-tr.md` (cite by section).

**Goal status:** CONFIRMED (v1).

## Target State

### Structure

Feature-first Flutter app per spec §11: `lib/core/{money,quantity,calc,l10n,
theme,util}` domain logic (widget-independent, fully tested), `lib/data/db`
drift schema, `lib/features/**` per spec areas (lists, shopping_mode+summary,
home, history/{price_history,insights}, voice_input, receipts, settings with
backup/reminders/attachments under lists or settings per feature), platform
shells android+ios hardened (no cleartext, backup rules, R8, key.properties).

### Data model

spec §8 entities; canonical values stored as codes, display names from l10n;
photos as files in app-private dir, DB holds paths only.

### Input helpers

speech_to_text (platform service, no model download), google_mlkit_text_recognition
(bundled Latin), deterministic local voice command parser, receipt parser with
confidence levels — all behind confirmation screens.

### Other

Local notifications (reminders); backup: versioned JSON export/import + CSV
result export; semantic accessibility; performance targets per spec §13.

## Explicit Non-Goals

spec §16 full list: mandatory accounts, cloud sync, shared lists, web,
scraping, live FX rates, cloud LLM OCR, recipes/pantry, route optimization,
location reminders, loyalty/coupons, watch, home-screen widget, commercial
catalog API, ads/subscription — plus production signing identity (Crazy
Penguin provides it later).

## Open Target Decisions

None.

## Success Conditions

AC1–AC11 (spec §14), verbatim:

- AC1 `flutter analyze` 0 issues; `flutter test` fully green
- AC2 ≥2 accountless lists; decimal quantity + estimated price; planned total in locale-aware currency format
- AC3 real price/quantity entry instantly updates projection; unplanned and not-bought items handled with correct semantics (not-bought ≠ 0 TL)
- AC4 completion screen shows price effect and quantity effect as separate rows
- AC5 tr/en works across all main flows; slogan follows selected language
- AC6 voice entry works via platform speech service; manual fallback on failure; no model download asked from user
- AC7 receipt OCR reads text in airplane mode after first install; OCR output never becomes purchase without user approval
- AC8 data persists across restarts; backup export/import works without data loss
- AC9 dark theme, large text, basic screen-reader accessibility
- AC10 no dead/button-less critical flows; Android debug/release + iOS build checks documented
- AC11 no `double` in monetary/decimal calculations; central money/value layer proven by tests
