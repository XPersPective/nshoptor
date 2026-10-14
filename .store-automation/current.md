# Current Architecture

## Runtime
- VERIFIED: Flutter 3.47.x/Dart null safety, Material 3; `lib/main.dart` -> `lib/app/`; `flutter test` 383 geçti (2026-10-15 takeover check).

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
Status: VERIFIED: `ListsScreen` now uses horizontal `PageView`; detail cards no longer show status chip or finish button. Item-level reorder and HomeShell consolidation remain pending.
Sources: `lib/features/home/**`, `lib/features/lists/**`, `test/features/lists/**`
- Existing HomeShell still has the legacy multi-tab shell; `ListsScreen` is the first migrated three-page flow.

### Item and price data
Status: VERIFIED
Sources: `lib/data/db/**`, `lib/core/money/**`, `lib/core/quantity/**`, `lib/features/lists/**`, `lib/features/shopping_mode/**`
- Decimal estimate/actual fields, nullable unknown actual price, real quantity separation and transaction-safe repositories exist.

### History and voice
Status: VERIFIED baseline; target copy/normalization and UX gaps pending.
Sources: `lib/features/history/**`, `lib/features/voice_input/**`, `test/features/history/**`, `test/features/voice_input/**`
- Price observations and native single-session voice paths exist; new interaction and product-level normalized chart acceptance must be mapped.

## Known Unknowns
- Exact HomeShell consolidation and item-level reorder/undo implementation still need a targeted source read.
- Whether existing price observations already carry enough unit metadata for the requested chart needs domain inspection.
