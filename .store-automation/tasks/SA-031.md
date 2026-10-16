# SA-031 — List item checkbox styled like the composer field
Status: READY
Priority: P2
Tier: L
Risk: LOW
Milestone: M3
Depends: -
Owner:
Areas: `lib/core/theme/app_theme.dart`, `lib/features/lists/list_detail_screen.dart`, `test/features/lists/**`
Domains: UI and product

## Objective
User: "aylik rapor alinabilmeli... yillk, aylik ve haftalik harcama... urun yillik, aylik haftalik harcama... guzel anlasilir grafikler... haftalik aylik ve alisveris limitleri... border stili... liste ögesindeki kare tik alanina da uygula... birden cok tema... spash ekrani temaya uyumlu... ikon isim slogan... nshoptor yazi marka stili her yerde ayni olsun." (2026-10-16)

## Steps
1. Theme checkboxTheme: rounded 6 px square, 1.5 px outline border like the input border, primary fill when checked.
2. Wrap the list item checkbox in the same rounded filled container as the composer field.

## Acceptance
- [ ] [visual] List item checkbox matches the composer border style in light and dark.
- [ ] [machine] `flutter test test/features/lists` exits 0.

## Verify
- `flutter test test/features/lists`
- `flutter analyze`

## Escalate if
- A choice changes stored data formats or billing.

## External

## Evidence

## Review

## Notes
- ready by claude-opus-5-5: risk class, data contract (SettingsStore keys, no schema change) and steps confirmed.
