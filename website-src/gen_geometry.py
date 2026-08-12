"""Generate every path in the Retainory landing page.

The site ships with no JavaScript (see website/_headers), so all geometry is computed
here and written into the HTML/CSS as literal path data. The retention curves use the
app's own FSRS-6 retrievability function, ported verbatim from
Retainory/Backend/RetainoryCore.swift:632 with the default w20 from FSRSWeights.swift.
"""
import math

W20 = 0.1542                       # FSRS-6 default decay parameter (w20)
FACTOR = 0.9 ** (-1.0 / W20) - 1.0  # so that R(S) == 0.90 exactly


def R(t, S):
    """Probability of recall t days after a review, for a card of stability S."""
    return min(1.0, max(1e-6, (1.0 + FACTOR * (t / S)) ** (-W20)))


def interval_for(target, S):
    """Days until recall falls to `target` — what the scheduler solves for."""
    return (S / FACTOR) * (target ** (-1.0 / W20) - 1.0)


# ---------------------------------------------------------------- the spine
# Corridor is 250px wide and never scales horizontally. x encodes recall on a
# 50–100% scale (the page labels that axis); y is time, stretched to fit the
# narrative column's real height via preserveAspectRatio="none".
#
# The section boundaries below are the narrative column's *measured* heights at the
# reference width (viewport >= 1180px, where .narrative is capped and text stops
# reflowing). They must stay in step with the min-heights in landing.css — that pair
# is what puts each event on the line beside the words that describe it. Re-measure
# and update both if the narrative copy changes length.
CORRIDOR_W = 250
HERO_END, PROOF_END = 640, 780
DECAY_END, REVIEWS_END, WEAK_END = 1601, 2405, 3058
H = 3768
X0, XW = 40.0, 160.0
FLOOR = 0.50


def x_of(r):
    return X0 + XW * min(1.0, max(0.0, (r - FLOOR) / (1.0 - FLOOR)))


pts = []

# Hero: freshly learned, already easing off.
START_Y = 300
for i in range(41):
    t = i / 40
    pts.append((x_of(1.0 - 0.07 * t), START_Y + (PROOF_END - START_Y) * t))

# Decay stage: one exposure, never reviewed. S is the default initial stability
# for a shaky first encounter; 14 days of slide.
S_RAW = 0.30
for i in range(1, 121):
    t = i / 120
    pts.append((x_of(R(14.0 * t, S_RAW)), PROOF_END + (DECAY_END - PROOF_END) * t))

# Review stages: the scheduler holds recall at the 0.90 target, so the teeth stay
# shallow while the gaps between them grow as stability compounds.
TARGET = 0.90
stabilities = [1.0, 2.6, 6.8, 17.0, 42.0]
gaps = [interval_for(TARGET, S) for S in stabilities]
span_y = WEAK_END - DECAY_END  # reviews + weak-topics stages share the timeline
# Vertical space is allocated on a log scale, not linearly. Linearly, the first two
# intervals (1 and 2.6 days against a 42-day fifth) collapse into 18px spikes and the
# whole run reads as a seismograph. Log spacing keeps every tooth legible while the
# widening — which is the actual point — still reads clearly down the column.
weights = [math.log(1.0 + g) for g in gaps]
total_gap = sum(weights)
y = float(DECAY_END)
nodes = []                     # (x, y_fraction_of_H) for the HTML dots
for gi, (S, gap) in enumerate(zip(stabilities, gaps)):
    nodes.append((x_of(1.0), y))
    pts.append((x_of(1.0), y))                       # the review restores it
    dy = span_y * weights[gi] / total_gap
    for i in range(1, 25):
        t = i / 24
        pts.append((x_of(R(gap * t, S)), y + dy * t))
    y += dy

# Readiness stage: held at target, one last long interval running off the bottom.
for i in range(1, 41):
    t = i / 40
    pts.append((x_of(R(gaps[-1] * 1.4 * t, stabilities[-1] * 2.4)),
                WEAK_END + (H - WEAK_END) * t))

spine = "M" + "L".join(f"{px:.1f} {py:.1f}" for px, py in pts)

# ---------------------------------------------------------------- the bell
BW, BH = 960, 300
MU, SIG, BASE, AMP = 430.0, 128.0, 252.0, 202.0


def bell_y(x):
    return BASE - AMP * math.exp(-((x - MU) ** 2) / (2 * SIG * SIG))


bell_pts = [(BW * i / 240, bell_y(BW * i / 240)) for i in range(241)]
bell = "M" + "L".join(f"{px:.1f} {py:.1f}" for px, py in bell_pts)

# Arc-length fractions, so the marker's CSS offset-distance lands on real x values.
seg = [0.0]
for i in range(1, len(bell_pts)):
    (x1, y1), (x2, y2) = bell_pts[i - 1], bell_pts[i]
    seg.append(seg[-1] + math.hypot(x2 - x1, y2 - y1))
total_len = seg[-1]


def frac_at_x(target_x):
    for i in range(1, len(bell_pts)):
        if bell_pts[i][0] >= target_x:
            return seg[i] / total_len
    return 1.0


start_x, end_x = MU, MU + 1.25 * SIG

# Tail wedge: everything beyond +1σ, closed to the baseline.
tail_from = MU + SIG
tail = [(px, py) for px, py in bell_pts if px >= tail_from]
tail_path = ("M" + "L".join(f"{px:.1f} {py:.1f}" for px, py in tail)
             + f"L{BW} {BASE:.1f}L{tail[0][0]:.1f} {BASE:.1f}Z")

out = {
    "spine": spine,
    "spine_viewbox": f"0 0 {CORRIDOR_W} {H}",
    "nodes": [(round(px, 1), round(py / H * 100, 3)) for px, py in nodes],
    "bell": bell,
    "bell_fill": bell + f"L{BW} {BASE:.1f}L0 {BASE:.1f}Z",
    "tail": tail_path,
    "marker_start_pct": round(frac_at_x(start_x) * 100, 2),
    "marker_end_pct": round(frac_at_x(end_x) * 100, 2),
    "intervals": [round(g, 1) for g in gaps],
}

import json, pathlib
pathlib.Path(__file__).with_name("geometry.json").write_text(json.dumps(out, indent=1))
print("intervals (days to 90% recall):", out["intervals"])
print("marker travel:", out["marker_start_pct"], "->", out["marker_end_pct"], "%")
print("spine points:", len(pts), "chars:", len(spine))
print("bell chars:", len(bell))
print("R(14d, S=0.30) =", round(R(14, 0.30), 3))
