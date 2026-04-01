#import "@local/bips-typst:0.1.1": *

#show: bips-theme

#title-slide(
  title: "Multi-Column Layouts",
  subtitle: "Simplified column helpers",
  author: "BIPS Research Team",
  institute: bips_en,
  date: datetime.today().display(),
)

#bips-slide(title: "Two-Column Layout")[
  Simple two-column layout with equal columns:

  #two-columns[
    === Left Column
    - Easy to use
    - Equal width by default
    - Clean syntax
    - No need to specify `grid()`
  ][
    === Right Column
    - Perfect for comparisons
    - Side-by-side content
    - Automatic spacing
    - Responsive design
  ]
]

#bips-slide(title: "Two Columns with Options")[
  Customized column widths and spacing:

  #two-columns(
    columns: (2fr, 1fr),
    gutter: 2em,
  )[
    === Wider Left Column (2fr)
    This column takes up twice the space of the right column. Perfect for main content with a sidebar.

    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  ][
    === Narrow Right (1fr)
    Sidebar content here.

    - Note 1
    - Note 2
    - Note 3
  ]
]

#bips-slide(title: "Three-Column Layout")[
  Equal three-column layout:

  #three-columns[
    === Method A
    - Accuracy: 85%
    - Speed: Fast
    - Cost: Low
  ][
    === Method B
    - Accuracy: 92%
    - Speed: Medium
    - Cost: Medium
  ][
    === Method C
    - Accuracy: 97%
    - Speed: Slow
    - Cost: High
  ]
]

#bips-slide(title: "Three Columns with Custom Widths")[
  #three-columns(
    columns: (1fr, 2fr, 1fr),
    gutter: 1.5em,
  )[
    === Narrow
    Side content
  ][
    === Wide Center
    Main content goes in the center column with more space for detailed information.
  ][
    === Narrow
    Side content
  ]
]

#bips-slide(title: "Columns with Callouts")[
  Combining columns with callout blocks:

  #two-columns[
    #callout(type: "tip", title: "Best Practice")[
      Use two columns for direct comparisons.
    ]

    Left side content continues here.
  ][
    #callout(type: "warning", title: "Limitation")[
      Avoid too many columns on slides.
    ]

    Right side content continues here.
  ]
]

#bips-slide(title: "Compact Lists in Columns")[
  Use `#compact` to tighten list spacing in dense layouts:

  #three-columns[
    Default:
    - Item A
    - Item B
    - Item C
  ][
    #compact[
      Compact:
      - Item A
      - Item B
      - Item C
    ]
  ][
    #compact(spacing: 0.2em, leading: 0.2em)[
      Tighter:
      - Item A
      - Item B
      - Item C
    ]
  ]
]

#bips-slide(title: "Compact with Line Breaks")[
  `#compact` also tightens intra-item line breaks:

  #two-columns[
    Default spacing:
    - First item with a \ second line
    - Second item
    - Third item with a \ longer description
  ][
    #compact[
      Compact spacing:
      - First item with a \ second line
      - Second item
      - Third item with a \ longer description
    ]
  ]
]

#bips-slide(title: "Usage Examples")[
  *Basic two columns:*
  ```typst
  #two-columns[
    Left content
  ][
    Right content
  ]
  ```

  *Custom widths:*
  ```typst
  #two-columns(
    columns: (2fr, 1fr),
    gutter: 2em,
  )[Wide left][Narrow right]
  ```

  *Three columns:*
  ```typst
  #three-columns[A][B][C]
  ```
]

#bips-slide(title: "Practical Research Example")[
  #two-columns(columns: (1.5fr, 1fr))[
    === Study Results

    Our analysis revealed:
    - Primary outcome: p < 0.001
    - Secondary outcome: p = 0.03
    - Effect size: d = 0.85

    #callout(type: "important")[
      Significant improvement observed
    ]
  ][
    #align(center)[
      #rect(
        width: 100%,
        height: 8em,
        fill: bips-text-gray.lighten(80%),
        [_Chart placeholder_],
      )
    ]

    _Figure 1: Treatment effects_
  ]
]

#thanks-slide(
  contact-author: "BIPS Research Team",
  email: "research@leibniz-bips.de",
)
