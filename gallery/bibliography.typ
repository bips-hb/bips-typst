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
  Pass the `.bib` file via `read()` and let the slide build the bibliography:

  ```typst
  #bibliography-slide(
    bib: read("references.bib"),
    full: true,
  )
  ```

  Use `read()` (not a bare path) so the path resolves relative to *your*
  document. `style` defaults to `"springer-basic-author-date"`; override per
  call, e.g. `style: "ieee"`. Or build the `#bibliography()` yourself:

  ```typst
  #bibliography-slide[
    #bibliography("refs.bib", title: none, style: "apa")
  ]
  ```
  The slide title is already `"References"`, so the bibliography's own
  heading is disabled by default.
]

// Bibliography slide — `read()` so the path resolves in your document
#bibliography-slide(
  title: "References",
  text-size: 16pt, // Adjust to fit more entries on the slide
  bib: read("references.bib"),
  full: true,
)
