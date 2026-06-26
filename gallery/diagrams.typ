// Diagrams — bypst gallery
//
// Drawing and diagramming inside a bips slide, for the TikZ crowd:
//   - CeTZ: general drawing (shapes, coordinates, annotations)
//   - Fletcher: nodes and arrows (flowcharts, commutative diagrams)
//
//   [CeTZ]     — the cetz package (drawing)
//   [Fletcher] — the fletcher package (nodes/arrows)
//
// Run: typst compile --root . gallery/diagrams.typ

#import "../bypst.typ": *
#import "@preview/cetz:0.4.1"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#show: bips-theme

#title-slide(
  title: "Diagrams in Typst",
  subtitle: "CeTZ and Fletcher for the TikZ crowd",
  author: "Your Name",
  institute: bips-en,
  date: datetime.today().display(),
)

#section-slide("CeTZ — drawing")

// [CeTZ] A canvas with basic shapes and coordinates.
#bips-slide(title: "Shapes and coordinates")[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      circle((0, 0), radius: 1, fill: color.blue.lighten(60%))
      rect((2, -1), (4, 1), fill: color.orange.lighten(60%))
      line((-1.5, 0), (1.5, 0), stroke: 1pt)
    })
  ]

  #small[`cetz.canvas({ import cetz.draw: *; circle(..); rect(..); line(..) })`]
]

// [CeTZ] Annotated drawing with labels.
#bips-slide(title: "Annotated drawing")[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      line((0, 0), (3, 0), mark: (end: ">"))
      line((0, 0), (0, 2), mark: (end: ">"))
      content((3.3, 0))[$x$]
      content((0, 2.3))[$y$]
      circle((2, 1.3), radius: 0.08, fill: black)
      content((2, 1.7))[$(x_i, y_i)$]
    })
  ]

  #small[`line(.., mark: (end: ">"))` for arrowheads; `content(pos)[..]` for text labels.]
]

// [CeTZ] A small tree drawn from coordinates.
#bips-slide(title: "A tree")[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      let n(pos, body) = {
        circle(pos, radius: 0.5, fill: color.blue.lighten(70%))
        content(pos)[#body]
      }
      line((0, 0), (-1.5, -1.5))
      line((0, 0), (1.5, -1.5))
      n((0, 0))[root]
      n((-1.5, -1.5))[L]
      n((1.5, -1.5))[R]
    })
  ]

  #small[Local `let n(pos, body)` draw helper for nodes; `line()` edges connect coordinates.]
]

#section-slide("Fletcher — nodes and arrows")

// [Fletcher] A flowchart with a decision diamond.
#bips-slide(title: "Flowchart")[
  #align(center)[
    #diagram(
      node-stroke: 1pt,
      spacing: 2em,
      node((0, 0), [Start], corner-radius: 2pt),
      edge("-|>"),
      node((0, 1), [Decision], shape: fletcher.shapes.diamond),
      edge("-|>", [yes]),
      node((0, 2), [End], corner-radius: 2pt),
      edge((0, 1), (1, 1), "-|>", [no]),
      node((1, 1), [Revise], corner-radius: 2pt),
    )
  ]

  #small[`shape: fletcher.shapes.diamond` for decisions; two outgoing edges for yes/no branches.]
]

// [Fletcher] A commutative diagram via the math-mode syntax.
#bips-slide(title: "Commutative diagram")[
  #align(center)[
    #diagram(
      $
                      G edge(f, ->) edge("d", pi, ->>) & im(f) \
        G slash ker(f) edge("ur", tilde(f), "hook-->")
      $,
    )
  ]

  #small[Math-mode `diagram($ ... $)` with `edge(label, arrow)`.]
]

// [Fletcher] A two-state machine with labeled edges.
#bips-slide(title: "State machine")[
  #align(center)[
    #diagram(
      node-stroke: 1pt,
      node((0, 0), [A], shape: circle),
      node((2, 0), [B], shape: circle),
      edge((0, 0), (2, 0), "-|>", [go], bend: 30deg),
      edge((2, 0), (0, 0), "-|>", [back], bend: 30deg),
    )
  ]

  #small[`shape: circle` nodes; `edge(.., bend: 30deg, [label])` for curved labeled transitions.]
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.name@leibniz-bips.de",
)
