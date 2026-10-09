# Android PDF acceptance — 2026-10-09

Native API 36 device: `emulator-5554`, AVD `nshoptor_test`. No PDF dependency added.

Reproduce: `flutter run --no-pub -t tool/pdf_probe.dart -d emulator-5554`, tap the PDF action. Cancel with Android Back, tap again, choose **Save as PDF**, save in Downloads, open the file in Android's PDF viewer.

Observed: first print cancelled; repeat print successfully opened. The fixture summary still showed planned TRY 6,800.00, actual 3,822.00 and comparable variance -658.00. Saving created `/sdcard/Download/NShoptor-1.pdf` (79,514 bytes), not merely a print preview. Android opened it through `com.google.android.apps.viewer.PdfViewerActivity`, using media content URI ID 25 in this test device.

Pulled with `adb pull /sdcard/Download/NShoptor-1.pdf build/pdf-audit/NShoptor-1.pdf`.
SHA-256: `A50C2EC0890981A3E4D8B0C40476663F34F2342087FFBCA1FF8B9077CA4135D2`.

Bundled Python pypdf confirmed five pages, Turkish title **Çığ Şölen**, **Yoğurt**, **şeftali**, item 85, and final totals. Bundled pypdfium2 rendered pages 1 and 2; both visually inspected, alongside Android viewer screenshot. Long product names and Arabic names fit; the table header repeats on page 2. Rows are intact across pages. Local evidence: `build/pdf-audit/{page-1,page-2,android-opened}.png` (generated artifacts, not source).

After this visual capture the quantity formatter was aligned with the existing MoneySeparators helper (Turkish 1.5 → 1,5). The focused report regression tests pass for this final formatting delta. Native print behavior is unchanged.

Domain checks: list and JSON backup tests 74 passed; report focused 2 passed. Escape regression includes script/image-like title/product text, RTL, KWD three decimal digits, unknown versus zero, unplanned items and quantity units. Mock print failure permits retry and changes no purchase records. Android debug APK builds; analyze has zero issues.

The print channel reports only that the system dialog opened. It never claims a saved file. One WebView owns one job until adapter finish; timeout/error and Activity destruction release it. JavaScript, file/content access and network loading are disabled. Taxes are explicitly unknown; this is a shopping summary.
