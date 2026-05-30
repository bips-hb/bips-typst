#import "../bypst.typ": *

#show: bips-theme

#title-slide(
  title: "Bibliography Slides",
  subtitle: "Automated reference management",
  author: "BIPS Research Team",
  institute: bips-en,
  date: datetime.today().display(),
)

#bips-slide(title: "Citations in Presentations")[
  Academic presentations often require proper citations:

  - Previous meta-analysis showed significant effects @johnson2023
  - This finding was replicated in larger cohorts @smith2022
  - Recent advances suggest new directions @brown2024

  The bibliography slide helper makes it easy to display all references.
]

#bips-slide(title: "Bibliography Options")[
  The `bibliography()` function provides several options:

  ```typst
  // Default usage (APA style)
  #bibliography-slide[
    #bibliography("references.bib", title: none, style: "apa", full: true)
  ]

  // Different citation style
  #bibliography-slide[
    #bibliography("refs.bib",title: none, style: "ieee")
  ]
  ```
  The `#bibliography-slide` has a slide title `"References"`, so we disable the automatic title in  `#bibliography()`.

]

// Bibliography slide — call bibliography() in your document so paths resolve correctly
#bibliography-slide(
  title: "References",
  text-size: 16pt, // Adjust to fit more entries on the slide
)[
  #bibliography("references.bib", title: none, style: "apa", full: true)
]
