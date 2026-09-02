// Test: title-slide with various configurations
#import "/bypst.typ": *
#show: bips-theme

// Single author
#title-slide(
  title: "Test Title",
  subtitle: "Test Subtitle",
  author: "Jane Doe",
  date: "2026-01-01",
)

// Multiple authors with institutions
#title-slide(
  title: "Multi-Author Test",
  subtitle: "Testing Institution Affiliations",
  authors: (
    [Jane Doe#inst(1)],
    [John Smith#inst(2)],
    [Alice Johnson#inst(1, 2)],
  ),
  institutions: (
    "Institute A",
    "Institute B",
  ),
  date: "2026-01-01",
  occasion: "Test Conference",
)
