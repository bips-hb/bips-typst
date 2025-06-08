#import "@local/bips-typst:0.1.0": *

#show: bips-theme

#title-slide(
  title: "Test Presentation",
  subtitle: "With working animations",
  author: "Test Author",
  institute: "BIPS",
  date: "Today",
)

#bips-slide(title: "Animation Test")[
  This slide should have logo and page number.
  
  First point appears immediately.
  
  #pause
  
  Second point appears after pause.
  
  #pause
  
  Third point appears after second pause.
]

#bips-slide(title: "Second Slide")[
  This slide should also have logo and page number.
  
  No animations here.
]