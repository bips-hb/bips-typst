#import "bips-theme.typ": *

#show: bips-theme

#title-slide(
  title: "Callout Blocks",
  subtitle: "Quarto-style callouts for presentations",
  author: "BIPS Research Team",
  institute: bips_en,
  date: datetime.today().display(),
)

#bips-slide(title: "Available Callout Types", text-size: 15pt)[
  The BIPS theme includes 4 callout types with distinct colors and icons:

  #grid(
    columns: (1fr, 1fr),
    [
      #callout(type: "note")[
        *Note callouts* use BIPS blue and memo icon. Perfect for additional information or research notes.
      ]

      #callout(type: "tip")[
        *Tip callouts* use BIPS green and lightbulb icon. Great for best practices or helpful suggestions.
      ]


    ],
    [
      #callout(type: "warning")[
        *Warning callouts* use BIPS orange and warning icon. Use for limitations, cautions, or important considerations.]
      #callout(type: "important")[
        *Important callouts* use red and exclamation icon. For critical findings or key takeaways.
      ]],
  )


]


#bips-slide(title: "Custom Titles and Icons", text-size: 16pt)[
  You can customize the title and icon:

  #callout(type: "note", title: "Research Finding")[
    Custom title replaces the default "NOTE" label.
  ]

  #callout(type: "tip", title: "Pro Tip", icon: "🎯")[
    Custom icon replaces the default lightbulb.
  ]

  #callout(type: "warning", icon: "🚨")[
    Custom icon with default title (WARNING).
  ]
]

#bips-slide(title: "Usage Examples")[
  *Basic usage:*
  ```typst
  #callout(type: "note")[
    Your content here
  ]
  ```

  *With custom title:*
  ```typst
  #callout(type: "warning", title: "Data Limitation")[
    Sample size was limited to n=50
  ]
  ```

  *With custom icon:*
  ```typst
  #callout(type: "tip", icon: "🔬")[
    Laboratory protocols available
  ]
  ```
]

#bips-slide(title: "Academic Use Cases", text-size: 16pt)[
  Perfect for academic presentations:

  #callout(type: "important", title: "Key Finding")[
    Intervention showed 23% reduction in risk (p < 0.001, 95% CI: 15-31%).
  ]

  #callout(type: "warning", title: "Study Limitations")[
    Results may not generalize to populations outside Northern Europe.
  ]

  #callout(type: "tip", title: "Future Research")[
    Longitudinal follow-up study planned for 2025-2027.
  ]
]

#bips-slide(title: "Animation Compatibility", text-size: 15pt)[
  Callout blocks work with animations:

  #callout(type: "note")[
    This callout appears immediately.
  ]

  #pause

  #callout(type: "tip")[
    This callout appears after the pause.
  ]

  #pause

  #callout(type: "important")[
    Final callout completes the sequence.
  ]
]

#thanks-slide(
  contact-author: "BIPS Research Team",
  email: "example@leibniz-bips.de",
)
