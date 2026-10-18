# SA-015 — Ads and subscription in architecture map
Status: PLANNED
Priority: P2
Tier: M
Risk: LOW
Milestone: M3
Depends: -
Owner:
Areas: `.store-automation/current.md`, `lib/features/ads/**`, `lib/features/subscription/**`, `lib/features/settings/**`, `test/features/ads/**`, `test/features/subscription/**`, `test/features/settings/**`
Domains: Ads, subscription and settings

## Objective
SA-011 and SA-012 added ads, subscription and settings code, but `current.md` Map and Domains do not list it (audit 2026-10-16). Map the real present state. Read code only; do not edit product.md.

## Steps
1. Read the Map section of `.store-automation/current.md` (≤40 lines).
2. Add Map lines: `lib/features/ads/` — interstitial and rewarded ad policy (`ad_gate.dart`); `lib/features/subscription/` — subscription service, paywall, lifetime adapter; `lib/features/settings/` — settings screen and plan badge.
3. Add a Domains section `### Ads, subscription and settings` with `Status: OBSERVED`, `Sources:` the Areas globs above, and short bullets that describe what the code does, each traceable to a file.
4. Leave Runtime and other domains untouched.

## Acceptance
- [ ] [machine] `flutter test test/features/ads`, `flutter test test/features/subscription` and `flutter test test/features/settings` all exit 0 (proves the listed Sources exist and pass).
- [ ] [artifact] Every bullet in the new Domains section maps to a file under its Sources; reviewer confirms by reading the three source folders.

## Verify
- `flutter test test/features/ads`
- `flutter test test/features/subscription`
- `flutter test test/features/settings`

## Escalate if
- The code contradicts product.md Non-Goals or the Goal: stop and point to SA-019, do not change product.md.

## External

## Evidence

## Review

## Notes
- Created from plan audit 2026-10-16.
