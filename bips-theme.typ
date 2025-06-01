#import "@preview/touying:0.6.1": *

// BIPS Color Definitions
#let bips-blue = rgb(23, 99, 170)
#let bips-text-gray = rgb(66, 66, 66)
#let bips-orange = rgb(250, 133, 55)
#let bips-green = rgb(49, 210, 57)

// BIPS theme that leverages Touying's infrastructure
#let bips-theme(
  aspect-ratio: "16-9",
  body
) = {
  
  // Global text and styling configuration
  show: set text(
    font: ("Fira Sans", "Arial"),
    size: 18pt,
    fill: bips-text-gray
  )
  
  // Emphasis in BIPS blue
  show emph: set text(fill: bips-blue)
  
  // Strong text in BIPS blue
  show strong: set text(fill: bips-blue)
  
  // List styling
  show list: set text(fill: bips-text-gray)
  show enum: set text(fill: bips-text-gray)
  
  // Code block styling - 80% of regular text size
  show raw.where(block: true): set text(size: 0.8em)
  show raw.where(block: false): set text(size: 0.8em)
  
  // Heading styles
  show heading.where(level: 1): set text(
    size: 20pt,
    weight: "bold",
    fill: bips-blue
  )
  
  show heading.where(level: 2): set text(
    size: 18pt,
    weight: "bold", 
    fill: bips-blue
  )
  
  show heading.where(level: 3): set text(
    size: 16pt,
    weight: "bold", 
    fill: bips-blue
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
          context text(size: 13pt, fill: bips-text-gray)[
            #str(here().page())
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
          v(0.1cm)
          rect(
            width: 80%,
            height: 1pt,
            fill: gradient.linear(
              bips-text-gray,
              bips-text-gray.transparentize(50%),
              bips-text-gray.transparentize(99%),
              angle: 0deg
            )
          )
          v(0.5cm)
        }
        
        // Track if we've seen a level 1 heading without a gradient line
        let pending-gradient = state("pending-gradient", false)
        
        // Custom slide title formatting
        show heading.where(level: 1): it => {
          pending-gradient.update(true)
          block(
            text(size: 24pt, weight: 600, fill: bips-blue)[#it.body]
          )
        }
        
        // Custom subtitle formatting
        show heading.where(level: 2): it => {
          block(
            width: 100%,
            spacing: 0.25em,
            {
              // Subtitle
              v(0.2cm)
              block(
                text(size: 18pt, weight: "bold", fill: bips-blue)[#it.body]
              )
              
              // Gradient line after subtitle
              gradient-line
            }
          )
          pending-gradient.update(false)
        }
        
        // Add gradient line after any other content if we have a pending title
        show: rest => {
          context {
            if pending-gradient.get() {
              gradient-line
              pending-gradient.update(false)
            }
          }
          rest
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
    set page(background: none) // No logo/page number on title slide
    
    set align(center)
    
    v(2cm)
    
    // Title
    if title != none {
      block(
        text(size: 26pt, weight: "bold", fill: bips-blue)[
          #title
        ]
      )
    }
    
    v(0.5cm)
    
    // Subtitle
    if subtitle != none {
      block(
        text(size: 20pt, weight: "bold", fill: bips-blue)[
          #subtitle
        ]
      )
    }
    
    v(1.5cm)
    
    // Author
    if author != none {
      block(
        text(size: 20pt, weight: "bold", fill: bips-blue)[
          #author
        ]
      )
    }
    
    v(0.3cm)
    
    // Institute
    if institute != none {
      block(
        text(size: 18pt, fill: bips-text-gray)[
          #institute
        ]
      )
    }
    
    v(1cm)
    
    // Date
    if date != none {
      block(
        text(size: 16pt, fill: bips-text-gray)[
          #date
        ]
      )
    }
    
    // Occasion
    if occasion != none {
      v(0.3cm)
      block(
        text(size: 16pt, fill: bips-text-gray)[
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
    #text(size: 32pt, weight: "bold", fill: bips-blue)[
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
    #text(size: 24pt, weight: "bold", fill: bips-blue)[
      #thanks-text
    ]
    
    #v(1cm)
    
    // Website
    #text(size: 16pt, fill: bips-blue)[
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
            #text(size: 14pt, fill: bips-text-gray)[
              *Contact*
              
              #text(fill: bips-blue)[#contact-author]\
              Leibniz Institute for Prevention Research\ 
              and Epidemiology -- BIPS\
              Achterstraße 30\
              D-28359 Bremen\
              Germany
              
              #if email != "" [
                #text(fill: bips-blue)[#email.replace("@", "(at)")]
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
