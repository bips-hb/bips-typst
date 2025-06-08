#import "@local/bips-typst:0.1.0": *

#show: bips-theme

#title-slide(
  title: "BIPS Theme Basic Example",
  subtitle: "Simple presentation structure",
  author: "Your Name",
  institute: "Leibniz Institute for Prevention Research & Epidemiology -- BIPS",
  date: datetime.today().display(),
)

#bips-slide(
  title: "Welcome",
  subtitle: "Getting started with BIPS Typst"
)[
  This is a basic BIPS presentation with:
  
  - Clean, professional design
  - BIPS institutional branding
  - Easy-to-use slide functions
  - *Blue emphasis* and _italic text_
  
  Perfect for academic presentations!
]

#section-slide[Main Content]

#bips-slide(title: "Key Features")[
  The BIPS theme provides:
  
  1. *Fast compilation* with Typst
  2. *Professional styling* with BIPS colors
  3. *Multiple slide types* for different needs
  4. *Easy customization* options
  
  Mathematical notation works seamlessly: $E = m c^2$
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.name@leibniz-bips.de",
)