#import "@local/bips-typst:0.1.0": *

#show: bips-theme

#title-slide(
  title: "Academic Content Elements",
  subtitle: "Images, tables, and references in presentations",
  author: "Research Author",
  institute: "BIPS",
  date: datetime.today().display(),
)

#bips-slide(
  title: "Including Images",
  subtitle: "With and without captions",
)[
  Basic image inclusion:

  #align(center)[
    #image("bips-logo.png", width: 20%)
  ]

  Images can be sized using `width` or `height` parameters and aligned as needed. Use local files like `"image.png"` or `"figures/chart.svg"`.
]

#bips-slide(
  title: "Images with Captions",
  subtitle: "Using figure blocks",
)[
  #figure(
    image("bips-logo.png", width: 25%),
    caption: [Example data visualization showing research findings],
  )

  The `figure` function automatically handles numbering and spacing. Captions can reference the image content or data source.
]

#bips-slide(
  title: "Basic Tables",
  subtitle: "Simple data presentation",
)[
  #table(
    columns: 3,
    align: center,
    [*Variable*], [*Mean*], [*SD*],
    [Age], [45.2], [12.8],
    [BMI], [24.1], [3.4],
    [Blood Pressure], [128/82], [15/8],
  )

  Tables use the theme's elegant default styling with subtle header highlighting and minimal borders.
]

#bips-slide(
  title: "Custom Table Styling",
  subtitle: "Overriding defaults when needed",
  text-size: 16pt,
)[
  #text(size: 14pt)[
    #table(
      columns: (1fr, 0.8fr, 0.8fr, 0.8fr, 1.2fr),
      align: (left, center, center, center, left),
      stroke: 0.5pt, // Override default for full grid
      [*Study*], [*N*], [*Age*], [*Effect*], [*CI (95%)*],
      [Johnson et al.], [245], [52.1], [0.82], [0.65-1.03],
      [Smith et al.], [189], [48.7], [0.91], [0.74-1.12],
      [Brown et al.], [312], [55.3], [0.76], [0.61-0.95],
      [Meta-analysis], [746], [51.8], [0.83], [0.72-0.96],
    )
  ]

  You can override the default styling with parameters like `stroke:` for different table needs.
]

#bips-slide(title: "Footnotes and References")[
  === Testing Footnotes
  Our theme now properly supports footnotes#footnote[This footnote should appear only on this slide.].

  === Multiple Footnotes
  Text with first note#footnote[First footnote content.] and text with second note#footnote[Second footnote with more details.].
]

#bips-slide(title: "Bibliographic References")[
  Academic presentations often require citations:

  - Previous research shows significant effects @johnson2023
  - Meta-analyses confirm these findings @smith2022
  - Recent studies suggest new directions @brown2024

  References can be managed using Typst's bibliography system with standard academic formats.
]

// Using the bibliography slide helper for cleaner code
#bibliography-slide[
  #bibliography("references.bib", style: "apa", full: true)
]


#bips-slide(title: "Content Best Practices")[
  For effective academic presentations:

  === Images
  - Use consistent sizing and alignment
  - Include informative captions when needed
  - Ensure images are readable at presentation size

  === Tables
  - Adjust font size to fit content (`text-size` parameter)
  - Use clear column headers and alignment
  - Consider splitting large tables across slides

  === References
  - Use inline citations with author-year format during slides
  - Create dedicated bibliography slide for full references
  - Avoid footnotes in presentations (use parenthetical notes instead)
  - Keep citation style consistent throughout
]

#thanks-slide(
  contact-author: "Research Author",
  email: "research@leibniz-bips.de",
)
