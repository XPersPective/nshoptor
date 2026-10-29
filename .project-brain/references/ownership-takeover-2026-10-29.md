# Ownership takeover — 2026-10-29

## Session authority
The user explicitly selected EXEC=S-ML and REV=S-ML in this chat. A new top-level session must ask once again under skill section 2.1; do not infer fresh routing authorization from this historical note. No CLI Agent Pool, permission expansion, store write or emulator operation occurred.

## Product change (PB-202, not shipped)
- ADR-009: schema v5 adds nullable planned_items.created_by_receipt_id with SET NULL. Pre-v5 provenance remains unknown; never guess from dates.
- Receipt-created approved/partial rows carry the original draft ID. Anonymous-to-list rehoming and background completion preserve it.
- Deletion removes only explicitly owned rows without other purchases; manual/unknown/shared rows and other receipts survive. Draft discard uses the same guarded deletion transaction.
- Separate backup remaps provenance; merge preserves fields absent in old backups. Validation rejects invalid creators and cross-list relations, including merge's retained local-only rows before commit.
- Partial capture and automatic matching isolate same-name rows owned by different receipts. Background completion rejects deleted/approved/photo-superseded drafts before creating a list.

## Observed verification (manual commands, not formal PB acceptance)
- `flutter test test/data test/features/receipts test/features/settings/backup test/features/lists/item_repository_test.dart --reporter expanded`: 279 PASS.
- `flutter test --no-pub --reporter expanded`: 977 PASS, 2 existing opt-in UI review tests SKIP (UI_REVIEW=true required). This is not a fresh native camera, screen-reader or iOS observation.
- `flutter analyze`: No issues found.
- Android debug build: PASS, `flutter build apk --debug --no-pub` (432s). APK 217862457 bytes; SHA-256 `16100de72f014389325c0340db096d1dc16bf441332141e2449b8111a3ba07f5`. Not installed, signed for store or uploaded. Build-generated locale formatting was restored to the exact previous tracked bytes; no localization changes remain.
- Native Luna source review found a merge ownership defect; director fixed it and added the atomic regression. Follow-up source review found the issue resolved and no remaining actionable findings in its bounded scope. This is not a qualified formal HIGH-risk review.
- `PB validate`: 0 fail, 12 warnings (97 open tasks; inherited task contracts/triad/verification gaps). No closure fabricated.

## Tooling blocker
`PB start PB-202 --agent gpt-6.1-sol` rejects the installed registry entry as unavailable. `PB check PB-202 --as gpt-6.1-sol` refuses READY because start did not succeed. Read-only tooling investigation confirmed gpt-6.1-sol/gpt-6-luna entries have available=false and no roles/tiers. Desktop native agents actually ran, but no supported adapter or defensible strength metadata was found for formal registration. Do not rename aliases, invent ratings or bypass the gate. Task remains open; no Evidence/Review PASS was handwritten.

## F20 limits and next work
No automatic onion/demo-product seed was found. Demo data requires an explicit Settings action. Home receipt import intentionally creates a distinct list; detail import passes its current list ID. The regression explicitly asserts both stores persist after two same-list approvals. The historic device incident's entry path/response is absent, so its root cause remains unconfirmed (PB-191).

After this checkpoint: resolve the formal native gate and retain the task until qualified acceptance. Continue the app-first queue in handoff-2026-10-29.md: unified camera/gallery F03, back-to-back capture F07, concise localized messages F10, device money-format check F23, narrow History selector spacing, native/device/a11y gates, privacy declarations/TestFlight/media. Store build remains 1.3.1+26; no new upload. Inherited website/tool-site work stays untouched.

## Local log hashes
Logs are ignored under `.project-brain/.cache/`; these hashes describe observed logs and do not turn them into PB typed evidence.
- `pb202-focused-tests.log`: `9d3ab393fbe2c20de2e853dbad750f47ab498eddfaa5f4281a9a88cb93715f78`
- `pb202-full-tests.log`: `a599e232eb5a86ae87572becabb187cbbb357c2eed9c69901e411bca3f875483`
- `pb202-analyze.log`: `3ba818bc3b4493487dd02dd8e984d630b95ec876a01946483e984b332720cc80`
- `pb202-android-build.log`: `5654cbcbab9e609c1b6f5c4b90cd6fa9f23fc368a7bfcc47693ef6cd8fff9968`
