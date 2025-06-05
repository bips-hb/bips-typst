#import "@preview/touying:0.6.1": *

#let bips-blue = rgb(23, 99, 170)
#let bips-text-gray = rgb(66, 66, 66)

#let test-theme(body) = {
  show: set text(
    font: ("Fira Sans", "Arial"),
    size: 18pt,
    fill: bips-text-gray,
  )
  
  // Add show rules one by one to test which breaks footnotes
  
  // Test 1: Emphasis rule
  show emph: it => text(fill: bips-blue, style: "italic", weight: "regular")[#it.body]
  
  // Test 2: Strong rule  
  show strong: it => text(fill: bips-blue, weight: "bold")[#it.body]
  
  // Test 3: Link rule
  show link: it => underline(text(fill: bips-blue)[#it])
  
  // Test 4: Table rules (suspicious)
  set table(
    stroke: none,
    fill: (_, y) => if y == 0 { bips-blue.lighten(85%) } else { none },
    inset: (x: 0.7em, y: 0.6em),
  )
  
  show table: it => block(
    stroke: (
      top: 1pt + bips-blue.lighten(50%), 
      bottom: 1pt + bips-blue.lighten(50%)
    ),
    inset: 0pt,
    it
  )
  
  touying-slides(
    config-page(
      paper: "presentation-16-9",
      margin: (top: 1.55cm, bottom: 1.55cm, left: 1.55cm, right: 1.75cm),
    ),
    body,
  )
}

#show: test-theme

#slide[
  = Test - Show Rules
  
  Testing with all our show rules.
  
  This slide has footnotes#footnote[First footnote with show rules.].
  
  More content with another footnote#footnote[Second footnote test.].
]

#slide[
  = Test - After Footnotes
  
  This slide should show only its own content.
  
  No footnotes from previous slide should appear here.
]