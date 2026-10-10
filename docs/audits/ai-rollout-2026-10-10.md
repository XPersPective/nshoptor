# AI/catalog rollout — 10 October2026

## Observed live state

- Worker deployment9f2fa4d4-fd5c-451a-9daa-4d6b624b405d succeeded at nshoptor-api.devx8585.workers.dev. Source bundle19.24KiB, startup1ms; dry-run succeeded first.
- Provider endpoint/model/secret unchanged: current Qwen Token Plan qwen3.6-flash, thinking disabled. New-policy quota Free10/Pro100/Max300; source fixed legacy200/1000. Global20000/day remains an operational ceiling, not a cash budget.
- Live health200. `python -B tool/ai_rollout_check.py`: two parallel synthetic milk parse requests at owned counter9 yielded AI200 and quota429, both used10/limit10/free; remote D1 count10. Test content/output not logged. Owned QA rows deleted, billed global increment retained. No user/global row reset; no real subscription purchase.
- Initial health probe Python default agent was blocked by Cloudflare1010; native Dart and identified NShoptor health agents returned200. Wrangler --file emitted import output despite --json; now --command returns parsed JSON. The earlier owned inserted row was identified by its logged last_row_id6 and count9/month, then only that row deleted. Current checker persists its owned ID before mutation and deletes in finally, retaining state if cleanup fails.
- `ruby tool/play/subscriptions.rb --verify-v2`: exact new benefits/USD prices, all new bases ACTIVE, Pro trial ACTIVE and scope anySubscriptionInApp. Legacy public metadata/base price snapshot equals previous capture byte-value-for-value after parsed comparison. New capture: play-prices-rollout-2026-10-10.json. Existing products/benefits/prices not modified.

|New SKU|Monthly USD/TRY|Annual USD/TRY|Monthly AI|
|---|---|---|---:|
|nshoptor_pro_v2|1.99 /119.99|19.99 /1179.99|100|
|nshoptor_max_v2|3.99 /234.99|39.99 /2369.99|300|

TRY prices are native Play regional conversion outputs, not a financial FX assumption. Pro monthly new-customer7day trial excludes prior app subscriptions; Max has no trial. Existing legacy Pro200/Max1000 and lifetime remain recognized. Prices queried by installed SDK; no hardcoded in-app currency amounts.

## Verification

- Ruby syntax, reviewed --preview-v2, actual --create-v2 and read-only --verify-v2 passed.
- npm test --prefix server:25 passed, real SQLite user/global atomic last-slot/rollback, cancel-state, replacement lineage and generic failure regressions.
- Flutter full suite369 passed; analyze no issues. New client source support previously verified; native release/runtime QA is PB-069 and internal AAB publication PB-061.
- Wrangler OAuth stayed in encrypted OS credential storage; no secret logged or copied. npm ci unavailable without a lockfile; installed already-declared Wrangler via npm install --no-package-lock, no manifest/dependency change. No schema change.

## Financial limits

DeepSeek-V4.1-Flash is the planning comparator by latest user request; it was not deployed as provider. Current Qwen account invoice/average credits unknown. ai-economics.md reports typical/full-output/annual/free-subsidy scenarios and stress losses. A trial converting in the same month shares the same canonical monthly quota, not an extra paid quota. Non-converting trial users can consume100 calls each and are acquisition expense beyond the10-call free-user assumption; no guaranteed net-profit claim. Actual token/credit mix, trial conversion, refunds and Play payouts must be measured before treating contribution scenarios as operating profit.

## Reproduce

```powershell
ruby tool/play/subscriptions.rb --verify-v2
ruby tool/play/subscriptions.rb --prices-json
npm test --prefix server
python -B tool/ai_rollout_check.py
```

Checker performs one billed synthetic AI attempt and deletes only its own random-install counter. Do not repeatedly run it without new verification need. Do not saturate live global usage for a boundary test: the Node SQLite tests prove that boundary.
