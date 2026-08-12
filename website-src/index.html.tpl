<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Retainory — Set the Curve</title>
    <meta
      name="description"
      content="Retainory turns your course material into an optimized study system that decides what to review, when to review it, and how to excel. Free, on iPhone."
    />
    <meta name="theme-color" content="#0A0E14" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="https://retainory.com/" />
    <meta property="og:title" content="Retainory — Set the Curve" />
    <meta
      property="og:description"
      content="Remember more. Retainory decides what to review, when to review it, and how to excel."
    />
    <meta name="twitter:card" content="summary" />
    <link rel="preload" href="/fonts/sora-bold.woff2" as="font" type="font/woff2" crossorigin />
    <link rel="stylesheet" href="/style.css" />
    <link rel="stylesheet" href="/landing.css" />
  </head>
  <body>
    <a class="skip" href="#main">Skip to content</a>

    <div class="shell">
      <header class="nav">
        <a class="wordmark" href="/">Retainory</a>
        <ul class="nav__links">
          <li><a href="#how">How it works</a></li>
          <li><a href="#science">The science</a></li>
          <li><a href="#pricing">Pricing</a></li>
          <li><a href="/support">Support</a></li>
        </ul>
        <!-- APP STORE URL: this href appears 4 times on this page. Replace every
             occurrence once the App Store listing exists. -->
        <a class="btn btn--primary" href="https://apps.apple.com/app/retainory"
          >Start Retaining Free</a
        >
      </header>
    </div>

    <main id="main">
      <!-- ============================================================
           The narrative column. One line runs from here to "Set the Curve":
           y is time, x is the probability you can still recall the material.
           ============================================================ -->
      <div class="narrative">
        <svg class="spine" viewBox="{{SPINE_VIEWBOX}}" preserveAspectRatio="none" aria-hidden="true">
          <defs>
            <linearGradient id="spine-grad" x1="0" y1="0" x2="0" y2="1">
              <stop offset="0%" stop-color="#2AF0D0" />
              <stop offset="100%" stop-color="#14D6C4" />
            </linearGradient>
          </defs>
          <!-- pathLength normalises the stroke-dash reveal to 0–1000 regardless of the
               path's real length and of the vertical stretch applied by the viewBox. -->
          <path class="spine__path" pathLength="1000" d="{{SPINE}}" />
        </svg>

        <div class="spine__scale" aria-hidden="true">
          <span>50</span>
          <span>100</span>
          <span>recall %</span>
        </div>

