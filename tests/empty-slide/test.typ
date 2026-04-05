// Test: empty-slide (no branding)
#import "/bips-typst.typ": *
#show: bips-theme
#title-slide(title: "Test")

#empty-slide[
  #align(center + horizon)[
    This slide has no logo, no page number, no branding.
  ]
]
