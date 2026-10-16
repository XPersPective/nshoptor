# SA-022 — Remove lifetime plan everywhere
Status: PLANNED
Priority: P1
Tier: M
Risk: MEDIUM
Milestone: M2
Depends: -
Owner:
Areas: `lib/features/subscription/**`, `lib/features/settings/settings_screen.dart`, `lib/features/home/home_screen.dart`, `lib/core/l10n/app_*.arb`, `test/features/subscription/**`, `test/features/settings/**`
Domains: UI and product

## Objective
User: "Ömür boyu diye bir şey yok... Max planı var sadece. Max, Pro ve ücretsiz." Remove the lifetime purchase concept from code, paywall, settings, home and every locale.

## Steps
1. grep -rn "ifetime" lib test: list every use (plan_lifetime button key, onLifetime callbacks, lifetime_only_adapter.dart, planLifetimeTitle, planLifetimeSubtitle).
2. Remove the lifetime button and onLifetime parameters from subscription_paywall.dart, settings_screen.dart and home_screen.dart.
3. Delete lib/features/subscription/lifetime_only_adapter.dart if no other file uses it.
4. Remove planLifetimeTitle and planLifetimeSubtitle from all lib/core/l10n/app_*.arb, then run flutter gen-l10n.
5. Update tests that expect the lifetime button; keep the Free, Pro and Max cards.

## Acceptance
- [ ] [machine] `flutter test test/features/subscription test/features/settings test/features/home` exits 0.
- [ ] [machine] grep for planLifetime, hasLifetimePurchase and onLifetime in lib finds nothing.
- [ ] [visual] Paywall at 412dp shows only the Free, Pro and Max cards.

## Verify
- `flutter test test/features/subscription`
- `flutter test test/features/settings`
- `flutter analyze`

## Escalate if
- napp_pro may still expose a lifetime API; the app stops using it. The 24h ad-reward temporary Pro stays.

## External

## Evidence

## Review

## Notes
- Created 2026-10-16 from the user request list (remove lifetime, upgrade proration, price parsing, long-press help, first-run guide, splash, all-locale translations).
