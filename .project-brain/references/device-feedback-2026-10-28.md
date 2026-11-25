# Device test feedback — Android 1.3.1+22 (user, 2026-10-28)

User directive: "bütün dediklerimi anla, maddeleştir, önce Project Brain'e enjekte et, yol haritası oluştur;
senden sonraki yapay zeka devralabilsin ve bütün hepsini bitirmeni istiyorum." Each item is binding unless
marked OPEN. Tasks PB-187..PB-201 implement them; ROADMAP at the end.

## A. Pro
- F01 After buying Pro, the Pro presentation must apply immediately: the linear progress indicator stays
  instead of the circular (Pro) one — Pro state does not refresh the UI.
- F02 The "Pro" badge touches the screen edge (lists app bar and Settings). Give it professional padding.

## B. Capture experience (receipts and labels)
- F03 No separate "camera or gallery?" chooser: the camera opens directly and offers picking from photos
  right there (gallery button beside the shutter / thumbnail), or one combined entry. Selection must be visible.
- F04 Shelf label: show the captured photo and the read result once and require confirmation before the
  price is applied (now it is applied directly).
- F05 Before the first receipt photo, a short tip: start at the very top; store name and date must be visible;
  capture as many items as fit; the rest goes in the next photo. "Don't show again"; re-enable in Settings
  ("Show capture tips").
- F06 Before a continuation photo, a short tip: same receipt; include the last item of the previous photo.
- F07 Fast multi-photo capture: after a partial photo the app immediately offers "Photograph the rest"
  (camera, with gallery option) and "New receipt"; the user shoots part 1, part 2, next receipt… without
  waiting for the AI after each photo ("pat pat").
- F08 AI reading runs in the background; the user can leave the screen/app; a local notification arrives when
  done; tapping it opens the list (and offers continuing if the receipt is incomplete).
- F09 Reading is too slow: minimise latency (fast vision model, smaller images, parallel photos).
- F10 Messages are too long/many: one short sentence per situation, localized.

## C. Receipt → list workflow
- F11 "Create list from receipt": the first photo must contain the header (store + date). If the header cannot
  be read, nothing is saved and the user is told to photograph from the top.
- F12 As soon as the header is read, the list is created (even if only part of the items was read) and the
  receipt is stored in that list as INCOMPLETE until its total is read.
- F13 Incomplete receipts belong to their list. No global "Continue receipt" banner/dialog outside lists
  (anonymous, multiplies). Inside a list: a "Receipts" section listing each receipt (store, date/time, total,
  state colour: complete / incomplete / failed); tapping an incomplete one continues it. "Scan receipt" inside a
  list offers "Continue <store, date>" for incomplete receipts and "New receipt".
- F14 One list may hold several receipts (different stores the same day).
- F15 Cancelled or failed captures leave nothing behind (no stray drafts). Receipts can be deleted; after deleting,
  the same receipt can be imported again (duplicate detection must allow it).
- F16 A partial reading imports what it could and keeps asking for the rest until the total is read.
- F17 Review: per-item "accept/ignore" is confusing; items are accepted by default, user only removes wrong ones.
- F18 Receipt items must not show "actual vs planned quantity" wording (a receipt has no plan intent); show
  quantity × unit price = line total.
- F19 Show the receipt date/time in the list when printed.
- F20 Bug: after importing a second receipt, the earlier receipt was not visible and sample items (e.g. onion)
  appeared in the list — investigate (demo data leaking / wrong list target).
- F21 OPEN (nice to have): AI fills category and brand for receipt items.

## D. Item editing and numbers
- F22 Tapping an item to edit price focuses the empty price field (home or market); if both are filled, focus the
  market price.
- F23 Price display/input with comma vs dot is confusing ("130,00 — 130 billion?"): follow the device format
  locale consistently, show grouping and decimals clearly.

## E. Voice / text lists
- F24 Parsing is correct but slow: use the fastest capable text model for list parsing (not the vision model).

## F. Layout
- F25 List detail: the big search bar at the top is bad. Totals block (home / market / difference) gets a title
  ("Totals"); the product list gets a title ("Products") with the sort control (A–Z / manual, short labels) at the
  right end of that title row (left in RTL); search sits with the product list.
- F26 Lists home: remove the show/hide-search toggle; search stays under the Lists/Completed/Archive tabs; sort
  control goes at the end of the tabs row; "Discover" moves into the app bar next to Pro with proper spacing;
  app bar row slightly higher, aligned.
- F27 Sorting must not disable search; both work together.

## G. Reports, history, export
- F28 Export = one Share action with a small menu: PDF or CSV via the system share sheet (WhatsApp etc.) and
  Print. No print-only "PDF" button.
- F29 Store naming: no duplicate "ŞOK MARKETLER TİC. A.Ş." + "ŞOK market"; one clean store name; a shopping trip
  can contain several stores.
- F30 Report views for day / week / month: by shopping (each list separately and all together), by store, by
  product; tabs/swipe; each view exportable/shareable separately or all at once.
- F31 Charts show values (Y-axis labels or value labels on bars); per-product charts by day/week/month; daily chart
  per shopping.
- F32 Date-range selection easy and visible (not buried).
- F33 Monthly and weekly budget planning more prominent; budget and planned-shopping reminders as free local
  notifications.

## H. Settings, theme, typography
- F34 Settings header: remove the small duplicate "NShoptor" title/icon at the top; keep the large icon + name.
  "Settings" title slightly larger. One consistent type hierarchy across the app.
- F35 Remove redundant captions above dropdowns that already show the value (Language, Number & currency, Theme).
- F36 Default theme is the brand dark green (premium black + green), not pure black.
- F37 "Keep screen on in shopping mode" is unclear: explain briefly or make it an in-shopping toggle.
- F38 Settings toggle "Show capture tips" (F05/F06).
- F39 OPEN: CSV export Pro-only? (user: "bakarız") — keep free until decided.

## I. Onboarding and splash
- F40 Interactive guided tour ("How to use"): help button near Pro/Discover; step-by-step coach marks on the real
  UI (e.g. create list from receipt), visually polished; first launch and on demand.
- F41 Splash: icon + "NShoptor" + slogan "Evdeki hesap çarşıya uyar" localized for every language; no black
  screen at start (native splash on Android and iOS).

## ROADMAP (order of work)
1. PB-191 receipt→list workflow (F11–F16, F19, F20) + PB-190 background/fast capture (F07–F09) — core value.
2. PB-188 capture UX tips/messages (F03, F05, F06, F10, F38) + PB-189 label confirmation (F04).
3. PB-192 review simplification (F17, F18, F21) + PB-193 editing/numbers (F22, F23) + PB-194 fast text model (F24).
4. PB-187 Pro refresh/badge (F01, F02) + PB-195/196 layouts (F25–F27).
5. PB-197 share/export (F28) + PB-198 reports (F29–F32) + PB-199 budget/notifications (F33).
6. PB-200 settings/theme/typography (F34–F37) + PB-201 tour/splash (F40, F41).
7. Full test suite, signed 1.3.1+23, Android internal test.
