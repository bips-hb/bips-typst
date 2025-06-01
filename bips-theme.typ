#import "@preview/touying:0.6.1": *

// BIPS Color Definitions
#let bips-blue = rgb(23, 99, 170)
#let bips-text-gray = rgb(66, 66, 66)
#let bips-orange = rgb(250, 133, 55)
#let bips-green = rgb(49, 210, 57)

// BIPS Typography Configuration
// =================================

// Main content styling
#let font-size-base = 18pt
#let font-color-base = bips-text-gray
#let font-weight-base = "regular"

#let font-size-small = 14pt
#let font-color-small = bips-text-gray
#let font-weight-small = "regular"

#let font-size-tiny = 13pt
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
#let font-size-slide-title = 24pt
#let font-color-slide-title = bips-blue
#let font-weight-slide-title = 600

#let font-size-slide-subtitle = 18pt
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
#let font-size-page-number = 13pt
#let font-color-page-number = bips-text-gray
#let font-weight-page-number = "regular"

// Code block styling
#let font-scale-code = 0.8

// Emphasis and strong text styling
#let font-color-emphasis = bips-blue
#let font-color-strong = bips-blue

// BIPS theme that leverages Touying's infrastructure
#let bips-theme(
  aspect-ratio: "16-9",
  body
) = {
  
  // Global text and styling configuration
  show: set text(
    font: ("Fira Sans", "Arial"),
    size: font-size-base,
    fill: font-color-base
  )
  
  // Emphasis in BIPS blue
  show emph: set text(fill: font-color-emphasis)
  
  // Strong text in BIPS blue
  show strong: set text(fill: font-color-strong)
  
  // List styling
  show list: set text(fill: font-color-base)
  show enum: set text(fill: font-color-base)
  
  // Code block styling - scaled down from base font size
  show raw.where(block: true): set text(size: font-scale-code * 1em)
  show raw.where(block: false): set text(size: font-scale-code * 1em)
  
  // Heading styles
  show heading.where(level: 1): set text(
    size: font-size-heading-1,
    weight: font-weight-heading-1,
    fill: font-color-heading-1
  )
  
  show heading.where(level: 2): set text(
    size: font-size-heading-2,
    weight: font-weight-heading-2, 
    fill: font-color-heading-2
  )
  
  show heading.where(level: 3): set text(
    size: font-size-heading-3,
    weight: font-weight-heading-3, 
    fill: font-color-heading-3
  )

  // Use Touying's infrastructure with BIPS customizations
  touying-slides(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 1.5cm, bottom: 1.5cm, left: 1cm, right: 1cm),
      background: {
        // Logo placement (appears on all slides)
        place(
          top + right,
          dx: -1cm,
          dy: 1cm,
          image("bips-logo.png", width: 3cm)
        )
        
        // Page number - centered underneath the logo
        place(
          top + right,
          dx: -2.25cm,
          dy: 4.25cm,
          context text(
            size: font-size-page-number, 
            fill: font-color-page-number, 
            weight: font-weight-page-number
          )[
            #str(here().page() - 1)
          ]
        )
      }
    ),
    config-common(
      // Use Touying's default slide function to preserve animations
      slide-fn: slide,
    ),
    // Apply BIPS slide title styling 
    config-methods(
      init: (self: none, body) => {
        // Helper function to create gradient line
        let gradient-line = {
          rect(
            width: 85%,
            height: 1pt,
            fill: gradient.linear(
              bips-text-gray,
              bips-text-gray.transparentize(50%),
              bips-text-gray.transparentize(95%),
              angle: 0deg
            )
          )
          v(0.5cm)
        }
        
        // Custom slide title formatting
        show heading.where(level: 1): it => {
          context {
            // Check if there's a level 2 heading on the same page after this title
            let current-page = here().page()
            let h2-headings = query(heading.where(level: 2))
            let has-subtitle = h2-headings.any(h => h.location().page() == current-page)
            
            block(
              width: 100%,
              spacing: 0.25em,
              {
                // Title
                block(
                  text(
                    size: font-size-slide-title, 
                    weight: font-weight-slide-title, 
                    fill: font-color-slide-title
                  )[#it.body]
                )
                
                // Only add gradient line if no subtitle follows
                if not has-subtitle {
                  v(0.1cm)
                  gradient-line
                }
              }
            )
          }
        }
        
        // Custom subtitle formatting with gradient line
        show heading.where(level: 2): it => {
          block(
            width: 100%,
            spacing: 0.25em,
            {
              // Subtitle
              v(0.2cm)
              block(
                text(
                  size: font-size-slide-subtitle, 
                  weight: font-weight-slide-subtitle, 
                  fill: font-color-slide-subtitle
                )[#it.body]
              )
              
              // Gradient line after subtitle
              v(0.1cm)
              gradient-line
            }
          )
        }
        body
      },
    ),
    body
  )
}

