// Local package (after running `just install` in the bips-typst repo):
#import "@local/bips-typst:0.1.1": *
// When published to Typst Universe, change to:
// #import "@preview/bips-typst:0.1.1": *

#show: bips-theme

#title-slide(
  title: "Your Presentation Title",
  subtitle: "Optional Subtitle",
  author: "Your Name",
  institute: bips_en,
  date: datetime.today().display(),
)

#bips-slide(title: "Introduction")[
  Your content here...
  
  - Bullet points
  - Math: $x^2 + y^2 = z^2$
  - *Bold* and _italic_ text
]

#section-slide("Results")

#bips-slide(title: "Main Findings")[
  #two-columns[
    Left column content
  ][
    Right column content
  ]
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.email@leibniz-bips.de",
)