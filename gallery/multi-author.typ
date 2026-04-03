#import "../bips-typst.typ": *

#show: bips-theme

// Title slide
#title-slide(
  title: "Bypst: The BIPS Typst Theme",
  subtitle: "Modern Presentations with Typst and Touying",
  authors: (
    "Jane Doe" + inst(1,2),
    "John Smith" + inst(3),
    "Pliny the Elder" + inst(1,4,5),
  ),
  institutes: (
    "Institute of Applied Exampleness",
    "University of Things and Stuff",
    "University of Peculiar Smells",
    "A Literal Hole in the Ground",
    "The Moon",
    "A Galaxy Far Far Away",
    "A Collection of Confusingly Labelled Drawers",
  ),
  date: datetime.today().display(),
  occasion: "The 27th Conference on Typst Presentations",
  institute-size: 14pt, // Custom smaller font size for institutions
)

// Regular content slides
#bips-slide(
  title: "Multi-Author Affiliation Examples",
  subtitle: "Two ways to specify multiple affiliations",
)[
  The `inst()` function supports multiple affiliations:
  
  === Method 1: Multiple calls
  ```typst
  "Jane Doe" + inst(1) + inst(2)
  ```
  
  === Method 2: Single call with multiple numbers  
  ```typst
  "Jane Doe" + inst(1,2)        // Same result as above
  "Pliny the Elder" + inst(1,4,5)  // Three affiliations
  ```
  
  Both methods produce superscript numbers: Jane Doe¹'² and Pliny the Elder¹'⁴'⁵
  
  #v(1fr)
  
  *Font size override*: This demo uses `institute-size: 14pt` to make the institution list smaller.
]

// Final slide with QR code
#thanks-slide(
  thanks-text: "Thank you for your attention!",
  contact-author: "Dr. Jane Doe",
  email: "jane.doe@leibniz-bips.de",
  qr-url: "https://lukasburk.de",
)
