// Test: bips-slide show-line parameter hides the title separator
#import "/bypst.typ": *
#show: bips-theme

#title-slide(title: "Test")

// Default: gradient line under the title is shown
#bips-slide(title: "Line Shown")[
  The gradient separator appears under the title.
]

// show-line: false hides the separator (counter keeps running)
#bips-slide(title: "Line Hidden", show-line: false)[
  No separator under the title, but this slide still consumes a page number.
]

// Works with a subtitle too
#bips-slide(title: "Title", subtitle: "Subtitle", show-line: false)[
  Hidden separator with both title and subtitle present.
]
