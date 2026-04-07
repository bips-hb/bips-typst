// Complete Feature Showcase — BIPS Typst Theme
//
// This file demonstrates all major features of the BIPS theme and the
// Touying presentation framework it is built on. It serves as both a
// gallery demo and user-facing documentation.
//
// Features are annotated with their source:
//   [BIPS]   — provided by the BIPS theme (theme.typ)
//   [Touying] — provided by the Touying package
//   [Typst]  — built-in Typst functionality
//
// Run: typst compile --root . gallery/complete.typ

#import "../bypst.typ": *

// [BIPS] Apply the BIPS theme with default settings.
// Optional overrides: base-size, slide-title-size, heading-*-size, etc.
#show: bips-theme

// ===================================================================
// TITLE SLIDE
// ===================================================================

// [BIPS] Multi-author title slide with institute affiliations.
// Use `author:` for a single author, or `authors:` + `institutes:` for
// multiple affiliations with superscript numbering via `inst()`.
#title-slide(
  title: "Bypst: The BIPS Typst Theme",
  subtitle: "A Complete Feature Showcase",
  authors: (
    [Jane Doe#inst(1)],
    [John Smith#inst(2)],
    [Alice Johnson#inst(1, 2)],
  ),
  institutes: (
    "Leibniz Institute for Prevention Research and Epidemiology — BIPS",
    "University of Bremen",
  ),
  date: datetime.today().display(),
  occasion: "The 27th Conference on Typst Presentations",
)

// ===================================================================
// SLIDE TYPES
// ===================================================================

// [BIPS] Section slides create visual dividers. They don't consume a
// slide number and appear in the PDF outline for navigation.
#section-slide[Slide Types]

// [BIPS] Content slide with title and subtitle — the workhorse slide type.
// Text formatting is auto-styled by the theme:
#bips-slide(
  title: "Text Formatting",
  subtitle: "Automatic styling from the BIPS theme",
)[
  // [BIPS] Bold and emphasis are automatically colored in BIPS blue:
  - *Bold text* renders in BIPS blue — use for key terms
  - _Emphasized text_ renders in blue italic — use for concepts
  - #link("https://typst.app")[Links] appear with a blue underline
  - Regular text uses the base gray color

  // [Typst] Standard Typst formatting works as expected:
  - Inline `code` uses Fira Mono at matching metrics
  - Footnotes work naturally#footnote[Like this one — appears at the slide bottom.]
]

// [BIPS] Content slide with title only (no subtitle) — renders slightly larger.
#bips-slide(title: "Color Utilities & Headings")[
  // [BIPS] Color helper functions for inline coloring:
  #blue[`#blue[]`], #orange[`#orange[]`], #green[`#green[]`], #gray[`#gray[]`]
  = Heading level 1
  == Heading level 2
  // [BIPS] Headings are styled in BIPS blue at all levels:
  === Heading Level 3
  Content below a heading. Levels 1--2 render in BIPS blue with
  em-based sizing that scales proportionally with `base-size`.
]

// ===================================================================
// LAYOUT & UTILITIES
// ===================================================================

#section-slide[Layout & Utilities]

// [BIPS] Two-column and three-column layout helpers.
// Alternatives: Touying's `components.side-by-side[][]` or Typst's built-in
// `grid()` work the same way inside a slide body.
// See https://typst.app/docs/reference/layout/grid/
#bips-slide(title: "Multi-Column Layouts")[
  // [BIPS] `two-columns[][]{:}` — equal widths by default
  #two-columns[
    *Left column*

    Default 1fr / 1fr split. Useful for text + image or side-by-side comparisons.
  ][
    *Right column*

    Custom widths: `two-columns(columns: (2fr, 1fr))[...][...]`
  ]

  #v(1em)

  // [BIPS] `three-columns[][][]` — three equal columns
  #three-columns[
    #blue[Column A]
  ][
    #orange[Column B]
  ][
    #green[Column C]
  ]
]

// [BIPS] Callout blocks — styled boxes for notes, tips, warnings, etc.
#bips-slide(title: "Callout Blocks")[
  #callout(type: "note")[Default note — icon appears inline with content.]

  #callout(type: "tip", title: "Pro Tip")[
    Use `title:` to add a header line to any callout type.
  ]

  #callout(type: "warning")[Warnings use BIPS orange for high visibility.]

  #callout(
    type: "important",
  )[Important callouts use red for critical information.]
]

// [BIPS] Images and figures — standard Typst image inclusion.
#bips-slide(title: "Images & Figures")[
  // [Typst] Basic image inclusion with sizing:
  #two-columns[
    #align(center)[
      #image("/bips-logo.png", height: 50%)
    ]
    Images are included with `#image()` and sized
    via `width` or `height`.
  ][
    // [Typst] `figure()` adds numbering and captions:
    #figure(
      image("/bips-logo.png", width: 50%),
      caption: [The BIPS logo],
    )
  ]
]

// [BIPS] Tables and math — styled automatically by the theme.
#bips-slide(title: "Tables & Mathematics")[
  // [Typst] Tables are auto-styled with BIPS blue header row and subtle borders:
  #two-columns[
    #table(
      columns: 3,
      [*Method*], [*MSE*], [*AUC*],
      [Random Forest], [0.042], [0.91],
      [Gradient Boosting], [0.038], [0.93],
      [Neural Net], [0.035], [0.94],
    )
  ][
    // [Typst] Display and inline math:
    The estimator is unbiased:

    $ hat(theta)_n = 1/n sum_(i=1)^n X_i $

    with variance $"Var"(hat(theta)_n) = sigma^2 / n$.
  ]
]

