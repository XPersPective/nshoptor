# Apple subscription verification (local implementation)

This path is implemented and locally tested. It has **not** been deployed or
verified with real App Store credentials or transactions and is not release-ready.

`POST /v1/ai` accepts `appleTransaction`, the complete StoreKit 2 signed transaction
JWS (at most 8192 characters). A transaction ID, decoded JWT, or legacy receipt is
insufficient. Sending both `appleTransaction` and `purchaseToken` returns 400.
The existing 16 KiB request body cap still applies. Play-only requests retain their
existing verification path.

The server requires `APPLE_BUNDLE_ID`, `APPLE_APP_ID` (numeric App Store app ID),
`APPLE_KEY_ID`, `APPLE_ISSUER_ID`, and `APPLE_PRIVATE_KEY` (In-App Purchase API P8
key text). These are configuration names only; this change does not set or read
live secrets. Production is the default. A separate sandbox server must explicitly
set **both** `APPLE_ENVIRONMENT=Sandbox` and `APPLE_ALLOW_SANDBOX=1`. Request fields
cannot select environment, trust roots, or disable online verification. Xcode and
LocalTesting environments are rejected.

Apple's official `SignedDataVerifier` verifies the certificate chain, signature,
bundle, environment, certificate validity and online certificate revocation. The
G2/G3 public Apple roots are embedded in `src/apple_roots.js` with source URL and
SHA-256 fingerprints. Root rotation requires a reviewed source update.

Every accepted proof then triggers the authenticated Get All Subscription
Statuses API for its verified `originalTransactionId`. Response app identity and
environment must match. The current transaction JWS must verify and share the same
original ID. Only the four exact product IDs `nshoptor_pro`, `nshoptor_max`,
`nshoptor_pro_v2`, `nshoptor_max_v2` are allowed; their real App Store catalog
availability has not been established. Status 1 requires a future transaction
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
- [Apple public root certificates](https://www.apple.com/certificateauthority/)
- [Get All Subscription Statuses](https://developer.apple.com/documentation/appstoreserverapi/get-all-subscription-statuses)
- [Cloudflare Node crypto compatibility](https://developers.cloudflare.com/workers/runtime-apis/nodejs/crypto/)
