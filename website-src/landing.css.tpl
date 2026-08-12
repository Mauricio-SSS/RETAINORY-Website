/* Retainory — landing page.

   The page has one idea: a single line runs the whole narrative column. Its
   vertical position is time; its horizontal position inside a fixed 250px
   corridor is the probability you can still recall the material, on a labelled
   50–100% scale. The line falls through the first section, is caught by timed
   reviews in the second, holds through the third and fourth, and then leaves the
   corridor entirely to become the tail of the distribution at "Set the Curve".
   After that the page drops the device and turns into plain documentation.

   No JavaScript: _headers ships a Content-Security-Policy with no script-src, so
   every path here is pre-computed by scratchpad gen_geometry.py from the app's own
   FSRS-6 retrievability function. The reveal is a CSS scroll-driven animation and
   degrades to "already drawn" wherever that isn't supported. */

/* ============================================================
   NARRATIVE COLUMN + THE SPINE
   ============================================================ */

.narrative {
  position: relative;
  max-width: var(--shell);
  margin: 0 auto;
  padding: 0 var(--s6);
}

.spine {
  position: absolute;
  left: var(--s6);
  top: 0;
  width: 250px;
  height: 100%;
  pointer-events: none;
}

.spine__path {
  fill: none;
  stroke: url(#spine-grad);
  stroke-width: 2;
  vector-effect: non-scaling-stroke;
}

/* The corridor's x axis is a real scale, so it gets labelled once, at the top. */
.spine__scale {
  position: absolute;
  left: var(--s6);
  top: 232px;
  width: 250px;
  height: 22px;
  pointer-events: none;
}

.spine__scale span {
  position: absolute;
  top: 0;
  font-family: var(--mono);
  font-size: var(--t-micro);
  color: var(--tx2);
}

.spine__scale span:nth-child(1) {
  left: 28px;
}
.spine__scale span:nth-child(2) {
  left: 188px;
}
.spine__scale span:nth-child(3) {
  left: 28px;
  top: 16px;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  opacity: 0.75;
}

.node {
  position: absolute;
  width: 9px;
  height: 9px;
  margin: -4.5px 0 0 -4.5px;
  border-radius: 50%;
  background: var(--brand);
  pointer-events: none;
}

{{NODES_CSS}}

/* ============================================================
   NARRATIVE SECTIONS
   The min-heights are load bearing: they are what keeps the line's events
   aligned with the words next to them without measuring anything at runtime.
   ============================================================ */

/* 250px of corridor plus a 60px gutter, so the line never crowds the text. */
.hero,
.proof,
.stage {
  padding-left: 310px;
}

.hero {
  min-height: 640px;
  display: grid;
  align-content: center;
  padding-top: var(--s9);
  padding-bottom: var(--s7);
}

.hero__title {
  font-family: var(--display);
  font-weight: 700;
  font-size: var(--t-hero);
  line-height: 1;
  letter-spacing: -0.04em;
  margin: var(--s5) 0 0;
  max-width: 13ch;
  text-wrap: balance;
}

.hero__title em {
  display: block;
  font-style: normal;
  font-weight: 300;
  color: var(--tx2);
}

.hero__sub {
  font-size: var(--t-t3);
  line-height: 1.55;
  color: var(--tx2);
  max-width: 46ch;
  margin: var(--s6) 0 var(--s4);
}

.hero__hint {
  font-family: var(--mono);
  font-size: var(--t-caption);
  color: var(--tx2);
  margin: 0 0 var(--s7);
  max-width: 46ch;
}

.proof {
  min-height: 140px;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: var(--s5);
  align-content: center;
  border-top: 1px solid var(--stroke-soft);
  border-bottom: 1px solid var(--stroke-soft);
}

.proof__item b {
  display: block;
  font-size: var(--t-label);
  font-weight: 600;
  margin-bottom: 2px;
}

.proof__item span {
  font-size: var(--t-caption);
  color: var(--tx2);
  line-height: 1.55;
}

.stage {
  padding-top: var(--s10);
  padding-bottom: var(--s10);
}

/* These four must stay in step with the section boundaries in gen_geometry.py —
   together they are what keeps each event on the line beside the words describing it. */
.stage--decay {
  min-height: 821px;
}
.stage--reviews {
  min-height: 804px;
}
.stage--weak {
  min-height: 652px;
}
.stage--ready {
  min-height: 710px;
}

.stage__grid {
  display: grid;
  grid-template-columns: minmax(0, 0.95fr) minmax(0, 1.05fr);
  gap: var(--s8);
  align-items: center;
}

.stage__marker {
  display: flex;
  align-items: center;
  gap: var(--s3);
  font-family: var(--mono);
  font-size: var(--t-micro);
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--tx2);
  margin: 0;
}

