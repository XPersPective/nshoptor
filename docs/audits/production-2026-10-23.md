# Production audit — 2026-10-23

Scope: [all fifty requirements](../spec/production-master-prompt-tr.md). This is an in-progress audit and takeover record, not a production approval. Current working files are authoritative; rerun checks after further edits.

## Initial state and reproducible defects

- Initial source tree was clean except pre-existing pubspec version +14→+15; unrelated --help/ and build-sa* outputs are preserved.
- Baseline `flutter test --reporter compact`: 432 passed,2 opt-in UI tests skipped; `.takeover-2026-10-23.log`. Server baseline25 passed.
- Four core defects were reproduced by failing regressions before fixes: Turkish title normalization, price-free tick, both-empty focus, price clearing retaining a purchase.
- Voice audit found a60s Android deadline/no continuation, silent ambiguous-total assumptions, wrong market/home price destination and ignored currency. Subsequent focused voice tests51 passed and server28 passed.
- Receipt audit found substring `kart` treating KARTON SÜT as payment/total, payment/change confusion, dropped explicit units and silent foreign-currency relabeling. Changes are in progress and require fresh combined verification.
- Settings placed AI/helper switches under the deletion heading; replayable help was absent. Help/guide changes and71-locale generation passed39 focused tests.

## Verified local slices so far

| Area | Observation | Limits |
|---|---|---|
| Lists/prices |123 lists/shopping tests; final21 regression/render journeys;24 PNGs in artifacts/qa/PB-120 | Source is evolving; full final regression still needed |
| Voice/server |51 voice tests and28 server tests | Physical microphone, installed models and iOS bridge not verified |
| Settings/help |39 focused tests;71 ARBs aligned; TR/EN/AR320dp2x light/dark layout tests | Rare-language linguistic review and native accessibility remain open |
| Reminders |13 focused tests after iOS permission/initialization and repository failure/concurrency fixes | Expiry, compensation and tap-navigation followups need final checks; actual iPhone delivery unverified |
| History/report |35 tests after Today tab and day/week PDF snapshot work | Followups for stale currency/date, unknown spending and DST are being incorporated |
| Website |141 static checks; delegated Chrome desktop/mobile390×844 and price demo interaction | No live Pages deployment readback yet; screenshot files were not retained |

Passing slices are not added together as a final-suite total. Do not treat old generated log files as current evidence.

## Requirement traceability

| Requirements | Task / current checkpoint |
|---|---|
| R01–R05 | PB-120/PB-114; core fixes and rendered regression matrix implemented; independent acceptance open |
| R06–R13 | PB-122; Android segments, price ambiguity, market destination, currency and local fast path implemented; native acceptance open |
| R14–R18 | PB-121/PB-126; receipt/label defects being fixed; real-image/OCR corpus and end-to-end import still open |
| R19–R24 | PB-130/PB-110/PB-118; neutral help grouping and replayable seven-section guide implemented; full language/visual/accessibility audit open |
| R25–R29 | PB-115/PB-117/PB-124; Today and generic period PDF added; unknown amounts/currency/DST review followups in progress; real save/share/import acceptance open |
| R30–R34 | PB-127; local reminder platform fixes implemented; tap-routing, failure recovery, offline/remote service evidence open |
| R35–R39 | PB-105/PB-107/PB-108/PB-123; severe iOS billing/share gaps identified; Discover platform wrapper and native review policy wiring in progress; live stores/ads unverified |
| R40–R42 | PB-128/PB-129; TR/EN website implemented; comparison below; deployment and broader ASO review open |
| R43–R45 | PB-129; existing external Play materials/AABs found; no video found in inspected assets/stores; new captures/video and actual store readback open |
| R46–R50 | PB-125; partial rendered journeys and durable planning present; global checks, real native scenarios, independent approval and publication remain open |

## Platform and service findings

