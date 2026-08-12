"""Substitute the generated geometry into the landing-page templates."""
import json, math, pathlib, re

HERE = pathlib.Path(__file__).parent
SITE = HERE.parent / "website"
g = json.loads((HERE / "geometry.json").read_text())

# --- review nodes: HTML dots + the CSS that places them on the line ---
nodes_html, nodes_css = [], []
for i, (x, ypct) in enumerate(g["nodes"], start=1):
    nodes_html.append(f'        <i class="node node--{i}" aria-hidden="true"></i>')
    nodes_css.append(
        f".node--{i} {{\n  left: calc(var(--s6) + {x}px);\n  top: {ypct}%;\n}}"
    )

# --- bell marker fallback position (used when offset-path is unsupported) ---
MU, SIG, BASE, AMP = 430.0, 128.0, 252.0, 202.0
end_x = MU + 1.25 * SIG
end_y = BASE - AMP * math.exp(-((end_x - MU) ** 2) / (2 * SIG * SIG))
marker_xy = f"translate({end_x:.1f} {end_y:.1f})"

subs_html = {
    "{{SPINE}}": g["spine"],
    "{{SPINE_VIEWBOX}}": g["spine_viewbox"],
    "{{NODES_HTML}}": "\n".join(nodes_html),
    "{{BELL}}": g["bell"],
    "{{BELL_FILL}}": g["bell_fill"],
    "{{TAIL}}": g["tail"],
    "{{MARKER_XY}}": marker_xy,
}
subs_css = {
    "{{NODES_CSS}}": "\n\n".join(nodes_css),
    "{{BELL}}": g["bell"],
    "{{MARKER_START}}": str(g["marker_start_pct"]),
    "{{MARKER_END}}": str(g["marker_end_pct"]),
}

# Template-only comments: <!--@ ... @--> is stripped from the output, ordinary
# <!-- ... --> is kept. HTML comments are shipped to the browser verbatim, so
# anything that is a note to ourselves rather than to a reader of the page has to
# use this form — notably the parked pricing table, which would otherwise put
# unannounced prices one View Source away on a page App Store review reads.
TPL_ONLY = re.compile(r"[ \t]*<!--@.*?@-->\n?", re.S)

for tpl, out, subs in (
    ("index.html.tpl", "index.html", subs_html),
    ("landing.css.tpl", "landing.css", subs_css),
):
    text = (HERE / tpl).read_text()
    for k, v in subs.items():
        text = text.replace(k, v)
    text = TPL_ONLY.sub("", text)
    leftover = [t for t in ("{{", "<!--@") if t in text]
    assert not leftover, f"{out} still has {leftover}"
    (SITE / out).write_text(text)
    print(f"wrote {out}: {len(text) / 1024:.1f} KB")

print("marker fallback:", marker_xy)
