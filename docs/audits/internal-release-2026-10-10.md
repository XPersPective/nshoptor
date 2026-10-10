# Internal Android releases — 2026-10-10

## Final release1.2.1+8

`fastlane deploy_internal` finished successfully21:16:48. Independent read-only Android Publisher SDK confirms internal versionCode8 completed; production remains1. No global metadata/images/screenshots or production promotion submitted. Publisher AAB92707807bytes SHA256 `759a9f65daf95af27087437a96ccd21aabfdaecf18f028823c58d2f3a7514a8c`, existing publisher certificate verified, known external secret literals absent. Permanent bundle/report/logs under `D:/AppPublishing/apps/nshoptor/artifacts/releases/1.2.1+8/`.

Full383/server25/analyze0/debug APK and publisher release passed; actual normal main CSV save/cancel/retry/pull and debug native backup roundtrip passed. Detailed source/build/native evidence: `release-1.2.1-2026-10-10.md`. Final app source GitHub CI38074155877 succeeded across all jobs; final code/fixture/helper CI38074516588 also completed success across all jobs.

## Earlier release1.2.0+7

`fastlane build_release` succeeded with external publisher signing and real AdMob IDs; `fastlane deploy_internal` succeeded. Read-only Android Publisher SDK confirms internal versionCode7 completed and production remains versionCode1. App version1.2.0. No global metadata/images or production promotion submitted.

AAB: build/app/outputs/bundle/release/app-release.aab,92209893bytes, SHA256 `f02ed36b24d37033a9d37c6edfd64fa4ffce3bae234b5063f9a5c317ca62bff1`. jarsigner verifies; certificate SHA256 `946f68a1ebb373fcc96e96701e7da235fb321cf4a76e580f46de6bd70701406e`, Crazy Penguin. Known external Qwen API key/Play private-key literal forms absent from all decompressed bundle members; secrets not logged.

Store text:73 Play locales,71 application ARBs retained. Updated canonical checklist, independent actual quantity/price, local editable input, PDF/quantity/frequency reports and independent locale/currency. New10/100/300 monthly quotas, legacy200/1000 preserved, annual same monthly quota, eligible7-day Pro monthly trial. Current Qwen unchanged; DeepSeek only pricing reference.

`python -B tool/store/check_assets.py` checks exact store locale coverage, limits and quota digits (including local numerals), source URL and render failure preserving old images. Render each app locale sequentially; one Flutter invocation drives both capture/feature tests. All67 app locales completed both render tests (134 passed runs);73 mapped store locales contain584 validated PNG1080x1920 and73 validated featureJPEG1024x500. Final check_assets.py metadata-root pass. English/Hebrew/Japanese/Arabic04 images visually inspected.

Generation root: D:/AppPublishing/apps/nshoptor/stores/google-play/metadata. Source catalog tool/store/listing.py +listing_extra.json; update descriptions/notes through existing Qwen script, preserving validated titles/short descriptions. Rejected length/omitted-rights translations were corrected; only passing values retained.

Build failures were diagnosed rather than ignored: overlapping host tests can regenerate debug plugin registration during a release build; `--no-pub` skips Flutter platform tooling regeneration (local FlutterCommand.regeneratePlatformSpecificToolingIfApplicable). Cached test registrant included integration_test while Gradle excludes dev plugins in release. Network failures also interrupted package resolution. Standard fastlane build with working network and isolated Flutter activity regenerated the correct release registrant and passed. No app-source workaround or SDK modification.

Native acceptance and physical/sandbox limits: release-2026-10-10.md. Internal test participation: https://play.google.com/apps/internaltest/4700463295417403444.
