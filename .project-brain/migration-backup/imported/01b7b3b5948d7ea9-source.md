# SA-035 — Translations for theme, spending, limit and report strings (71 locales)
Status: READY
Priority: P1
Tier: M
Risk: LOW
Milestone: M3
Depends: -
Owner:
Areas: `lib/core/l10n/app_*.arb`
Domains: UI and product

## Objective
User: "aylik rapor alinabilmeli... yillk, aylik ve haftalik harcama... urun yillik, aylik haftalik harcama... guzel anlasilir grafikler... haftalik aylik ve alisveris limitleri... border stili... liste ögesindeki kare tik alanina da uygula... birden cok tema... spash ekrani temaya uyumlu... ikon isim slogan... nshoptor yazi marka stili her yerde ayni olsun." (2026-10-16)

## Steps
1. Collect keys added by the tasks above; translate into all 71 ARB files; run flutter gen-l10n.

## Acceptance
- [ ] [machine] `flutter test test/core/l10n` exits 0.

## Verify
- `flutter test test/core/l10n`
- `flutter gen-l10n`

## Escalate if
- A choice changes stored data formats or billing.

## External

## Evidence

## Review

## Notes
- ready by claude-opus-5-5: risk class, data contract (SettingsStore keys, no schema change) and steps confirmed.
