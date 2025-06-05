#import "@preview/touying:0.6.1": *

// Minimal working Touying presentation
#let my-theme(body) = touying-slides(
  config-page(
    paper: "presentation-16-9",
    margin: (x: 2cm, y: 1cm),
  ),
  body,
)

#show: my-theme

#slide[
  = Slide 1 - No Footnotes

  This slide has no footnotes.

  - Point 1
  - Point 2
]

#slide[
  = Slide 2 - With Footnotes

  - This slide has footnotes#footnote[First footnote content.].
  - More content with another footnote#footnote[Second footnote.].
  - Some more text for debugging purposes
  - Just checking if this does anything
]

#slide[
  = Slide 3 - After Footnotes

  This slide comes after footnotes.

  Should be normal content only.
]
