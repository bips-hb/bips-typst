#import "bips-theme.typ": *

#show: bips-theme

// Look, here's a demo presentation that shows the stuff you'll actually use.
// Copy this file, change the content, and you're golden.

#title-slide(
  title: "Your Research Project",
  subtitle: "Findings and Implications",
  author: "Your Name",
  institute: bips_en,
  date: datetime.today().display(),
  occasion: "Conference of Implied Applications", // Delete this line if you don't need it
)

#bips-slide(title: "Introduction")[
 What's in the tin:

  - *BIPS branding* without the LaTeX headaches
  - *Instant compilation* — seriously, it's faster than saying "Schnitzelbrot"
  - *Git-friendly* plain text format (your future self will thank you)
  - *Math that just works*: $ s^2 = 1/(n-1) sum_(i=1)^n (x_i - macron(x))^2  $

  #vfill

  Perfect for when you need slides by tomorrow.
]

#bips-slide(
  title: "Study Overview",
  subtitle: "What we actually did",
  text-size: 15pt,
)[
  === Objectives
  - Investigate relationship between X and Y
  - Assess impact of intervention Z
  - Try to get significant results (kidding... mostly)

  === Methods
  - Randomized controlled trial
  - n = 500 participants 
  - 12-month follow-up

  #callout(type: "note")[
    Ethics approval obtained. Yes, we did the paperwork.
  ]
]

#section-slide("Results") // Drama break

#bips-slide(title: "Key Findings")[
  #two-columns[
    === Primary Outcome
    - Significant effect found 🎉
    - p < 0.001 (reviewer 2 can't complain)
    - Effect size: Cohen's d = 0.65
    - Clinical relevance: Actually meaningful!

    === Secondary Outcomes
    - Quality of life ↑
    - Healthcare costs ↓
    - Participants didn't hate it
  ][
    #pause
    === The Math Part
    We used a standard regression model:

    $ y_i = beta_0 + beta_1 x_i + epsilon_i $

    Where:
    - $y_i$ = outcome for participant $i$
    - $x_i$ = treatment (1 = got it, 0 = didn't)
    - $epsilon_i$ = random noise (always there)

  ]
]

#bips-slide(title: "Let's Walk Through This")[
  Here's what happened over time:

  At baseline, groups were pretty similar:
  - Control: 45.2 ± 8.1
  - Treatment: 44.8 ± 7.9

  #pause

  After 6 months — things got interesting:
  - Control: 46.1 ± 8.3 (barely moved)
  - Treatment: 52.7 ± 6.2

  #pause

  At 12 months — effect still there:
  - Control: 45.8 ± 8.5
  - Treatment: 54.1 ± 5.8

]

#bips-slide(title: "Limitations (Because Honesty)")[
  Every study has them. Here are ours:

  #callout(type: "warning", title: "The Not-So-Great Parts")[
    - Single center = limited generalizability
    - 15% dropped out (but equally across groups, so... yay?)
    - Only followed for 12 months (grants, am I right?)
    - Self-reported outcomes (people lie, we know)
  ]

]

#section-slide("Conclusions")

#bips-slide(title: "Take-Home Messages")[
  === What We Found
  1. The intervention *actually works* (still surprised)
  2. Effects last at least 12 months
  3. Effect size is clinically meaningful (not just p-hacking)
  4. Implementation seems feasible (important for the real world)

  === So What?
  - #green[Ready for prime time] — let's scale this up
  - #blue[Training materials ready] — 2-day workshop developed
  - #orange[Cost-effective] — neat
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.email@leibniz-bips.de",
  // qr-url: "https://your-data-repository.com", // Uncomment for QR code magic
)
