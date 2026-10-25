# Native receipt QA — 2026-10-25

This records a bounded synthetic-fixture OCR run and a separate shared-emulator gallery/review flow. It is evidence for those paths only; it does not close PB-156 or establish general device stability.

## On-device OCR integration

`.resume-native-realistic-test.log` shows a successful debug build/install and one passing integration test, `native OCR imports a realistic Turkish receipt exactly once`. The test ran the generated photographic fixture in `integration_test/fixtures/receipt_realistic_tr.json` through on-device ML Kit. Captured OCR output is recorded in the log as `REALISTIC_RECEIPT_OCR`.

The test asserted merchant `ÖRNEK MARKET`, receipt number `2026000123`, date/time, TRY, and total 90.00 TRY; it parsed three products (apple 1 kg / 20 TRY, bread 2 / 40 TRY, milk / 30 TRY), approved them, verified all three purchases reference one receipt, and retried the same document. The duplicate was rejected and purchase/receipt counts remained three and one. This fixture is synthetic, not a real customer's receipt.

## Shared emulator gallery/review flow

The saved UI and database artifacts under `artifacts/qa/2026-10-25-native/` record a gallery selection and approval on shared emulator `5554`. `shared-picker.xml` shows the Android photo picker, `shared-review.xml` and `shared-accepted.xml` capture review and approval, and `shared-before-duplicate.json` records one TRY list and three purchases totaling 9,000 minor units (90 TRY). The receipt claim belongs to one reviewed receipt. `shared-after-duplicate.json` reports `quick_check: ok`, one list, three purchases, `paid_minor: 9000`, one claimed receipt, and both one pending draft and one reviewed receipt. Retrying the same receipt did not add another purchase set; the pending draft remained present.

The captured installed APK predates the latest source UI fixes. Its native UI still shows the old generated title `Review receipt` and quantity/price lines such as `1.000 kg × · ₺20.00`; neither artifact verifies the current merchant-title fallback or corrected row formatting. The latest source must be rebuilt and installed before those UI fixes receive native confirmation.

## Exit and limits

`shared-exit-info.txt` records the app process exiting at 2026-10-25 14:27:27 with Android reason `USER REQUESTED`, subreason `FORCE STOP`, status 0. That process exit is an intentional force-stop, not an app ANR. `last-anr.txt` is a separate earlier snapshot (01:46) for the system `[Gesture Monitor]` input-dispatch timeout; it does not identify the 14:27 app exit as an ANR. Earlier app and Android service ANRs reproduced on task-specific AVDs remain unresolved in [emulator-stability-2026-10-25.md](emulator-stability-2026-10-25.md).

This does not verify a real user's camera capture, all camera/gallery permission and lifecycle cases, prolonged stability, current-source UI behavior, or iOS. Those checks remain open. No acceptance or review status is inferred from these artifacts.
