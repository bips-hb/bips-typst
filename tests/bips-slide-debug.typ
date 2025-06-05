#import "bips-theme.typ": *

#show: bips-theme

// Test our specific bips-slide function vs regular slide

#slide[
  = Regular Touying Slide
  
  This uses regular touying slide function.
  
  This slide has footnotes#footnote[First footnote with regular slide.].
  
  More content with another footnote#footnote[Second footnote test.].
]

#slide[
  = Regular Slide - After
  
  Regular slide after footnotes.
  
  Should be clean.
]

#bips-slide(title: "BIPS Slide Function")[
  This uses our custom bips-slide function.
  
  This slide has footnotes#footnote[First footnote with bips-slide.].
  
  More content with another footnote#footnote[Second footnote with bips-slide.].
]

#bips-slide(title: "BIPS Slide - After")[
  BIPS slide after footnotes.
  
  Should be clean.
]