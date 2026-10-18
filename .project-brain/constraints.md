# Constraints

- C-001: Existing fixed-point/decimal monetary and quantity core stays; do not introduce double arithmetic (source: legacy ADR-001/constraints)
- C-002: SQLite/Drift schema changes require versioned migration and transaction safety (source: legacy C-011)
- C-003: Offline-first, no account/cloud sync, and existing Android-first release setup remain (source: legacy C-002/C-030/C-033)
- C-004: Voice/OCR candidates never mutate data before user approval; native voice remains device-local (source: legacy C-003/C-005/ADR-006)
- C-005: Existing localization remains ARB/gen-l10n with all locale keys aligned (source: legacy ADR-003)
- C-006: Minimize code/dependencies and reuse existing repositories/controllers (source: user AGENTS.md)

- C-007: Brand icon, NShoptor, slogan and Pro accent stay green regardless of palette (user 2026-10-18).
- C-008: Actual market price presence, including explicit zero, determines purchased state; estimate alone does not (user attachment 2026-10-18).
- C-009: Do not use Astra. Discover installed external CLI agents first; Luna is authorized for discovery only. Implementation/review routes need actual user model selection (user 2026-10-18).
- C-010: Report only verified completion; preserve open checks and offer reopening completed shopping lists (user 2026-10-18).
- C-011: Keep existing user's untracked build/metadata outputs; no global Flutter configuration changes (source: takeover and legacy SA-018).
