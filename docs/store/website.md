# GitHub Pages website

The buildless marketing website lives in `website/`. The real product name is
NShoptor. Turkish is the root page and English is `/en/`; both contain complete
static text and remain readable without JavaScript. The only script enhances
the illustrative market-price demo. It makes no network requests and stores no
input. There are no third-party scripts, fonts, cookies or analytics.

## Editing and local checks

1. Edit localized text and HTML in `tool/site/build_site.py`.
2. Run `python tool/site/build_site.py` and commit both generated HTML pages.
3. Run `python tool/site/check_site.py`.
4. Serve `website/` with `python -m http.server 4173 --directory website`.
5. Inspect `/` and `/en/` at narrow and desktop widths. Try an empty market
   price, `0`, `85,50`, `85.50` and invalid text. The other example purchases
   total TRY 74.50. Clearing tomatoes removes its check; 0 keeps its check.

The checker uses Python's standard library. It checks generated output freshness,
local links and anchors, both languages, canonical/hreflang, JSON-LD, sitemap,
social-image dimensions and essential accessibility hooks. Visual layout and
screen-reader behavior require browser/device review.

## Publication

`.github/workflows/pages.yml` validates and uploads only `website/`, then deploys
with GitHub Pages. It supports manual dispatch and changes on `main`. The intended
public base URL is `https://xperspective.github.io/nshoptor/`. Configure repository
Settings → Pages → Source → GitHub Actions before running it. GitHub Pages is
appropriate for this public repository without a paid hosting subscription.

Source preparation is not evidence of a live deployment. Verify the completed
Pages action and public URL after publication. If the repository, domain or
default branch changes, update the workflow and the `BASE` constant, regenerate
the HTML, and update robots/sitemap accordingly.

## Truthful availability and claims

- The Play package is `com.crazypenguin.nshoptor`. The button says to check
  availability, because a public production listing has not been verified.
- No App Store product ID was found. iOS is plain availability text, without a
  made-up link or availability promise. Add a store link only after verifying it.
- The example is expressly labeled illustrative, not a current app screenshot.
  The social card is a locally composed brand asset without stock imagery.
- The guide explains optional home prices, automatic purchase state from any
  recorded market price (including 0), review before saving AI/OCR suggestions,
  offline limits and plan-dependent exports. It promises no unverified reports,
  free AI service, perfect recognition, ratings, user counts or testimonials.
- Privacy links directly to the tracked bilingual policy in `docs/store/` so it
  does not duplicate or drift from the source. Support email is
  `devcrazypenguin@gmail.com`.

## SEO and content upkeep

Each language has its own title, description, canonical URL, reciprocal hreflang,
semantic sections, one H1, FAQ text and Open Graph metadata. The site includes
robots, a sitemap, a 1200×630 social card and truthful WebSite JSON-LD. Do not add
structured review/price/download claims until independently verified. Turkish
and English are currently the only website locales; app language coverage is
not claimed for this website. Store indexing and search ranking cannot be
guaranteed by metadata.

## Verification — 2026-10-23

- `python tool/site/check_site.py`: **141 checks passed**.
- Served both local pages with Python HTTP server: root, English page, CSS,
  JavaScript and icon returned HTTP 200 (cached assets subsequently 304).
- Chrome desktop screenshot inspected: two-column introduction and example,
  readable typography and clear branding.
- Chrome viewport override at 390×844, followed by reload: single-column
  introduction and demo inspected; English FAQ checked with readable wrapping.
- Browser interaction: TR `0` checked the item without adding to TRY 74.50;
  `85,50` checked it and updated the total to TRY 160.00; clearing reset the
  check and restored TRY 74.50. English invalid text displayed validation;
  `85.50` yielded TRY 160.00. Language navigation and expanding the offline FAQ
  worked. Screenshots were inspected in the browser tool; no screenshot files
  are retained in the repository.
- The temporary preview tab was closed, viewport override reset and owned HTTP
  server stopped. No public deployment was performed by the site implementation
  task. A live Pages readback and native screen-reader review remain separate.
