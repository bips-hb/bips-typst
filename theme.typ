#import "@preview/touying:0.6.1": *
#import "@preview/codetastic:0.2.2": qrcode

// ===================================================================
// BIPS TYPST PRESENTATION THEME
// ===================================================================
// 
// A modern presentation template for BIPS using Typst and Touying
// https://github.com/bips-hb/bips-typst
//
// ===================================================================

// ===================================================================
// INSTITUTIONAL SHORTCUTS
// ===================================================================

#let bips_en = [Leibniz Institute for Prevention Research and Epidemiology --- BIPS]
#let bips_de = [Leibniz-Institut für Präventionsforschung und Epidemiologie --- BIPS]

// ===================================================================
// COLOR DEFINITIONS
// ===================================================================

#let bips-blue = rgb(23, 99, 170)
#let bips-logo-blue = rgb(65,125,177)
#let bips-text-gray = rgb(66, 66, 66)
#let bips-orange = rgb(250, 133, 55)
#let bips-green = rgb(49, 210, 57)

// ===================================================================
// TYPOGRAPHY CONFIGURATION
// ===================================================================

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
#let font-size-section-slide = 40pt
#let font-color-section-slide = bips-blue
#let font-weight-section-slide = "bold"

// Thanks slide styling
#let font-size-thanks-slide-main = 24pt
#let font-color-thanks-slide-main = bips-blue
#let font-weight-thanks-slide-main = "bold"

#let font-size-thanks-slide-website = 20pt
#let font-color-thanks-slide-website = bips-blue
#let font-weight-thanks-slide-website = "regular"

#let font-size-thanks-slide-contact = 14pt
#let font-color-thanks-slide-contact = bips-text-gray
#let font-weight-thanks-slide-contact = "regular"

// Page number styling
// Note: Page numbers cannot be customized per-slide due to Touying's architecture.
// The footer (containing page numbers) is rendered at the page level, not slide level,
// making per-slide size customization impossible without significant refactoring.
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

// ===================================================================
// UTILITY FUNCTIONS
// ===================================================================

/// Choose first non-none value from list of options
/// This simplifies the common pattern: if override != none { override } else { default }
/// Usage: #pick-first(user-override, theme-default)
#let pick-first(..options) = {
  for option in options.pos() {
    if option != none {
      return option
    }
  }
  return none
}

// ===================================================================
// BACKGROUND UTILITY FUNCTIONS
// ===================================================================

/// Create background with BIPS logo and/or page number
/// This centralizes the positioning logic for consistent placement across slide types
#let bips-background(
  show-logo: true, 
  show-page-number: true,
  page-number-size: font-size-page-number,  // Allow override for theme customization
) = {
  if show-logo or show-page-number {
    {
      if show-logo {
        // BIPS logo placement
        place(
          top + right,
          dx: -1cm,
          dy: 1cm,
          image("bips-logo.png", width: 3cm),
        )
      }
      
      if show-page-number {
        // Page number placement
        place(
          top + right,
          dx: -2.25cm,
          dy: 4.25cm,
          text(
            size: page-number-size,
            fill: font-color-page-number,
            weight: font-weight-page-number,
          )[
            #context {
              let slide-num = utils.slide-counter.get().first()
              // Use a simple state counter to track if title slide exists
              let title-slide-marker = query(<bips-title-slide-marker>)
              let has-title-slide = title-slide-marker.len() > 0
              
              if has-title-slide {
                // With title slide: first content slide (slide-num=1) should show "1"
                str(slide-num)
              } else {
                // Without title slide: first slide (slide-num=0) should show "1"  
                str(slide-num + 1)
              }
            }
          ],
        )
      }
    }
  } else {
    // Return empty background when both are disabled
    none
  }
}

