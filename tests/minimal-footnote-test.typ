#import "bips-theme.typ": *

#show: bips-theme

#bips-slide(title: "Footnote Test")[
  Some content with a footnote#footnote[This is a footnote that should stay on this slide.].
  
  More content here.
]

#bips-slide(title: "Next Slide")[
  This slide should be clean with no footnotes from the previous slide.
]