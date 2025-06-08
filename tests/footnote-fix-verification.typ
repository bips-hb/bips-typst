#import "@local/bips-typst:0.1.0": *

#show: bips-theme

#slide[
  = Verification: Regular Slide
  
  Regular slide with footnote#footnote[Regular slide footnote].
]

#bips-slide(title: "Verification: BIPS Slide")[
  BIPS slide with footnote#footnote[BIPS slide footnote - should appear at bottom of this slide].
  
  More content here.
]

#bips-slide(title: "Verification: Multiple Footnotes")[
  First footnote#footnote[First footnote content.] and second footnote#footnote[Second footnote content.].
  
  Both should appear at bottom of this slide only.
]

#bips-slide(title: "Verification: Clean Slide")[
  This slide should have no footnotes from previous slides.
  
  It should be completely clean.
]