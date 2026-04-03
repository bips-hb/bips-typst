#import "../bips-typst.typ": *

// Example of theme customization options
#show: bips-theme.with(
  // Global font size overrides
  base-size: 20pt,              // Larger base font (default: 18pt)
  slide-title-size: 28pt,       // Larger slide titles (default: 26pt)
  slide-subtitle-size: 22pt,    // Larger slide subtitles (default: 20pt)
  page-number-size: 16pt,       // Smaller page numbers (default: 18pt)
  
  // Code styling overrides
  code-block-scale: 0.85,       // Slightly smaller code blocks (default: 0.8)
  code-inline-scale: 1.0,       // Normal inline code (default: 1.0)
)

#title-slide(
  title: "BIPS Theme Customization",
  subtitle: "Font sizes, colors, and styling options",
  author: "Your Name",
  institute: "BIPS",
  date: datetime.today().display(),
)

#bips-slide(title: "Global Theme Customization")[
  The BIPS theme supports three levels of customization:
  
  === 1. Global Theme Overrides
  Set presentation-wide customizations:
  ```typst
  #show: bips-theme.with(
    base-size: 20pt,           // Larger text throughout
    slide-title-size: 28pt,    // Bigger slide titles
    code-block-scale: 0.85,    // Adjust code block size
  )
  ```
  
  === 2. Individual Slide Overrides  
  Override settings for specific slides:
  ```typst
  #bips-slide(
    title: "Special Slide",
    text-size: 16pt,           // Just this slide
    code-block-scale: 1.2,     // Larger code here
  )[Content]
  ```
]

#bips-slide(title: "Available Customization Options")[
  *Font Size Options:*
  - `base-size`: Main text size
  - `slide-title-size`: Slide title size
  - `slide-subtitle-size`: Slide subtitle size
  - `heading-1-size`, `heading-2-size`, `heading-3-size`: Heading sizes
  - `small-size`, `tiny-size`: Smaller text sizes
  - `page-number-size`: Page number size
  
  *Code Styling Options:*
  - `code-block-scale`: Scale for code blocks
  - `code-inline-scale`: Scale for `inline code`
  
  *Slide-Level Options:*
  - `title-size`, `subtitle-size`, `text-size`: Override for specific slides
]

#bips-slide(title: "Font Sizes in Action")[
  This presentation demonstrates larger font sizes:
  
  - Base text is 20pt (instead of 18pt)
  - Slide titles are 28pt (instead of 26pt)
  - Slide subtitles are 22pt (instead of 20pt)
  - Page numbers are 16pt (instead of 18pt)
  
  Compare this to the `basic.typ` example to see the difference!
]

#bips-slide(title: "Code Scaling Examples")[
  Testing the global code scaling settings:
  
  Inline code like `import pandas as pd` uses normal scale (1.0x).
  
  Code blocks use slightly smaller scale (0.85x):
  ```python
  # Data analysis example
  import pandas as pd
  import matplotlib.pyplot as plt
  
  def analyze_data(df):
      summary = df.describe()
      return summary
  
  # Create visualization  
  plt.figure(figsize=(10, 6))
  plt.plot(data['x'], data['y'])
  plt.title('Research Results')
  plt.show()
  ```
]

#bips-slide(
  title: "Slide-Level Override Demo", 
  subtitle: "This slide uses custom sizing",
  // Override global settings for this slide only
  text-size: 16pt,              // Smaller text for dense content
  title-size: 24pt,             // Smaller title than global
  subtitle-size: 18pt,          // Smaller subtitle than global
  code-block-scale: 1.1,        // Larger code blocks
)[
  This slide overrides the global settings:
  
  - Text is 16pt (vs 20pt global setting)
  - Title is 24pt (vs 28pt global setting) 
  - Subtitle is 18pt (vs 22pt global setting)
  - Code blocks are larger (1.1x vs 0.85x global):
  
  ```r
  # R analysis example - larger code
  library(ggplot2)
  library(dplyr)
  
  results <- data %>%
    group_by(condition) %>%
    summarise(
      mean_response = mean(response),
      sd_response = sd(response),
      n = n()
    )
  
  ggplot(results, aes(x = condition, y = mean_response)) +
    geom_col(fill = "steelblue") +
    theme_minimal()
  ```
]

#bips-slide(title: "Color and Style Customization")[
  The theme provides built-in color utilities:
  
  - #blue[BIPS blue text] using `#blue[text]`
  - #orange[BIPS orange text] using `#orange[text]`
  - #green[BIPS green text] using `#green[text]`
  - #gray[Gray text] using `#gray[text]`
  
  Text formatting automatically uses BIPS colors:
  - *Bold text* appears in blue
  - _Emphasized text_ appears in blue italic
  - #link("https://typst.app")[Links] appear in blue with underline
  
  For advanced color customization, edit the color variables at the top of `theme.typ`.
]

#bips-slide(title: "Advanced Customization")[
  For deeper customization, edit variables in `theme.typ`:
  
  ```typst
  // Color definitions
  #let bips-blue = rgb(23, 99, 170)
  #let font-color-base = bips-text-gray
  
  // Font sizes (theme defaults)
  #let font-size-base = 18pt
  #let font-size-slide-title = 26pt
  
  // Spacing
  #let list-spacing = 0.8em
  #let enum-spacing = 0.8em
  ```
  
  The hierarchical system ensures your customizations work predictably:
  *Theme defaults* → *Global overrides* → *Individual slide overrides*
]

#thanks-slide(
  contact-author: "Your Name", 
  email: "your.email@leibniz-bips.de",
)