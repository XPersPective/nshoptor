# SA-034 — Monthly report PDF
Status: READY
Priority: P1
Tier: M
Risk: MEDIUM
Milestone: M3
Depends: -
Owner:
Areas: `lib/features/history/insights/**`, `lib/features/shopping_mode/summary/pdf_report.dart`, `test/features/history/**`
Domains: UI and product

## Objective
User: "aylik rapor alinabilmeli... yillk, aylik ve haftalik harcama... urun yillik, aylik haftalik harcama... guzel anlasilir grafikler... haftalik aylik ve alisveris limitleri... border stili... liste ögesindeki kare tik alanina da uygula... birden cok tema... spash ekrani temaya uyumlu... ikon isim slogan... nshoptor yazi marka stili her yerde ayni olsun." (2026-10-16)

## Steps
1. buildMonthlyReport(db, month, currency, l10n, locale): completed lists of the month with planned, actual, difference; totals; categories; limit status.
2. Print through the existing nshoptor/print channel like the shopping report.
3. Button on the spending screen month header.

## Acceptance
- [ ] [machine] Monthly report HTML test: escaped text, totals equal the overview totals.
- [ ] [interaction] Report opens the Android print dialog from the spending screen.

## Verify
- `flutter test test/features/history`
- `flutter analyze`

## Escalate if
- A choice changes stored data formats or billing.

## External

## Evidence

## Review

## Notes
- ready by claude-opus-5-5: risk class, data contract (SettingsStore keys, no schema change) and steps confirmed.
