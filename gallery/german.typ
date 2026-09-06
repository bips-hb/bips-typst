// German-language presentation — localization reference.
//
// One line does everything: `#set text(lang: "de")` before the theme. It drives
// Typst's own output (Abbildung, „…“, Silbentrennung, Literaturangaben) *and*
// the theme's own strings (Danksagung, Kontaktblock, Literatur, Institutsname).
// Nothing else in this file mentions a language.
#import "../bypst.typ": *

#set text(lang: "de")
#show: bips-theme.with()

// [BIPS] `institution` defaults to the BIPS name in the deck's language, so the
// title slide shows the German form without being told.
#title-slide(
  title: "Deutschsprachiger Foliensatz",
  subtitle: "Lokalisierung in bypst",
  author: "Erika Mustermann",
  date: "5. September 2026",
)

#bips-slide(
  title: "Was die Sprache steuert",
  subtitle: "Typst und Theme aus einer Quelle",
)[
  / Typst: Abbildungspräfixe, Anführungszeichen, Silbentrennung, Literaturangaben
  / Theme: Danksagung, Kontaktblock, Titel der Literaturfolie, Institutsname

  #v(0.5em)

  Er nannte es #quote[eine ungefähre Antwort] und ging weiter --- die
  Anführungszeichen richten sich nach der Dokumentsprache.
]

#bips-slide(title: "Abbildungen und Zitate")[
  #two-columns[
    // [Typst] Das Präfix lautet "Abbildung", nicht "Figure".
    #figure(
      image("/logo.png", width: 55%),
      caption: [Das BIPS-Logo],
    )
  ][
    #quote(block: true, attribution: [Tukey, 1962])[
      Eine ungefähre Antwort auf die richtige Frage ist weit mehr wert als eine
      exakte Antwort auf die falsche.
    ]
  ]
]

#bips-slide(title: "Karten")[
  #card(title: "Definition")[
    Der *Schätzwert* ist die Zahl, die ein Schätzverfahren aus einer
    konkreten Stichprobe berechnet.
  ]
  #card(title: "Ergebnis", color: bips-green)[
    Konsistenz: $hat(theta) -> theta$ in Wahrscheinlichkeit.
  ]
]

// [BIPS] `title:` bleibt frei — ohne Angabe steht hier "Literatur".
#bibliography-slide(bib: read("references.bib"))

// [BIPS] Danksagung, Überschrift "Kontakt" und Anschrift kommen auf Deutsch.
// Jeder Wert lässt sich einzeln überschreiben, etwa für eine Außenstelle.
#thanks-slide(
  contact-author: "Erika Mustermann",
  email: "mustermann@leibniz-bips.de",
)
