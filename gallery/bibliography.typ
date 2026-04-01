#import "@local/bips-typst:0.1.1": *

#show: bips-theme

#title-slide(
  title: "Bibliography Slides",
  subtitle: "Automated reference management",
  author: "BIPS Research Team",
  institute: bips_en,
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
  The `bibliography-slide()` function provides several options:
  
  ```typst
  // Default usage (APA style)
  #bibliography-slide[
    #bibliography("references.bib", style: "apa", full: true)
  ]

  // Different citation style
  #bibliography-slide[
    #bibliography("refs.bib", style: "ieee")
  ]

  // Custom title
  #bibliography-slide(title: "Literature")[
    #bibliography("refs.bib", style: "apa", full: true)
  ]
  ```
]

// Bibliography slide — call bibliography() in your document so paths resolve correctly
#bibliography-slide[
  #bibliography("references.bib", style: "apa", full: true)
]