// Test: term lists share list/enum metrics
#import "/bypst.typ": *
#show: bips-theme

#bips-slide(title: "Term Lists")[
  / First term: Its definition
  / Second term: Its definition
  / Third term: Its definition
]

#bips-slide(title: "Nested and Compact")[
  - Bullet
    / Nested term: Tightened inside a list
  #compact[
    / Compact term: Tighter spacing
    / Another: Second entry
  ]
]

// Regression guard: a 3-item term list must be exactly as tall as a 3-item
// bullet list. Term rows lack the taller ascender/descender line box unless
// the theme sets it, which is what made them look cramped.
#context {
  let bullets = measure[
    - One
    - Two
    - Three
  ]
  let terms = measure[
    / One: x
    / Two: x
    / Three: x
  ]
  assert(
    bullets.height == terms.height,
    message: "term/list heights diverged: "
      + repr(bullets.height)
      + " vs "
      + repr(terms.height),
  )
}
