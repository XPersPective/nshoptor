<!-- project-brain -->
## Project Brain
This project keeps its state in `.project-brain/` (current architecture, target, open tasks).
Before any work, load the `project-brain` skill and run its boot step; follow it for all work here.

## User workflow correction — 2026-10-26

Store Automation was removed. Do not install, run, or adopt its cached or backup copies.
Use Project Brain for development and the installed Release Harbor skill for authorized store publishing:
`C:/Users/rubicon/.skills-manager/skills/release-harbor/SKILL.md`.
Project Forge is a separate new-project startup protocol, not a publishing tool.
Preserve the user's existing full-access and publishing authorization; do not request it again.
Do not start CLI Agent Pool. Native agents must use the current permission profile and must not request extra approvals.
Finish the Android and iOS app, receipt/invoice correctness, and remaining app tasks before website work.

## Android emulator

Use only the shared AVD `Medium_Phone_API_36.0`. Do not create, duplicate, rename, or use a temporary project AVD.
If the shared emulator is being used by another session, leave it untouched and continue independent work.
Keep builds and emulator startup separate; do not confuse host memory pressure or emulator ANRs with app correctness.
