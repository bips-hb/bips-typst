# Bypst: BIPS Typst Presentation Template

Fast, modern presentation template for BIPS using [Typst](https://typst.app/) and [Touying](https://touying-typ.github.io/).

## Features

- **Lightning fast** — Compiles in milliseconds, not minutes
- **BIPS branded** — Colors, fonts, and logo placement based on [bips-beamer](http://github.com/bips-hb/bips-beamer)
- **Git-friendly** — Plain text format for version control
- **Full-featured** — Animations, multi-author support, callout boxes, and more

## Quick Start

```typst
#import "@local/bips-typst:0.1.0": *
#show: bips-theme

#title-slide(
  title: "Your Presentation Title",
  author: "Your Name",
  institute: bips_en, // or bips_de for the German title
  date: "June 6, 2025",
)

#bips-slide(title: "Introduction")[
  - Bullet points work as expected
  - *Bold* and _italic_ text in BIPS blue
  - Math notation: $ s^2 = 1/(n-1) sum_(i=1)^n (x_i - overline(x))^2 $
  
  #pause  // Click to reveal next content
  
  - Animations with `#pause`
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.email@leibniz-bips.de",
  qr-url: "https://link-to-slides.example.com" // Generates QR code for last slide
)
```

## Installation

### Option 1: Local Package (Recommended for Development)

1. Clone this repository
2. Install locally: `just install`
3. Use in any project:
   ```typst
   #import "@local/bips-typst:0.1.0": *
   ```

### Option 2: Direct Download

1. Download `bips-theme.typ` and `bips-logo.png`
2. Place in your project folder
3. Import: `#import "bips-theme.typ": *`

**Note**: All examples use the local package import (`@local/bips-typst:0.1.0`). For direct download, replace with the file-based import shown above.

### Option 3: Published Package (Future)

When published to Typst Universe:
```typst
#import "@preview/bips-typst:0.1.0": *
```

## Core Features

### Slide Types

- `#title-slide()` — Opening slide with author/institution
- `#bips-slide()` — Content slides with optional title/subtitle
- `#section-slide()` — Section dividers (with optional logo/page number control)
- `#thanks-slide()` — Closing slide with contact info
- `#empty-slide[]` — Blank slide (no logo/numbering)

### Useful Helpers

```typst
// Two-column layout
#two-columns[Left content][Right content]

// Callout boxes
#callout(type: "note")[Important information]
#callout(type: "tip")[Helpful hint]
#callout(type: "warning")[Caution needed]

// Color helpers
#blue[text] #orange[text] #green[text] #gray[text]
```

### Animation Functions

The theme re-exports Touying's animation utilities:

```typst
#pause  // Click to reveal next content

#uncover(2)[Content on 2nd click]  // Show on specific subslide
#only(1)[Content on 1st click only]  // Only on specific subslide

#alternatives[
  First version
][
  Second version
][
  Third version
]
```

### Multiple Authors

```typst
#title-slide(
  title: "Collaborative Research",
  authors: (
    "Jane Doe" + inst(1,2),
    "John Smith" + inst(1),
    "Alice Johnson" + inst(3),
  ),
  institutes: (
    "BIPS",
    "University of Bremen",
    "Other Institution",
  ),
)
```

### Section Slides

Section slides support optional logo and page number control:

```typst
// Default: shows logo, hides page number (department preference)
#section-slide("Results")

// Hide logo and page number (clean divider)
#section-slide("Methods", show-logo: false, show-page-number: false)

// Show both logo and page number (full branding)
#section-slide("Discussion", show-logo: true, show-page-number: true)

// Show page number but hide logo (minimal branding)
#section-slide("Conclusions", show-logo: false, show-page-number: true)
```

### Customization

Global settings:
```typst
#show: bips-theme.with(
  base-size: 20pt,
  slide-title-size: 28pt,
  code-block-scale: 0.9,
)
```

Per-slide overrides:
```typst
#bips-slide(
  title: "Dense Content",
  text-size: 16pt,
)[
  Smaller text for this slide only
]
```

## Examples

See `gallery/` for complete examples:
- `basic.typ` — Simple starter template
- `animations.typ` — Step-by-step reveals
- `multi-author.typ` — Collaboration examples
- `customization.typ` — Font and styling options

Copy `gallery/basic.typ` for a ready-to-use template or `gallery/complete.typ` for a comprehensive example.

## Development

### Contributing

1. Clone the repository: `git clone https://github.com/bips-hb/bips-typst.git`
2. Install locally: `just install`
3. Make changes to files in `lib/`
4. Test: `just all` or `just test`
5. Reinstall after changes: `just uninstall && just install`

### Commands

- `just install` - Install package locally for development
- `just uninstall` - Remove local package installation  
- `just all` - Compile all gallery demos
- `just test` - Run test suite with validation
- `just clean` - Remove generated PDFs

### Package Structure

```
lib/                    # Package source
├── bips-typst.typ     # Main entry point
├── theme.typ          # Theme implementation
├── bips-logo.png      # Required asset
└── references.bib     # Bibliography file

template/              # Example templates
gallery/              # Demo presentations  
tests/                # Test suite
debug/                # Development debugging files (git-ignored)
```

## Tips

- Use `typst watch file.typ` for live preview while editing
- Tables automatically get BIPS styling
- Images: `#image("figure.png", width: 50%)`
- Check [Touying docs](https://touying-typ.github.io/) for advanced features

## Requirements

- Typst (latest version recommended)
- No other dependencies — template includes everything needed

## License

CC BY-SA 4.0

## Contributing

Issues and PRs welcome.
