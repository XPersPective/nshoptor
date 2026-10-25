# Receipt and shelf integrity checkpoint — 2026-10-25

This records source changes and observed checks, not acceptance of N001–N075.

## Actual checks

- Full Flutter baseline:715 passed,2 opt-in visual tests skipped in `.resume-full-2026-10-25-recheck.log`. This preceded the following integrity review fixes.
- Followup receipt/schema/awake focused run:142 passed in `.resume-integrity-regressions3.log`.
- Shelf extraction and form persistence:33 passed in `.resume-shelf-basis2.log`; a further explicit-label-ownership test was added afterwards and awaits the current full run.
- Analyzer clean after shelf/source changes in `.resume-shelf-analyze.log`.
- Server44 passed in `.resume-server-2026-10-25.log`.
- Final full run `.resume-full-integrity-shelf.log`:737 passed,2 opt-in visual tests skipped,5m31s. Includes the explicit ownership regression. Android fixture APK build is now pending.

## Review findings repaired in source

1. A bare quantity×unit-price row now joins its preceding product name; trailing money labels no longer prevent row classification.
2. Store/document number/date/time/total metadata uses reconstructed visual reading order, preserving original OCR fragments.
3. Older pending backup data cannot downgrade a committed receipt claim or replace its capture/list binding during merge; rejection rolls back all writes.
4. Choosing continuation camera/gallery never silently replaces a mismatched receipt. Only explicit retake may replace evidence and subsequently collect unreferenced owned images.
5. Printed foreign currency supersedes context-only defaults; prepend and encoded replay preserve the resulting currency and exact fixed-point amounts. Explicit conflicts still reject.
6. AI/rule suggestions use immutable input snapshots. Responses arriving after merge/split/name/quantity/amount edits cannot apply old indices to new rows.
7. Receipt identityv2 uses merchant/document number/date+minute/currency. Observed seconds remain metadata. Approval also recomputes oldv1 claims from retained capture/metadata, so omitting seconds in a later OCR read does not duplicate that receipt. Arbitrary OCR errors and identical merchant labels across branches still require real-corpus validation.
8. Shelf unit/package labels associate only with a unique nearby spatial price. Explicit candidates participate in ownership competition; ambiguity stays unresolved. Package/name inheritance respects columns; multiple prices on one OCR row each use their own preceding quantity segment.
9. Photo price input preserves the user's existing product name and only fills an empty new name. A20TRY/100g quote applied to400g saves80TRY with canonical0.2TRY/g, tested by numeric value rather than serialization scale.

## UI and native limits

The71locale shopping-screen toggle now reports the actual awake/on or can-turn-off state in tooltip and toast. Translation key coverage and widget behavior do not establish natural-language quality in every locale. Continuation screenshots in `artifacts/qa/2026-10-25-receipts/` are real-font widget renders; AR320/2x and TR412 were inspected. They are not native or store screenshot proof.

`integration_test/receipt_realistic_test.dart` embeds the generated photographic fixture documented in `integration_test/fixtures/receipt_realistic_tr.json`. It asserts MLKit text/metadata,1kg apples20,2bread40,milk30,total90, approval, purchase FKs and duplicate rejection. Native execution is pending. The fixture is synthetic, not a real customer's receipt.

Earlier native app ANRs and Android service failures remain reproduced, unresolved PB-156 evidence. Both task AVDs are stopped. The shared AVD is running another game session and is not interrupted. Host RAM pressure prevents claiming that merely changing the OCR model or adding an emulator solves stability.

Formal Brain start/check/review/accept remains behind stale legacy pool approval. The user forbids that pool; no approval, digest evidence or review result has been fabricated. All task acceptance boxes remain open until their real criteria are verified.
