# Current Architecture

## Runtime
- OBSERVED (historical baseline): Flutter 3.47.x/Dart null safety, Material 3; `lib/main.dart` -> `lib/app/`. 2026-10-15: `flutter test --no-pub` 392 geçti; görüntülü detail/form/klavye/tamamlama kontrolleri 3 viewport geçti, analyze hatasız, Android x64 debug APK derlendi ve emülatöre kuruldu (SA-005).

## Map
- `lib/main.dart` — uygulama boot, DB ve root wiring
- `lib/app/` — NShoptorApp, dil/tema/default controller'ları
- `lib/features/home/` — HomeShell ve ana sayfa sekme/kartları
- `lib/features/lists/` — listeler, `ListDetailScreen`, `ItemFormSheet`, repository ve gestures
- `lib/features/shopping_mode/` — mevcut alışveriş modu ve sonuç karşılaştırması
- `lib/features/history/` — arşiv, fiyat geçmişi, analizler
- `lib/features/voice_input/` — Android native ses adapter'ı ve ayrıştırıcı
- `lib/core/money|quantity|calc/` — fixed-point para, miktar ve plan/gerçek hesapları
- `lib/data/db/` — Drift şema/migration/üretilmiş DB
- `lib/core/l10n/` — ARB ve üretilmiş 71 dil
- `test/features/lists/` — liste/form/controller/widget kanıtları
- `test/features/history/` — fiyat geçmişi ve analiz kanıtları
- `test/features/voice_input/` — ses yaşam döngüsü ve miktar parser testleri
- `lib/features/ads/` — geçiş reklamı ve ödüllü hediye politikası (`ad_gate.dart`)
- `lib/features/subscription/` — abonelik servisi, paywall, lifetime adapter
- `lib/features/settings/` — ayarlar ekranı, plan rozeti ve Pro bölümü
- `test/features/ads/`, `test/features/subscription/`, `test/features/settings/` — bu alanların kanıtları

## Domains

### Navigation and list UI
Status: STALE: HomeShell opens Lists with three bottom destinations (Lists/History/Settings); summary, assistant, receipt and Discover are in the list toolbar menu. ListsScreen has tappable/swipeable List/Completed/Archived tabs, collapsible search and one creation FAB. List currency/budget/note are under Details. SA-004 viewport evidence covers 412dp light, 800dp dark and 320dp RTL at 2x text.
Sources: `lib/features/home/**`, `lib/features/lists/**`, `test/features/lists/**`
- Detail shows one list title, compact product/quantity/prices, a single microphone inside the composer and completion after all rows. Completion uses existing transaction/state/result flow; completed/archived details have no mutation controls. Item swipe-delete/undo and long-press reorder remain.
- Item actual quantity/unit and custom fields are under Details; validation exposes hidden invalid fields. Existing-list quick capture omits redundant title, conversion action after candidates exist and source chip.
- Android API36 final APK interaction: create default-title list -> type Milk -> approve one candidate (no title/source/second convert control) -> finish warning -> Result -> back -> Completed contains the list. Historical native screenshots are retained in the adoption archive; no current screenshot evidence is claimed.

### Item and price data
Status: STALE
Sources: `lib/data/db/**`, `lib/core/money/**`, `lib/core/quantity/**`, `lib/features/lists/**`, `lib/features/shopping_mode/**`
- Decimal estimate/actual fields, nullable unknown actual price, real quantity separation and transaction-safe repositories exist.

### Ads, subscription and settings
Status: STALE (SA-011, SA-012; code and tests exist, store-side setup not verified here).
Sources: `lib/features/ads/**`, `lib/features/subscription/**`, `lib/features/settings/**`, `test/features/ads/**`, `test/features/subscription/**`, `test/features/settings/**`
- Ad gate: geçiş reklamı alışveriş sonunda, günlük ödüllü hediye; release derlemesinde test reklam kimliği reddedilir (`fastlane/Fastfile`).
- Subscription: plan rozeti 7 gün deneme durumu; lifetime adapter; Play'de ürün (`IAP_PRO_LIFETIME`) kurulumu mağaza tarafında ayrıca doğrulanmalı.

### History and voice
Status: STALE baseline; normalized chart and single-mic acceptance pending (SA-016, SA-017).
Sources: `lib/features/history/**`, `lib/features/voice_input/**`, `test/features/history/**`, `test/features/voice_input/**`
- Price observations and native single-session voice paths exist; new interaction and product-level normalized chart acceptance must be mapped.

## Known Unknowns
- Flutter global build-dir is currently `build`; verification commands should use the repository default and must not depend on the preserved `build-sa*` folders.
- Whether existing price observations already carry enough unit metadata for the requested chart needs domain inspection.

## Takeover 2026-10-18
- VERIFIED: `flutter test --reporter compact`: 428 passed, 2 skipped. Log `.takeover-tests.log` (ignored).
- Historical architecture claims above require targeted readback before acceptance. User asks for 71-language production readiness, receipt import, reopening, stable branding and simpler reports.
- Existing unknown changes: release readback additions in former SA-021; untracked `--help/` and `build-sa*/` directories. Preserve them.
- Map addition: `lib/features/receipts/` — receipt intake, parser and review.
- No application source was changed during plan adoption; independent SA-037 review is still pending as PB-119.
