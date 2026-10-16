# SA-018 — Build dir conflict for verification
Status: PLANNED
Priority: P3
Tier: M
Risk: LOW
Milestone: M4
Depends: -
Owner:
Areas: `.store-automation/current.md`, `.store-automation/config.json`
Domains: Runtime

## Objective
current.md Known Unknowns: a global Flutter `build-dir=build-sa010-check` conflicts with `android/build.gradle.kts` outputs under `build`; verification temporarily uses `build`. Pick one reproducible verification command without changing the global Flutter config.

## Steps
1. Run `flutter config` (read only) and read `android/build.gradle.kts`.
2. Choose one per-run approach that keeps `build/` as the Android output, and write the exact command in current.md Runtime.
3. Update the Known Unknowns entry to state the chosen approach and what it replaces.
4. Do not delete the untracked `build-sa*` directories; they are the user's to remove. Record them in Notes.

## Acceptance
- [ ] [machine] `flutter test` exits 0 with the documented approach.
- [ ] [artifact] current.md Runtime holds the command, and the Known Unknowns entry matches what was run (reviewer reads).

## Verify
- `flutter test`
- `flutter analyze`

## Escalate if
- A global Flutter or Gradle setting must change: ask the user first.

## External

## Evidence

## Review

## Notes
- Created from plan audit 2026-10-16.
- Untracked, not deleted: `--help/`, `build-sa001-check/`, `build-sa010-check/`, `build-sa022-check4/`, `build-sa022-check5/`.
