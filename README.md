# retainory.com

The marketing and legal site for Retainory. Static HTML and CSS, **no JavaScript**,
deployed to Cloudflare Pages.

```
website/       ← the deployed site. This is the Pages output directory.
website-src/   ← templates, generators and source captures. Never deployed.
```

That split is load bearing, not tidiness. Pages serves everything in the output
directory except paths beginning with `_`, so anything that should not be public has to
live outside `website/` — which is why the engineering notes are at
[`website-src/README.md`](website-src/README.md) rather than beside the pages they
describe. **Read that file before changing anything here.**

## Do not hand-edit `website/index.html` or `website/landing.css`

They are build outputs. The landing page's path data alone is ~7 KB of coordinates,
computed from the app's own FSRS-6 retrievability function so the curves on the page are
the model rather than a drawing of it. Edit the templates in `website-src/` and run:

```bash
python3 website-src/gen_geometry.py && python3 website-src/build.py
```

`website/style.css` and the three legal pages *are* hand-written.

## Deploying

Cloudflare Pages, with:

- **Build command:** _(leave empty)_
- **Build output directory:** `website`

Every push to `main` redeploys. `_headers` is read at deploy time and applies the
security headers; it is not served as a file.

To deploy without Git:

```bash
npx wrangler pages deploy website --project-name retainory
```

## Where the rest of Retainory lives

The iOS app and the backend are in a separate private repository. Files under
`Retainory/` or `flashcard-backend/` referenced in `website-src/README.md` are there,
not here. The two are coupled in three places worth knowing about:

- The landing page's geometry is generated from the app's FSRS weights. If those change,
  regenerate rather than leaving the site asserting a curve the product no longer
  produces.
- `website/img/` are real screenshots of the app, and they only sit on the page unframed
  because the site's colour tokens are the app's literal shipped values.
- The app hard-codes `https://retainory.com/terms` and `https://retainory.com/privacy`,
  so **those two paths cannot change** without also changing the app.

## The prelaunch page

This repo previously held the "Something new is coming August 4" waitlist page. It is
preserved at the `prelaunch` tag:

```bash
git show prelaunch:index.html
git checkout prelaunch -- .   # to restore it wholesale
```
