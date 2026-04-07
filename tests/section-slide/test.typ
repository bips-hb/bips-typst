// Test: section-slide variations
#import "/bypst.typ": *
#show: bips-theme
#title-slide(title: "Test")

#section-slide[First Section]
#bips-slide(title: "Content After Section")[Some content.]
#section-slide("No Logo Section", show-logo: false)
#bips-slide(title: "After No-Logo Section")[More content.]
