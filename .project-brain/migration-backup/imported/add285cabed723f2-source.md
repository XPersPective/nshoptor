# SA-037 — Restore visible Other Apps navigation
Status: REVIEW
Priority: P1
Tier: M
Risk: MEDIUM
Milestone: M3
Depends: -
Owner: gpt-6.1-sol
Areas: `lib/features/home/home_screen.dart`, `lib/features/lists/lists_screen.dart`, `test/features/home/home_screen_test.dart`, `test/a11y/accessibility_test.dart`
Domains: Navigation and list UI

## Objective
User: "diger uygulamar kismi yok. nappkit template te de vardi." Restore the visible “Diğer uygulamalar” destination supplied by napp_core; it must not be hidden inside the list tools menu.

## Steps
1. In `lib/features/home/home_screen.dart`, make `OtherAppsPage` the third `IndexedStack` page and add the localized Discover navigation destination between History and Settings; increment the settings-visit counter only for its new index.
2. In `lib/features/home/home_screen.dart`, retain the no-identity Discover placeholder for test seams and remove the route-push helper now superseded by the tab.
3. In `lib/features/lists/lists_screen.dart`, remove the Discover callback, menu entry and enum case so the one visible navigation target is not duplicated in the secondary tools menu.
4. In `test/features/home/home_screen_test.dart` and `test/a11y/accessibility_test.dart`, assert the four destinations and the visible Discover label, then pump the no-identity tab and assert its placeholder is reachable.

## Acceptance
- [x] [machine] `flutter test test/features/home/home_screen_test.dart test/a11y/accessibility_test.dart` exits 0 and asserts four bottom destinations plus a tappable Discover destination.
- [x] [interaction] On the normal app journey, tapping “Keşfet” takes the user to the Other Apps page without opening the list tools menu; with no identity, the safe placeholder is shown.
- [x] [accessibility] At 320dp-wide test surface, the localized four-destination navigation remains exposed by Material `NavigationBar` semantics and no overflow exception occurs.

## Verify
- `flutter test test/features/home/home_screen_test.dart test/a11y/accessibility_test.dart`
- `flutter analyze`

## Escalate if
- The requested destination needs a new apps feed, a new external URL, or a different placement than the existing template’s bottom navigation.

## External

## Evidence
- [machine] check `flutter test test/features/home/home_screen_test.dart test/a11y/accessibility_test.dart` | PASS | exit=0 | 32.375s | by=gpt-6.1-sol | digest=593eb88c708c70e1 | contract=6a80791322aa8631 | log=runs/SA-037-20261016T225027Z-1.log@9ab6cb5dc34f453a
- [machine] check `flutter analyze` | PASS | exit=0 | 24.687s | by=gpt-6.1-sol | digest=593eb88c708c70e1 | contract=6a80791322aa8631 | log=runs/SA-037-20261016T225100Z-2.log@17a9437a884c01ed
- [interaction] Launch app -> tap Keşfet -> selected navigation index is 2 -> list page is absent; test passes. | criterion=1e371e | by=gpt-6.1-sol | digest=593eb88c708c70e1 | contract=6a80791322aa8631
- [accessibility] 320dp surface -> Material NavigationBar exposes four destinations -> no overflow exception; test passes. | criterion=1df9de | by=gpt-6.1-sol | digest=593eb88c708c70e1 | contract=6a80791322aa8631

## Review

## Notes
- ready by gpt-5: existing `AppIdentity.otherAppsUrl`, `OtherAppsPage`, repository and localization key are already wired; this only restores their visible navigation placement without data or external-contract changes.
- start by gpt-6.1-sol | risk=MEDIUM | contract=6a80791322aa8631
