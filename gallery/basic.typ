#import "../bypst.typ": *

#show: bips-theme

#title-slide(
  title: "BIPS Theme Basic Example",
  subtitle: "Simple presentation structure",
  author: "Your Name",
  institute: bips_en,
  date: datetime.today().display(),
)

#bips-slide(
  title: "Welcome",
  subtitle: "Getting started with bypst"
)[
  This is a basic BIPS presentation with:
  
  - Clean, simple design
  - BIPS institutional branding
  - Easy-to-use slide functions
  - *Blue emphasis* and _italic text_

]


#bips-slide(
  title: "Welcome",
)[
  This is a basic BIPS presentation with:
  
  - Clean, simple design
  - BIPS institutional branding
  - Easy-to-use slide functions
  - *Blue emphasis* and _italic text_

]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.name@leibniz-bips.de",
)
