// Test: theme chrome follows the document language
#import "/bypst.typ": *
#set text(lang: "de")
#show: bips-theme

// institution defaults to the German name via config-info
#title-slide(title: "Deutscher Foliensatz", author: "Max Mustermann")

// title: auto resolves to "Literatur"
#bibliography-slide[Keine Einträge.]

// thanks-text / contact-title / institution / address all resolve to German
#thanks-slide(contact-author: "Max Mustermann", email: "max@leibniz-bips.de")

// ...and every one of them stays overridable, e.g. for a satellite office
#thanks-slide(
  thanks-text: "Danke!",
  contact-title: "Anschrift",
  address: [Musterweg 1\ 12345 Musterstadt],
  website: "www.example.org",
)

// A language table missing a key falls back to English silently, which reads as
// a half-translated deck rather than an error. Keep the tables in lockstep.
#for (lang, table) in theme-strings {
  assert(
    table.keys().sorted() == theme-strings.en.keys().sorted(),
    message: "theme-strings." + lang + " does not define the same keys as en",
  )
}
