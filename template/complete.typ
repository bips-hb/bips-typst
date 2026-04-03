// Local package (after running `just install` in the bips-typst repo):
#import "@local/bips-typst:0.2.0": *
// When published to Typst Universe, change to:
// #import "@preview/bips-typst:0.2.0": *

#show: bips-theme.with(
  base-size: 18pt,
  slide-title-size: 26pt,
)

#title-slide(
  title: "Complete BIPS Presentation Example",
  subtitle: "Showcasing all features",
  authors: (
    "Jane Doe" + inst(1, 2),
    "John Smith" + inst(1),
  ),
  institutes: (
    bips_en,
    "University of Bremen",
  ),
  date: datetime.today().display(),
  occasion: "Annual Conference 2025",
)

#bips-slide(title: "Features Overview")[
  This template includes:

  - Multiple slide types
  - Callout boxes
  - Animations
  - Multi-column layouts
  - Bibliography support
  - QR code generation
]

#section-slide("Examples")

#bips-slide(title: "Callout Boxes")[
  #callout(type: "note")[
    This is a note callout.
  ]

  #callout(type: "tip")[
    This is a tip callout.
  ]

  #callout(type: "warning")[
    This is a warning callout.
  ]

  #callout(type: "important")[
    This is an important callout.
  ]
]

#bips-slide(title: "Animations")[
  - First item

  #pause

  - Second item appears on click

  #pause

  - Third item appears last
]

#thanks-slide(
  contact-author: "Jane Doe",
  email: "jane.doe@leibniz-bips.de",
  qr-url: "https://github.com/bips-hb/bips-typst",
)
