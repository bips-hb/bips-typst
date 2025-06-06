#import "bips-theme.typ": *

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
  // Default usage (APA style, references.bib)
  #bibliography-slide()
  
  // Custom bibliography file
  #bibliography-slide(file: "my-refs.bib")
  
  // Different citation style
  #bibliography-slide(style: "ieee")
  
  // Custom title
  #bibliography-slide(title: "Literature")
  
  // Show only cited references
  #bibliography-slide(full: false)
  ```
]

// Bibliography slide with default settings
#bibliography-slide()