#import "@preview/touying:0.6.1": *
#import "@preview/codetastic:0.2.2": qrcode

// Useful shorthand
#let bips_en = [Leibniz Institute for Prevention Research and Epidemiology --- BIPS]
#let bips_de = [Leibniz-Institut für Präventionsforschung und Epidemiologie --- BIPS]

// BIPS Color Definitions
#let bips-blue = rgb(23, 99, 170)
#let bips-text-gray = rgb(66, 66, 66)
#let bips-orange = rgb(250, 133, 55)
#let bips-green = rgb(49, 210, 57)

// BIPS Color Utility Functions
// ============================

/// Apply BIPS blue color to text
/// Example: #blue[This text is blue]
#let blue(content) = text(fill: bips-blue)[#content]

/// Apply BIPS orange color to text
/// Example: #orange[This text is orange]
#let orange(content) = text(fill: bips-orange)[#content]

/// Apply BIPS green color to text
/// Example: #green[This text is green]
#let green(content) = text(fill: bips-green)[#content]

/// Apply gray color to text
/// Example: #gray[This text is gray]
#let gray(content) = text(fill: bips-text-gray)[#content]

// BIPS Typography Configuration
// =================================

// Main content styling
#let font-size-base = 18pt
#let font-color-base = bips-text-gray
#let font-weight-base = "regular"

#let font-size-small = 14pt
#let font-color-small = bips-text-gray
#let font-weight-small = "regular"

#let font-size-tiny = 12pt
#let font-color-tiny = bips-text-gray
#let font-weight-tiny = "regular"

// Regular heading styling
#let font-size-heading-1 = 20pt
#let font-color-heading-1 = bips-blue
#let font-weight-heading-1 = "bold"

#let font-size-heading-2 = 18pt
#let font-color-heading-2 = bips-blue
#let font-weight-heading-2 = "bold"

#let font-size-heading-3 = 16pt
#let font-color-heading-3 = bips-blue
#let font-weight-heading-3 = "bold"

// Slide title and subtitle styling
#let font-size-slide-title = 26pt
#let font-color-slide-title = bips-blue
#let font-weight-slide-title = 600

#let font-size-slide-subtitle = 20pt
#let font-color-slide-subtitle = bips-blue
#let font-weight-slide-subtitle = "bold"

// Title slide styling
#let font-size-title-slide-main = 26pt
#let font-color-title-slide-main = bips-blue
#let font-weight-title-slide-main = "bold"

#let font-size-title-slide-subtitle = 20pt
#let font-color-title-slide-subtitle = bips-blue
#let font-weight-title-slide-subtitle = "bold"

#let font-size-title-slide-author = 20pt
#let font-color-title-slide-author = bips-blue
#let font-weight-title-slide-author = "bold"

#let font-size-title-slide-institute = 18pt
#let font-color-title-slide-institute = bips-text-gray
#let font-weight-title-slide-institute = "regular"

#let font-size-title-slide-date = 16pt
#let font-color-title-slide-date = bips-text-gray
#let font-weight-title-slide-date = "regular"

// Section slide styling
#let font-size-section-slide = 32pt
#let font-color-section-slide = bips-blue
#let font-weight-section-slide = "bold"

// Thanks slide styling
#let font-size-thanks-slide-main = 24pt
#let font-color-thanks-slide-main = bips-blue
#let font-weight-thanks-slide-main = "bold"

#let font-size-thanks-slide-website = 16pt
#let font-color-thanks-slide-website = bips-blue
#let font-weight-thanks-slide-website = "regular"

#let font-size-thanks-slide-contact = 14pt
#let font-color-thanks-slide-contact = bips-text-gray
#let font-weight-thanks-slide-contact = "regular"

// Page number styling
#let font-size-page-number = 18pt
#let font-color-page-number = bips-text-gray
#let font-weight-page-number = "regular"

// Code styling
#let font-scale-code-inline = 1
#let font-scale-code-block = 0.8

// List and enumeration spacing
#let list-spacing = 0.8em
#let enum-spacing = 0.8em

// Emphasis and strong text styling
#let font-color-emphasis = bips-blue
#let font-color-strong = bips-blue

