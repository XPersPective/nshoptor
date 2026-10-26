# Current Architecture

## Read first
- Goal and order: Android+iOS app and invoice correctness first; publishing preparation next; website last. New requests steer the ongoing work. Existing full authorization persists. No CLI Agent Pool, no Store Automation, no AI coauthor trailers. Routine native workers use low models; director reviews architecture/security.
- Working branch: codex/app-takeover-20261026. Draft PR: https://github.com/XPersPective/nshoptor/pull/1. Latest pushed source a3a2d63; subsequent settings/paywall corrections are local pending checkpoint.
- Active intake: PB-161 security/AI attribution; PB-162 repository/publishing cleanup; PB-163 professional store assets/video/localized Android+iOS release. The 55 earlier open records contain implemented but unaccepted work; do not infer completion from their number.
- App remains 1.3.0+18 locally; Play code18 is consumed. Read remote versions before selecting a new code/upload. No new mobile publication in this takeover.

## Verified and pending
- Invoice PB-158: 149 receipt tests; explicit quantity columns and signed/product-code boundaries. Independent static review PASS. Real-photo/layout coverage remains open.
- Trial PB-150/157: clock correction tested; live D1 migration and Worker trial rollout read back, repeated QA registration has one seven-day deadline and unchanged usage counters.
- Apple PB-159: verified current StoreKit ownership, annual paid catalog, grace, unfinished delivery recovery; Apple JWS transport and official server signature/current-status verification. Server61PASS and workerd crypto fixture PASS. Subscription46PASS including paywall links/retry. Source review PASS. Apple backend not deployed; valid account/issuer/app/catalog/signing and sandbox payments remain unverified.
- iOS CI40282022693 SUCCESS: new StoreKit Swift and71 permission locales compile with Xcode26.3; synthetic Turkish nativeOCR/approval/3purchases90TRY/dedup passes on an existing iPhone simulator. This is not physical camera/real-photo/payment proof.
- Main CI40282022697:817PASS/1FAIL/2opt-in skip. Settings Future-returning setState callback was fixed in3places; local22settings tests PASS, including denial→retry→success. Fresh full CI is required after pending checkpoint.
- Full analyzer was clean before final paywall changes; final check pending. Local full test stopped at441 without completion; two local Android builds exited-1 without success. Host memory pressure observed, cause not proven. A confirmed orphan Kotlin child of this task's stopped Gradle daemon was stopped; other user applications untouched.
- Backup PB-160: pending restored reminders, native-ID collision preservation, explicit retry;54focused tests PASS before the final callback correction, then22settings/restore tests PASS.
- Renderer QA:6scenarios,36captures:412lightTR/800darkTR/320Arabic2x. Native sustained crash/ANR, physical speech/print/notifications and full accessibility acceptance remain open.

## Security and ownership
- Current preliminary tracked-text and credential-path history scan found no high-confidence private-key/token signatures. Public Contributors API lists only XPersPective. One historical AI coauthor trailer exists (ec5a453); no AI author/committer names. Full redacted Gitleaks history scan underway outside the repo; do not call the preliminary scan exhaustive.
- Canonical private publishing registry: D:/AppPublishing/README.md; app folder apps/nshoptor; publisher crazypenguin. Secrets stay outside Git. Nonsecret Fastlane automation may remain versioned here; paths are references, not embedded credentials.
- App Store metadata/screenshots directories currently contain0files. No fabricated App Store URL or publication claim.
- Website71locale work remains intact and uncommitted; design/deployment postponed. PB-162 will define external canonical site ownership and update deployment dependencies before removing old copies.
- Archive valuable evidence/user work with verified hashes before cleanup. Remove only classified obsolete/generated material at verified absolute workspace paths.

## Map (load only needed domains)
- lib/features/receipts, test/features/receipts — OCR-neutral document/parser/review, durable drafts/identity, fixed-point quantities, approval and dedup.
- lib/data/db — Drift schema4, migrations and receipt/purchase integrity.
- lib/features/subscription, lib/features/ai, server — store ownership/trial, signed credential transport, server verification/quota/AI; server/APPLE_ENTITLEMENTS.md details Apple configuration.
- ios/Runner — native on-device speech, HTML print and StoreKit bridge; tool/ios/localize_usage.py generates71permission locales from ARBs.
- lib/features/lists, home, shopping_mode — lists/items/prices, navigation, shopping completion and reopening.
- lib/features/history — spending/report/budget/export; purchases and currencies remain distinct.
- lib/features/settings — preferences, guide, backup/import/delete; reminders remain pending until OS activation.
- lib/core/l10n —71ARB/generated app languages; interface coverage is not OCR-script coverage.
- fastlane, tool/store, docs/store — nonsecret release commands/source contracts; actual credentials/materials are private.
- .github/workflows/ci.yml, ios.yml — server/analyze/test/security/Android release and native iOS compile/OCR.
- website, tool/site, pages.yml — current website dependencies pending PB-162 ownership cleanup; do not delete user changes.
- .project-brain/tasks/PB-141..163 — active requirements/acceptance; intake-2026-10-24.md is earlier user scope loaded on demand.
- references/takeover-2026-10-26.md and docs/audits/mobile-takeover-2026-10-26-tr.md — detailed dated checkpoint, not an all-complete claim.
- Historical Current snapshot is hash-verified under D:/AppPublishing/apps/nshoptor/original-notes/project-brain-history/2026-10-26-<source-hash-prefix>/current.md. Older temporary-AVD and pool decisions are superseded.

## Next
1. Finish final analyzer, checkpoint settings/paywall fixes and fresh full CI.
2. Complete PB-161 security/attribution readback; preserve source tree/history backup before any attribution cleanup.
3. PB-162 manifest/archive/cleanup and publishing hierarchy; keep current app acceptance work open.
4. Resolve actual Apple account/platform gates, obtain signed candidates and real native evidence; then localized store assets/release and finally website.
