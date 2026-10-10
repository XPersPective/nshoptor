# Android1.2.1+8 verification — 2026-10-10

## Native JSON backup bridge

`flutter test integration_test/backup_picker_test.dart -d emulator-5564 --reporter expanded`:1 passed on dedicated API36 PlayStore AVD `nshoptor_release_check_20261010`. Actual FilePicker export cancellation, retry/save, import cancellation, retry/select and separate confirmation passed. The fixture uses SettingsScreen, an explicit in-memory fake Pro entitlement and owned in-memory SQLite/temp files; it does not boot main, touch a customer database or test a real purchase.

Assertions: exported version1 JSON, quantity1.5/KWD amounts, separate restoration creates2lists/2items with fresh IDs; temp files removed. Pulled saved JSON1030bytes SHA256 `7d153e5f472c752bcf5322c78097c6922a3052d2d5303677c907bd18777eb001`.

Permanent artifacts: `D:/AppPublishing/apps/nshoptor/artifacts/release-qa/backup-native-1.2.1+8.log`, `NShoptor_Backup_QA_1_2_1.json`, `backup_cancel_save.png`, `backup_save_qa.png`, `backup_cancel_pick.png`, `backup_pick_qa.png`.

The fullyLive test waits outside Flutter frame pumping while Android SAF owns foreground, then requires resumed lifecycle and the operation's busy flag to clear. Older paused-frame/time-out attempts are superseded by this actual pass. Final normal main CSV and publisher signature/upload verification follow below.

## Scope of prior device evidence

Normal optimized main7 PDF, exact financial amounts, cold reopen, partial completion/cancel, native wake flags and denied-microphone fallback remain in `release-2026-10-10.md`; they are not relabeled8. Native on-device speech/offline OCR bridge fixtures passed separately. Physical transcript/camera capture and real Play purchase are unverified, as already scoped by target decisions. Global Play store metadata/images are validated locally and deferred from this internal release.

## Final source checks and publisher bundle

Final source application commit51c8e99 includes native reminder cancellation/default production wiring and calendar text reflow. Full Flutter383 passed, server25 passed, analyzer0, configured debug APK built34.6s. Default notification MethodChannel test proves cancel failure preserves rows in both deletion paths; no permission request. Analytics tests retain320dp/2x en/ar and add375dp/landscape, light/dark, reduced motion and full day text.

`fastlane build_release` completed21:03:58 with external publisher signing and real AdMob IDs. AAB92707807bytes SHA256 `759a9f65daf95af27087437a96ccd21aabfdaecf18f028823c58d2f3a7514a8c`; jarsigner verifies. Certificate SHA256 `946f68a1ebb373fcc96e96701e7da235fb321cf4a76e580f46de6bd70701406e` matches existing publisher7. All decompressed members checked against known external provider key, Play PEM forms and signing-password literals, none found. This is a bounded literal check. Preserved bundle/report: `D:/AppPublishing/apps/nshoptor/artifacts/releases/1.2.1+8/`.

Final redacted Git history scan133commits/7.12MB found no leaks. Source diff since Brain genesis passes whitespace check; TODO/FIXME/UnimplementedError/debugPrint search over production Flutter/Worker/Android source found none. Store73 locales/584PNG/73feature validated; economics self-check passed. AAB is rebuilt after both last app changes; previous unuploaded code8 bundle is superseded.

## Normal optimized main8 CSV

`flutter build apk --release --target-platform android-x64`: succeeded151.9s,62082011bytes (59.2MB), normal main with QA debug signing/Google test AdMob IDs; publisher AAB above retains real signing/IDs. APK SHA256 `29936bf09f55c813460cf3cc04f6f22bbeb9b5ce1cbb74721f3cb6ee9c118c00`. aapt confirms existing package/versionCode8/versionName1.2.1/target36. Installed with `adb install -r`, no uninstall/wipe; previous owned draft survived.

Created owned CSV_QA_8 item, quantity1, planned12.34USD/actual13.00USD. Finish result shows0.66 difference(5.3%). Actual Android SaveFile cancel returned unchanged Summary with export enabled; retry opened native DocumentsUI, saved `NShoptor_CSV_QA_1_2_1.csv` to Downloads. Pulled170byte CSV has UTF8 BOM; csv.reader asserts name, planned quantity1/12.34, actual quantity1/13.00 and0.66. Actual unit price retains full decimal13.000000. SHA256 `fe74f6a0d72587aac9042984bca878bd70737fa424b6270e864263e6a98696b2`. Force-stop/reopen retained completed list and monthly12.34/13.00/0.66.

Permanent D release-qa: main-optimized-1.2.1+8.apk, CSV above, csv_native_cancel.png/csv_native_save.png/csv_release_summary.png (summary visually inspected; complete text and controls). Native main proof is distinct from the backup debug fixture. Only owned5564 controlled; shared5556/5554 untouched.

## Google Play and cleanup

`fastlane deploy_internal` completed21:16:48; independent read-only Android Publisher SDK confirms internal8 completed, production1 unchanged. No production promotion or global metadata/images submitted. Final app source CI38074155877 allgreen; fixture/helper follow-up715bcf3 same app source already passed Analyze/Test/gitleaks and build verification was running at publication. Prepared store notes8 remain in permanent D metadata root.

Owned temporary AVD `nshoptor_release_check_20261010` was stopped after proof and removed using native avdmanager after verifying its exact non-junction C path. Only synthetic QA data removed; shared AVDs/publishing/source preserved. Source stays D; build junction targets `C:/CodexBuilds/nshoptor/build`. Final disk free C15.6GB/D10GB (current generated build retained for Fastlane; old cleanup PB096).
