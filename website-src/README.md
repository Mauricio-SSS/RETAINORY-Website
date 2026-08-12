# retainory.com — marketing + legal site

Static HTML and CSS. **No JavaScript** — see "The landing page" below for why that
constraint is load bearing rather than incidental. Deployed to **Cloudflare Pages**;
the domain is registered through **Cloudflare Registrar**.

**This file lives in `website-src/`, not in `website/`, and has to stay here.** Pages
serves everything in the output directory except paths beginning with `_`, so a README
sitting in `website/` is published — and this one carries unannounced pricing, a known
font-licensing gap, and notes on what the privacy policy is load bearing for. None of
that belongs at `retainory.com/README.md`. The same reasoning is why the parked pricing
table in `index.html.tpl` uses the build-stripped `<!--@ … @-->` comment form: an
ordinary HTML comment ships to the browser.

## Before the next deploy

`website/index.html` links to `https://apps.apple.com/app/retainory` in **five** places.
That URL does not resolve yet. Replace every occurrence with the real App Store listing
before this goes live, or the primary CTA is a dead link. The same placeholder is in
`privacy.html`, `terms.html`, and `support.html` (once each, in the header).

## Files

Deployed (`website/`, the Pages output directory):

| Path                    | What it is                                             |
| ----------------------- | ------------------------------------------------------ |
| `index.html`            | The landing page. **Generated** — see below.           |
| `landing.css`           | Landing-page styles. **Generated** — see below.        |
| `style.css`             | Shared shell: tokens, type, nav, footer, prose.        |
| `img/`                  | Product screenshots. **Generated** — see below.        |
| `fonts/`                | Sora subset (Bold + Light), self-hosted, ~7.4 KB each. |
| `privacy/terms/support` | Hand-written. Legal + support copy.                    |
| `_headers`              | Security headers. Read at deploy time, never served.   |

Source (`website-src/`, never deployed):

| Path                | What it is                                              |
| ------------------- | ------------------------------------------------------- |
| `*.tpl`             | The templates. Edit these, never the generated output.   |
| `gen_geometry.py`   | Computes the spine geometry from the app's FSRS model.   |
| `build.py`          | Substitutes geometry into the templates.                 |
| `make_shots.py`     | Crops `captures/` into `website/img/`.                   |
| `captures/`         | The uncropped app captures. The one un-regenerable input.|

Regenerate the font subsets from the TTFs the app already bundles:

```bash
python3 -m fontTools.subset Retainory/Backend/Fonts/Sora-Bold.ttf --unicodes="U+0020-007E,U+00A0,U+00A9,U+00B7,U+2010-2015,U+2018-201D,U+2022,U+2026,U+2192,U+2713,U+00D7" --layout-features="kern,liga,calt" --no-hinting --output-file=/tmp/sora.ttf && woff2_compress /tmp/sora.ttf
```

Sora ships under the SIL Open Font License, which requires the licence text to travel
with the font files. **There is no `OFL.txt` anywhere in this repo** — neither beside
the app's TTFs nor here. Drop the copy from the Sora distribution into `fonts/` (and
alongside `Retainory/Backend/Fonts/`) to be compliant.

## The landing page

The page is built around one device: a single line runs the length of the narrative
column. Its **vertical** position is time; its **horizontal** position inside a fixed
250px corridor is the probability you can still recall the material, on a labelled
50–100% axis. It falls through the first section, is caught by timed reviews in the
second, holds through the third and fourth, and leaves the corridor at "Set the Curve"
to become the tail of the distribution. After that the page drops the device and
becomes plain documentation.

**The curves are the app's own model, not drawings of it.** Every path is computed
from the FSRS-6 retrievability function ported verbatim from
`Retainory/Backend/RetainoryCore.swift:632`, at the default `w20 = 0.1542` from
`FSRSWeights.swift`. If those change in the app, regenerate rather than leaving the
site asserting a curve the product no longer produces.

### Regenerating

`index.html` and `landing.css` are **build outputs — do not hand-edit them.** The
path data alone is ~7 KB of coordinates. Edit the templates in `../website-src/`
instead:

```bash
python3 website-src/gen_geometry.py && python3 website-src/build.py
```

`gen_geometry.py` computes the geometry (spine, bell curve, tail wedge, node
positions) and writes `geometry.json`; `build.py` substitutes it into the two templates. Commit
the regenerated files.

### Screenshots

`img/*.webp` are **captures of the running app**, cropped by
`../website-src/make_shots.py` (which documents the capture commands). Nothing on this
page is a recreation of product UI — an earlier draft drew the readiness gauge and a
per-topic mastery heatmap in HTML, and the heatmap in particular described a feature the
app does not have. If a panel claims to show the product, it must be a screenshot.

The uncropped source PNGs are committed in `../website-src/captures/`. They are the only
input in this whole pipeline that cannot be regenerated from code — everything else here
is computed — so a crop can be retuned later without having to reproduce the seeded app
state that produced the capture.

The crops deliberately keep the app's own background in the margins. Because `--ink` is
that same value, the cards' real rounded corners read correctly with **no border, radius
or device frame added in CSS** — the crop does the framing.

