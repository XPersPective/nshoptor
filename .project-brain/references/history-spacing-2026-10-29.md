# History currency spacing — 2026-10-29 (PB-203)

- Existing Material/AppTheme layout retained. Currency selector padding now reserves vertical room for the floating label below the date selector, with no report/data/period contract change.
- Regression RED before the fix: at 320dp, 2x text, TR, label top452.5 versus required468.0; it overlapped the date button by11.5 logical pixels.
- Four explicit capture/interaction cases PASS: 320dp/2x TR light and AR dark, 1280dp/1x TR dark and AR light. These are actual Flutter widget renders with Windows Segoe UI and MaterialIcons, not native Android/iOS observations.
- Director inspected all four PNGs: date and currency label remain separated, including the three-line Arabic date; compact report body remains scrollable. Native screen-reader and broader device gates remain open.
- Tests cover >=48dp selector height, currency semantics, Escape retaining TRY, switching to USD, previous period changing date/showing reset, reset restoring the original date and retaining USD. No new loading/error state introduced by padding.
- `flutter test --no-pub test/features/history --reporter expanded`: 109 PASS (includes four additional normal Flutter test-font cases).
- `flutter analyze --no-pub`: No issues found.
- Incremental Android debug build: PASS, `flutter build apk --debug --no-pub` (77.8s). No install or upload. Build-generated locale formatting restored; no localization changes remain.
- Bounded native Luna source review found a missing assertion for previous/reset; strengthened it and received no remaining actionable findings. This is observed review, not a formal PB PASS/qualified registration.
- Test harness initially leaked its semantics handle and stalled DB shutdown; corrected with finally disposal/unmount/pump/close. Subsequent full four-case render and history suite runs pass. No failed harness run is presented as product proof.
- Formal PB execution/acceptance remains blocked by the already observed native-model registry issue from PB-202. No alias/rating bypass, manually forged Evidence/Review record or checked acceptance.

## Local artifact hashes
These ignored local logs/captures are observations, not formal typed evidence. Captures are under `.cache/pb203-captures/`.
- `pb203-red.log`: `b0be5baf361dca3ccf641c29bcef3b2ec1c44230e3e6768af6be5e6b1f92e808`
- `pb203-render-tests.log`: `67ff5ded370de82cdf21d0bd3246863a18da3462c333f1e8577576a878016e56`
- `pb203-history-tests.log`: `4f43ced146da8872d243b504bdc70bb5c0ffad44ee16da3999828a784711ac20`
- `pb203-analyze.log`: `3b5e9f166967b51f655ea9b0281d7ce879ae61b25086db75b9c228a64ef6ab47`
- `1280_ar_light.png`: `077a8a5072b02bf0ac8ddd45e4a0db409d8d0bc522282c76623a43fceb68f134`
- `1280_tr_dark.png`: `bcfbd5303ea2820eb4cda67837ae23aa3084196142a5e4e121b52769a1c558fb`
- `320_ar_dark.png`: `9ff42e76fae4f3342597a42dfaac289cdcbdfc061eb7555b4f5894653cfea0d4`
- `320_tr_light.png`: `ea6d87bded96d64b2aacf4548a4a3dffbbf659423a5553833d6f1903c3e859fe`
- `pb203-android-build.log`: `1734d8b77a2189134a6b4d8ea8f270a834d95032d73893bee2033cd47c8d1205`
- `app-debug.apk`: `a3758841f95eec1c9b8be6a0f17d6598b8a7936756207efe06b586af73049c78`