// ===================================================================
// MAIN THEME FUNCTION
// ===================================================================

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
  let effective-font-size-base = pick-first(base-size, font-size-base)
  let effective-font-size-slide-title = pick-first(slide-title-size, font-size-slide-title)
  let effective-font-size-slide-subtitle = pick-first(slide-subtitle-size, font-size-slide-subtitle)
  let effective-font-size-heading-1 = pick-first(heading-1-size, font-size-heading-1)
  let effective-font-size-heading-2 = pick-first(heading-2-size, font-size-heading-2)
  let effective-font-size-heading-3 = pick-first(heading-3-size, font-size-heading-3)
  let effective-font-size-small = pick-first(small-size, font-size-small)
  let effective-font-size-tiny = pick-first(tiny-size, font-size-tiny)
  let effective-font-size-page-number = pick-first(page-number-size, font-size-page-number)
  let effective-code-block-scale = pick-first(code-block-scale, font-scale-code-block)
  let effective-code-inline-scale = pick-first(code-inline-scale, font-scale-code-inline)

  // Global text and styling configuration
  show: set text(
    font: "Fira Sans",
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

  // Note: Heading styles are handled within slide functions to avoid
  // interference with Touying's animation system (#pause)

  // Use Touying's infrastructure with BIPS customizations
  touying-slides(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 1.55cm, bottom: 1.55cm, left: 1.55cm, right: 1.75cm),
      background: bips-background(
        show-logo: true, 
        show-page-number: true,
        page-number-size: effective-font-size-page-number,
      ),
    ),
    body,
  )
}

// ===================================================================
// SLIDE TYPE DEFINITIONS
// ===================================================================

// -------------------------------------------------------------------
// Content Slides
// -------------------------------------------------------------------

