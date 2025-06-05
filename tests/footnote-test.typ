#import "bips-theme.typ": *

#show: bips-theme

#title-slide(
  title: "Footnote Debug Test",
  author: "Debug",
  institute: "BIPS",
  date: datetime.today().display(),
)

#bips-slide(title: "Slide 1 - No Footnotes")[
  This slide has no footnotes. Everything should display normally.
  
  - Point 1
  - Point 2
  - Point 3
]

#bips-slide(title: "Slide 2 - With Footnotes")[
  This slide has footnotes#footnote[First footnote content here.].
  
  Multiple footnotes can be used#footnote[Second footnote with different content.] on the same slide.
  
  The footnotes should appear at the bottom of this slide, not on a separate slide.
]

#bips-slide(title: "Slide 3 - After Footnotes")[
  This slide comes after the footnote slide.
  
  It should display normally without any footnote content from the previous slide.
  
  - Normal content
  - No footnotes here
  - Should work fine
]

#bips-slide(title: "Slide 4 - Single Footnote")[
  Testing with just one footnote#footnote[Single footnote test.] to see if the issue persists.
  
  Regular content continues here.
]

#bips-slide(title: "Slide 5 - Final Test")[
  Final slide to see if footnotes from previous slides appear here.
  
  This should be clean content only.
]