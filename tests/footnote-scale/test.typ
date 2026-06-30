// Test: footnote-scale theme parameter.
// Footnote entry text should render at footnote-scale * base size.
// Here: 0.5 * 18pt (default base) = 9pt. The probe surfaces the rendered
// size so it can be verified via pdftotext (tytanic itself is compile-only).
#import "/bypst.typ": *
#show: bips-theme.with(footnote-scale: 0.5)

#show footnote.entry: it => context [[fn-size: #text.size] #it]

#bips-slide(title: "Footnote scale")[
  A claim#footnote[footnote body text] with some surrounding body text.
]
