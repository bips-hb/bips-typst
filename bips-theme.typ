#import "@preview/touying:0.6.1": *

// BIPS Color Definitions
#let bips-blue = rgb(23, 99, 170)
#let bips-text-gray = rgb(66, 66, 66)
#let bips-orange = rgb(250, 133, 55)
#let bips-green = rgb(49, 210, 57)

// Main slide function
#let slide(
  title: none,
  subtitle: none,
  ..content
) = {
  pagebreak(weak: true)
  
  set page(
    paper: "presentation-16-9",
    margin: (top: 1.5cm, bottom: 1.5cm, left: 1cm, right: 1cm),
    background: {
      // Logo placement
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
          #counter(page).display()
        ]
      )
    }
  )
  
  set text(
    font: ("Fira Sans", "Arial"),
    size: 20pt,
    fill: bips-text-gray
  )
  
  // Header with title and subtitle
  if title != none {
    block(
      width: 100%,
      spacing: 0.25em,
      {
        // Title
        block(
          text(size: 24pt, weight: 600, fill: bips-blue)[#title]
        )
        
        // Subtitle
        if subtitle != none {
          block(
            text(size: 22pt, weight: 400, fill: bips-blue)[#subtitle]
          )
        }
        
        // Horizontal gradient line
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
    )
  }
  
  // Content
  content.pos().join()
}

// Title slide function
#let title-slide(
  title: none,
  subtitle: none,
  author: none,
  institute: none,
  date: none,
  occasion: none,
) = {
  set page(
    paper: "presentation-16-9",
    margin: (top: 2cm, bottom: 1.5cm, left: 1cm, right: 1cm),
    background: none
  )
  
  set text(
    font: ("Fira Sans", "Arial"),
    fill: bips-text-gray
  )
  
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
}

// Section slide function
#let section-slide(
  section-title
) = {
  set page(
    paper: "presentation-16-9",
    margin: (top: 2cm, bottom: 1.5cm, left: 1cm, right: 1cm),
    background: none
  )
  
  set text(
    font: ("Helvetica", "Arial"),
    fill: bips-blue
  )
  
  set align(center + horizon)
  
  text(size: 32pt, weight: "bold")[
    #section-title
  ]
}

// Thanks slide function
#let thanks-slide(
  thanks-text: "Thank you for your attention!",
  contact-author: "",
  email: "",
) = {
  set page(
    paper: "presentation-16-9",
    margin: (top: 2cm, bottom: 1.5cm, left: 1cm, right: 1cm),
    background: none
  )
  
  set text(
    font: ("Helvetica", "Arial"),
    fill: bips-text-gray
  )
  
  set align(center)
  
  v(1cm)
  
  // Thanks message
  text(size: 24pt, weight: "bold", fill: bips-blue)[
    #thanks-text
  ]
  
  v(1cm)
  
  // Website
  text(size: 16pt, fill: bips-blue)[
    www.leibniz-bips.de/en
  ]
  
  v(1cm)
  
  // Contact information and logo - flush to bottom
  place(
    bottom,
    dy: -0.1cm,
    grid(
      columns: (1fr, 1fr),
      align: (right, left),
      gutter: 2em,
      {
        align(right)[
          #text(size: 14pt, fill: bips-text-gray)[
            *Contact*
            
            #text(fill: bips-blue)[#contact-author]
            
            Leibniz Institute for Prevention Research\
            and Epidemiology -- BIPS
            
            Achterstraße 30
            
            D-28359 Bremen
            
            #text(fill: bips-blue)[#email]
          ]
        ]
      },
      {
        align(left)[
          #image("bips-logo.png", width: 5cm)
        ]
      }
    )
  )
}

// Empty slide function (no logo, no page number)
#let empty-slide(
  ..content
) = {
  pagebreak(weak: true)
  
  set page(
    paper: "presentation-16-9",
    margin: (top: 2cm, bottom: 1.5cm, left: 1cm, right: 1cm),
    background: none
  )
  
  set text(
    font: ("Helvetica", "Arial"),
    size: 11pt,
    fill: bips-text-gray
  )
  
  content.pos().join()
}

// Configure text styling globally
#let bips-theme(doc) = {
  // Emphasis in BIPS blue
  show emph: set text(fill: bips-blue)
  
  // List styling
  show list: set text(fill: bips-text-gray)
  show enum: set text(fill: bips-text-gray)
  
  // Code block styling - 80% of regular text size
  show raw.where(block: true): set text(size: 0.8em)
  show raw.where(block: false): set text(size: 0.8em)
  
  // Heading styles
  show heading.where(level: 1): set text(
    size: 18pt,
    weight: "bold",
    fill: bips-blue
  )
  
  show heading.where(level: 2): set text(
    size: 14pt,
    weight: "bold", 
    fill: bips-blue
  )
  
  show heading.where(level: 3): set text(
    size: 12pt,
    weight: "bold", 
    fill: bips-blue
  )
  
  doc
}