// BIPS theme that leverages Touying's infrastructure
#let bips-theme(
  aspect-ratio: "16-9",
  // Global font size overrides (optional)
  base-size: none,
  slide-title-size: none,
  slide-subtitle-size: none,
  heading-1-size: none,
  heading-2-size: none,
  heading-3-size: none,
  small-size: none,
  tiny-size: none,
  page-number-size: none,
  code-block-scale: none,
  code-inline-scale: none,
  body,
) = {
  // Calculate effective font sizes (use override if provided, otherwise theme default)
  let effective-font-size-base = if base-size != none { base-size } else { font-size-base }
  let effective-font-size-slide-title = if slide-title-size != none { slide-title-size } else { font-size-slide-title }
  let effective-font-size-slide-subtitle = if slide-subtitle-size != none { slide-subtitle-size } else {
    font-size-slide-subtitle
  }
  let effective-font-size-heading-1 = if heading-1-size != none { heading-1-size } else { font-size-heading-1 }
  let effective-font-size-heading-2 = if heading-2-size != none { heading-2-size } else { font-size-heading-2 }
  let effective-font-size-heading-3 = if heading-3-size != none { heading-3-size } else { font-size-heading-3 }
  let effective-font-size-small = if small-size != none { small-size } else { font-size-small }
  let effective-font-size-tiny = if tiny-size != none { tiny-size } else { font-size-tiny }
  let effective-font-size-page-number = if page-number-size != none { page-number-size } else { font-size-page-number }
  let effective-code-block-scale = if code-block-scale != none { code-block-scale } else { font-scale-code-block }
  let effective-code-inline-scale = if code-inline-scale != none { code-inline-scale } else { font-scale-code-inline }
  // Global text and styling configuration
  show: set text(
    font: ("Fira Sans", "Arial"),
    size: effective-font-size-base,
    fill: font-color-base,
  )

  // Emphasis (_text_) in BIPS blue (color only, no italic)
  show emph: it => text(fill: font-color-emphasis, style: "italic", weight: "regular")[#it.body]

  // Strong text (*text*) in BIPS blue (color only, no bold)
  show strong: it => text(fill: font-color-strong, weight: "bold")[#it.body]

  // Links in BIPS blue with thin underline to distinguish from emphasis
  show link: it => underline(text(fill: bips-blue)[#it])


  // Table styling - set elegant defaults
  set table(
    stroke: none,
    fill: (_, y) => if y == 0 { bips-blue.lighten(85%) } else { none },
    inset: (x: 0.7em, y: 0.6em),
  )

  // Add subtle borders around tables
  show table: it => block(
    stroke: (
      top: 1pt + bips-blue.lighten(50%),
      bottom: 1pt + bips-blue.lighten(50%),
    ),
    inset: 0pt,
    it,
  )

  // List styling with configurable spacing
  show list: set list(spacing: list-spacing)
  show list: set text(fill: font-color-base)
  show enum: set enum(spacing: enum-spacing)
  show enum: set text(fill: font-color-base)

  // Code styling - separate scaling for inline vs block code
  show raw.where(block: true): set text(size: effective-code-block-scale * 1em)
  show raw.where(block: false): set text(size: effective-code-inline-scale * 1em)

  // Basic heading styles
  show heading.where(level: 1): set text(
    size: effective-font-size-slide-title,
    weight: font-weight-slide-title,
    fill: font-color-slide-title,
  )

  show heading.where(level: 2): set text(
    size: effective-font-size-slide-subtitle,
    weight: font-weight-slide-subtitle,
    fill: font-color-slide-subtitle,
  )

  show heading.where(level: 3): set text(
    size: effective-font-size-heading-3,
    weight: font-weight-heading-3,
    fill: font-color-heading-3,
  )


  // Use Touying's infrastructure with BIPS customizations
  touying-slides(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 1.55cm, bottom: 1.55cm, left: 1.55cm, right: 1.75cm),
      background: {
        // Logo placement (no context queries)
        place(
          top + right,
          dx: -1cm,
          dy: 1cm,
          image("bips-logo.png", width: 3cm),
        )

        // Page number (simple counter, no here().page() queries)
        place(
          top + right,
          dx: -2.25cm,
          dy: 4.25cm,
          text(
            size: effective-font-size-page-number,
            fill: font-color-page-number,
            weight: font-weight-page-number,
          )[
            #context counter(page).display()
          ],
        )
      },
    ),
    body,
  )
}

// Custom slide function with grid layout for title/content separation
#let bips-slide(
  title: none,
  subtitle: none,
  // Optional font size overrides for this slide
  title-size: none,
  subtitle-size: none,
  text-size: none,
  page-number-size: none,
  code-block-scale: none,
  code-inline-scale: none,
  ..args,
  body,
) = {
  slide(..args)[
    // Apply slide-specific styling overrides
    #if page-number-size != none or code-block-scale != none or code-inline-scale != none {
      show raw.where(block: true): set text(size: if code-block-scale != none { code-block-scale * 1em } else { font-scale-code-block * 1em })
      show raw.where(block: false): set text(size: if code-inline-scale != none { code-inline-scale * 1em } else { font-scale-code-inline * 1em })
    }
    
    #if title != none or subtitle != none {
      // Title and subtitle section - smart spacing without grid
      v(.1em)

      // Combine title and subtitle in natural flow
      if title != none and subtitle != none {
        // Both title and subtitle - natural line break between them
        block(
          width: 90%, 
          // stroke: 1pt,
          [
            #text(
              size: if title-size != none { title-size } else { font-size-slide-title },
              weight: font-weight-slide-title,
              fill: font-color-slide-title,
            )[#title]
          ],
        )
        // #linebreak()
        v(-0.5em)
        block(
          width: 90%, 
          // stroke: 1pt,
          [
            #text(
              size: if subtitle-size != none { subtitle-size } else { font-size-slide-subtitle },
              weight: font-weight-slide-subtitle,
              fill: font-color-slide-subtitle,
            )[#subtitle]
          ],
        )
      } else if title != none {
        // Title only
        text(
          size: if title-size != none { title-size } else { font-size-slide-title },
          weight: font-weight-slide-title,
          fill: font-color-slide-title,
        )[#title]
      } else if subtitle != none {
        // Subtitle only
        text(
          size: if subtitle-size != none { subtitle-size } else { font-size-slide-subtitle },
          weight: font-weight-slide-subtitle,
          fill: font-color-slide-subtitle,
        )[#subtitle]
      }

      // Space before gradient line
      // v(0.5em)

      // Gradient line
      // gradient.linear gray to white was more robust than .transparentize which did not show up
      // properly on most PDF viewers I tried
      rect(
        width: 85%,
        height: 0.5pt,
        fill: gradient.linear(
          bips-text-gray,
          white,
          angle: 0deg,
        ),
      )

      v(1em)

      // Content area - natural flow allows footnotes to work
      if text-size != none {
        text(size: text-size)[#body]
      } else {
        body
      }
    } else {
      // If no title/subtitle, just show content
      if text-size != none {
        text(size: text-size)[#body]
      } else {
        body
      }
    }
  ]
}

// Helper function to format author with superscript affiliations
// Can take single number: inst(1) or multiple numbers: inst(1,4,5)
#let inst(..numbers) = {
  let nums = numbers.pos()
  if nums.len() == 0 {
    ""
  } else {
    super[#nums.map(str).join(",")]
  }
}

// Title slide function using Touying's infrastructure
#let title-slide(
  title: none,
  subtitle: none,
  author: none,
  authors: none, // Alternative: array of authors for multi-affiliation support
  institute: none,
  institutes: none, // Alternative: array of institutes for multi-affiliation support
  date: none,
  occasion: none,
  // Optional font size overrides
  title-size: none,
  subtitle-size: none,
  author-size: none,
  institute-size: none,
  date-size: none,
) = {
  slide(
    setting: body => {
      set page(
        background: {
          // Logo placement (no page number on title slide)
          place(
            top + right,
            dx: -1cm,
            dy: 1cm,
            image("bips-logo.png", width: 3cm),
          )
        },
      )

      set align(center)

      // Title slide doesn't affect page numbering - content slides will start at 1

      // v(2cm)
      v(1fr)

      // Title
      if title != none {
        block(
          text(
            size: if title-size != none { title-size } else { font-size-title-slide-main },
            weight: font-weight-title-slide-main,
            fill: font-color-title-slide-main,
          )[
            #title
          ],
        )
      }

      // v(0.5cm)
      v(1fr)

      // Subtitle
      if subtitle != none {
        block(
          text(
            size: if subtitle-size != none { subtitle-size } else { font-size-title-slide-subtitle },
            weight: font-weight-title-slide-subtitle,
            fill: font-color-title-slide-subtitle,
          )[
            #subtitle
          ],
        )
      }

      // v(1.5cm)
      v(1fr)

      // Author(s) - support both single and multiple authors
      if authors != none {
        // Multiple authors format
        block(
          text(
            size: if author-size != none { author-size } else { font-size-title-slide-author },
            weight: font-weight-title-slide-author,
            fill: font-color-title-slide-author,
          )[
            #authors.join(", ")
          ],
        )
      } else if author != none {
        // Single author format (backward compatibility)
        block(
          text(
            size: if author-size != none { author-size } else { font-size-title-slide-author },
            weight: font-weight-title-slide-author,
            fill: font-color-title-slide-author,
          )[
            #author
          ],
        )
      }

      v(1fr)

      // Institute(s) - support both single and multiple institutes
      if institutes != none {
        // Multiple institutes format with numbering
        block(
          text(
            size: if institute-size != none { institute-size } else { font-size-title-slide-institute },
            weight: font-weight-title-slide-institute,
            fill: font-color-title-slide-institute,
          )[
            #for (i, inst) in institutes.enumerate() [
              #super[#(i + 1)] #inst
              #if i < institutes.len() - 1 [\ ]
            ]
          ],
        )
      } else if institute != none {
        // Single institute format (backward compatibility)
        block(
          text(
            size: if institute-size != none { institute-size } else { font-size-title-slide-institute },
            weight: font-weight-title-slide-institute,
            fill: font-color-title-slide-institute,
          )[
            #institute
          ],
        )
      }
      v(1fr)
      // Date
      if date != none {
        block(
          text(
            size: if date-size != none { date-size } else { font-size-title-slide-date },
            weight: font-weight-title-slide-date,
            fill: font-color-title-slide-date,
          )[
            #date
          ],
        )
      }

      // Occasion
      if occasion != none {
        block(
          text(
            size: if date-size != none { date-size } else { font-size-title-slide-date },
            weight: font-weight-title-slide-date,
            fill: font-color-title-slide-date,
          )[
            #occasion
          ],
        )
      }
    },
  )[]
}

// Section slide function using Touying's infrastructure
#let section-slide(section-title) = {
  slide(
    setting: body => {
      set page(background: none) // Clean background for section slides
      set align(center + horizon)
    },
  )[
    #text(
      size: font-size-section-slide,
      weight: font-weight-section-slide,
      fill: font-color-section-slide,
    )[
      #section-title
    ]
  ]
}

