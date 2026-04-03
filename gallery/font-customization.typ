#import "../bips-typst.typ": *

// Test global font size overrides
#show: bips-theme.with(
  base-size: 16pt, // Smaller base text
  slide-title-size: 22pt, // Smaller slide titles
  slide-subtitle-size: 16pt, // Smaller slide subtitles
)

#title-slide(
  title: "Font Size Customization Demo",
  subtitle: "Testing Global and Local Overrides",
  author: "Theme Developer",
  institute: "BIPS",
  date: datetime.today().display(),
)

#bips-slide(
  title: "Global Font Size Override",
  subtitle: "This presentation uses custom global font sizes",
)[
  This slide uses the global font size overrides:

  - Base text: 16pt (was 18pt)
  - Slide title: 22pt (was 24pt)
  - Slide subtitle: 16pt (was 18pt)

  All slides in this presentation will use these sizes by default.
]

#bips-slide(
  title: "Individual Slide Override",
  subtitle: "This slide overrides the global settings",
  title-size: 26pt, // Override just this slide's title
  subtitle-size: 20pt, // Override just this slide's subtitle
  text-size: 24pt, // Override just this slide's content text
)[
  This slide demonstrates individual slide overrides:

  - Title: 26pt (overridden)
  - Subtitle: 20pt (overridden)
  - Content text: 24pt (overridden)

  Only this slide uses these custom sizes.
]

#bips-slide(title: "Back to Global Settings")[
  This slide is back to using the global font size overrides:

  - Base text: 16pt (global setting)
  - Title: 22pt (global setting)
  - No subtitle on this slide

  The hierarchy works: Theme defaults → Global overrides → Individual slide overrides
]

#bips-slide(
  title: "Link Styling Test"
)[
  Testing different text formatting options:
  
  - *Bold text* (blue, no underline)
  - _Emphasized text_ (blue italic, no underline)  
  - #link("https://typst.app")[Link text] (blue with underline)
  - Regular text (gray)
  
  Links are now clearly distinguishable from emphasis through the underline!
  
  More examples:
  - Visit #link("https://leibniz-bips.de")[BIPS website]
  - Check out #link("https://touying-typ.github.io/")[Touying documentation]
  - Learn more about #link("https://typst.app")[Typst]
]
