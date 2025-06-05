#import "bips-theme.typ": *

// Example of theme customization options
#show: bips-theme.with(
  // Global font size overrides
  base-size: 20pt,              // Larger base font
  slide-title-size: 28pt,       // Larger slide titles
  page-number-size: 16pt,       // Larger page numbers
  
  // Code styling overrides
  code-block-scale: 0.9,        // Slightly smaller code blocks
  code-inline-scale: 1.0,       // Normal inline code
)

#title-slide(
  title: "BIPS Theme Customization",
  subtitle: "Font sizes and code scaling options",
  author: "Theme Developer",
  institute: bips_en,
  date: datetime.today().display(),
)

#bips-slide(title: "Global Theme Customization")[
  The BIPS theme supports global customization:
  
  *Font Size Options:*
  - `base-size`: Base text size (default: 18pt, here: 20pt)
  - `slide-title-size`: Slide title size (default: 26pt, here: 28pt)  
  - `page-number-size`: Page number size (default: 18pt, here: 16pt)
  - Plus heading sizes, small/tiny text, etc.
  
  *Code Styling Options:*
  - `code-block-scale`: Scale for code blocks (here: 0.9)
  - `code-inline-scale`: Scale for `inline code` (here: 1.0)
]

#bips-slide(title: "Code Examples with Global Settings")[
  Testing the global code scaling:
  
  Inline code like `import numpy as np` uses 1.0x scale.
  
  Code blocks use 0.9x scale:
  ```python
  # This code block is scaled to 0.9x of base size
  import matplotlib.pyplot as plt
  import pandas as pd
  
  def analyze_data(df):
      return df.describe()
  ```
]

#bips-slide(
  title: "Slide-Level Overrides",
  subtitle: "Per-slide customization",
  // Override global settings for this slide only
  text-size: 16pt,              // Smaller text for this slide
  code-block-scale: 1.2,        // Larger code blocks  
  code-inline-scale: 1.1,       // Larger inline code
)[
  This slide overrides the global settings:
  
  - Text is smaller (16pt vs 20pt global)
  - `Inline code` is larger (1.1x vs 1.0x global) 
  - Code blocks are larger (1.2x vs 0.9x global):
  
  ```r
  # This code block is larger than previous slides
  library(ggplot2)
  ggplot(data, aes(x, y)) + 
    geom_point() +
    theme_minimal()
  ```
]

#bips-slide(title: "Usage Examples")[
  *Global Theme Customization:*
  ```typst
  #show: bips-theme.with(
    base-size: 20pt,
    page-number-size: 16pt, 
    code-block-scale: 0.9,
  )
  ```
  
  *Slide-Level Customization:*
  ```typst
  #bips-slide(
    title: "My Slide",
    text-size: 16pt,
    code-block-scale: 1.2,
  )[Content here]
  ```
]

#thanks-slide(
  contact-author: "Theme Developer", 
  email: "dev@leibniz-bips.de",
)