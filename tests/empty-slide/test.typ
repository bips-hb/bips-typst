// Test: empty-slide (no branding)
#import "/bypst.typ": *
#show: bips-theme
#title-slide(title: "Test")

#empty-slide[
  #align(center + horizon)[
    This slide has no logo, no page number, no branding.
  ]
]

// count: true keeps the slide in the numbered sequence and shows the number
#empty-slide(count: true)[
  #align(center + horizon)[
    Chrome-free but still counted; the page number is shown.
  ]
]
