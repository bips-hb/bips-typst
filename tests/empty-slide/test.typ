// Test: empty-slide (no branding)
#import "/bypst.typ": *
#show: bips-theme
#title-slide(title: "Test")

#empty-slide[
  #align(center + horizon)[
    This slide has no logo, no page number, no branding.
  ]
]

// count: true keeps the slide in the numbered sequence and shows the number
#empty-slide(count: true)[
  #align(center + horizon)[
    Chrome-free but still counted; the page number is shown.
  ]
]

// slide-level passthrough: a full-bleed background via config-page, plus the
// new content-align argument instead of a manual #align wrapper
#empty-slide(
  config: config-page(fill: bips-blue),
  content-align: center + horizon,
)[
  #text(fill: white)[Full-bleed background via config passthrough]
]

// composer: full-bleed multi-pane layout with multiple content blocks
#empty-slide(composer: (1fr, 1fr))[
  #rect(fill: bips-blue, width: 100%, height: 100%)
][
  #rect(fill: bips-orange, width: 100%, height: 100%)
]

// New toggles: logo on, number on, while staying counted.
#empty-slide(count: true, show-logo: true)[
  Full-bleed-ish slide that keeps the logo and counts in the sequence.
]

// Number explicitly off even though counted.
#empty-slide(count: true, page-number: false)[Counted but no visible number.]

// Logo on without counting.
#empty-slide(show-logo: true)[Logo, no number, not counted.]