// Title slide function using Touying's infrastructure
#let title-slide(
  title: none,
  subtitle: none,
  author: none,
  institute: none,
  date: none,
  occasion: none,
) = {
  slide(setting: body => {
    set page(
      background: {
        // Logo placement (no page number on title slide)
        place(
          top + right,
          dx: -1cm,
          dy: 1cm,
          image("bips-logo.png", width: 3cm)
        )
      }
    )
    
    set align(center)
    
    // Title slide doesn't affect page numbering - content slides will start at 1
    
    v(2cm)
    
    // Title
    if title != none {
      block(
        text(
          size: font-size-title-slide-main, 
          weight: font-weight-title-slide-main, 
          fill: font-color-title-slide-main
        )[
          #title
        ]
      )
    }
    
    v(0.5cm)
    
    // Subtitle
    if subtitle != none {
      block(
        text(
          size: font-size-title-slide-subtitle, 
          weight: font-weight-title-slide-subtitle, 
          fill: font-color-title-slide-subtitle
        )[
          #subtitle
        ]
      )
    }
    
    v(1.5cm)
    
    // Author
    if author != none {
      block(
        text(
          size: font-size-title-slide-author, 
          weight: font-weight-title-slide-author, 
          fill: font-color-title-slide-author
        )[
          #author
        ]
      )
    }
    
    v(0.3cm)
    
    // Institute
    if institute != none {
      block(
        text(
          size: font-size-title-slide-institute, 
          weight: font-weight-title-slide-institute, 
          fill: font-color-title-slide-institute
        )[
          #institute
        ]
      )
    }
    
    v(1cm)
    
    // Date
    if date != none {
      block(
        text(
          size: font-size-title-slide-date, 
          weight: font-weight-title-slide-date, 
          fill: font-color-title-slide-date
        )[
          #date
        ]
      )
    }
    
    // Occasion
    if occasion != none {
      v(0.3cm)
      block(
        text(
          size: font-size-title-slide-date, 
          weight: font-weight-title-slide-date, 
          fill: font-color-title-slide-date
        )[
          #occasion
        ]
      )
    }
  })[]
}

// Section slide function using Touying's infrastructure  
#let section-slide(section-title) = {
  slide(setting: body => {
    set page(background: none) // Clean background for section slides
    set align(center + horizon)
  })[
    #text(
      size: font-size-section-slide, 
      weight: font-weight-section-slide, 
      fill: font-color-section-slide
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
) = {
  slide[
    #set page(background: none)
    #set align(center)
    
    #v(1cm)
    
    // Thanks message
    #text(
      size: font-size-thanks-slide-main, 
      weight: font-weight-thanks-slide-main, 
      fill: font-color-thanks-slide-main
    )[
      #thanks-text
    ]
    
    #v(1cm)
    
    // Website
    #text(
      size: font-size-thanks-slide-website, 
      weight: font-weight-thanks-slide-website, 
      fill: font-color-thanks-slide-website
    )[
      www.leibniz-bips.de/en
    ]
    
    #v(1cm)
    
    // Contact information and logo - positioned at bottom
    #place(
      bottom,
      dy: -0.5cm,
      grid(
        columns: (1fr, 1fr),
        align: (right, left),
        gutter: 2em,
        [
          #align(right)[
            #text(
              size: font-size-thanks-slide-contact, 
              weight: font-weight-thanks-slide-contact, 
              fill: font-color-thanks-slide-contact
            )[
              *Contact*
              
              #text(fill: font-color-thanks-slide-website)[#contact-author]\
              Leibniz Institute for Prevention Research\ 
              and Epidemiology -- BIPS\
              Achterstraße 30\
              D-28359 Bremen\
              Germany
              
              #if email != "" [
                #text(fill: font-color-thanks-slide-website)[#email.replace("@", "(at)")]
              ]
            ]
          ]
        ],
        [
          #align(left)[
            #image("bips-logo.png", width: 5cm)
          ]
        ]
      )
    )
  ]
}

// Empty slide function using Touying's infrastructure
#let empty-slide(..content) = {
  slide(setting: body => {
    set page(background: none)
  })[
    #content.pos().join()
  ]
}
