# SA-028 — Translations of new strings in all 71 locales
Status: PLANNED
Priority: P1
Tier: M
Risk: LOW
Milestone: M3
Depends: -
Owner:
Areas: `lib/core/l10n/app_*.arb`, `test/core/l10n/**`
Domains: UI and product

## Objective
User: "bütün dillerde" — every new string from SA-022..SA-027 exists in all 71 ARB files with a real translation, not English.

## Steps
1. After SA-022, SA-025 and SA-026 add keys, list the new keys.
2. Write each key in every ARB file; an English placeholder is not allowed.
3. Run flutter gen-l10n and the locale key alignment test.

## Acceptance
- [ ] [machine] flutter test test/core/l10n exits 0 (all keys aligned).
- [ ] [artifact] Reviewer spot-checks 5 locales for each new key.

## Verify
- `flutter test test/core/l10n`
- `flutter gen-l10n`

## Escalate if
- Machine translation alone is not language quality (release.md); a reviewer checks.

## External

## Evidence

## Review

## Notes
- Created 2026-10-16 from the user request list (remove lifetime, upgrade proration, price parsing, long-press help, first-run guide, splash, all-locale translations).
