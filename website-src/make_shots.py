"""Crop app captures into the product screenshots the landing page uses.

    python3 website-src/make_shots.py

Every crop keeps the app's own background (#0A0E14) in the margins. That is the
same value as the site's --ink, so the cards' real rounded corners read correctly
with nothing added on the web side: no border, no CSS radius, no device bezel.
Framing a screenshot in fake chrome is the tell of a site with nothing real to
show, so the crop does the framing and the CSS does none.

The capture must be on the SIGNAL theme
---------------------------------------
The site's tokens are Signal's literal values, so a capture on any other theme
lands on the page as a visibly different product: Classic in particular renders
the primary button indigo (#5954DB) and the exam anchor blue (#438CF5) where the
site promises teal and gold. Release builds force `RetainThemeID.shipping`
(RetainTheme.swift:405), but a debug build honours whatever the theme picker
persisted — so check the accent before cropping, not after. The tell is the exam
anchor bar: gold is Signal, blue is Classic.

To add or replace a shot
------------------------
1. Capture at 3x on a dark-appearance device with seeded data — an empty install
   produces empty cards. Either source works; they differ only in geometry.

       # simulator, iPhone 17 Pro (1206x2622) — card edges at x=61 and x=1145
       UDID=<device>
       xcrun simctl ui $UDID appearance dark
       xcrun simctl launch --terminate-running-process $UDID ClosedAI.Retainory
       xcrun simctl io $UDID screenshot --type=png /tmp/shot-<name>.png

       # device, iPhone 15/16/17 Pro (1290x2796) — card edges at x=60 and x=1229,
       # x=54 and x=1235 inside a presented sheet. Side button + volume up, then
       # AirDrop the PNG over.

2. Find the crop box: leave ~20px of app background on every side so the corner
   radius survives, and cut horizontally in a gutter BETWEEN cards. Never crop a
   frame where a floating control (the session CTA, the onboarding Continue bar,
   the tab bar) overlaps content — in the app that is a scroll position, but out
   of context it reads as a rendering fault.
3. Add a JOBS row, run this file, and put the reported width/height on the <img>.
   Those attributes are what reserve layout space before the image loads, and
   they are also what the narrative column's measured min-heights depend on.
4. Re-measure the section and update BOTH gen_geometry.py and landing.css.tpl
   (see README.md, next to this file).
"""
import pathlib
import subprocess
from PIL import Image

HERE = pathlib.Path(__file__).parent
OUT = HERE.parent / "website" / "img"
OUT.mkdir(parents=True, exist_ok=True)

# The full-screen captures live in the repo beside this file rather than in /tmp,
# so a crop can be adjusted later without reproducing the seeded app state that
# produced it. They are the only inputs here that cannot be regenerated from code.
SRC = HERE / "captures"

# name, source capture, crop box (left, top, right, bottom), output width
JOBS = [
    # Home: status bar through the bottom of the "Now" card. Cropping below that
    # avoids the floating session CTA overlapping the Insights carousel, which
    # reads as a rendering fault out of context. Currently unused by the page —
    # kept because it is the obvious hero image if the hero ever takes one.
    ("app-home", "shot-home-dark.png", (0, 0, 1206, 1870), 680),
    # Readiness: gauge card + exam anchor + the three counters, as one column.
    ("app-readiness", "shot-readiness.png", (40, 640, 1166, 1820), 820),
    # Memory risk zones: the whole card, all four objectives.
    ("app-risk-zones", "shot-riskzones.png", (40, 908, 1166, 1925), 820),
    # Onboarding step 1, device capture. The milestone card from its top corners
    # down through the AP/SAT/ACT/LSAT rows, cut mid-gutter before the third row
    # so the grid reads as continuing rather than as ending short. Cutting there
    # also clears the floating Continue bar, which sits over that third row.
    ("app-objectives", "shot-objectives.png", (32, 880, 1257, 2340), 820),
]

for name, filename, box, width in JOBS:
    src = SRC / filename
    if not src.exists():
        print(f"{name:16} SKIPPED — no capture at {src}")
        continue
    im = Image.open(src).convert("RGB").crop(box)
    h = round(im.height * width / im.width)
    im = im.resize((width, h), Image.LANCZOS)
    tmp = pathlib.Path("/tmp") / f"{name}-src.png"
    im.save(tmp)
    webp = OUT / f"{name}.webp"
    # q92 is visually lossless on flat UI at these sizes and about a fifth the
    # size of the PNG. WebP has been safe everywhere since 2020, and this page
    # already requires a browser new enough for scroll-driven animation.
    subprocess.run(["cwebp", "-quiet", "-q", "92", "-m", "6", str(tmp), "-o", str(webp)],
                   check=True)
    print(f'{name:16} {width}x{h}  {webp.stat().st_size // 1024:3d}K   '
          f'<img src="/img/{name}.webp" width="{width}" height="{h}">')