**Capture on the Signal theme.** That unframed trick only works while the capture and the
page agree on the palette, and the agreement is not automatic: release builds force
`RetainThemeID.shipping`, but a debug build honours whatever the in-app theme picker
persisted. A Classic capture lands here with an indigo primary button and a blue exam
anchor where the site promises teal and gold, which reads as two different products on
one page. The quickest tell is the exam anchor bar — gold is Signal, blue is Classic.

Two coupled things when you add or replace one:

1. The `width`/`height` attributes on the `<img>` must match the generated file. They
   reserve layout space before the image loads.
2. Section heights change, so re-measure and update **both** `gen_geometry.py` and the
   `min-height` values in `landing.css.tpl` (see the next section).

### Why no JavaScript

`_headers` ships a CSP with no `script-src`, so `default-src 'none'` blocks scripts
outright. The page's two motion moments — the line drawing itself as you scroll, and
the marker travelling into the tail — are CSS scroll-driven animations
(`animation-timeline`, `offset-path`). Both are wrapped in `@supports` and degrade to
their finished state where unsupported, and both are disabled under
`prefers-reduced-motion`. This is precisely why the geometry is pre-computed: keeping
the page scriptless is what lets the CSP stay this tight.

`font-src 'self'` was added to `_headers` for the self-hosted Sora subset. That is the
only directive that changed.

### Design tokens

Nothing on the site invents its own visual language. Colour comes from the `.signal`
palette in `Retainory/Backend/UI/RetainTheme.swift` — the theme the app actually ships
(`RetainThemeID.shipping`) — radii from the closed 6/10/12/14 scale in
`RetainColor.swift`, and type from the eight-step ladder in `Fonts/RetainFonts.swift`.
The token values are the app's literal ones, which is what lets the screenshots sit on
the page unframed: the ink behind their rounded corners is the page's own `--ink`. The house rules travel with them: neutral two-layer shadows
only (never tinted), no decorative blur, and the brand gradient appears on the
wordmark and nowhere else.

The site commits to the dark identity in both light and dark browser themes. That is a
choice, not an omission — it is the app's own ground, and a site that inverts between
pages reads as two products.

## Why these pages exist

They are not optional decoration — the app and App Store review both require them:

| Page       | Required by                                                              |
| ---------- | ------------------------------------------------------------------------ |
| `/privacy` | App Store Connect's Privacy Policy URL field, and `AppLinks.privacyURL`. |
| `/terms`   | `AppLinks.termsURL`.                                                     |
| `/support` | App Store Connect's Support URL field.                                   |

`Retainory/Backend/AppLinks.swift` hard-codes `https://retainory.com/terms` and
`https://retainory.com/privacy` as its fallbacks, so **these paths cannot change**
without also changing the app (or overriding `RETAINORY_TERMS_URL` /
`RETAINORY_PRIVACY_URL` in `Info.plist`).

Cloudflare Pages serves `terms.html` at `/terms` automatically — no config needed.

## Deploying

Cloudflare Pages → Create a project → Connect to Git → pick this repo, then:

- **Build command:** _(leave empty)_
- **Build output directory:** `website`

Every push to the branch redeploys. `_headers` is read at deploy time and applies the
security headers; it is not served as a file.

To deploy without Git:

```bash
npx wrangler pages deploy website --project-name retainory
```

## Pricing must not outrun the binary

The pricing section says **Free**, and only Free, because the shipped app has no in-app
purchase — the paywall lives in `v2-archive` and `PurchaseManager` compiles without
anything presenting it. A drafted two-tier table (Free / Premium at $4.99/mo or
$34.99/year) is parked in a comment in `index.html.tpl` directly above the live block.

Publish it only once the StoreKit products are live in App Store Connect. Until then the
site would be advertising something nobody can buy, and App Store review compares the
listing against the marketing URL. Note also that the drafted free tier is *narrower*
than what ships today, so releasing it takes capability away from existing users rather
than only adding a paid option.

## Keeping the privacy policy honest

The policy describes actual app behaviour, verified against
`Retainory/PrivacyInfo.xcprivacy`, `Retainory/Backend/JourneyTelemetry.swift`, and the
`/events` handler in `flashcard-backend/server.js`. Two claims in particular are load
bearing and will become false if the code changes:

- **"Your study data never leaves your device."** True only while nothing syncs cards,
  schedules, or review history to a server. Re-adding accounts or sync in V2 invalidates
  this section.
- **"Usage events carry only a random installation ID."** True while
  `JourneyTelemetryEvent` has no user identifier. The `userID` field was deliberately
  removed for the MVP; re-adding it changes what has to be disclosed here, in
  `PrivacyInfo.xcprivacy`, and in App Store Connect's privacy questionnaire.

The app currently has **no in-app toggle to disable usage events**, so the policy does
not claim one. If such a toggle is added, say so under "Your choices and rights".

Retention ("up to 30 days") matches Cloud Logging's default `_Default` bucket retention.
If that bucket is reconfigured, update the policy to match.
