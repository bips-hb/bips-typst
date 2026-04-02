# BIPS Typst Presentation Template

A 16:9 presentation template for [BIPS](https://www.leibniz-bips.de/) using [Typst](https://typst.app/) and [Touying](https://touying-typ.github.io/). Based on the institutional style from [bips-beamer](http://github.com/bips-hb/bips-beamer).

**Version: 0.1.1**

## Quick Start

```typst
#import "@local/bips-typst:0.1.1": *
#show: bips-theme

#title-slide(
  title: "Your Presentation Title",
  author: "Your Name",
  institute: bips_en, // or bips_de
  date: datetime.today().display(),
)

#bips-slide(title: "Introduction")[
  - Bullet points
  - *Bold* and _italic_ in BIPS blue
  - Math: $s^2 = 1/(n-1) sum_(i=1)^n (x_i - overline(x))^2$

  #pause

  - Revealed on click
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.email@leibniz-bips.de",
  qr-url: "https://link-to-slides.example.com",
)
```

## Installation

Clone and install locally:

```sh
git clone https://github.com/bips-hb/bips-typst.git
cd bips-typst
just install
```

Then import in any `.typ` file:

```typst
#import "@local/bips-typst:0.1.1": *
```

## Slide Types

| Function | Purpose |
|---|---|
| `#title-slide()` | Opening slide with author, institute, date |
| `#bips-slide()` | Content slide with optional title/subtitle |
| `#section-slide()` | Section divider |
| `#thanks-slide()` | Closing slide with contact info and optional QR code |
| `#bibliography-slide[]` | References |
| `#empty-slide[]` | Blank slide without branding |

### Content slide options

```typst
#bips-slide(
  title: "Slide Title",
  subtitle: "Optional Subtitle",
  content-align: center + horizon, // center content vertically and horizontally
  text-size: 16pt,                 // override text size for this slide
)[
  Content here
]
```

`content-align` accepts any Typst alignment: `center`, `horizon`, `center + horizon`, etc.

### Multi-author title slides

```typst
#title-slide(
  title: "Collaborative Research",
  authors: (
    "Jane Doe" + inst(1,2),
    "John Smith" + inst(1),
  ),
  institutes: (
    "BIPS",
    "University of Bremen",
  ),
)
```

### Section slides

```typst
#section-slide("Results")
#section-slide("Methods", show-logo: false, show-page-number: true)
```

## Layout Helpers

```typst
// Two columns (equal by default)
#two-columns[Left][Right]
#two-columns(columns: (2fr, 1fr), gutter: 2em)[Wide][Narrow]

// Three columns
#three-columns[A][B][C]
```

## Utilities

### Color helpers

```typst
#blue[text]  #orange[text]  #green[text]  #gray[text]
```

### Callout boxes

```typst
#callout(type: "note")[Information]
#callout(type: "tip")[Helpful hint]
#callout(type: "warning")[Caution]
#callout(type: "important")[Critical]
#callout(type: "tip", title: "Custom Title")[With a title]
```

### Compact list spacing

For dense layouts (e.g. multi-column slides), use `#compact` to tighten list spacing:

```typst
#compact[
  - Item A
  - Item B
  - Item C
]
```

Adjustable: `#compact(spacing: 0.2em, leading: 0.2em)[...]`

For lighter adjustments, `#set list(spacing: 0.4em)` works as a local override.

### Vertical fill

```typst
#vfill  // shorthand for v(1fr)
```

### Institutional names

```typst
#bips_en  // Leibniz Institute for Prevention Research and Epidemiology — BIPS
#bips_de  // Leibniz-Institut für Präventionsforschung und Epidemiologie — BIPS
```

## Animations

The theme re-exports Touying's animation functions:

```typst
#pause                              // reveal on click
#uncover(2)[On second click]        // show on specific subslide
#only(1)[First click only]          // only on specific subslide
#alternatives[Version A][Version B] // swap content
```

**Note**: Do not use `#pause` inside `#two-columns` / `#three-columns`. Use `#uncover()` or `#only()` instead.

## Global Customization

```typst
#show: bips-theme.with(
  aspect-ratio: "16-9",       // default
  base-size: 20pt,
  slide-title-size: 28pt,
  page-number-size: 16pt,
  code-block-scale: 0.9,
  code-inline-scale: 1,
)
```

## Examples

The `gallery/` directory contains 13 example presentations:

- `basic.typ` — starter template
- `complete.typ` — comprehensive feature showcase
- `animations.typ` — step-by-step reveals
- `columns.typ` — multi-column layouts and `#compact`
- `multi-author.typ` — multiple affiliations
- `callouts.typ` — callout box types
- `customization.typ` — font and styling overrides
- `bibliography.typ` — references
- `content-elements.typ` — tables, code, math
- `font-customization.typ` — typography options
- `qr-code.typ` — QR code on thanks slide
- `aspect-ratio.typ` — non-default aspect ratios
- `lecture-demo.typ` — longer example

## Development

```sh
just install    # install package locally
just uninstall  # remove local package
just all        # compile all gallery demos
just test       # run test suite
just clean      # remove generated PDFs
```

After editing theme files, run `just install` before compiling.

### Project Structure

```
bips-typst.typ   # package entrypoint
theme.typ        # theme implementation
bips-logo.png    # logo asset
typst.toml       # package metadata
template/        # Typst Universe templates
gallery/         # example presentations
tests/           # test suite
```

## Requirements

- Typst >= 0.12.0
- Dependencies: touying 0.6.1, codetastic 0.2.2 (resolved automatically)

## License

MIT
