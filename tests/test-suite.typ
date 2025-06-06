#import "bips-theme.typ": *

// Test Suite for BIPS Theme
// Run: typst compile test/test-suite.typ test/test-suite.pdf
// Expected: Specific number of pages without spurious blanks

#show: bips-theme

// Test 1: Basic animations (Expected: 3 pages)
#bips-slide(title: "Test 1: Basic Animation")[
  Point 1
  #pause
  Point 2
  #pause
  Point 3
]

// Test 2: Animation with content overflow risk (Expected: ? pages)
#bips-slide(title: "Test 2: Content Overflow")[
  #for i in range(20) [
    Line #i with some content that might overflow.
    #if i == 10 [ #pause ]
  ]
]

// Test 3: Footnotes (Expected: 1 page, footnotes at bottom)
#bips-slide(title: "Test 3: Footnotes")[
  Text with footnote#footnote[This should appear at bottom of this slide only.].

  More text with another footnote#footnote[Second footnote.].
]

// Test 4: Footnotes + Animation (Expected: 2 pages, footnotes stay with content)
#bips-slide(title: "Test 4: Footnotes + Animation")[
  Before pause with footnote#footnote[Pre-pause footnote.].
  #pause
  After pause with footnote#footnote[Post-pause footnote.].
]

// Test 5: Complex content (Expected: 1 page)
#bips-slide(title: "Test 5: Complex Content")[
  #table(
    columns: 3,
    [A], [B], [C],
    [1], [2], [3],
  )

  - List item 1
  - List item 2

  `Code block`

  *Bold* and _italic_ text.
]

// Test 6: Edge case - Very long title/subtitle (Expected: 1 page, no overflow)
#bips-slide(
  title: "Test 6: Very Long Title That Might Cause Layout Issues And Could Potentially Overflow",
  subtitle: "Also a very long subtitle that tests the layout constraints and spacing and is also otherwise perfectly cromulant",
)[
  Content after very long headers.

  Long headers should be avoided but it's better to have a linebreak than to overflow into the logo.
]

// Test 7: Animation with tables (Expected: 2 pages)
#bips-slide(title: "Test 7: Animation + Tables")[
  Before table:
  #pause

  #table(
    columns: 2,
    [Col 1], [Col 2],
    [Data 1], [Data 2],
  )
]

// Test 8: Callout blocks (Expected: 1 page)
#bips-slide(title: "Test 8: Callout Blocks")[
  #callout(type: "note")[Note callout test]
  #callout(type: "tip", title: "Custom Title")[Tip with title]
  #callout(type: "warning", icon: "🚨")[Warning with custom icon]
  #callout(type: "important")[Important callout]
]

// Test 9: Callouts with animation (Expected: 2 pages)
#bips-slide(title: "Test 9: Callouts + Animation")[
  #callout(type: "note")[Before pause]
  #pause
  #callout(type: "important")[After pause]
]

// Test 10: Column layouts (Expected: 1 page)
#bips-slide(title: "Test 10: Column Layouts")[
  #two-columns[
    Two column test - left
  ][
    Two column test - right
  ]

  #three-columns[Left][Center][Right]
]

// Test 11: Bibliography slide (Expected: 1 page)
// Note: Only if references.bib exists
// #bibliography-slide()

// Summary slide for manual verification
#bips-slide(title: "Test Results Summary", text-size: 14pt)[
  #two-columns(
    [
      *Expected Results:*
      - Test 1: 3 pages (animation states)
      - Test 2: Check for spurious blanks
      - Test 3: 1 page, footnotes at bottom
      - Test 4: 2 pages, footnotes with correct content
      - Test 5: 1 page, all elements render
      - Test 6: 1 page, no title overflow
      - Test 7: 2 pages, table after pause
      - Test 8: 1 page, all callout types render
      - Test 9: 2 pages, callouts with animation
      - Test 10: 1 page, column layouts work
    ],
    [
      *Manual Checks:*
      - Logo appears on all content slides
      - Page numbers increment correctly
      - No spurious blank pages
      - Footnotes don't bleed between slides
    ]
  )

]
