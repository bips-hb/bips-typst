// Test: bips-theme(lang:) overrides the document's own text.lang
#import "/bypst.typ": *
#set text(lang: "de")
#show: bips-theme.with(lang: "en")

// The theme sets text.lang itself, so Typst's built-in strings follow the
// override too — not just the theme's own chrome.
#context assert.eq(
  text.lang,
  "en",
  message: "bips-theme(lang:) did not set text.lang",
)

#bips-slide(title: "Override")[
  #figure(caption: [Caption], rect(width: 3cm, height: 1cm))
]

#thanks-slide(contact-author: "Max Mustermann")
