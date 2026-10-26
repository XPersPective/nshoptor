# Current Architecture

## Runtime
- CURRENT CHECKPOINT 2026-10-26: app first, website last. Branch `codex/app-takeover-20261026`; draft PR https://github.com/XPersPective/nshoptor/pull/1. Source checkpoints 9d508be and 2942ffa are WIP, not release acceptance. Invoice follow-up: seven focused and 149 receipt tests PASS; independent static re-review PASS after signed-quantity/product-code fix. Renderer QA: six opt-in scenarios PASS, narrow/wide/light/dark/Arabic 2x captures in artifacts/qa/2026-10-26. iOS Xcode 26.3 unsigned release compile PASS in run 40279549409; native OCR test still running at this entry. Android release CI still running. PB-159 addresses actual StoreKit purchase/restore and Apple verification; local implementation in progress, no Apple deployment. Play production unchanged. Entries below are chronological history, including superseded temporary-emulator decisions; only the shared Medium_Phone_API_36.0 is now permitted.
- 2026-10-26 TAKEOVER: Store Automation kullanılmaz; geliştirmePB/yayınReleaseHarbor. Kullanıcı "Site işi en son" dedi; önce Android+iOS ve gerçek fiş/fatura doğruluğu. Güncel796FlutterPASS/2skip,analyzetemiz,server51PASS; bu sonuçlar yeniPB-158faturasütunudüzeltmesindenöncedir. PB-157saatdüzeltmesi33test+bağımsızkaynakincelemesiPASS. Trialbackendmigration/deployment/ikiidempotentQAaccess200geriokundu,eskiusage/globalcountersdeğişmedi,YZçağrısıyok. Playinternal18completed/production1completed+14draft; yeni mobil yayın yok. iOSAppleAPIUnauthorized veStoreKiteksik; nativecihazkanıtlarıaçık. Tamdurum: references/takeover-2026-10-26.md.
- LATEST user priority: stop coupling emulator startup to builds. All own Gradle/profile build trees stopped. Shared5554 was independently started21:39 and runs dev.cepavlusu.cep_avlusu; left untouched. Existing task-owned C: AOSP AVD nshoptor_temp_aosp_api36 now runs5556,720×1600/2cores/noGooglePlay. Requested1024MB was automatically raised to2048MB by emulator36.1.9. Home screenshot aosp-light-home.png inspected; Settings opened5043ms and Home returned. Initial launcher18:52:08 focus-window ANR was recorded, so this establishes running/interactive emulator, not general stability. No profile main APK has passed/installed; C: build was stopped at user priority. Source checkpoint ba23873 retained all implementation; canonical sources remain D:.
- LATEST stability correction: shared-emulator cold boot reproduced18:17:57 focus-event ANR during initial debug launch, despite clean process exit-info. Warm return340ms and next process launch5822ms recovered; therefore native stability remains OPEN. Main startup now defers optional billing/consent/ads until first frame, skips ad SDK for ad-free use, removes automatic full-screen ads and forced1.6s splash. Profile APK is being built; latest startup source is not installed/verified yet. Reports domain105PASS, new preview/export-state tests pending; see PB-147/PB-156.
- 2026-10-25 ACTIVE, NOT COMPLETE: N001–N074 and N075/PB-156 retained; 51 tasks remain open. Full Flutter715PASS/2 opt-in skips (.resume-full-2026-10-25-recheck.log) before the integrity followup; then142 focused receipt/schema/awake tests PASS, analyzer clean (.resume-integrity-analyze2.log). Shelf followup33PASS; final full737PASS/2 opt-in skips (.resume-full-integrity-shelf.log), analyzer clean (.resume-shelf-analyze.log). Server44PASS. The realistic-fixture on-device ML Kit integration test passed once, and bounded shared-emulator gallery approval/duplicate evidence is saved; this is not general stability or task acceptance. Details: references/native-receipt-2026-10-25.md.
- Schema4: durable receipt evidence, ordered overlap/discount/prepend and app-owned media, strict approval transaction, purchase receipt FKs and global identity. Review followup guards stale backup downgrade and late AI indices; metadata uses reading geometry; bare quantity rows keep names; continue requires explicit retry before evidence replacement; currency context rebases to printed evidence. Identityv2 normalizes minute precision and preflights legacyv1 claims; full printed seconds remain metadata. Synthetic realistic native fixture/test passed once; UI proof was from an APK predating latest source UI fixes.
- Native: earlier temporary C: GooglePlay AVD reproduced actual app/system ANRs and host memory pressure; BT disable/2GB restart did not establish stability. New bounded OCR/gallery flow ran on shared emulator5554: one list, three purchases totaling90TRY, duplicate did not change counts, one pending draft remained. App exit record was USER REQUESTED/FORCE STOP status0, not an ANR; an older last-ANR snapshot is a separate system Gesture Monitor timeout. General stability and latest UI fixes remain unverified; no new AVD was created. See references/native-receipt-2026-10-25.md.
- User-authorized low-model maintenance ran flutter clean in kamubul/n-keto-tracker, gained3,700,662,272bytes on D:. Sources stayed on D:. Five old test-cache folders were SHA256 copied to C: but recursive removal was auto-review rejected and originals remain; see references/disk-cleanup-results-2026-10-25.md and disk-cleanup-2026-10-25.json.
- 2026-10-24 yeni kapsam: `.project-brain/intake-2026-10-24.md` N001–N074 ve PB-141..155. Özgün kullanıcı eki Brain sources içinde; önceki R01–R74 korunur.11 eski plan kaynağı hash doğrulamalı dış arşiv sonrası Brain references/history içine taşındı; bağımsız anlamsal inceleme PASS,formal kabul eski havuz onayı kapısında açık. Yeni kullanıcı yalnız native alt ajan yetkisi verdi; havuz çalıştırılmaz.
- Bu oturum başlangıç kontrolü: `flutter test --reporter compact`600PASS/2opt-in skip. Ortak kamera/galeri ve ayrı hata durumları sonrası83odaklı testPASS. Gerçek kusurlu fiş,kamera seçici ve iOS başarısı bu sayılardan çıkarılamaz; PB-141/PB-142 açık kalır.
- 2026-10-24 PB-135..137: single annual Pro source (USD1 beforetax,100AI/calendar month), annual-only native offer guard and token, legacy restore/allowances preserved; app71/store73/siteTR-EN/README source updated. Readable measured Y axes, compact+exact long values/RTL, wide spending exact rows. Final568FlutterPASS/2opt-in skip,38UI_REVIEWPASS,37serverPASS, analyzer clean, site155/store73checksPASS. Signed1.3.0+18 build481s PASS, targetSDK36/uploadsignature/12x64bit16KB verified. Livecatalog solePro_v2/yearlyACTIVE, US1USD/TR59.99TRY, other7plans+lifetimeINACTIVE;73live listinglocales exactsource match; PagesTR/ENdeployed/checkpassed. Playinternal18completed withmatchingSHA6d745b40dd7bdd0e4cd652a1d6b85a841a11f7077b38ebea16369a1b666e8556; productionunchanged. Details docs/audits/annual-pro-charts-2026-10-24-tr.md; formalPB approval issue remains.
- 2026-10-24 PB-134: visible localized product search and stable pending-first/purchased-last presentation implemented; zero market price counts, clearing restores pending group; search covers planned/unplanned without changing full totals, works read-only and blocks filtered reorder.16focused/548fullpass(2skip)/9finalfocusedpass, analyzer clean; actual-theme TR412light/dark andAR320/2x captures inspected, independent native review PASS with physical-drag/keyboard limits. Signed release1.2.9/17 built/identity verified; Playinternalconfirmedcompleted, remoteSHA256equal, productionunchanged. Formal PB start is blocked by changed legacy pool approval; no Evidence/Review/accept fabricated. Details docs/audits/product-search-2026-10-24-tr.md; all earlier production gaps remain open.
- Latest R61 final: shared visible two-option selector nowcovers4flows includingunplannedpurchase. Newunplanned prices are selected-quantity totals (2items/5.50=>5.50; unittoggle=>2.75 andback), priorcanonicalrecords preserved. Full539tests passed/2opt-in skipped; analyzerclean6.1s; Androidx64debugbuilt66.3s, SHA256206151C86DA58A67769AAA8DD670BA985C573B539DC169CBEB7BBA84F6AE392C. `.one-tap-price-{full,analyze,build}.log`. TRrender04inspected, all8capturestepspass. NewUI nativeinstall/storeupload notperformed. Earlier538/2707FC checkpoint immediatelybelow is superseded. Full-app UX/native/payment/OCR/iOS gates remainopen.
- R61 UX: sharedPriceModeSelector replaces all3price dropdowns (itemform, voicepreview, drafteditor); total remains new-entrydefault, no Settings preference. Both options visible and select inone tap; perfieldconversion keeps economicvalue and refocusesnumericinput. Drafteditor now converts its editableamount too; DialogRoute.completed governscontrollerdisposal. Full538pass/2opt-in skip, analyzerclean17.6s; TR/DE/AR320px/2x selectedsemantics/48dp tests3pass. Androidx64debug built35.6s, SHA2562707FC885539DB5521C28EE99508E3C564302AE92F25B5B00BCCA901A4499426. TR8screens in artifacts/store/2026-10-23-one-tap/tr/. New APKnot installed/nativechecked or storepublished thisfollowup; earlier nativeproof belowcoverspreviousdropdownbuild.
- Native followup: existingUSD/TR QA list400g/home350 retained aftersave/reopen, marketfocus=true; market320→800/kg, savedsummary350/320/−30, checked=true (`price-market-saved.xml`). Pages monthlycopy bcc16c3 nowlive, Actions40000016783 success and TR/ENHTTP200 checked. Latest audit: docs/audits/price-contract-2026-10-23.md. Brainvalidate28open/2ADR/0fail/1warn (backlogsize); typedUI criteria nowincludeaccessibility. Production/iOS/realOCR/paymentgates remainopen.
- Source checkpoint bcc16c3 (R51–R60):535full Flutter tests passed/2opt-in skipped; analyzerclean;37server tests passed;23history/homefollowup tests passed after glyph/date visualfix. TR/EN8screens each recaptured in artifacts/store/2026-10-23-pricing/. Android x64 debug1.2.8+16 built97.1s and adb no-streaming upgrade succeeded; nativeprice journey pending. APK SHA256 D84C539991869487A6A0DB2BAACBAC1D7C4DCFFC19458C02786715CEBC6C391D. Site147checks pass; remote monthlysite/serverv2 not yet published at this exact checkpoint.
- R51–R60 architecture: monthly-only new offers; optional shopping date/time and date/A–Z/manual sorting; manual price defaults to selected-quantity total. Schema3 nullableactualpricingInputMode preserves legacy money. Current verified results are the newerbcc16c3 checkpoint above; earlier focused45/49test checkpoints are superseded. Website monthlycopy now live: Actions40000016783 success, TR/ENHTTP200 literalmonthlycopyreadback. Serverv2/mobile publicupdate still notdeployed.
- 2026-10-23 source checkpoint (acceptance still open): Flutter full suite493passed/2opt-in skipped; analyzerclean. NativeAPK com.crazypenguin.nshoptor1.2.8+16 built(targetSDK36) and installed on API36 emulator; native journey checks remain. See docs/audits/production-2026-10-23.md for precise evidence and blockers. Earlier Runtime/STALE sections below are historical and must not override this checkpoint.
- OBSERVED (historical baseline): Flutter 3.47.x/Dart null safety, Material 3; `lib/main.dart` -> `lib/app/`. 2026-10-15: `flutter test --no-pub` 392 geçti; görüntülü detail/form/klavye/tamamlama kontrolleri 3 viewport geçti, analyze hatasız, Android x64 debug APK derlendi ve emülatöre kuruldu (SA-005).

## Map
- `lib/main.dart` — uygulama boot, DB ve root wiring
- `lib/core/text/list_title.dart` — Turkish-aware list normalization/input formatter
- `lib/features/discover/`, `lib/features/engagement/` — platform catalogue, safe store actions and persistent review policy
- `lib/features/lists/reminders/` — on-device notification permission/scheduling, DB compensation and tap payload
- `website/`, `tool/site/`, `.github/workflows/pages.yml` — deployed TR/EN GitHub Pages site
- `.project-brain/references/production-master-prompt-tr.md` — user scope R01–R74 and successor prompt; chronological supersession in `.project-brain/references/consolidation-2026-10-24.md`
- `docs/spec/price-input-contract.md` — total/unit defaults, source bases, discounts, schema3 and separate estimated/actual graph rules
- `lib/core/calc/price_input.dart`, `lib/features/lists/list_scheduling.dart` — fixed-point price basis conversion and optional-date/sorting UI
- `docs/store/preview-2026-10-23.md`, `artifacts/store/2026-10-23/` — current TR/EN rendered assets/video drafts
- `tool/store/read_play.rb`, `tool/store/make_preview.py` — safe release readback and reproducible marketing draft generation
- `server/src/currencies.js` — literal money currency set, tested against Flutter core
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
