#import "@local/bips-typst:0.1.0": *

#show: bips-theme

#title-slide(
  title: "Animation Features Demo",
  subtitle: "Incremental reveals with Touying",
  author: "Animation Expert",
  institute: "BIPS", 
  date: datetime.today().display(),
)

#bips-slide(
  title: "Incremental Reveals",
  subtitle: "Using #pause for step-by-step presentation"
)[
  Content appears step by step:
  
  - First point shows immediately
  #pause
  - Second point appears on click
  #pause  
  - Third point follows
  
  #pause
  
  You can also reveal entire blocks of content at once!
]

#bips-slide(
  title: "Mathematical Animations", 
  subtitle: "Step-by-step equation building"
)[
  Let's solve this equation:
  
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

#bips-slide(
  title: "Two-Column Layouts",
  subtitle: "Using \\#meanwhile for synchronized reveals"
)[
  #grid(columns: (1fr, 1fr), gutter: 2em)[
    Left column content:
    - First item
    #pause
    - Second item  
    #pause
    - Third item
  ][
    #meanwhile
    Right column appears when `#meanwhile` is triggered.
    #pause
    
    Additional right content on next click.
  ]
]

#thanks-slide(
  contact-author: "Animation Expert",
  email: "animations@leibniz-bips.de",
)
