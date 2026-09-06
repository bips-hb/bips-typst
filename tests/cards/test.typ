// Test: card() titled content boxes
#import "/bypst.typ": *
#show: bips-theme

#bips-slide(title: "Cards")[
  #card(title: "Definition")[Default blue card with a title bar.]

  // Untitled: the title bar branch is skipped, leaving a plain shaded panel.
  #card[Untitled card, body only.]
]

#bips-slide(title: "Card Options")[
  #two-columns[
    #card(title: "Result", color: bips-green)[Recolored title bar and tint.]
  ][
    #card(title: "Dark", fill: luma(230), title-color: white, color: bips-blue)[
      Explicit body fill overriding the tint.
    ]
  ]
  #card(
    title: "Wide",
    width: 60%,
    radius: 0pt,
  )[Custom width and square corners.]
]
