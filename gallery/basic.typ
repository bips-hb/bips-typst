#import "../bypst.typ": *

#show: bips-theme

#title-slide(
  title: "BIPS Theme Basic Example",
  subtitle: "Simple presentation structure",
  author: "Your Name",
  institute: bips-en,
  date: datetime.today().display(),
)

#bips-slide(
  title: "Welcome",
  subtitle: "Getting started with bypst",
)[
  This is a basic BIPS presentation with:

  - Clean, simple design
  - BIPS institutional branding
  - Easy-to-use slide functions
  - *Blue emphasis* and _italic text_

]

#bips-slide(
  title: "A normal slide",
  subtitle: "With two columns",
  composer: (1fr, 2fr),
)[
  - A first item
  - A _second_ item
  - A *third* item

][
  - A normal amount of items
  - A very normal fifth item
  
  #two-columns(columns: (1fr, 1fr))[
    A secret nested two-column thing with a left column
  ][
    #blue[The nested right column]
  ]
  Subsequent text under the nested two-column thing with just a bunch of text.
]


#thanks-slide(
  contact-author: "Your Name",
  email: "your.name@leibniz-bips.de",
)