#let bips-slide(
  title: none,
  subtitle: none,
  // Optional font size overrides for this slide
  title-size: none,
  subtitle-size: none,
  text-size: none,
  code-block-scale: none,
  code-inline-scale: none,
  ..args,
  body,
) = {
  slide(..args)[
    // Apply slide-specific styling overrides including headings
    #show raw.where(block: true): set text(
      size: pick-first(code-block-scale, font-scale-code-block) * 1em,
    )
    #show raw.where(block: false): set text(
      size: pick-first(code-inline-scale, font-scale-code-inline) * 1em,
    )
    
    // Handle heading styling within slides to avoid animation interference
    #show heading.where(level: 3): set text(
      size: font-size-heading-3,
      weight: font-weight-heading-3,
      fill: font-color-heading-3,
    )

    #if title != none or subtitle != none {
      // Title and subtitle section - smart spacing without grid
      v(.1em)

      // Combine title and subtitle in natural flow
      if title != none and subtitle != none {
        // Both title and subtitle - natural line break between them
        block(
          width: 90%,
          [
            #text(
              size: pick-first(title-size, font-size-slide-title),
              weight: font-weight-slide-title,
              fill: font-color-slide-title,
            )[#title]
          ],
        )
        v(-0.5em)
        block(
          width: 90%,
          [
            #text(
              size: pick-first(subtitle-size, font-size-slide-subtitle),
              weight: font-weight-slide-subtitle,
              fill: font-color-slide-subtitle,
            )[#subtitle]
          ],
        )
      } else if title != none {
        // Title only
        text(
          size: pick-first(title-size, font-size-slide-title),
          weight: font-weight-slide-title,
          fill: font-color-slide-title,
        )[#title]
      } else if subtitle != none {
        // Subtitle only
        text(
          size: pick-first(subtitle-size, font-size-slide-subtitle),
          weight: font-weight-slide-subtitle,
          fill: font-color-slide-subtitle,
        )[#subtitle]
      }

      // Gradient line after title/subtitle
      rect(
        width: 85%,
        height: 1pt,
        fill: gradient.linear(
          bips-text-gray,
          white,
          angle: 0deg,
        ),
      )

      v(1em)

      // Content area - natural flow allows footnotes to work
      let content-size = pick-first(text-size, none)
      if content-size != none {
        text(size: content-size)[#body]
      } else {
        body
      }
    } else {
      // If no title/subtitle, just show content
      let content-size = pick-first(text-size, none)
      if content-size != none {
        text(size: content-size)[#body]
      } else {
        body
      }
    }
  ]
}

// -------------------------------------------------------------------
// Title Slide
// -------------------------------------------------------------------

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
        background: bips-background(
          show-logo: true,
          show-page-number: false,  // No page number on title slide
        ),
      )

      // Mark that a title slide exists for slide numbering logic
      place(hide[#metadata("title-slide") <bips-title-slide-marker>])

      set align(center)

      v(1fr)

      // Title (width constrained to prevent overlap with logo in top-right)
      if title != none {
        block(
          width: 85%,
          text(
            size: pick-first(title-size, font-size-title-slide-main),
            weight: font-weight-title-slide-main,
            fill: font-color-title-slide-main,
          )[
            #title
          ],
        )
      }

      v(1fr)

      // Subtitle
      if subtitle != none {
        block(
          width: 85%,
          text(
            size: pick-first(subtitle-size, font-size-title-slide-subtitle),
            weight: font-weight-title-slide-subtitle,
            fill: font-color-title-slide-subtitle,
          )[
            #subtitle
          ],
        )
      }

      v(1fr)

      // Author(s) - support both single and multiple authors
      if authors != none {
        // Multiple authors format
        block(
          text(
            size: pick-first(author-size, font-size-title-slide-author),
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
            size: pick-first(author-size, font-size-title-slide-author),
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
            size: pick-first(institute-size, font-size-title-slide-institute),
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
            size: pick-first(institute-size, font-size-title-slide-institute),
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
            size: pick-first(date-size, font-size-title-slide-date),
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
            size: pick-first(date-size, font-size-title-slide-date),
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

// -------------------------------------------------------------------
// Section Slide
// -------------------------------------------------------------------

#let section-slide(
  section-title,
  show-logo: true,     // Show BIPS logo by default (department requirement)
  show-page-number: false,  // Hide page number by default (cleaner look)
) = {
  slide(
    setting: body => {
      // Use utility function for consistent logo/page number placement
      set page(
        background: bips-background(
          show-logo: show-logo,
          show-page-number: show-page-number,
        )
      )
      
      // Add invisible heading for PDF outline/bookmarks
      place(hide[#heading(level: 1, outlined: true)[#section-title]])
      
      set align(center + horizon)
      
      text(
        size: font-size-section-slide,
        weight: font-weight-section-slide,
        fill: font-color-section-slide,
      )[
        #section-title
      ]
    },
  )[]
}

// -------------------------------------------------------------------
// Bibliography Slide
// -------------------------------------------------------------------

/// Display a bibliography slide with references
///
/// Due to Typst's path resolution, `bibliography()` must be called from
/// the user's document (not inside this package). Pass the result as content.
///
/// Example:
/// ```
/// #bibliography-slide[
///   #bibliography("references.bib", style: "apa", full: true)
/// ]
/// ```
#let bibliography-slide(
  title: "References",
  body,
) = {
  bips-slide(title: title)[
    #align(horizon)[
      #body
    ]
  ]
}

// -------------------------------------------------------------------
// Thanks Slide
// -------------------------------------------------------------------

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
      rows: (1fr, 1fr, auto),
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
        #align(center + horizon)[
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
              #image("bips-logo.png", width: 5.5cm)
            ]
          ],
        )
      ]
    )
  ]
}

// -------------------------------------------------------------------
// Empty Slide
// -------------------------------------------------------------------

#let empty-slide(..content) = {
  slide(
    setting: body => {
      set page(
        background: bips-background(
          show-logo: false,
          show-page-number: false,
        )
      )
      content.pos().join()
    },
  )[]
}

// ===================================================================
// UTILITY FUNCTIONS
// ===================================================================

// -------------------------------------------------------------------
// Color Utility Functions
// -------------------------------------------------------------------

/// Apply BIPS blue color to text
/// Example: #blue[This text is blue]
#let blue(content) = text(fill: bips-blue)[#content]

