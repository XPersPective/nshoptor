# Apple subscription verification

The server implementation and its Apple configuration were deployed on
2026-10-26. Worker version `fd6afe87-b2cc-4ee2-b567-e0fd3131c61d` was read back
at 100% traffic. All seven required/configuration secret names were confirmed;
values remain encrypted outside this repository. Health, malformed-proof rejection,
unchanged usage counters and preservation of the existing trial deadline were
checked. The 66 server tests and official-verifier workerd fixtures pass.

This does **not** establish a successful paid entitlement. Real StoreKit purchase,
restore, renewal/grace, refund and online Apple verification remain acceptance
checks. A credential probe received Sandbox API validation and Production HTTP
401; Production account/API access still needs verification. Private release
receipts in the existing AppPublishing registry retain the deployment and probes.

`POST /v1/ai` accepts `appleTransaction`, the complete StoreKit 2 signed transaction
JWS (at most 8192 characters). A transaction ID, decoded JWT, or legacy receipt is
insufficient. Sending both `appleTransaction` and `purchaseToken` returns 400.
The existing 16 KiB request body cap still applies. Play-only requests retain their
existing verification path.

The server requires `APPLE_BUNDLE_ID`, `APPLE_APP_ID` (numeric App Store app ID),
`APPLE_KEY_ID`, `APPLE_ISSUER_ID`, and `APPLE_PRIVATE_KEY` (In-App Purchase API P8
key text). These are configuration names only; no secret values belong in source.
Production is the default and rejects Sandbox unless explicitly opted in. On the same endpoint,
`APPLE_ALLOW_SANDBOX=1` permits Production followed by Sandbox **full verification**
if Production verification fails; `APPLE_ENVIRONMENT` remains `Production` (or unset).
This supports TestFlight and App Review purchases, which use Apple's Sandbox.
A Sandbox-only server must still explicitly set **both**
`APPLE_ENVIRONMENT=Sandbox` and `APPLE_ALLOW_SANDBOX=1` and rejects Production.
Any other environment or opt-in value does not enable Sandbox. Request fields
cannot select environment, trust roots, or disable online verification. Xcode and
LocalTesting environments are rejected.

Apple's official `SignedDataVerifier` verifies the certificate chain, signature,
bundle, environment, certificate validity and online certificate revocation. The
G2/G3 public Apple roots are embedded in `src/apple_roots.js` with source URL and
SHA-256 fingerprints. Root rotation requires a reviewed source update.

Every accepted proof then triggers the authenticated Get All Subscription
Statuses API for its verified `originalTransactionId`. Response app identity and
environment must match the verifier that accepted the submitted proof. Production
requires the exact configured numeric `appAppleId` in the status response. Following
Apple's optional `StatusResponse.appAppleId` schema and Sandbox verifier behavior,
verified Sandbox may omit that field; any present value must exactly match the
configured numeric ID (null, strings and wrong IDs are rejected). The configured
app ID remains mandatory in both environments. Bundle/environment and all signed
transaction/renewal checks are unchanged. That
verified environment fixes the API hostname, current transaction and renewal
verifier, and quota namespace. An API/status failure never retries another host;
no decoded client claims select permission, trust or routing. The current
transaction JWS must verify and share the same
original ID. Only the four exact product IDs `nshoptor_pro`, `nshoptor_max`,
`nshoptor_pro_v2`, `nshoptor_max_v2` are allowed; their real App Store catalog
availability must be verified against the live catalog. The new annual offering
uses only `nshoptor_pro_v2`; the other IDs preserve existing ownership verification
and do not authorize creating new monthly, Max or lifetime sales. Status 1 requires a future transaction
expiry. Status 4 requires a separately verified renewal JWS with the same original
ID and product and a future `gracePeriodExpiresDate`; it may have an expired paid
transaction. Revoked and upgraded transactions never grant access. The quota
identity is `apple:` plus SHA-256 of environment, bundle and original ID, so renewal
transaction IDs and installation IDs cannot manufacture fresh paid buckets.

Missing configuration, malformed/unverifiable proof, certificate checks, API
outages, missing lineage and inconsistent status return generic 503 **before quota
reservation**. Definitively inactive, expired, revoked, or unsupported purchases
return free entitlement; normal trial/free policy then applies. No Apple status
cache is used. Refund freshness therefore follows Apple's status API propagation
on each request; there is still no notification receiver, refund-history polling,
or independent guarantee of immediate revocation propagation. The JWS is bearer
evidence; this does not establish a separate signed-in app account or prevent
sharing a leaked proof. Such sharing uses the same canonical quota bucket.

Sandbox opt-in is an explicit server operator decision: team TestFlight and
Sandbox test accounts can create test purchases without a real payment and may
consume AI allowance. Environment/bundle/original-ID identity prevents renewals or
reinstalls of one purchase from creating new paid buckets; Production and Sandbox
remain separate namespaces. The existing global AI cap also applies. These controls
do not prevent a tester from creating multiple Sandbox purchase lineages/accounts
or prove a real charge, and are not a complete abuse defense. Keep the flag enabled
only while accepting this tester/review access policy. Android and free/trial quota
rules are unchanged.

The Apple library is imported inside the request: its jsrsasign dependency seeds
randomness at import time, which Workers forbids at module initialization. The
current `2026-10-01` compatibility date enables Node compatibility by default;
the existing Wrangler configuration is unchanged. Local workerd testing executes
the actual official verifier, X509/Node crypto and jsrsasign with an ephemeral test
CA, checks a valid transaction and grace renewal, and rejects an altered signature.
The harness pins Miniflare 5.20261006.1-alpha, the exact runtime bundled by stable
Wrangler 4.149.0, to exercise the actual October date and automatic Node support.
The older latest-stable Miniflare requires an older compatibility date and adds a
known-vulnerable Sharp dependency tree, so it is not added separately.
Test roots and disabled OCSP enter only direct test function options in an isolated
test worker, never production HTTP or environment configuration. Live Apple OCSP
and authenticated status calls remain untested without credentials.

Validation commands:

```
npm ci
npm test
npm run test:apple-runtime
npx wrangler deploy --dry-run --outdir .apple-dry-run
```

The final command only bundles locally; it does not deploy. Evidence is in
`.takeover-apple-*.log` in this directory. Production dependency audit is clean;
the pinned development Worker tools currently report Undici advisories and need
separate maintenance before treating the full toolchain as audited.

Primary references:

- [Apple official Node library](https://github.com/apple/app-store-server-library-node)
- [Apple status response schema](https://github.com/apple/app-store-server-library-node/blob/main/models/StatusResponse.ts)
- [Apple public root certificates](https://www.apple.com/certificateauthority/)
- [Get All Subscription Statuses](https://developer.apple.com/documentation/appstoreserverapi/get-all-subscription-statuses)
- [Apple Sandbox testing and TestFlight](https://developer.apple.com/documentation/storekit/testing-in-app-purchases-with-sandbox)
- [Configure in-app purchases for App Review](https://developer.apple.com/help/app-review/before-submitting-for-review/configure-in-app-purchases)
- [Cloudflare Node crypto compatibility](https://developers.cloudflare.com/workers/runtime-apis/nodejs/crypto/)
