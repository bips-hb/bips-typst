// Test: block quotes and figure captions
#import "/bypst.typ": *
#show: bips-theme

#bips-slide(title: "Quotes")[
  #quote(block: true, attribution: [Tukey, 1962])[
    Far better an approximate answer to the right question.
  ]

  // No attribution — the attribution block must be skipped entirely.
  #quote(block: true)[A quote standing on its own.]

  // Inline quotes keep Typst's quotation marks, untouched by the theme.
  He called it #quote[an approximate answer] and moved on.
]

#bips-slide(title: "Captions")[
  #figure(caption: [A caption], rect(width: 4cm, height: 1cm))
]

// Captions render at `caption-scale` of the surrounding size. Compare a figure
// against the same figure with the scaling locally undone; equal heights mean
// the theme's rule is gone. (The figure gap cancels out, unlike a with/without
// caption comparison.)
#context {
  let art = rect(width: 4cm, height: 1cm)
  let fig = figure(caption: [A caption], art)
  // Absolute size: inside the caption `1em` is already the scaled size, so a
  // relative override would be a no-op (same trap as `footnote-scale`).
  let unscaled = {
    show figure.caption: set text(size: font-size-base)
    fig
  }
  assert(
    measure(fig).height < measure(unscaled).height,
    message: "captions are not scaled below body size",
  )
}