/// Apply BIPS logo blue color to text
/// Example: #logo-blue[This text is the same shade of blue as the BIPS logo]
#let logo-blue(content) = text(fill: bips-logo-blue)[#content]

/// Apply BIPS orange color to text
/// Example: #orange[This text is orange]
#let orange(content) = text(fill: bips-orange)[#content]

/// Apply BIPS green color to text
/// Example: #green[This text is green]
#let green(content) = text(fill: bips-green)[#content]

/// Apply gray color to text
/// Example: #gray[This text is gray]
#let gray(content) = text(fill: bips-text-gray)[#content]

// -------------------------------------------------------------------
// Author Affiliation Helper
// -------------------------------------------------------------------

/// Helper function to format author with superscript affiliations
/// Can take single number: inst(1) or multiple numbers: inst(1,4,5)
#let inst(..numbers) = {
  let nums = numbers.pos()
  if nums.len() == 0 {
    ""
  } else {
    super[#nums.map(str).join(",")]
  }
}

// -------------------------------------------------------------------
// Multi-Column Layout Helpers
// -------------------------------------------------------------------

/// Two-column layout with equal columns by default
///
/// Example: #two-columns[Left content][Right content]
/// With options: #two-columns(gutter: 2em)[Left][Right]
#let two-columns(
  gutter: 1em,
  columns: (1fr, 1fr),
  ..args,
  left,
  right,
) = {
  grid(
    columns: columns,
    gutter: gutter,
    ..args,
    left,
    right,
  )
}

/// Three-column layout with equal columns by default
///
/// Example: #three-columns[Left][Center][Right]
/// With options: #three-columns(gutter: 1.5em, columns: (1fr, 2fr, 1fr))[L][C][R]
#let three-columns(
  gutter: 1em,
  columns: (1fr, 1fr, 1fr),
  ..args,
  left,
  center,
  right,
) = {
  grid(
    columns: columns,
    gutter: gutter,
    ..args,
    left,
    center,
    right,
  )
}

// -------------------------------------------------------------------
// Callout Blocks
// -------------------------------------------------------------------

/// Create compact styled callout blocks with inline icons
///
/// Available types: note, tip, warning, important
/// Displays icon inline with content for space efficiency
///
/// Example: #callout(type: "warning")[Content here]
#let callout(
  type: "note",
  title: none,
  icon: none,
  body,
) = {
  // Color schemes for different callout types
  let colors = (
    note: (border: bips-blue, bg: bips-blue.lighten(90%), icon: bips-blue),
    tip: (border: bips-green, bg: bips-green.lighten(90%), icon: bips-green),
    warning: (border: bips-orange, bg: bips-orange.lighten(90%), icon: bips-orange),
    important: (border: red, bg: red.lighten(90%), icon: red),
  )

  // Default icons for each type
  let icons = (
    note: "📝",
    tip: "💡",
    warning: "⚠",
    important: "❗",
  )

  let color-scheme = colors.at(type, default: colors.note)
  let default-icon = icons.at(type, default: icons.note)
  let display-icon = pick-first(icon, default-icon)

  block(
    width: 100%,
    stroke: (left: 4pt + color-scheme.border),
    fill: color-scheme.bg,
    inset: (left: 0.8em, right: 0.8em, top: 0.5em, bottom: 0.5em),
    radius: (right: 4pt),
    below: 0.8em,
  )[
    #if title != none {
      // When title is provided, show icon + title on separate line as before
      text(
        size: 0.9em,
        weight: "bold",
        fill: color-scheme.icon,
      )[
        #if display-icon != none [#display-icon ]
        #title
      ]
      v(0.3em)
      body
    } else {
      // Default: icon inline with content, no title
      if display-icon != none [
        #text(fill: color-scheme.icon, size: 0.9em)[#display-icon] #h(0.5em)
      ]
      body
    }
  ]
}

// -------------------------------------------------------------------
// Miscellaneous Helpers
// -------------------------------------------------------------------

/// Convenience function for vertical fill
#let vfill = v(1fr)