// [BIPS] Text size utilities and compact spacing.
#bips-slide(title: "Text Sizes & Compact Spacing")[
  Normal body text at the default `base-size` (18pt).

  // [BIPS] `#small[]` and `#tiny[]` scale proportionally with base-size:
  #small[`#small[]` — useful for source attributions or secondary information.]

  #tiny[`#tiny[]` — the smallest preset, for disclaimers or fine print.]

  #v(0.5em)

  // [BIPS] `#compact[]` reduces list/enum spacing for dense content:
  #two-columns[
    *Normal spacing:*
    - Item A
    - Item B
    - Item C
  ][
    *Compact spacing:*
    #compact[
      - Item A
      - Item B
      - Item C
    ]
  ]
]

// [BIPS] Vertical fill and content alignment.
#bips-slide(title: "Vertical Fill & Alignment")[
  Top-aligned content (the default).

  // [BIPS] `#vfill` is shorthand for `v(1fr)` — pushes content apart:
  #vfill

  Bottom content, pushed down by `#vfill` between the two blocks.
]

// ===================================================================
// ANIMATIONS (TOUYING)
// ===================================================================

#section-slide[Animations]

// [Touying] `#pause` — the simplest animation. Content before each #pause
// appears on the current subslide; content after appears on the next click.
// Slide numbers stay consistent across all subslides.
#bips-slide(
  title: "Incremental Reveals with #pause",
  subtitle: "Touying's simplest animation primitive",
)[
  - This point is visible from the start
  #pause
  - This appears on click 2
  #pause
  - This appears on click 3

  #pause
  Equations can also be revealed: $E = m c^2$
]

// [Touying] `#uncover()` and `#only()` — fine-grained subslide control.
// Unlike #pause (which is sequential), these target specific subslides.
#bips-slide(
  title: "Fine-Grained Animations",
  subtitle: "Touying: #uncover and #only",
)[
  // [Touying] `uncover("2-")` makes content invisible (but space-reserving)
  // until subslide 2. Subslide specs: "2", "2-", "2-4", "-3".
  Always visible content.
  #pause

  #uncover("3-")[This appears from subslide 3 onward.]

  #only("2")[_This text is only on subslide 2 — then it vanishes._]
]

// [Touying] `#alternatives` — replace content in-place across subslides.
// Useful for showing different versions of the same element.
#bips-slide(
  title: "Replacing Content with #alternatives",
  subtitle: "Touying: swapping content in-place",
)[
  The current analysis method is:

  #alternatives[
    *Step 1:* Data collection and cleaning
  ][
    *Step 2:* Exploratory analysis and visualization
  ][
    *Step 3:* Model fitting and validation
  ]

  #small[(Switch slides to cycle between steps)]
]

// [Touying] `#meanwhile` — synchronize multi-column animations.
// The right column starts fresh when #meanwhile is reached.
#bips-slide(
  title: "Multi-Column Animations",
  subtitle: "Touying: #pause in grids with #meanwhile",
)[
  #grid(columns: (1fr, 1fr))[
    *Left column:*
    - Data collection
    #pause
    - Preprocessing
    #pause
    - Feature engineering
  ][
    #meanwhile
    *Right column* appears at the same time as the left column begins.
    - Synchronized content across columns
  ]
]

// [Touying] `#pause` works inside math environments too.
#bips-slide(
  title: "Step-by-Step Equations",
  subtitle: "Touying: #pause inside math blocks",
)[
  Completing the square:

  $
      f(x) & = x^2 + 4x + 4 \
    #pause & = (x + 2)^2
  $

  #pause
  Therefore, the vertex is at $x = -2$.
]

// ===================================================================
// CUSTOMIZATION
// ===================================================================

#section-slide[Customization]

#bips-slide(
  title: "Per-Slide Overrides",
  subtitle: "BIPS theme: text-size, title-size, code-block-scale",
  text-size: 16pt,
  code-block-scale: 1, // Keep code block at 100% so it's not too small
)[
  // [BIPS] Individual slides can override text-size, title-size,
  // subtitle-size, code-block-scale, and code-inline-scale.
  This slide uses `text-size: 16pt` (default is 18pt), which allows
  fitting more content when needed.\
  You can adjust global defaults:
  
  // [Typst] Code blocks are auto-styled with Fira Mono:
  ```typst
  #show: bips-theme.with(
    base-size: 20pt,          // Scale everything up
    heading-1-size: 24pt,     // Explicit heading override
    code-block-scale: 0.75,   // Smaller code blocks
  )
  ```
  
  Or override defaults per slide
  
  ```typst
    #bips-slide(
      title: "Per-Slide Overrides",
      subtitle: "BIPS theme: text-size, title-size, code-block-scale",
      text-size: 16pt,
      code-block-scale: 1, // Keep code block at 100% so it's not too small
    )[...]
  ```
]

// [BIPS] Section slide without logo — `show-logo: false`.
#section-slide("Special Slides", show-logo: false)

// [BIPS] Empty slide — no logo, no page number, no branding.
// Useful for full-bleed images, transitions, or special layouts.
#empty-slide[
  #align(center + horizon)[
    _This is an empty slide_ — no logo, no page number.

    Useful for full-bleed images or transition screens.
  ]
]

// [BIPS] Thanks/contact slide with QR code.
// Use `qr-url:` to generate a QR code, or omit it to show the BIPS website.
#thanks-slide(
  thanks-text: "Thank you for your attention!",
  contact-author: "Dr. Jane Doe",
  email: "jane.doe@leibniz-bips.de",
  qr-url: "https://github.com/bips-hb/bips-typst",
)
