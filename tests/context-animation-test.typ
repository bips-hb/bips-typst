#import "@preview/touying:0.6.1": *

// Test 1: Theme without context background
#let simple-theme(body) = {
  show: set text(font: ("Fira Sans", "Arial"), size: 18pt)
  
  touying-slides(
    config-page(
      paper: "presentation-16-9",
      margin: (top: 1.55cm, bottom: 1.55cm, left: 1.55cm, right: 1.75cm),
      // No background context function
    ),
    body,
  )
}

#show: simple-theme

#slide[
  = Test Without Context Background
  
  Before pause.
  
  #pause
  
  After pause.
]

// Test 2: Theme with context background (like our current theme)
#let context-theme(body) = {
  show: set text(font: ("Fira Sans", "Arial"), size: 18pt)
  
  touying-slides(
    config-page(
      paper: "presentation-16-9", 
      margin: (top: 1.55cm, bottom: 1.55cm, left: 1.55cm, right: 1.75cm),
      background: context {
        let current-page = here().page()
        if current-page > 1 {
          // Simulated logo placement
          place(top + right, dx: -1cm, dy: 1cm, rect(width: 2cm, height: 1cm, fill: blue))
        }
      },
    ),
    body,
  )
}

#show: context-theme

#slide[
  = Test With Context Background
  
  Before pause.
  
  #pause
  
  After pause.
]