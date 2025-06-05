#import "@preview/touying:0.6.1": *

// Test BIPS theme parts individually to find footnote issue

// Basic colors (safe)
#let bips-blue = rgb(23, 99, 170)
#let bips-text-gray = rgb(66, 66, 66)

// Basic font configuration only
#let minimal-bips-theme(body) = {
  show: set text(
    font: ("Fira Sans", "Arial"),
    size: 18pt,
    fill: bips-text-gray,
  )
  
  // Use standard Touying
  touying-slides(
    config-page(
      paper: "presentation-16-9",
      margin: (top: 1.55cm, bottom: 1.55cm, left: 1.55cm, right: 1.75cm),
    ),
    body,
  )
}

#show: minimal-bips-theme

#slide[
  = Test 1 - Minimal Theme
  
  Testing with just basic font configuration.
  
  This slide has footnotes#footnote[First footnote with minimal theme.].
  
  More content with another footnote#footnote[Second footnote test.].
]

#slide[
  = Test 2 - After Footnotes
  
  This slide should show only its own content.
  
  No footnotes from previous slide should appear here.
]