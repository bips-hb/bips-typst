#import "../bypst.typ": *

#show: bips-theme.with(aspect-ratio: "4-3")

// Title slide
#title-slide(
  title: "Bypst: The BIPS Typst Theme",
  subtitle: "Now also in Retro 4:3!",
  author: "Jane Doe & John Smith",
  institute: bips-en,
  date: datetime(
    year: 2008,
    month: 3,
    day: 4,
  ).display(),
  occasion: "The 27th Conference on Typst Presentations",
)

// Regular content slides
#bips-slide(title: "You can change layouts")[
  - ... and it won't even cost you an afternoon to fix alignment issues afterwards.
  - The `datetime()` thing in the title is purely convenience by the way

  #v(1em)

  You can just enter "March 7, 2026" or whatever. It's fine.\
  However, #link("https://en.wikipedia.org/wiki/ISO_8601", "ISO 8601") would have an opinion
  about the formatting, and `datetime().display()` automatically formats the date _correctly_.

]
