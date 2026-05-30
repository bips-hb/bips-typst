// Test: Touying animation primitives compile without errors
#import "/bypst.typ": *
#show: bips-theme
#title-slide(title: "Test")

// #pause — sequential reveals
#bips-slide(title: "Pause Test")[
  - First item
  #pause
  - Second item
  #pause
  - Third item
]

// #uncover and #only
#bips-slide(title: "Uncover and Only")[
  Always visible.
  #pause
  #uncover("3-")[Appears from subslide 3.]
  #only("2")[Only on subslide 2.]
]

// #alternatives
#bips-slide(title: "Alternatives")[
  #alternatives[Step 1][Step 2][Step 3]
]

// #meanwhile in grid
#bips-slide(title: "Meanwhile")[
  #grid(columns: (1fr, 1fr))[
    Left column
    #pause
    More left content
  ][
    #meanwhile
    Right column (synchronized)
  ]
]

// #pause in math
#bips-slide(title: "Math Animation")[
  $
         x & = 1 + 2 \
    #pause & = 3
  $
]
