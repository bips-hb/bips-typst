// Test: citation helpers (citet, citep, sideref, footcite)
#import "/bypst.typ": *
#show: bips-theme

#bips-slide(title: "Citation helpers")[
  Prose: #citet(<knuth1984>) introduced literate programming.
  Parenthetical: a foundational work #citep(<knuth1984>).
  Footnote-style#footcite(<knuth1984>).

  #sideref(<knuth1984>)
  #sideref(<knuth1984>, form: "prose")

  #bibliography(
    bytes(
      "@book{knuth1984, author={Knuth, Donald E.}, title={The TeXbook}, year={1984}, publisher={Addison-Wesley}}",
    ),
    title: none,
    style: "springer-basic-author-date",
  )
]
