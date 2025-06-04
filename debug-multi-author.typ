#import "bips-theme.typ": *

#show: bips-theme

// Example 1: Multiple authors with affiliations using inst() function
#title-slide(
  title: "Multi-Author Presentation Example",
  subtitle: "Demonstrating Author-Affiliation Mapping",
  authors: (
    "Jane Doe" + inst(1) + inst(2),
    "John Smith" + inst(1), 
    "Alice Johnson" + inst(3)
  ),
  institutes: (
    "Leibniz Institute for Prevention Research & Epidemiology -- BIPS",
    "University of Bremen, Department of Statistics", 
    "Max Planck Institute for Demographic Research"
  ),
  date: datetime.today().display(),
  occasion: "Multi-Institutional Research Conference",
)

#bips-slide(
  title: "How to Use Multi-Author Format"
)[
  To create a title slide with multiple authors and affiliations:

  ```typst
  #title-slide(
    title: "Your Title",
    authors: (
      "Jane Doe" + inst(1) + inst(2),
      "John Smith" + inst(1), 
      "Alice Johnson" + inst(3)
    ),
    institutes: (
      "First Institution",
      "Second Institution", 
      "Third Institution"
    ),
    // ... other parameters
  )
  ```
  
  - Use `authors: ()` array instead of `author:`
  - Use `institutes: ()` array instead of `institute:`
  - Add `inst(number)` to author names for superscript affiliation numbers
  - Authors can have multiple affiliations: `inst(1) + inst(2)`
]