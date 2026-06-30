// Speaker Notes — bypst gallery demo
//
// Demonstrates Touying speaker notes. A note is attached by writing
// `#speaker-note[...]` immediately AFTER a slide; it never appears on the slide
// itself. Notes reach the presenter two ways:
//   1. pdfpc presenter console — via an exported `.pdfpc` sidecar (enable-pdfpc).
//   2. Rendered beside each slide in the PDF (show-notes-on-second-screen).
//
// `just all` builds both artifacts from this file:
//   - gallery/speaker-notes.pdf      normal 16:9 deck (open this in pdfpc)
//   - gallery/speaker-notes.pdfpc    the sidecar pdfpc reads for the notes
//   - gallery/speaker-notes-notes.pdf  notes rendered inline (no pdfpc needed)
//
// To try pdfpc (install: `brew install pdfpc`):
//   pdfpc gallery/speaker-notes.pdf      # auto-loads the .pdfpc sidecar
//
// Run: typst compile --root . gallery/speaker-notes.typ
//   Add `--input notes=true` to render the notes beside each slide in the PDF.

#import "../bypst.typ": *

// [Touying] enable-pdfpc records the notes into the exported sidecar. The deck
// stays a normal 16:9 PDF (the proper input for pdfpc). Passing
// `--input notes=true` additionally renders the notes beside each slide.
// [Touying] config-info() sets the PDF metadata and feeds the title slide;
// config-common() enables pdfpc export and presenter notes. Both config dicts
// are forwarded to Touying and merged.
#show: bips-theme.with(
  config-info(
    title: "Speaker Notes",
    subtitle: "Presenter-only notes with Touying",
    author: "BIPS",
  ),
  config-common(
    enable-pdfpc: true,
    show-notes-on-second-screen: if sys.inputs.at("notes", default: "")
      == "true" {
      right
    },
  ),
)

#title-slide()
#speaker-note[A note attached to the title slide. It appears in the right-hand panel, never on the slide.]

// [Touying] Attach a note by placing `#speaker-note[...]` right after the slide.
#bips-slide(title: "Attaching a Note")[
  Write `#speaker-note[...]` immediately after a slide call. The note stays
  out of the slide and is delivered only to the presenter.

  - Record notes for export: `config-common(enable-pdfpc: true)`
  - Show them beside each slide (as in this deck):
    `config-common(show-notes-on-second-screen: right)`
]
#speaker-note[
  Notes accept *formatted* content: multiple paragraphs, lists, emphasis.

  Remind the audience that this text is visible only to the presenter.
]

// [Touying] Notes work on any slide type, including those with #pause. Attach
// after the whole slide; the note covers all of its subslides.
#bips-slide(title: "Notes with Animations")[
  First point.
  #pause
  Second point appears on click.
]
#speaker-note[This single note is shown for every subslide of the animated slide.]

// [Touying] To present with pdfpc, export a sidecar alongside the PDF, then
// open the PDF in pdfpc — it reads the notes from the sidecar.
#bips-slide(title: "Exporting for pdfpc")[
  #link("https://pdfpc.github.io/")[pdfpc] is a presenter console (current slide,
  next slide, notes, timer). Export the sidecar with:

  #small[`typst query --root . slides.typ --field value --one "<pdfpc-file>" > slides.pdfpc`]
]
#speaker-note[The sidecar carries these notes; pdfpc loads them next to the slides.]
