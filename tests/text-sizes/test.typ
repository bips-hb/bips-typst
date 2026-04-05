// Test: text size utilities and helpers
#import "/bips-typst.typ": *
#show: bips-theme
#title-slide(title: "Test")

// small and tiny
#bips-slide(title: "Small and Tiny")[
  Normal text.
  #small[This is small text.]
  #tiny[This is tiny text.]
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