.stage__marker::before {
  content: "";
  width: 22px;
  height: 1px;
  background: var(--brand);
  flex: 0 0 22px;
}

.stage h2 {
  font-family: var(--display);
  font-weight: 700;
  font-size: var(--t-big);
  line-height: 1.08;
  letter-spacing: -0.035em;
  margin: var(--s4) 0 var(--s4);
  max-width: 16ch;
  text-wrap: balance;
}

.stage p {
  font-size: var(--t-body);
  line-height: 1.7;
  color: var(--tx2);
  max-width: 48ch;
  margin: 0 0 var(--s4);
}

.stage p:last-child {
  margin-bottom: 0;
}

/* ---------- panels: the app's own components, at full size ---------- */

.panel {
  background: var(--surface);
  border: 1px solid var(--stroke);
  border-radius: var(--r-lg);
  padding: var(--s6);
  box-shadow: var(--elev);
}

.panel__cap {
  font-family: var(--mono);
  font-size: var(--t-micro);
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--tx2);
  margin: 0 0 var(--s4);
}

.panel__foot {
  font-family: var(--mono);
  font-size: var(--t-micro);
  color: var(--tx2);
  margin: var(--s4) 0 0;
  line-height: 1.6;
}

/* interval growth */

.intervals {
  display: grid;
  gap: var(--s3);
  margin: 0;
}

.intervals div {
  display: grid;
  grid-template-columns: 62px 1fr 74px;
  align-items: center;
  gap: var(--s4);
  padding-bottom: var(--s3);
  border-bottom: 1px solid var(--stroke-soft);
}

.intervals div:last-child {
  border-bottom: 0;
  padding-bottom: 0;
}

.intervals dt {
  font-family: var(--mono);
  font-size: var(--t-caption);
  color: var(--tx2);
}

.intervals dd {
  margin: 0;
  font-family: var(--mono);
  font-size: var(--t-caption);
  color: var(--tx);
  text-align: right;
  font-variant-numeric: tabular-nums;
}

.intervals i {
  display: block;
  height: 3px;
  border-radius: 2px;
  background: var(--brand);
}

.iv-1 {
  width: 6%;
}
.iv-2 {
  width: 14%;
}
.iv-3 {
  width: 32%;
}
.iv-4 {
  width: 62%;
}
.iv-5 {
  width: 100%;
}

/* how the cards get there */

.chain {
  margin: var(--s6) 0 0;
  padding: 0;
  list-style: none;
  display: flex;
  flex-wrap: wrap;
  gap: var(--s2) var(--s4);
  font-size: var(--t-caption);
  color: var(--tx2);
  max-width: 48ch;
}

.chain li {
  display: flex;
  align-items: center;
  gap: var(--s4);
}

.chain li + li::before {
  content: "";
  width: 14px;
  height: 1px;
  background: var(--stroke);
}

/* ---------- product screenshots ----------

   These are captures of the running app, not recreations. They are cropped so
   the app's own background sits in the margins — and because the site's --ink
   IS that colour (both come from the .signal palette), the cards' real rounded
   corners read correctly with nothing added here: no border, no radius, no
   device bezel. A screenshot in a fake chrome frame is the tell of a site that
   had nothing real to show, so the crop does the framing and CSS does none.

   Where a screenshot replaces a panel, the panel chrome goes with it: two
   nested borders 28px apart is the "screenshot inside a screenshot" look. */

.shot {
  margin: 0;
}

.shot img {
  display: block;
  width: 100%;
  height: auto;
}

/* ============================================================
   SET THE CURVE — the line leaves the corridor
   ============================================================ */

.curve {
  border-top: 1px solid var(--stroke-soft);
  background: var(--recessed);
  padding: var(--s10) 0;
  margin-top: var(--s9);
}

