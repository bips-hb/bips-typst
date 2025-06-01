#import "bips-theme.typ": *

#show: bips-theme

// Title slide
#title-slide(
  title: [The BIPS Typst Theme],
  subtitle: [Modern Presentations with Typst and Touying],
  author: [Jane Doe & John Smith],
  institute: [Leibniz Institute for Prevention Research & Epidemiology -- BIPS],
  date: datetime.today().display(),
  occasion: [The 27th Conference on Typst Presentations],
)

// Regular content slides
#slide(
  title: [Introduction to BIPS Typst Theme],
  subtitle: [Modern slide design with Typst],
)[
  - The BIPS Typst theme brings the institutional design to modern presentation tools
  - Built on top of the powerful *Touying* package for Typst
  - Maintains consistency with BIPS branding and visual identity
  - Key advantages:
    + Fast compilation (milliseconds vs. seconds with LaTeX)
    + Clean, modern syntax
    + Powerful mathematical typesetting
    + Easy customization and theming
]

#slide(
  title: [Key Features],
)[
  The BIPS Typst theme includes:

  1. *Color Scheme*: Official BIPS colors (blue, orange, green)
  2. *Typography*: Helvetica default with Fira Sans option
  3. *Layouts*: Title slides, content slides, section slides, thanks slides
  4. *Branding*: BIPS logo positioning and institutional information
  5. *Flexibility*: Easy customization and content formatting

  Mathematical equations work seamlessly:
  
  $ sum_(i=1)^n x_i = bar(x) dot n $
  
  The math font remains serif while text uses sans-serif, following academic conventions.
]

// Section slide
#section-slide[Research Applications]

#slide(
  title: [Research Use Cases],
  subtitle: [Where this theme excels],
)[
  Perfect for:

  - *Academic Presentations*: Conference talks, seminars, thesis defenses
  - *Research Reports*: Data presentations, methodology explanations
  - *Institutional Communication*: BIPS internal and external presentations
  - *Collaborative Work*: Version control friendly, text-based format

  #emph[Emphasis] uses BIPS blue color for highlighting important concepts.
]

#slide(
  title: [Technical Advantages],
)[
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

// Another section
#section-slide[Getting Started]

#slide(
  title: [Using the BIPS Theme],
  subtitle: [Quick start guide],
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
      
      #slide(title: [Slide Title])[
        Your content here
      ]
      ```
    ]
  )
]

#slide(
  title: [Customization Options],
)[
  Theme customization includes:

  - *Language*: English ("en") or German ("de") support
  - *Fonts*: Helvetica (default) or Fira Sans family
  - *Aspect Ratio*: 16:9 (recommended) or 4:3
  - *Colors*: Built-in BIPS color palette
  
  Advanced users can modify:
  - Slide layouts and spacing
  - Color definitions
  - Typography settings
  - Logo placement and sizing
]

// Final slide
#thanks-slide(
  thanks-text: "Thank you for your attention",
  contact-author: "Dr. Jane Doe",
  email: "jane.doe@leibniz-bips.de",
)
