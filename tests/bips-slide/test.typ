// Test: bips-slide with title, subtitle, and content variations
#import "/bypst.typ": *
#show: bips-theme

#title-slide(title: "Test")

// Title + subtitle
#bips-slide(title: "Title and Subtitle", subtitle: "The subtitle")[
  Content with *bold* and _emphasis_.
]

// Title only (renders larger)
#bips-slide(title: "Title Only")[
  Content without a subtitle.
]

// Subtitle only
#bips-slide(subtitle: "Just a Subtitle")[
  This slide has only a subtitle.
]

// Headings at all three levels
#bips-slide(title: "Heading Levels")[
  = Level 1 Heading
  Content under h1.

  == Level 2 Heading
  Content under h2.

  === Level 3 Heading
  Content under h3.
]

// Lists and enums
#bips-slide(title: "Lists")[
  - Item one
  - Item two
    - Nested item
  - Item three

  + First
  + Second
  + Third
]

// Inline code and code blocks
#bips-slide(title: "Code")[
  Inline `code` and a block:

  ```typst
  #let x = 42
  ```
]

// Footnotes
#bips-slide(title: "Footnotes")[
  Text with a footnote#footnote[This is the footnote text.] and another#footnote[Second footnote.].
]

// Content alignment
#bips-slide(title: "Center Aligned", content-align: center + horizon)[
  This content is centered both horizontally and vertically.
]

// Math
#bips-slide(title: "Mathematics")[
  Inline math: $x^2 + y^2 = z^2$

  Display math:
  $ hat(theta)_n = 1/n sum_(i=1)^n X_i $
]

// Long title must not push the divider down (shrink-to-fit safeguard).
#bips-slide(
  title: "A very long slide title that would otherwise wrap onto two or three lines and overflow the fixed header box height quite badly indeed",
  subtitle: "with a subtitle underneath as well",
)[
  The divider should sit at the same height as on a short-title slide.
]