.curve__grid {
  display: grid;
  grid-template-columns: 430px minmax(0, 1fr);
  gap: var(--s8);
  align-items: center;
}

.curve h2 {
  font-family: var(--display);
  font-weight: 700;
  font-size: var(--t-big);
  line-height: 1.1;
  letter-spacing: -0.035em;
  margin: var(--s4) 0 var(--s4);
  text-wrap: balance;
}

.curve p {
  font-size: var(--t-body);
  line-height: 1.7;
  color: var(--tx2);
  margin: 0 0 var(--s6);
}

.bell {
  width: 100%;
  height: auto;
}

.bell__axis {
  stroke: rgba(255, 255, 255, 0.1);
}

.bell__fill {
  fill: url(#bell-grad);
  opacity: 0.09;
}

.bell__tail {
  fill: url(#bell-grad);
  opacity: 0.2;
}

.bell__line {
  fill: none;
  stroke: url(#bell-grad);
  stroke-width: 2;
}

.bell__sigma {
  stroke: rgba(255, 255, 255, 0.14);
  stroke-dasharray: 3 4;
}

.bell__tick {
  font-family: var(--mono);
  font-size: 11px;
  fill: var(--tx2);
}

.bell__marker circle {
  fill: var(--brand);
}

.bell__marker text {
  font-family: var(--ui);
  font-size: 12px;
  font-weight: 600;
  fill: var(--tx);
  text-anchor: middle;
}

.figcap {
  font-family: var(--mono);
  font-size: var(--t-micro);
  color: var(--tx2);
  margin: var(--s4) 0 0;
  line-height: 1.6;
}

/* ============================================================
   DOCUMENTATION MODE — the device is spent; the page goes plain
   ============================================================ */

.section {
  padding: var(--s10) 0;
  border-top: 1px solid var(--stroke-soft);
}

.section__head {
  display: grid;
  grid-template-columns: 200px minmax(0, 1fr);
  gap: var(--s7);
  margin-bottom: var(--s7);
}

.section__head h2 {
  font-family: var(--display);
  font-weight: 700;
  font-size: clamp(24px, 2.8vw, 34px);
  letter-spacing: -0.03em;
  line-height: 1.12;
  margin: 0 0 var(--s3);
  max-width: 20ch;
  text-wrap: balance;
}

.section__head p {
  font-size: var(--t-body);
  line-height: 1.7;
  color: var(--tx2);
  max-width: var(--measure);
  margin: 0;
}

.rh {
  font-family: var(--mono);
  font-size: var(--t-micro);
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--tx2);
  padding-top: 6px;
  border-top: 1px solid var(--tx);
  margin: 0;
  height: fit-content;
}

.principle {
  display: grid;
  grid-template-columns: 200px minmax(0, 1.05fr) minmax(0, 1fr);
  gap: var(--s7);
  padding: var(--s6) 0;
  border-top: 1px solid var(--stroke-soft);
  align-items: start;
}

.principle h3 {
  font-family: var(--display);
  font-weight: 700;
  font-size: var(--t-t3);
  letter-spacing: -0.02em;
  margin: 0 0 var(--s2);
}

.principle p {
  font-size: var(--t-label);
  line-height: 1.65;
  color: var(--tx2);
  margin: 0;
}

.principle__impl {
  padding-left: var(--s5);
  border-left: 2px solid var(--brand);
}

.principle__impl b {
  display: block;
  font-family: var(--mono);
  font-size: var(--t-micro);
  font-weight: 500;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--tx2);
  margin-bottom: var(--s2);
}

.principle__impl p {
  color: var(--tx);
}

/* The principle definitions are quoted from the literature, so the clause the
   product actually acts on is lifted out of the grey rather than paraphrased
   away. Weight stays at 500 — bold inside 15px body text is a shout. */
.principle p strong {
  color: var(--tx);
  font-weight: 500;
}

.refs {
  display: grid;
  gap: var(--s3);
  margin: var(--s7) 0 0;
  padding: var(--s5) 0 0;
  border-top: 1px solid var(--stroke-soft);
  font-size: var(--t-caption);
  color: var(--tx2);
  max-width: var(--measure);
}

.refs a {
  color: var(--brand);
  text-underline-offset: 3px;
}

/* Two groups: the works the principles cite, then everything else. Without the
   split the reader can't tell which references back a claim on this page and
   which are just recommended. */
.refs__head {
  font-family: var(--mono);
  font-size: var(--t-micro);
  font-weight: 500;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--tx);
  margin-top: var(--s5);
  padding-bottom: var(--s2);
  border-bottom: 1px solid var(--stroke-soft);
}

