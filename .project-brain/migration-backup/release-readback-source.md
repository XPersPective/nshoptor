# SA-021 — Play release 1.2.4+11 internal and production draft
Status: PLANNED
Priority: P1
Tier: H
Risk: HIGH
Milestone: M4
Depends: -
Owner:
Areas: <`src/x/**`, `tests/x/**`>
Domains: <domain>

## Objective
<what and why, in the user's words>

## Steps
1. <exact path, symbol and change; one action per step>

## Acceptance
- [ ] [machine] <observable condition>

## Verify
- `<command>`

## Escalate if
- <change that needs a user decision>

## External
- play internal upload 1.2.7+14 | confirmed | readback: fastlane output Successfully finished the upload to Google Play (internal track, 02:08 +03)
- play production draft promote 1.2.7+14 | confirmed | readback: fastlane output Successfully finished the upload (production, draft, 02:14 +03; submit for review in Play Console)
- play internal upload 1.2.6+13 | confirmed | readback: fastlane output Successfully finished the upload to Google Play (internal track only, 22:49 +03)
- play internal upload 1.2.5+12 | confirmed | readback: fastlane output Successfully finished the upload to Google Play 17:38 (+03), internal track; production not promoted
- play internal upload 1.2.4+11 | confirmed | readback: fastlane output Successfully finished the upload 14:47 (+03); not an independent API readback
- play production draft promote 1.2.4+11 | confirmed | readback: fastlane output Successfully finished the upload 14:52 (+03), track production, status draft; submit for review is manual in Play Console

## Evidence

## Review

## Notes
- Version 1.2.4+11 built from main (AAB sha256 recorded in readback once confirmed). Previous readback 1.2.3+10 is internal+production draft. Final 'send for review' stays in Play Console (API accepts draft only).
- Ads/subscription in Play: Data safety, ads declaration and IAP products (IAP_PRO_LIFETIME) are Console-side; not verified here.
