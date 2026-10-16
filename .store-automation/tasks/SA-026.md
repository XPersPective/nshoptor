# SA-026 — First-run guide shown once (all locales)
Status: PLANNED
Priority: P2
Tier: M
Risk: MEDIUM
Milestone: M3
Depends: -
Owner:
Areas: `lib/features/onboarding/**` (new), `lib/features/home/home_screen.dart`, `lib/features/settings/settings_repository.dart`, `lib/core/l10n/app_*.arb`, `test/features/onboarding/**`
Domains: UI and product

## Objective
User: "Uygulama ilk açıldığında bir kere göstersin... Tamam deyip nasıl yapıldığını bir kere göstersin." A short step-by-step guide appears once on first launch, with a Tamam button per step.

## Steps
1. Add a SettingsStore flag guide.seen (default false).
2. Create lib/features/onboarding/first_run_guide.dart: 4 steps: add item (+), voice (mic), receipt (fiş tara), plan (plan simgesi). Each step has a Tamam button; the last one sets guide.seen and closes.
3. In HomeShell build, show the guide once when the flag is false (after the first frame).
4. Widget test: first pump shows the guide; after finishing, a new HomeShell does not show it.

## Acceptance
- [ ] [interaction] First launch shows the guide; second launch does not.
- [ ] [machine] flutter test test/features/onboarding exits 0.
- [ ] [visual] The guide fits 320dp and 2x text.

## Verify
- `flutter test test/features/onboarding`
- `flutter analyze`

## Escalate if
- Strings in all locales are SA-028.

## External

## Evidence

## Review

## Notes
- Created 2026-10-16 from the user request list (remove lifetime, upgrade proration, price parsing, long-press help, first-run guide, splash, all-locale translations).