.refs__head:first-child {
  margin-top: 0;
}

.price {
  display: grid;
  grid-template-columns: 200px minmax(0, 1fr);
  gap: var(--s7);
  align-items: start;
}

.price__amount {
  font-family: var(--display);
  font-weight: 700;
  font-size: clamp(40px, 6vw, 68px);
  letter-spacing: -0.04em;
  line-height: 1;
  margin: 0 0 var(--s4);
}

.price p {
  font-size: var(--t-body);
  line-height: 1.7;
  color: var(--tx2);
  max-width: var(--measure);
  margin: 0 0 var(--s5);
}

.closer {
  text-align: center;
  padding: var(--s10) 0;
  border-top: 1px solid var(--stroke-soft);
}

.closer h2 {
  font-family: var(--display);
  font-weight: 700;
  font-size: clamp(44px, 8vw, 104px);
  letter-spacing: -0.05em;
  line-height: 0.95;
  margin: var(--s4) 0 var(--s5);
}

.closer p {
  font-size: var(--t-t3);
  color: var(--tx2);
  margin: 0 auto var(--s7);
  max-width: 40ch;
}

.closer .btns {
  justify-content: center;
}

/* ============================================================
   MOTION — two moments, both answering scroll. Everything degrades to
   "already in its final state" without scroll-driven animation support.
   ============================================================ */

@keyframes spine-draw {
  to {
    stroke-dashoffset: 0;
  }
}

@keyframes node-in {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes marker-travel {
  from {
    offset-distance: {{MARKER_START}}%;
  }
  to {
    offset-distance: {{MARKER_END}}%;
  }
}

@supports (animation-timeline: view()) {
  @media (prefers-reduced-motion: no-preference) {
    .narrative {
      view-timeline-name: --spine;
      view-timeline-axis: block;
    }

    .spine__path {
      stroke-dasharray: 1000;
      stroke-dashoffset: 1000;
      animation: spine-draw linear both;
      animation-timeline: --spine;
      animation-range: cover 10% cover 88%;
    }

    .node {
      opacity: 0;
      animation: node-in linear both;
      animation-timeline: view();
      animation-range: contain 25% contain 45%;
    }
  }
}

@supports (offset-path: path("M0 0")) and (animation-timeline: view()) {
  @media (prefers-reduced-motion: no-preference) {
    .bell__marker {
      transform: none;
      offset-path: path("{{BELL}}");
      offset-rotate: 0deg;
      offset-distance: {{MARKER_START}}%;
      animation: marker-travel linear both;
      animation-timeline: view();
      animation-range: entry 70% contain 60%;
    }
  }
}

/* ============================================================
   NARROW VIEWPORTS — the corridor needs 250px it doesn't have, so the
   line steps aside rather than being squeezed into a squiggle.
   ============================================================ */

/* Below 1180px the shell stops being capped, the columns narrow, and the copy
   reflows taller than the min-heights the spine's geometry was measured against.
   Rather than let the line drift out of step with the words, the corridor stands
   down and the page reflows to a single column. */
@media (max-width: 1179px) {
  .spine,
  .spine__scale,
  .node,
  /* "The line on the left…" is a lie once the line is gone. */
  .hero__hint {
    display: none;
  }

  .hero,
  .proof,
  .stage {
    padding-left: 0;
  }

  .hero,
  .stage--decay,
  .stage--reviews,
  .stage--weak,
  .stage--ready {
    min-height: 0;
  }

  .stage__grid,
  .curve__grid,
  .section__head,
  .principle,
  .price {
    grid-template-columns: minmax(0, 1fr);
    gap: var(--s5);
  }

  .stage {
    padding-top: var(--s9);
    padding-bottom: var(--s9);
  }
}

@media (max-width: 680px) {
  .proof {
    grid-template-columns: 1fr 1fr;
    gap: var(--s5);
    padding-top: var(--s6);
    padding-bottom: var(--s6);
    min-height: 0;
  }

  .intervals div {
    grid-template-columns: 54px 1fr 64px;
  }
}
