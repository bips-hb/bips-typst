#import "@preview/touying:0.6.1": *

#let bips-blue = rgb(23, 99, 170)
#let bips-text-gray = rgb(66, 66, 66)
#let font-size-slide-title = 24pt
#let font-weight-slide-title = 600
#let font-color-slide-title = bips-blue

// Minimal bips-slide function that just adds title and lets Touying handle layout
#let bips-slide-minimal(
  title: none,
  subtitle: none,
  ..args,
  body,
) = {
  slide(..args)[
    #if title != none {
      // Simple title without constrained blocks
      text(
        size: font-size-slide-title,
        weight: font-weight-slide-title,
        fill: font-color-slide-title,
      )[#title]
      
      // Simple line
      line(length: 85%, stroke: 0.5pt + bips-text-gray.lighten(60%))
      
      v(0.5em)
    }
    
    // Just put the body directly - no wrapping blocks
    #body
  ]
}

#let simple-theme(body) = {
  show: set text(
    font: ("Fira Sans", "Arial"),
    size: 18pt,
    fill: bips-text-gray,
  )
  
  touying-slides(
    config-page(
      paper: "presentation-16-9",
      margin: (top: 1.55cm, bottom: 1.55cm, left: 1.55cm, right: 1.75cm),
    ),
    body,
  )
}

#show: simple-theme

#slide[
  = Regular Touying Slide
  
  This uses regular touying slide function.
  
  This slide has footnotes#footnote[First footnote with regular slide.].
  
  More content with another footnote#footnote[Second footnote test.].
]

#bips-slide-minimal(title: "Minimal BIPS Slide")[
  This uses our minimal bips-slide function.
  
  This slide has footnotes#footnote[First footnote with minimal bips-slide.].
  
  More content with another footnote#footnote[Second footnote with minimal bips-slide.].
]

#bips-slide-minimal(title: "After Footnotes")[
  This slide should be clean with no footnotes from previous slide.
]