{{NODES_HTML}}

        <section class="hero">
          <p class="eyebrow">Academic performance</p>
          <h1 class="hero__title">Remember more.<em>Set the Curve.</em></h1>
          <p class="hero__sub">
            Retainory turns your course material into an optimized study system that
            decides what to review, when to review it, and how to excel.
          </p>
          <p class="hero__hint">
            The line on the left is one lecture in your memory. Keep scrolling.
          </p>
          <div class="btns">
            <a class="btn btn--primary" href="https://apps.apple.com/app/retainory"
              >Start Retaining Free</a
            >
            <a class="btn btn--ghost" href="#how">See how it works</a>
          </div>
        </section>

        <section class="proof">
          <div class="proof__item">
            <b>FSRS-6 adapted scheduling</b>
            <span>The open spaced-repetition model, fitted to your own ratings.</span>
          </div>
          <div class="proof__item">
            <b>Any of your materials</b>
            <span>Lecture PDFs and pasted notes — not a stock question bank.</span>
          </div>
          <div class="proof__item">
            <b>All of your objectives</b>
            <span>Every course and exam tracked against its own date.</span>
          </div>
          <div class="proof__item">
            <b>Free to use</b>
            <span>Nothing to sign up for, and nothing to pay.</span>
          </div>
        </section>

        <section class="stage stage--decay">
          <div class="stage__grid">
            <div>
              <p class="stage__marker">Day 1 · unreviewed</p>
              <h2>Set your objectives.</h2>
              <p>
                Recall starts falling the moment the lecture ends. Set your objectives, add
                your materials, and start tracking your memory and your readiness against
                the date that actually matters.
              </p>
              <p>
                Tracking, scheduling and optimizing are complicated and time-consuming.
                Leave the logistics and the neuroscience to us, so you can focus on the
                material.
              </p>
            </div>
            <figure class="shot">
              <img
                src="/img/app-objectives.webp"
                width="820"
                height="977"
                loading="lazy"
                decoding="async"
                alt="The app's first setup step, headed &quot;What are you studying for?&quot;, offering AP Exam — which uses the official AP date when available — alongside SAT, ACT and LSAT, each set from your registered test day."
              />
              <figcaption class="figcap">
                Step one, before a single card exists: the date. Everything after it is
                scheduled backward from there. The line beside this section is one
                exposure that never got reviewed — at the app's default decay parameter
                (w<sub>20</sub>&nbsp;=&nbsp;0.1542), FSRS-6 puts recall at 55% by day 14.
                Your own numbers depend on your ratings.
              </figcaption>
            </figure>
          </div>
        </section>

        <section class="stage stage--reviews" id="how">
          <div class="stage__grid">
            <div>
              <p class="stage__marker">Each node · one review</p>
              <h2>Your memory curve sets your review schedule.</h2>
              <p>
                Retainory schedules each session for the day your recall needs the support.
                The timing is drawn from the science, so you never review so early that you
                waste the session, or so late that you have to learn it again.
              </p>
              <p>
                Your plan adapts to every session and every review. Because each successful
                review makes the memory more stable, the gap to the next one gets longer —
                the line stops falling, and the reviews spread out.
              </p>
              <ul class="chain">
                <li>Add a PDF or paste notes</li>
                <li>Cards drafted per concept</li>
                <li>You answer before you see</li>
              </ul>
            </div>
            <div class="panel">
              <p class="panel__cap">Interval to the next review</p>
              <dl class="intervals">
                <div><dt>1st</dt><i class="iv-1"></i><dd>1 day</dd></div>
                <div><dt>2nd</dt><i class="iv-2"></i><dd>3 days</dd></div>
                <div><dt>3rd</dt><i class="iv-3"></i><dd>7 days</dd></div>
                <div><dt>4th</dt><i class="iv-4"></i><dd>17 days</dd></div>
                <div><dt>5th</dt><i class="iv-5"></i><dd>42 days</dd></div>
              </dl>
              <p class="panel__foot">
                Illustrative. At the default 90% target the interval in days is the card's
                stability, so the real sequence is whatever your ratings produce.
              </p>
            </div>
          </div>
        </section>

        <section class="stage stage--weak">
          <div class="stage__grid">
            <div>
              <p class="stage__marker">Ranked · every objective</p>
              <h2>Know what you don't know yet.</h2>
              <p>
                Every answer updates an estimate of what is still retrievable. Retainory
                ranks your objectives by how fast they are decaying and how close the exam
                is, so the material that needs you surfaces on its own.
              </p>
              <p>
                Confidence is the least reliable signal a student has. This replaces it
                with one that was measured.
              </p>
            </div>
            <figure class="shot">
              <img
                src="/img/app-risk-zones.webp"
                width="820"
                height="741"
                loading="lazy"
                decoding="async"
                alt="Memory risk zones in the app, listing four objectives worst-first: Organic Chemistry final, 16 due today, 12 days left; Physiology quiz, 10 due today, 4 days left; Biochemistry midterm, 12 due today, 27 days left; Genetics problem set, 8 due today, 40 days left."
              />
              <figcaption class="figcap">
                Retainory on iPhone. Real output from a real review history — every figure
                on this page is computed, none of it is mocked up.
              </figcaption>
            </figure>
          </div>
        </section>

        <section class="stage stage--ready">
          <div class="stage__grid">
            <div>
              <p class="stage__marker">Exam date</p>
              <h2>Walk in prepared.</h2>
              <p>
                Walk into your exam knowing you replaced cramming with an optimized study
                schedule — one that had you studying less and absorbing more. Set the date
                on day one, and from then on one figure tells you where you actually stand
                against it.
              </p>
              <p>
                Nothing here is a streak or a badge. It's an instrument, and instruments
                are only useful when you trust them to disagree with you.
              </p>
            </div>
            <figure class="shot">
              <img
                src="/img/app-readiness.webp"
                width="820"
                height="859"
                loading="lazy"
                decoding="async"
                alt="The app's readiness screen: a gauge reading 74, labelled READY, beside the note that 46 due cards are shaping today's score. Below it the exam anchor — Physiology quiz, 4 days, 14 August — and three counters: 46 due today, 4 at risk, 22 minutes this week."
              />
              <figcaption class="figcap">
                The gold bar is the exam anchor. It is the only thing on the screen allowed
                to use that color, so the date is never something you have to look for.
              </figcaption>
            </figure>
          </div>
        </section>
      </div>

      <!-- ============================================================
           The line leaves the corridor and becomes the distribution.
           ============================================================ -->
      <section class="curve">
        <div class="shell curve__grid">
          <div>
            <p class="eyebrow">Set the Curve</p>
            <h2>The goal isn't more studying. It's moving your position on the curve.</h2>
            <p>
              Everyone in the room reads the same chapter. What separates the results is
              how much of it survived the three weeks in between. Retention is the lever
              almost nobody pulls.
            </p>
            <a class="btn btn--primary" href="https://apps.apple.com/app/retainory"
              >Start Retaining Free</a
            >
          </div>
          <figure>
            <svg
              class="bell"
              viewBox="0 0 960 300"
              role="img"
              aria-label="A distribution of exam performance. A marker sits in the upper tail, to the right of the middle."
            >
              <defs>
                <linearGradient id="bell-grad" x1="0" y1="0" x2="1" y2="0">
                  <stop offset="0%" stop-color="#14D6C4" />
                  <stop offset="100%" stop-color="#2AF0D0" />
                </linearGradient>
              </defs>
              <path class="bell__fill" d="{{BELL_FILL}}" />
              <path class="bell__tail" d="{{TAIL}}" />
              <line class="bell__axis" x1="0" y1="252" x2="960" y2="252" />
              <line class="bell__sigma" x1="430" y1="50" x2="430" y2="252" />
              <line class="bell__sigma" x1="558" y1="130" x2="558" y2="252" />
              <path class="bell__line" d="{{BELL}}" />
              <g class="bell__marker" transform="{{MARKER_XY}}">
                <circle cx="0" cy="0" r="5" />
                <text x="0" y="-14">you</text>
              </g>
              <text class="bell__tick" x="8" y="276">lower</text>
              <text class="bell__tick" x="430" y="276" text-anchor="middle">
                exam performance
              </text>
              <text class="bell__tick" x="952" y="276" text-anchor="end">higher</text>
            </svg>
            <figcaption class="figcap">
              Illustrative distribution. Retainory measures your recall, not your classmates
              — it does not compute or report class rank.
            </figcaption>
          </figure>
        </div>
      </section>

      <!-- ============================================================
           Documentation mode.
           ============================================================ -->
      <div class="shell">
        <section class="section" id="science">
          <div class="section__head">
            <p class="rh">The science</p>
            <div>
              <h2>Three mechanisms, implemented rather than cited.</h2>
              <p>
                Retainory was built with one of the leading minds in memory and retention,
                now an AI researcher at a top lab, to adapt the science behind FSRS-6
                scheduling for test prep.
              </p>
            </div>
          </div>

          <div class="principle">
            <p class="rh">Encoding</p>
            <div>
              <h3>What you keep is decided at intake.</h3>
              <p>
                Memory encoding is the process by which incoming information is transformed
                into a mental and neural representation that can be stored in long-term
                memory, with what is ultimately remembered depending on
                <strong>how the material is processed at intake</strong>
                (Craik &amp; Lockhart, 1972; Tulving &amp; Thomson, 1973; McGaugh, 2000).
              </p>
            </div>
            <div class="principle__impl">
              <b>In Retainory</b>
              <p>
                Your notes are stored, summarized and compartmentalized into flashcards and
                other study formats, to improve how your material is learned and encoded
                into long-term memory.
              </p>
            </div>
          </div>

          <div class="principle">
            <p class="rh">Memory consolidation</p>
            <div>
              <h3>A memory has to be stabilized after the fact.</h3>
              <p>
                Memory consolidation is the progressive post-acquisition process by which
                <strong
                  >initially labile memory traces are stabilized and reorganized into
                  durable long-term representations</strong
                >, including a gradual shift from hippocampus-dependent to distributed
                neocortical storage (Dudai, 2004; McGaugh, 2000; Frankland &amp; Bontempi,
                2005).
              </p>
            </div>
            <div class="principle__impl">
              <b>In Retainory</b>
              <p>
                FSRS-6 estimates each card's stability and difficulty, then applies spaced
                repetition to improve memory consolidation.
              </p>
            </div>
          </div>

          <div class="principle">
            <p class="rh">Retrieval</p>
            <div>
              <h3>Retrieval is not only a symptom of learning. It's a cause of it.</h3>
              <p>
                Memory retrieval is the process by which
                <strong
                  >stored information is accessed and reconstructed from long-term memory
                  into conscious awareness</strong
                >, with success depending on the match between current cues and the way the
                information was originally encoded (Tulving, 1983).
              </p>
            </div>
            <div class="principle__impl">
              <b>In Retainory</b>
              <p>
                Every session asks you to retrieve what you encoded and consolidated. That
                act is what solidifies the learning and holds the retention in place.
              </p>
            </div>
          </div>

          <div class="refs">
            <p class="refs__head">Cited above, in order</p>
            <p>
              Craik, F. I. M., &amp; Lockhart, R. S. (1972). Levels of processing: A
              framework for memory research.
              <em>Journal of Verbal Learning and Verbal Behavior</em>, 11(6).
              <a href="https://doi.org/10.1016/S0022-5371(72)80001-X">DOI</a>
            </p>
            <p>
              Tulving, E., &amp; Thomson, D. M. (1973). Encoding specificity and retrieval
              processes in episodic memory. <em>Psychological Review</em>, 80(5).
              <a
                href="https://archive.org/download/wikipedia-scholarly-sources-corpus/10.1037%252Fa0017364.zip/10.1037%252Fh0020071.pdf"
                >PDF</a
              >
            </p>
            <p>
              McGaugh, J. L. (2000). Memory — a century of consolidation.
              <em>Science</em>, 287(5451).
              <a href="https://www.science.org/doi/pdf/10.1126/science.287.5451.248">PDF</a>
            </p>
            <p>
              Dudai, Y. (2004). The neurobiology of consolidations, or, how stable is the
              engram? <em>Annual Review of Psychology</em>, 55.
              <a href="https://www.antoniocasella.eu/dnlaw/Dudai_2004.pdf">PDF</a>
            </p>
            <p>
              Frankland, P. W., &amp; Bontempi, B. (2005). The organization of recent and
              remote memories. <em>Nature Reviews Neuroscience</em>, 6(2).
              <a href="https://doi.org/10.1038/nrn1607">DOI</a>
            </p>
            <p>
              Tulving, E. (1983). <em>Elements of Episodic Memory</em>. Oxford University
              Press. Précis in <em>Behavioral and Brain Sciences</em>, 7(2).
              <a
                href="https://www.cambridge.org/core/journals/behavioral-and-brain-sciences/article/abs/precis-of-elements-of-episodic-memory/8EA952C5CDFC4F0AEC3555E7301F8E8A"
                >Abstract</a
              >
            </p>

            <p class="refs__head">Further reading on methodology</p>
            <p>
              Ebbinghaus, H. (1885). <em>Über das Gedächtnis</em>. — the original decay
              measurements.
            </p>
            <p>
              Rubin, D. C., &amp; Wenzel, A. E. (1996). One hundred years of forgetting: A
              quantitative description of retention.
              <em>Psychological Review</em>, 103(4).
              <a
                href="https://users.cs.northwestern.edu/~paritosh/papers/KIP/100YearsOfForgetting.pdf"
                >PDF</a
              >
            </p>
            <p>
              Wixted, J. T. (2004). The psychology and neuroscience of forgetting.
              <em>Annual Review of Psychology</em>, 55.
              <a href="https://cenl.ucsd.edu/Jclub/Wixted_2004.pdf">PDF</a>
            </p>
            <p>
              Roediger, H. L., &amp; Karpicke, J. D. (2006). Test-enhanced learning.
              <em>Psychological Science</em>, 17(3).
              <a
                href="https://psychology.ecu.edu/wp-content/pv-uploads/sites/216/2019/03/Roediger-Karpicke-2006.pdf"
                >PDF</a
              >
            </p>
            <p>
              Cepeda, N. J., Pashler, H., Vul, E., Wixted, J. T., &amp; Rohrer, D. (2006).
              Distributed practice in verbal recall tasks.
              <em>Psychological Bulletin</em>, 132(3).
              <a href="https://augmentingcognition.com/assets/Cepeda2006.pdf">PDF</a>
            </p>
            <p>
              Diekelmann, S., &amp; Born, J. (2010). The memory function of sleep.
              <em>Nature Reviews Neuroscience</em>, 11(2).
              <a href="https://research.uni-luebeck.de/en/publications/the-memory-function-of-sleep"
                >Record</a
              >
            </p>
            <p>
              Karpicke, J. D., &amp; Blunt, J. R. (2011). Retrieval practice produces more
              learning than elaborative studying with concept mapping.
              <em>Science</em>, 331(6018).
              <a
                href="https://learninglab.psych.purdue.edu/downloads/2011/2011_Karpicke_Blunt_Science.pdf"
                >PDF</a
              >
            </p>
            <p>
              Dunlosky, J., Rawson, K. A., Marsh, E. J., Nathan, M. J., &amp; Willingham,
              D. T. (2013). Improving students' learning with effective learning
              techniques. <em>Psychological Science in the Public Interest</em>, 14(1).
              <a
                href="https://www.wku.edu/senate/documents/improving_student_learning_dunlosky_2013.pdf"
                >PDF</a
              >
            </p>
            <p>
              Murre, J. M. J., &amp; Dros, J. (2015). Replication and analysis of
              Ebbinghaus' forgetting curve. <em>PLOS ONE</em>, 10(7).
              <a href="https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0120644"
                >Open access</a
              >
            </p>
            <p>
              The scheduler:
              <a href="https://github.com/open-spaced-repetition/fsrs4anki"
                >open-spaced-repetition/fsrs4anki</a
              >.
            </p>
          </div>
        </section>

        <!--@ ============================================================
             PRICING — the page must never describe a product the binary can't
             sell. The app ships with no in-app purchase (the paywall lives in
             `v2-archive`; PurchaseManager compiles but nothing presents it), so
             the live block below says Free and only Free.

             The two-tier table is drafted and parked here. Uncomment it, delete
             the Free-only block, and add `.tiers` styling on the DAY the
             StoreKit products are live in App Store Connect — not before, or
             the site is advertising something nobody can buy and the listing
             contradicts it:

               FREE — $0
                 0 generations / month · 1 objective
                 Universal algorithm · Flashcards only
               PREMIUM — $4.99/mo or $34.99/year
                 40 generations / month · Unlimited objectives
                 Personalized algorithm · Full prep suite

             Note the free tier above is *narrower* than what ships today
             (unlimited objectives, generation included), so shipping it is a
             takeaway from existing users, not just an addition.

             This comment uses the <!--@ … @--> form, which build.py strips from
             the output. Unannounced prices must not ship inside the page.
             ============================================================ @-->
        <section class="section" id="pricing">
          <div class="price">
            <p class="rh">Pricing</p>
            <div>
              <p class="price__amount">Free.</p>
              <p>
                The full scheduling engine, your own material, no trial timer and no
                account. There is no paid tier today. If one ever arrives, it will be
                announced here first.
              </p>
              <div class="btns">
                <a class="btn btn--primary" href="https://apps.apple.com/app/retainory"
                  >Start Retaining Free</a
                >
              </div>
            </div>
          </div>
        </section>

        <section class="closer">
          <p class="eyebrow">Don't study to keep up</p>
          <h2>Set the Curve.</h2>
          <p>Walk into the exam knowing you're prepared, because something measured it.</p>
          <div class="btns">
            <a class="btn btn--primary" href="https://apps.apple.com/app/retainory"
              >Start Retaining Free</a
            >
          </div>
        </section>
      </div>
    </main>

    <footer class="foot">
      <div class="foot__inner">
        <span>&copy; 2026 Retainory</span>
        <span class="foot__links">
          <a href="/privacy">Privacy</a>
          <a href="/terms">Terms</a>
          <a href="/support">Support</a>
          <a href="mailto:support@retainory.com">support@retainory.com</a>
        </span>
      </div>
    </footer>
  </body>
</html>