- iOS has no custom speech or print bridge. Subscription code and server validation are Google Play-specific; no functional StoreKit ownership/offer path was found. App Store product ID is absent. These are concrete release blockers, not completed iOS features.
- iOS AdMob application setup and platform-specific ad-unit gates need correction and actual-device validation. Existing ad policy tests do not prove live ads or consent behavior.
- Catalogue data comes from remote apps.json with24h cache. It does not crawl Play/App Store. The former kit UI displayed entries lacking a current-platform link; an app-owned filter is being checked.
- Current AI configuration uses Qwen token-plan endpoint. Workers/D1 configuration alone proves neither the account's billing plan nor a free AI provider. Do not run paid provider experiments or silently switch plans.
- Native review availability/actual submitted ratings cannot be inferred from opening a page. Use native review API with persistent conservative limits; never offer a benefit for a positive review.
- The pre-existing `nshoptor_test` AVD is invalid/missing its config and fails with ARM/QEMU error. Existing Chatimus_QA2 x86_64 API36 AVD boots; no user AVD or global Flutter settings were modified.

## Free service sources checked

- [GitHub Pages](https://docs.github.com/en/pages/getting-started-with-github-pages/what-is-github-pages): free public repositories support static hosting. This repository is public; Pages API initially404.
- [Cloudflare D1 pricing](https://developers.cloudflare.com/d1/platform/pricing/): Free includes5m rows read/day,100k rows written/day and5GB total. Daily-limit exhaustion rejects queries; it does not establish unlimited capacity. [Workers limits](https://developers.cloudflare.com/workers/platform/limits/) lists100k requests/day and10ms CPU on Free. Confirm actual account plan/usage before promising a zero bill.
- [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging): remote messaging is available; list-time reminders already use on-device scheduling and require no messaging server. No Firebase project, paid function or new charge was introduced.
- [Apple review guidelines](https://developer.apple.com/app-store/review/guidelines/) require honest functionality, compliant purchases/privacy and the provided review API. [Google Data safety](https://support.google.com/googleplay/android-developer/answer/10787469) includes third-party SDK practices; source drafts are not proof of submitted console declarations.

## Competitor comparison and product decisions

These are primary product-page observations, not claims of a complete market survey or verified side-by-side device testing.

| Product/source | Publicly documented strengths | Implication for this app |
|---|---|---|
| [Bring](https://www.getbring.com/en/features) | Real-time household lists, store-order sorting, offers/loyalty cards and recipes | Clear shared-list/household gap; keep current account-free/offline scope explicit. Do not add offer clutter to the primary shopping flow. |
| [AnyList](https://www.anylist.com/features) | Shared lists, favourites/categories, widgets, recipes and meal planning; advanced features in paid tier | Templates/history should be easy to reuse. A home-screen quick-add widget is a future convenience candidate after correctness/platform parity. |
| [Listonic](https://listonic.com/features) | Offline editing with sync, shared lists, prices and AI planning | AI by itself is not sufficient differentiation. Prioritize reliable planned-versus-market money, explicit price meaning, receipts and readable reports. |

Immediate additions implemented/prioritized are truthful purchase status, ambiguity confirmation, replayable help, period reports, safe notifications and platform-aware links. Cloud accounts/sync, recipe discovery, loyalty cards and widgets remain product candidates outside the accepted no-cloud-rewrite baseline; they must not delay reliable core functionality or be advertised as present.

## Verified checkpoint — 2026-10-23 continuation

- Fresh full Flutter run: **492 passed, 2 opt-in store/render tests skipped**, exit0 (`.final-suite-2026-10-23.log`). The first run found `KDV(%1)` becoming a product after prefix hardening. Header punctuation was corrected; all53 receipt tests and the subsequent full run passed. FISTIK/VATAN/KARTON products remain intact.
- Fresh whole-project analyzer: **No issues found**, exit0 (`.final-analyze-2026-10-23.log`). Server suite now **29 passed**, exit0, including model price evidence that quotes130 but invents260 and Turkish1.260,50 normalization.
- Reminder notification payloads/cold launch/live duplicate taps/stale IDs are exercised. The test's Drift-close hang was fixed with close→pump→await. Distinct reminder taps while another reminder route is open are still suppressed; choose an explicit switching policy before claiming exhaustive navigation coverage.
- Discover's320dp/2x Android/iOS tests now pass in the full suite. Its initial failures came from a Latin1 test-response fixture containing Turkishı, not from a production platform-filter defect. Real catalogue freshness and live store availability are separate checks.
- Settings sharing now passes a nonempty iPad popover origin, uses the live website when no iOS listing exists, catches plugin/launcher failures and prevents concurrent actions. Missing iOS App Store identity hides the unusable rating action. A successful explicit rating-page request suppresses future automatic reminders; it never claims a review was submitted. Both platform regression tests pass.
- Today screenshot rerender:6tests passed with actual fonts/AppTheme. Independent worker inspected `artifacts/qa/PB-115/320_today.png` and `412_today.png`; unknown/free/partial totals remain distinct. Root inspected PB-120 light412dp and RTL320dp/2x price/check screenshots. Native accessibility and the entire theme/locale matrix remain open.
- Website published at **https://xperspective.github.io/nshoptor/**; English at `/en/`. Commit`3c9fc21`; GitHub Actions run`39929927342` completed/success. Root HTTP readback:200 for both pages and matching TR/EN titles. Pages uses the workflow build type. These facts do not mean the mobile update is published.
- Official Play API readback succeeded using the existing crazypenguin service-account reference. Production:version1 completed and version14/1.2.7 draft. Internal:version15/1.2.7 completed. Four subscription products(`nshoptor_pro`, `nshoptor_max`, and `_v2` variants) each have ACTIVE monthly/yearly base plans.73 store listing locales are present. Temporary readback edit was deleted without commit; no release/catalogue/price mutation occurred. The reusable command is `ruby tool/store/read_play.rb <credential-file> com.crazypenguin.nshoptor`; it never prints credentials.
- Version15 is already occupied remotely: a new upload must use a greater code. The source's user-facing `appVersion` was also found stale at1.2.1 versus pubspec1.2.7+15; correct both together when preparing the new release, and verify the built artifact.
- Android debug build and explicit TR store-capture verification are still running at this checkpoint; no APK/install/video/release result is claimed. The prior owned emulator is no longer listed by adb. Preserve the existing AVD; restart only for the native verification after build.
- Workers deployment readback succeeded. Last observed remote version is`e427d4bc-9c8c-4ce7-b806-d5be5f3c0242`(2026-10-10). No new server deployment or paid model request has occurred. Preserve remote variable overrides when deploying corrected server code.
- Project Brain validation:25open tasks,2ADRs,0fail/0warn. Existing PB-130 machine evidence is stale and has not been repurposed; all acceptance boxes remain honest. No provider/pool approval gate was bypassed.

## Handoff / next actions

1. All worker edits have been read back. Core/history/reminder worker released its files and Flutter test slot; voice/site workers reached account limits. Read their actual diffs and this checkpoint, rather than replaying jobs.
2. Serialize Flutter tests on Windows: concurrent runners lock build/native_assets/windows/sqlite3.dll. Never delete another runner's DLL or alter global build-dir.
3. Run focused receipt/discover/engagement/history/notification checks, then one fresh full Flutter/server/analyze pass and Android build. Fix failures before any application release.
4. Persist actual screenshots/reports and update task Resume/Notes. Existing Pool PB-130 evidence predates native source changes and is stale; do not tick acceptance from it.
5. Independently validate website and publish its scoped source/workflow; record deployment ID/status/URL. Verify actual Play tracks/products/metadata using authorized release tools without printing credentials. Do not claim internal rollout or a prepared workflow as public release.
6. iOS compilation, native bridges, StoreKit, App Store ID/account and actual-device evidence remain required for iOS publication. Keep explicit blockers and next steps for the next AI.
