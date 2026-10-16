# SA-024 — Price parsing: trailing price is estimate; AI prompt rewrite
Status: PLANNED
Priority: P1
Tier: H
Risk: HIGH
Milestone: M2
Depends: -
Owner:
Areas: `lib/features/voice_input/parser/voice_command_parser.dart`, `lib/features/voice_input/ai_list_parser.dart`, `server/src/tasks.js`, `test/features/voice_input/**`, `server/test/**`
Domains: UI and product

## Objective
User: "1 kilo domates 20 TL... 20'yi tahmine eklemesi gerekiyor... yapay zekanın farklı ürün olduğunu algılaması... sağlam bir prompt." A trailing price goes to the estimate, never into the name; the AI prompt separates items reliably.

## Steps
1. voice_command_parser.dart: add a trailing price rule: number followed by lira, tl, euro or dolar at the end of an item -> unitPrice = number, isUnitPrice false (line estimate), currencyCode set; remove those tokens from the name.
2. Tests: "1 kilo domates 20 TL" -> name domates, quantity 1 kilogram, unitPrice 20, isUnitPrice false; "elma 20 lira 2 ekmek" -> two items, first with price 20.
3. Rewrite the parse_list system prompt in server/src/tasks.js: split items at number+name boundaries; a price after an item is an estimate and never part of the name; unit defaults to piece; examples for "1 kilo elma 1 ekmek", "1 kilo domates 20 TL" and "elma kilosu 40 lira".
4. Server test: prompt contains the three example rules; npm --prefix server test passes.
5. Do not deploy the Worker inside this task; deploy is a separate approved step.

## Acceptance
- [ ] [machine] flutter test test/features/voice_input exits 0 with the new price tests.
- [ ] [machine] npm --prefix server test exits 0.
- [ ] [artifact] The prompt text contains the three examples (reviewer reads).

## Verify
- `flutter test test/features/voice_input`
- `npm --prefix server test`
- `flutter analyze`

## Escalate if
- The prompt change goes live only after a Worker deploy (user approval).

## External

## Evidence

## Review

## Notes
- Created 2026-10-16 from the user request list (remove lifetime, upgrade proration, price parsing, long-press help, first-run guide, splash, all-locale translations).
