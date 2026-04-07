// Test: multi-column layout helpers
#import "/bypst.typ": *
#show: bips-theme
#title-slide(title: "Test")

// Default two-columns
#bips-slide(title: "Two Columns Default")[
  #two-columns[Left content][Right content]
]

// Custom column widths
#bips-slide(title: "Two Columns Custom")[
  #two-columns(columns: (2fr, 1fr))[Wider left][Narrow right]
]

// Three columns
#bips-slide(title: "Three Columns")[
  #three-columns[A][B][C]
]
