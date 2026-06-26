// Data Visualization — bypst gallery
//
// Grammar-of-graphics plots inside a bips slide with gribouille, whose API
// is modelled on ggplot2/plotnine — aimed at users coming from R.
//
//   [gribouille] — the gribouille package (grammar of graphics)
//
// Run: typst compile --root . gallery/dataviz.typ

#import "../bypst.typ": *
#import "@preview/gribouille:0.4.1": *

#show: bips-theme

// A small self-contained dataset (no external file reads).
// Data shape: array of row dictionaries (one dict per observation).
#let trees = (
  (species: "oak", girth: 8.3, height: 70),
  (species: "oak", girth: 10.5, height: 72),
  (species: "oak", girth: 12.9, height: 74),
  (species: "pine", girth: 11.0, height: 81),
  (species: "pine", girth: 13.8, height: 85),
  (species: "pine", girth: 16.0, height: 88),
)

#title-slide(
  title: "Data Visualization",
  subtitle: "ggplot2-style plots with gribouille",
  author: "Your Name",
  institute: bips-en,
  date: datetime.today().display(),
)

// [gribouille] Minimal scatter: data + aesthetic mapping + a geom layer.
// mapping: takes an aes() call; layers: takes a tuple of geom objects.
#bips-slide(title: "A scatter plot")[
  #align(center)[
    #plot(
      data: trees,
      mapping: aes(x: "girth", y: "height"),
      layers: (geom-point(),),
      width: 14cm,
      height: 8cm,
    )
  ]

  #small[`plot(data: .., mapping: aes(x: .., y: ..), layers: (geom-point(),))`]
]

// [gribouille] Map a third variable to colour via the aesthetic mapping.
#bips-slide(title: "Grouping by colour")[
  #align(center)[
    #plot(
      data: trees,
      mapping: aes(x: "girth", y: "height", colour: "species"),
      layers: (geom-point(size: 4pt),),
      width: 14cm,
      height: 8cm,
    )
  ]

  #small[Add `colour: "species"` to `aes()` — gribouille adds a legend automatically.]
]

// [gribouille] Layer geom-smooth on top of geom-point for a trend line.
#bips-slide(title: "Trend lines")[
  #align(center)[
    #plot(
      data: trees,
      mapping: aes(x: "girth", y: "height"),
      layers: (
        geom-point(size: 3pt),
        geom-smooth(method: "lm", se: false),
      ),
      width: 14cm,
      height: 8cm,
    )
  ]

  #small[Stack layers in the `layers:` tuple — drawn in order.]
]

// [gribouille] Titles, axis labels, and a minimal theme.
// labels: and theme: are named arguments on plot(), not positional geom layers.
#bips-slide(title: "Labels and theme")[
  #align(center)[
    #plot(
      data: trees,
      mapping: aes(x: "girth", y: "height", colour: "species"),
      layers: (geom-point(size: 4pt),),
      labels: labels(
        title: "Tree girth vs height",
        x: "Girth (in)",
        y: "Height (ft)",
        colour: "Species",
      ),
      theme: theme-minimal(),
      width: 14cm,
      height: 8cm,
    )
  ]
]

// [gribouille] Summaries with error bars.
// stat-summary is passed as stat: inside the geom, not as a top-level layer.
// geom-errorbar needs ymin/ymax; stat-summary(fun: "mean-sd") computes them.
#bips-slide(title: "Summaries with error bars")[
  #align(center)[
    #plot(
      data: trees,
      mapping: aes(x: "species", y: "height"),
      layers: (
        geom-errorbar(stat: stat-summary(fun: "mean-sd"), width: 0.3),
        geom-point(
          stat: stat-summary(fun: "mean"),
          size: 5pt,
        ),
      ),
      labels: labels(x: "Species", y: "Height (ft)"),
      theme: theme-minimal(),
      width: 10cm,
      height: 8cm,
    )
  ]

  #small[`stat:` on a geom aggregates before drawing; `"mean-sd"` yields `ymin`/`ymax`.]
]

// [gribouille] A polished plot combining all the pieces.
#bips-slide(title: "Putting it together")[
  #align(center)[
    #plot(
      data: trees,
      mapping: aes(x: "girth", y: "height", colour: "species"),
      layers: (
        geom-point(size: 4pt),
        geom-smooth(method: "lm", se: false),
      ),
      labels: labels(
        title: "Trees",
        x: "Girth (in)",
        y: "Height (ft)",
        colour: "Species",
      ),
      theme: theme-minimal(),
      width: 14cm,
      height: 8cm,
    )
  ]
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.name@leibniz-bips.de",
)
