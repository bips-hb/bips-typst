#import "../bypst.typ": *

// Test Suite for BIPS Theme
// Run: typst compile tests/test-suite.typ tests/test-suite.pdf
// Expected: Specific number of pages without spurious blanks

#show: bips-theme

// ===================================================================
// SLIDE TYPE TESTS
// ===================================================================

// Test: Title slide - single author (Expected: 1 page, no page number)
#title-slide(
  title: "Test: Title Slide",
  subtitle: "Single author variant",
  author: "Test Author",
  institute: bips_en,
  date: "2025-01-01",
)

// Test: Title slide - multi-author (Expected: 1 page, no page number)
#title-slide(
  title: "Test: Multi-Author Title",
  subtitle: "Multiple affiliations",
  authors: ([Author A#inst(1)], [Author B#inst(2)], [Author C#inst(1, 2)]),
  institutes: ("Institute Alpha", "Institute Beta"),
  date: "2025-01-01",
  occasion: "Test Conference",
)

// Test: Section slide (Expected: 1 page, logo visible, no page number)
#section-slide("Test: Section Slide")

// Test: Section slide without logo (Expected: 1 page, no logo, no page number)
#section-slide("Test: Section No Logo", show-logo: false)

// ===================================================================
// CONTENT SLIDE TESTS
// ===================================================================

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
// Note: Only if references.bib exists in the test directory
// #bibliography-slide[
//   #bibliography("references.bib", style: "apa", full: true)
// ]

// ===================================================================
// SPECIAL SLIDE TESTS
// ===================================================================

// Test: Empty slide (Expected: 1 page, no logo, no page number)
#empty-slide[
  This slide has no branding elements.
]

// Test: Thanks slide without QR (Expected: 1 page)
#thanks-slide(
  contact-author: "Test Author",
  email: "test@leibniz-bips.de",
)

// Test: Thanks slide with QR code (Expected: 1 page)
#thanks-slide(
  thanks-text: "Questions?",
  contact-author: "Test Author",
  email: "test@leibniz-bips.de",
  qr-url: "https://github.com/bips-hb/bips-typst",
)

// ===================================================================
// UTILITY AND STYLING TESTS
// ===================================================================

// Test 11: small[] and tiny[] utilities (Expected: 1 page)
#bips-slide(title: "Test 11: Small and Tiny Utilities")[
  Normal text at base size.

  #small[This text uses the #raw("#small[]") utility — smaller than base.]

  #tiny[This text uses the #raw("#tiny[]") utility — smallest size.]

  Back to normal text.
]

// Test 12: compact layout helper (Expected: 1 page)
#bips-slide(title: "Test 12: Compact Layout")[
  #two-columns[
    #compact[
      - Compact item A
      - Compact item B
      - Compact item C
      - Compact item D
    ]
  ][
    #compact(spacing: 0.2em, leading: 0.2em)[
      - Extra compact A
      - Extra compact B
      - Extra compact C
      - Extra compact D
    ]
  ]
]

// Test 13: content-align parameter (Expected: 1 page)
#bips-slide(
  title: "Test 13: Content Alignment",
  content-align: center + horizon,
)[
  This content should be centered both horizontally and vertically.
]

// Test 14: vfill helper (Expected: 1 page)
#bips-slide(title: "Test 14: Vertical Fill")[
  Top content.
  #vfill
  Bottom content pushed down by `#vfill`.
]

// Test 15: Heading levels 1, 2, 3 styling (Expected: 1 page)
#bips-slide(title: "Test 15: Heading Levels")[
  = Heading Level 1

  == Heading Level 2

  === Heading Level 3

  All headings should render in BIPS blue with bold weight.
]

// ===================================================================
// SUMMARY
// ===================================================================

// Summary slide for manual verification
#bips-slide(title: "Test Results Summary", text-size: 14pt)[
  #two-columns(
    [
      *Slide Type Tests:*
      - Title slide (single author): 1 page
      - Title slide (multi-author): 1 page
      - Section slide: 1 page each
      - Empty slide: 1 page
      - Thanks slide (no QR): 1 page
      - Thanks slide (with QR): 1 page

      *Content Tests (1--10):*
      - Test 1: 3 pages (animations)
      - Test 2: Content overflow
      - Tests 3--10: Various features
    ],
    [
      *Manual Checks:*
      - Title slides have no page number
      - Section slides have logo, no page number
      - Empty slide has no branding
      - Thanks slides render correctly
      - Logo appears on all content slides
      - Page numbers increment correctly
      - No spurious blank pages
    ],
  )
]
