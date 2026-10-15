# Current Architecture

## Runtime
- VERIFIED: Flutter 3.47.x/Dart null safety, Material 3; `lib/main.dart` -> `lib/app/`. 2026-10-15: `flutter test --no-pub` 392 geçti; görüntülü detail/form/klavye/tamamlama kontrolleri 3 viewport geçti, analyze hatasız, Android x64 debug APK derlendi ve emülatöre kuruldu (SA-005).

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

## Domains

### Navigation and list UI
Status: VERIFIED: HomeShell opens Lists with three bottom destinations (Lists/History/Settings); summary, assistant, receipt and Discover are in the list toolbar menu. ListsScreen has tappable/swipeable List/Completed/Archived tabs, collapsible search and one creation FAB. List currency/budget/note are under Details. SA-004 viewport evidence covers 412dp light, 800dp dark and 320dp RTL at 2x text.
Sources: `lib/features/home/**`, `lib/features/lists/**`, `test/features/lists/**`
- Detail shows one list title, compact product/quantity/prices, a single microphone inside the composer and completion after all rows. Completion uses existing transaction/state/result flow; completed/archived details have no mutation controls. Item swipe-delete/undo and long-press reorder remain.
- Item actual quantity/unit and custom fields are under Details; validation exposes hidden invalid fields. Existing-list quick capture omits redundant title, conversion action after candidates exist and source chip.

### Item and price data
Status: VERIFIED
Sources: `lib/data/db/**`, `lib/core/money/**`, `lib/core/quantity/**`, `lib/features/lists/**`, `lib/features/shopping_mode/**`
- Decimal estimate/actual fields, nullable unknown actual price, real quantity separation and transaction-safe repositories exist.

### History and voice
Status: VERIFIED baseline; target copy/normalization and UX gaps pending.
Sources: `lib/features/history/**`, `lib/features/voice_input/**`, `test/features/history/**`, `test/features/voice_input/**`
- Price observations and native single-session voice paths exist; new interaction and product-level normalized chart acceptance must be mapped.

## Known Unknowns
- Global Flutter build-dir=build-sa010-check conflicts with android/build.gradle.kts outputs under build; verification temporarily uses global build-dir=build. Native assets and plugin manifest need regeneration after changing it.
- Whether existing price observations already carry enough unit metadata for the requested chart needs domain inspection.
