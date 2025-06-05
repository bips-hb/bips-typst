#import "@preview/touying:0.6.1": *

#let simple-theme(body) = {
  show: set text(font: ("Fira Sans", "Arial"), size: 18pt)
  
  touying-slides(
    config-page(
      paper: "presentation-16-9",
      margin: (top: 1.55cm, bottom: 1.55cm, left: 1.55cm, right: 1.75cm),
    ),
    body,
  )
}

#show: simple-theme

// Test 1: Regular slide with footnotes
#slide[
  = Test 1: Regular Slide
  
  Regular content with footnote#footnote[Regular footnote].
  
  More content here.
]

// Test 2: Slide with fixed height content area 
#slide[
  #box(height: 80%, width: 100%)[
    = Test 2: Fixed Height Box
    
    Content in fixed height box with footnote#footnote[Fixed height footnote].
    
    More content here.
  ]
]

// Test 3: Slide with grid layout like bips-slide
#slide[
  #grid(
    rows: (20%, 80%),
    [= Test 3: Grid Layout Title],
    [
      Content in grid with footnote#footnote[Grid footnote].
      
      More content here.
    ]
  )
]

// Test 4: Clean slide to see footnote bleed
#slide[
  = Test 4: Clean Slide
  
  This should have no footnotes from previous slides.
]