// Thanks slide function using Touying's infrastructure
#let thanks-slide(
  thanks-text: "Thank you for your attention!",
  contact-author: "",
  email: "",
  qr-url: none, // Optional: URL to generate QR code for (replaces website URL)
) = {
  slide[
    #set page(background: none)

    // 3-row grid layout: thanks text, QR/website, contact+logo
    #grid(
      rows: (1fr, auto, auto),
      row-gutter: 2em,
      [
        // Row 1: Thanks message (centered, taking up available space)
        #align(center + horizon)[
          #text(
            size: font-size-thanks-slide-main,
            weight: font-weight-thanks-slide-main,
            fill: font-color-thanks-slide-main,
          )[
            #thanks-text
          ]
        ]
      ],
      [
        // Row 2: QR code or website (centered)
        #align(center)[
          #if qr-url != none [
            // Show QR code when URL is provided
            #qrcode(qr-url, width: 4cm, debug: false, quiet-zone: 0, colors: (white, bips-blue))
          ] else [
            // Show website URL as before
            #text(
              size: font-size-thanks-slide-website,
              weight: font-weight-thanks-slide-website,
              fill: font-color-thanks-slide-website,
            )[
              www.leibniz-bips.de
            ]
          ]
        ]
      ],
      [
        // Row 3: Contact information and logo
        // #v(1fr)
        #grid(
          columns: (1fr, 1fr),
          align: (right, left),
          gutter: 2em,
          [
            #align(right)[
              #text(
                size: font-size-thanks-slide-contact,
                weight: font-weight-thanks-slide-contact,
                fill: font-color-thanks-slide-contact,
              )[
                *Contact*

                #text(fill: font-color-thanks-slide-website)[#contact-author]\
                Leibniz Institute for Prevention Research\
                and Epidemiology -- BIPS\
                Achterstraße 30\
                28359 Bremen\
                Germany

                #if email != "" [
                  #text(fill: font-color-thanks-slide-website)[#email]
                ]
              ]
            ]
          ],
          [
            #align(left)[
              #image("bips-logo.png", width: 5.6cm)
            ]
          ],
        )
      ]
    )
  ]
}

// Empty slide function using Touying's infrastructure
#let empty-slide(..content) = {
  slide(
    setting: body => {
      set page(background: none)
    },
  )[
    #content.pos().join()
  ]
}
