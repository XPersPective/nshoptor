# Current Architecture

## Read first
- Goal and order: Android+iOS app and invoice correctness first; publishing preparation next; website last. New requests steer the ongoing work. Existing full authorization persists. No CLI Agent Pool, no Store Automation, no AI coauthor trailers. Routine native workers use low models; director reviews architecture/security.
- Working branch: codex/app-takeover-20261026. Draft PR: https://github.com/XPersPective/nshoptor/pull/1. Verified app source96c5b2e includes settings/paywall corrections. Historical commit hashes map through the private attribution backup.
- Active intake: PB-161 security/AI attribution; PB-162 repository/publishing cleanup; PB-163 professional store assets/video/localized Android+iOS release. The 55 earlier open records contain implemented but unaccepted work; do not infer completion from their number.
- Candidate1.3.1+19 selected after fresh Play readback confirms internal18/production1+draft14. No candidate upload or new mobile publication yet. Read remote versions again before uploading.

## Verified and pending
- Invoice PB-158: 149 receipt tests; explicit quantity columns and signed/product-code boundaries. Independent static review PASS. Real-photo/layout coverage remains open.
- Trial PB-150/157: clock correction tested; live D1 migration and Worker trial rollout read back, repeated QA registration has one seven-day deadline and unchanged usage counters.
- Apple PB-159: verified current StoreKit ownership, annual paid catalog, grace, unfinished delivery recovery; Apple JWS transport and official server signature/current-status verification. Server61PASS and workerd crypto fixture PASS. Subscription46PASS including paywall links/retry. Source review PASS. Existing team API key now authenticates with issuer read from the console; app6827116818 exact API readback PASS. Distribution certificate/key/p12 match Team53X3279WA3 and are valid through2027-10-23; matching profile, catalog/backend and sandbox payment acceptance remain open.
- iOS CI40282022693 SUCCESS: new StoreKit Swift and71 permission locales compile with Xcode26.3; synthetic Turkish nativeOCR/approval/3purchases90TRY/dedup passes on an existing iPhone simulator. This is not physical camera/real-photo/payment proof.
- CI40316373426 SUCCESS on96c5b2e:822tests PASS,2opt-in skips; analyzer/server/security and Android release compilation PASS. Settings22 and subscription46 focused tests passed. CI40316373433 SUCCESS: iOS release compile and native synthetic receipt OCR/persistence regression passed.
- Bounded local Android x64 debug build PASS,122.6s; APK215044837bytes SHA256 e685d9a8eb1037d16135053221d5a30333c541322138aea3b0c3558b77a17663. Earlier incomplete local tests/builds are not passes. Only owned orphan Kotlin process stopped; no unrelated applications touched.
- Backup PB-160: pending restored reminders, native-ID collision preservation, explicit retry;54focused tests PASS before the final callback correction, then22settings/restore tests PASS.
- Shared Android AVD startup: three successful starts7279/453/6330ms, final activity resumed, no recorded app crash/ANR. Private screenshot inspected; literal '# days left' defect found, tracked PB-164 and being fixed. This bounded check is not sustained stability acceptance. Renderer36captures archived; physical speech/print/notifications and full accessibility remain open.

## Security and ownership
- Verified official Gitleaks8.30.1 full-history/all-ref and806tracked-file scans:0findings, plus latest CI security PASS. Public Contributors lists only XPersPective. The one Claude coauthor trailer was removed after private bundle backups;240commits verified with identical source trees/authors/committers. Exact leased public updates read back; no AI coauthor remains in current refs. This scan is not an absolute guarantee against every possible secret format.
- Canonical private publishing registry: D:/AppPublishing/README.md; app folder apps/nshoptor; publisher crazypenguin. Secrets stay outside Git. Nonsecret Fastlane automation may remain versioned here; paths are references, not embedded credentials.
- App Store record6827116818 created and read back through the existing authenticated publisher browser; exact bundle com.crazypenguin.nshoptor registered under Team53X3279WA3. Turkish primary language, SKU nshoptor-ios, iOS1.0 Prepare for Submission. Private receipt original-notes/apple-record-2026-10-26.json. Metadata/screenshots, signing, catalog/backend and actual payments remain open; this is not public availability.
- ADR-006 defines ownership: source/tests/nonsecret Fastlane here; credentials/store media/receipts externally; website source/tools move together later, with validated static artifact deployment. Website71locale work remains intact and uncommitted; design/deployment postponed until app acceptance.
- Cleanup receipts:1095obsolete/generated files archived, removed or relocated after hash verification; .store-automation absent; root18files/0logs. Private original-notes/project-cleanup-2026-10-26 holds manifests and receipts. Normal current build/dependencies and user changes preserved.

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
- references/takeover-2026-10-26.md — detailed dated checkpoint, not an all-complete claim. The dated mobile audit is archived privately at original-notes/project-cleanup-2026-10-26/repo/docs/audits/mobile-takeover-2026-10-26-tr.md.
- Historical Current snapshot is hash-verified under D:/AppPublishing/apps/nshoptor/original-notes/project-brain-history/2026-10-26-<source-hash-prefix>/current.md. Older temporary-AVD and pool decisions are superseded.

## Next
1. PB-164 fixes literal plural counter labels across71locales;9focused localization tests PASS. Checkpoint candidate1.3.1+19, run fresh full CI and verify the installed corrected label.
2. Keep PB-161 scan/history/cleanup receipts and ADR-006 synchronized; formal PB acceptance remains unavailable with the old native-model registry.
3. Complete remaining app behavior and device/account proof; preserve all outstanding acceptance gates.
4. Resolve actual Apple account/platform gates, obtain signed candidates and real native evidence; then localized store assets/release and finally website.
