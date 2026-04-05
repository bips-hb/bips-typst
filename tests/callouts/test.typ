// Test: callout blocks
#import "/bips-typst.typ": *
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
