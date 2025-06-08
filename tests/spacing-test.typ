#import "@local/bips-typst:0.1.0": *

#show: bips-theme

#bips-slide(title: "Title Only")[
  Content with title only - spacing should be minimal after title.
]

#bips-slide(title: "Title with Subtitle", subtitle: "This is a subtitle")[
  Content with both title and subtitle - spacing should be appropriate between them.
]

#bips-slide(subtitle: "Subtitle Only")[
  Content with subtitle only - spacing should be minimal after subtitle.
]