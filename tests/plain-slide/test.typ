// Test: plain-slide — title/subtitle in a header block (divider as its bottom
// edge), over a fully native Touying body (#pause, composer, multi-body).
#import "/bypst.typ": *
#show: bips-theme

// title + subtitle header, native body + pause
#plain-slide(title: "A native slide", subtitle: "with a header block")[
  The body is plain content. #pause It animates.
  - one
  - two
]

// content-align in single-body mode
#plain-slide(title: "Centered")[
  Vertically centered body via content-align is also available.
]

// no header (no title/subtitle): body fills from the top, page number only
#plain-slide(content-align: center + horizon)[
  Headerless plain slide.
]

// composer multi-pane layout
#plain-slide(title: "Two panes", composer: (1fr, 1fr))[
  left content
][
  right content
]
