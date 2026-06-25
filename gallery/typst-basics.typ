// Typst Basics — bypst gallery
//
// Native Typst features useful inside a bips slide, aimed at users coming
// from LaTeX/Beamer who don't yet know Typst itself. Features here are
// intentionally distinct from complete.typ (which showcases the bips theme
// and Touying). Everything below is built-in Typst — no extra packages.
//
//   [Typst] — built-in Typst functionality
//
// Run: typst compile --root . gallery/typst-basics.typ

#import "../bypst.typ": *

#show: bips-theme

#title-slide(
  title: "Typst Basics",
  subtitle: "Native features for the LaTeX crowd",
  author: "Your Name",
  institute: bips-en,
  date: datetime.today().display(),
)

// [Typst] Block quotes carry an attribution.
#bips-slide(title: "Quotes")[
  #quote(block: true, attribution: [Donald Knuth])[
    The best programs are written so that computing machines can perform them
    quickly and so that human beings can understand them clearly.
  ]

  #small[`#quote(block: true, attribution: [...])[...]`]
]

// [Typst] Term lists: "/ Term: definition" — like LaTeX description lists.
#bips-slide(title: "Term lists")[
  / Estimand: the quantity a study aims to estimate.
  / Estimator: a rule for computing an estimate from data.
  / Estimate: the value an estimator produces on a sample.

  #small[`/ Term: definition` per line]
]

// [Typst] Tables: plain, then styled with a header row, fills, and alignment.
#bips-slide(title: "Tables")[
  #table(
    columns: 3,
    table.header[Model][AUC][Brier],
    [Logistic], [0.81], [0.14],
    [Random forest], [0.86], [0.11],
    [XGBoost], [0.88], [0.10],
  )

  #small[`table.header[..]`, `columns:`, plus `fill:`/`stroke:`/`align:`]
]

// [Typst] Styled table: zebra fill + right-aligned numerics.
#bips-slide(title: "Styled tables")[
  #table(
    columns: (auto, 1fr, 1fr),
    align: (left, right, right),
    fill: (_, row) => if calc.odd(row) { luma(245) },
    stroke: none,
    table.header[Model][AUC][Brier],
    [Logistic], [0.81], [0.14],
    [Random forest], [0.86], [0.11],
    [XGBoost], [0.88], [0.10],
  )
]

// [Typst] Figures carry captions and can be cross-referenced with @label.
#bips-slide(title: "Figures and cross-references")[
  #figure(
    rect(width: 4cm, height: 2cm, fill: color.blue.lighten(70%))[#align(
      center + horizon,
    )[A figure]],
    caption: [A placeholder figure.],
  ) <fig-demo>

  See @fig-demo for an example. Reference any labelled element with `@label`.
]

// [Typst] Footnotes attach to the slide.
#bips-slide(title: "Footnotes")[
  Typst resolves footnotes automatically#footnote[Like this one, rendered at
    the bottom of the slide.] and numbers them in document order.

  #small[`#footnote[...]`]
]

// [Typst] Raw blocks get syntax highlighting by language tag.
#bips-slide(title: "Code blocks")[
  ```python
  def estimate(data):
      return sum(data) / len(data)
  ```

  #small[Fenced with a language tag for highlighting.]
]

// [Typst] Links: external URLs and internal references.
#bips-slide(title: "Links")[
  External: #link("https://typst.app/docs")[the Typst documentation].

  Internal: jump back to #link(<fig-demo>)[the figure].

  #small[`#link("url")[..]` and `#link(<label>)[..]`]
]

// [Typst] Numbered equations are referenced like figures.
#bips-slide(title: "Numbered equations")[
  #set math.equation(numbering: "(1)")

  $ overline(x) = 1/n sum_(i=1)^n x_i $ <eq-mean>

  The sample mean @eq-mean averages the observations.
]

// [Typst] Enum and list styling: custom numbering and markers.
#bips-slide(title: "List and enum styling")[
  #set enum(numbering: "1.a)")
  + First
    + nested lower-alpha
    + second nested
  + Second

  #list(marker: ([▸], [–]))[
    Custom markers
  ][
    per nesting level
  ]
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.name@leibniz-bips.de",
)
