// Test: base-slide — touying-native body + toggleable BIPS chrome.
#import "/bypst.typ": *
#show: bips-theme

// full chrome (defaults): header, logo, page number, divider
#base-slide(title: "Base slide", subtitle: "all chrome on")[
  Native body. #pause It animates.
  - one
  - two
]

// logo off
#base-slide(title: "No logo", show-logo: false)[Body without the logo.]

// page number off
#base-slide(title: "No number", page-number: false)[Body without a page number.]

// divider off
#base-slide(title: "No divider", show-line: false)[Body without the divider line.]

// counter frozen (not counted) — number hidden too
#base-slide(title: "Uncounted", count: false, page-number: false)[
  This slide does not advance the counter.
]

// no header: body fills from top, page number still shown
#base-slide(content-align: center + horizon)[Headerless base slide.]

// composer multi-pane
#base-slide(title: "Two panes", composer: (1fr, 1fr))[left][right]

// content-align + text-size override
#base-slide(title: "Centered small", content-align: center + horizon, text-size: 14pt)[
  Smaller, centered body.
]
