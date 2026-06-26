// Test: callout blocks
#import "/bypst.typ": *
#show: bips-theme
#title-slide(title: "Test")

#bips-slide(title: "All Callout Types")[
  #callout(type: "note")[This is a note.]
  #callout(type: "tip")[This is a tip.]
  #callout(type: "warning")[This is a warning.]
  #callout(type: "important")[This is important.]
]

#bips-slide(title: "Callout with Title")[
  #callout(type: "tip", title: "Pro Tip")[
    Callouts can have titles.
  ]
]

#bips-slide(title: "Default Callout")[
  #callout[Default (no type) is a neutral shaded box.]
]

#bips-slide(title: "Callout Shorthands")[
  #callout-note[Note shorthand.]
  #callout-tip[Tip shorthand.]
  #callout-warning[Warning shorthand.]
  #callout-important(title: "Heads up")[Important shorthand with a title.]
]
