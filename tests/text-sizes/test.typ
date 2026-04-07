// Test: text size utilities and helpers
#import "/bypst.typ": *
#show: bips-theme
#title-slide(title: "Test")

// text size utilities
#bips-slide(title: "Text Sizes")[
  #huge[Huge text.] \
  #large[Large text.] \
  Normal text. \
  #small[Small text.] \
  #tiny[Tiny text.]
]

// compact spacing
#bips-slide(title: "Compact Spacing")[
  #compact[
    - Item A
    - Item B
    - Item C
  ]
]

// vfill
#bips-slide(title: "Vertical Fill")[
  Top content.
  #vfill
  Bottom content.
]

// Color helpers
#bips-slide(title: "Color Utilities")[
  #blue[Blue] #orange[Orange] #green[Green] #gray[Gray]
]
