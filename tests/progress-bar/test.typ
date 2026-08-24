// Test: opt-in progress bar renders on counted content slides only
#import "/bypst.typ": *
#show: bips-theme.with(progress-bar: true)

#title-slide(title: "Progress Bar Test")

#bips-slide(title: "Counted slide")[
  Bar should span the bottom page edge.
]

#bips-slide(title: "With pauses")[
  - One
  #pause
  - Two
]

#empty-slide[
  No bar here — uncounted by default.
]

#empty-slide(count: true)[
  Bar here — counted.
]

#base-slide(title: "Explicit off", progress-bar: false)[
  No bar despite the theme flag.
]

#section-slide("Section")

#thanks-slide()
