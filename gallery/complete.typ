#import "bips-theme.typ": *

#show: bips-theme

// Title slide
#title-slide(
  title: "Bypst: The BIPS Typst Theme",
  subtitle: "Modern Presentations with Typst and Touying",
  author: "Jane Doe & John Smith",
  institute: bips_en,
  date: datetime.today().display(),
  occasion: "The 27th Conference on Typst Presentations",
)

// Regular content slides
#bips-slide(
  title: "Introduction to BIPS Typst Theme",
  subtitle: "Modern slide design with Typst",
)[
  - The BIPS Typst theme brings the institutional design to modern presentation tools
  - Built on top of the powerful _Touying_ package for Typst
  - Maintains consistency with BIPS branding and visual identity
  - Key advantages:
    + Fast compilation (milliseconds vs. seconds with LaTeX)
    + Clean, modern syntax
    + Powerful mathematical typesetting
    + Easy customization and theming
    + Professional BIPS styling with configurable typography
]

#bips-slide(title: "Key Features")[
  The BIPS Typst theme includes:

  1. *Color Scheme*: Official BIPS colors (#blue[blue], #orange[orange], #green[green])
  2. *Layouts*: Title slides, content slides, section slides, thanks slides
  3. *Branding*: BIPS logo positioning and institutional information
  4. *Typography*: Configurable font sizes, colors, and weights
  5. *Color Utilities*: Easy-to-use color functions

  Mathematical equations work seamlessly:
  $ sum_(i=1)^n x_i = macron(x) dot n $
]

// Section slide
#section-slide[Theme Features & Usage]

#bips-slide(
  title: "Color Utilities & Formatting",
  subtitle: "Easy-to-use color functions",
)[
  The theme provides convenient color utilities:

  - #blue[`#blue[text]`] - Apply BIPS blue color
  - #orange[`#orange[text]`] - Apply BIPS orange color
  - #green[`#green[text]`] - Apply BIPS green color
  - #gray[`#gray[text]`] - Apply gray color

  Text formatting options:
  - *Bold text* appears in blue (customizable)
  - _Emphasized text_ appears in blue italic (customizable)
  - #link("https://typst.app")[Link text] appears in blue with underline
  - Regular text uses the base color
]

// Section slide
#section-slide[Research Applications]

#bips-slide(
  title: "Research Use Cases",
  subtitle: "Where this theme excels",
)[
  Perfect for:

  - *Academic Presentations*: Conference talks, seminars, thesis defenses
  - *Research Reports*: Data presentations, methodology explanations
  - *Institutional Communication*: BIPS internal and external presentations
  - *Collaborative Work*: Version control friendly, text-based format

  #emph[Emphasis] uses BIPS blue color for highlighting important concepts.
]

#bips-slide(title: "Technical Advantages")[
  Compared to traditional presentation tools:

  === PowerPoint vs. Typst
  - Typst: Version control friendly, programmatic generation
  - PowerPoint: WYSIWYG editing, widespread compatibility

  === LaTeX Beamer vs. Typst
  - Typst: Much faster compilation, cleaner syntax
  - Beamer: Mature ecosystem, extensive documentation

  === Markdown slides vs. Typst
  - Typst: Superior mathematical typesetting, better layouts
  - Markdown: Simpler syntax for basic presentations
]

// Empty slide example
#empty-slide[
  #align(center + horizon)[
    This is an empty slide

    (No logo, no page number)

    #text(size: 14pt, style: "italic")[
      Useful for special content or transitions
    ]
  ]
]

// Animation examples section
#section-slide[Animation Examples]

#bips-slide(
  title: "Manual Incremental Reveals",
  subtitle: "Using #pause for step-by-step presentation",
)[
  Here are some key points:

  - First point appears immediately
  #pause
  - Second point appears on next click
  #pause
  - Final point completes the slide

  #pause
  You can also reveal blocks of content:
  #pause

  Mathematical equations work too:
  $ f(x) = x^2 + 2x + 1 $
  #pause
  $ f(x) = (x + 1)^2 $

]

#bips-slide(
  title: "Two-Column Animation",
  subtitle: "Using #meanwhile for synchronized reveals",
)[
  #grid(columns: (1fr, 1fr))[
    Left column starts:
    - First item here
    #pause
    - Second item appears
    #pause
    - Third item follows
  ][
    #meanwhile
    - Right column content appears when #meanwhile is triggered
    - Pretty neat.

  ]
]

#bips-slide(
  title: "Math Step-by-Step",
  subtitle: "Revealing equation steps",
)[
  Let's solve this equation step by step:

  $
    f(x) &= x^2 + 4x + 4 \
    #pause
    &= x^2 + 4x + 4 \
    #pause
    &= (x + 2)^2
  $

  #pause
  Therefore, the vertex is at $x = -2$.
]

// Another section
#section-slide[Getting Started]

#bips-slide(
  title: "Using the BIPS Theme",
  subtitle: "Quick start guide",
)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      To use this theme in your presentations:

      1. Import the theme
      2. Apply the theme with `#show`
      3. Create title slide
      4. Add content slides

      Then create slides with the various slide functions.
    ],
    [
      ```typst
      #import "bips-theme.typ": *

      #show: bips-theme

      #title-slide(
        title: [Your Title],
        subtitle: [Your Subtitle],
        author: [Your Name],
        // ... other parameters
      )

      #slide[
        = Slide Title
        Your content here
      ]
      ```
    ],
  )
]

#bips-slide(title: "Customization Options")[
  Theme customization through global variables:

  *Typography Configuration:*
  - Font sizes for all elements (titles, subtitles, body text)
  - Font colors for all text types
  - Font weights (bold, regular, etc.)
  - List and enumeration spacing

  *Easy Customization:*
  - All variables organized at the top of `bips-theme.typ`
  - Color utility functions: `#blue[]`, `#orange[]`, `#green[]`, `#gray[]`
  - Configurable emphasis and strong text styling
  - Page numbering starts at 1 for content slides
  - Separate scaling for `inline code` (0.95) and code blocks (0.8)
]

// Final slide
#thanks-slide(
  thanks-text: "Thank you for your attention!",
  contact-author: "Dr. Jane Doe",
  email: "jane.doe@leibniz-bips.de",
  qr-url: "https://codeberg.org/lksbrk/bips-typst", // QR code linking to presentation URL
)
