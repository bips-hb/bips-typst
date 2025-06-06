# BIPS Typst Presentation Template

A modern presentation template for BIPS using [Typst](https://typst.app/) and the [Touying](https://touying-typ.github.io/) package. This template provides the BIPS institutional design with the speed and simplicity of Typst.

## Features

- **Fast compilation**: Milliseconds instead of seconds compared to LaTeX Beamer
- **BIPS branding**: Colors, logo placement, and institutional styling
- **Multiple slide types**: Title slides, content slides, section slides, bibliography slides, and thanks slides
- **Grid-based layout**: Automatic title/content separation with gradient line positioning
- **Elegant table styling**: Minimal borders with subtle header highlighting
- **Configurable typography**: All font sizes, colors, and weights easily customizable
- **Color utilities**: Convenient functions for BIPS colors (`#blue[]`, `#orange[]`, `#green[]`, `#gray[]`)
- **Animations**: Incremental reveals with `#pause` and `#meanwhile` (see [Touying docs](https://touying-typ.github.io/docs/dynamic/simple))
- **QR code generation**: Automatic QR codes on thanks slides for easy presentation sharing
- **Multi-author support**: LaTeX Beamer-style author-affiliation mapping with superscript numbers
- **Hierarchical customization**: Theme defaults → global overrides → individual slide overrides
- **Callout blocks**: Quarto-style callouts (note, tip, warning, important) with icons and colors
- **Column helpers**: Simplified `#two-columns[][]` and `#three-columns[][][]` for multi-column layouts
- **Version control friendly**: Text-based format that works well with Git

## Requirements

- [Typst](https://typst.app/) (latest version recommended)
- The Touying package (automatically downloaded: `@preview/touying:0.6.1`)

## Quick Start

1. Import the BIPS theme and apply it to your document by downloading the theme file and logo:

```typst
#import "bips-theme.typ": *

#show: bips-theme

// Or with global font size customization:
// #show: bips-theme.with(
//   base-size: 16pt,
//   slide-title-size: 22pt,
// )

// Create title slide
#title-slide(
  title: "Your Presentation Title",
  subtitle: "Your Subtitle",
  author: "Your Name",
  institute: "Leibniz Institute for Prevention Research & Epidemiology -- BIPS",
  date: datetime.today().display(),
  occasion: "Conference or Meeting Name",
)

// Regular content slides
#bips-slide(
  title: "Slide Title",
  subtitle: "Optional Subtitle"  // Can be omitted
)[
  Your content goes here:
  
  - Bullet points work great
  - *Bold text* appears in BIPS blue  
  - _Emphasized text_ appears in BIPS blue
  - Use color utilities: #blue[blue], #orange[orange], #green[green]
  - Mathematical equations: $ sum_(i=1)^n x_i $
  
  #pause
  
  - Incremental reveals with #pause
]

// Using convenience helpers
#bips-slide(title: "Research Results")[
  #two-columns[
    === Methods
    - Sample size: n=500
    - Duration: 12 months
    
    #callout(type: "warning")[
      Dropout rate: 15%
    ]
  ][
    === Key Findings
    - Primary outcome: p<0.001
    - Effect size: d=0.85
    
    #callout(type: "important")[
      Clinically significant
    ]
  ]
]

// Section slides
#section-slide[New Section]

// Thanks slide
#thanks-slide(
  thanks-text: "Thank you for your attention",
  contact-author: "Your Name",
  email: "your.email@leibniz-bips.de",
)
```

2. Compile your presentation:

```bash
typst compile your-presentation.typ
```

Or use the free online [typst editor](https://typst.app/) (imagine Overleaf, but fast).

## Exploring Examples

The `gallery/` directory contains focused examples showcasing different features:

```bash
# Compile all gallery demos  
just all

# Try individual examples
typst compile gallery/basic.typ
typst compile gallery/qr-code.typ  
typst compile gallery/animations.typ

# Development workflow
typst watch gallery/basic.typ  # Auto-recompile on changes
just clean                          # Remove generated PDFs
```

Each demo is self-contained and demonstrates specific theme capabilities.

## Available Slide Types

### Content Slides

```typst
#bips-slide(
  title: "Slide Title",
  subtitle: "Optional Subtitle"  // Can be omitted
)[
  Your slide content
  
  #pause  // For incremental reveals
  
  More content appears on click
]
```

**Note**: The `bips-slide` function uses a grid layout with 15% reserved for title/subtitle area and 85% for content. The gradient line is automatically positioned between these sections.

### Title Slide

#### Single Author
```typst
#title-slide(
  title: "Presentation Title",
  subtitle: "Subtitle",
  author: "Author Name",
  institute: "Institution",
  date: "Date",
  occasion: "Event/Conference",  // Optional
)
```

#### Multiple Authors with Affiliations
```typst
#title-slide(
  title: "Presentation Title", 
  subtitle: "Subtitle",
  authors: (
    "Jane Doe" + inst(1) + inst(2),  // Author with multiple affiliations
    "John Smith" + inst(1),          // Author with single affiliation
    "Alice Johnson" + inst(3)        // Author with different affiliation
  ),
  institutes: (
    "First Institution", 
    "Second Institution",
    "Third Institution"
  ),
  date: "Date",
  occasion: "Event/Conference",  // Optional
  institute-size: 14pt,  // Optional: smaller font for many institutions
)
```

**Note**: Use `inst(number)` to add superscript affiliation numbers to author names, similar to LaTeX Beamer's `\inst{}` command. Authors can have multiple affiliations in two ways:
- Multiple calls: `"Jane Doe" + inst(1) + inst(2)`  
- Single call with multiple numbers: `"Jane Doe" + inst(1,2)`

#### Font Size Customization
You can override the default font sizes for title slide elements:
```typst
#title-slide(
  // ... content parameters
  title-size: 28pt,      // Override title font size
  subtitle-size: 16pt,   // Override subtitle font size
  author-size: 18pt,     // Override author font size
  institute-size: 14pt,  // Override institute font size
  date-size: 14pt,       // Override date/occasion font size
)
```

### Section Slides

```typst
#section-slide[Section Name]
```

### Bibliography Slide

Dedicated slide for displaying references with proper formatting:

```typst
// Basic usage (uses references.bib with APA style)
#bibliography-slide()

// Custom options
#bibliography-slide(
  file: "my-references.bib",  // Custom .bib file
  style: "ieee",              // Citation style (apa, ieee, chicago-author-date, etc.)
  title: "Literature",        // Custom title (default: "References")
  full: false,                // Show only cited references (default: true)
)
```

The bibliography is automatically centered with proper vertical spacing. Combine with citations in your slides using `@key` syntax.

### Thanks Slide

```typst
#thanks-slide(
  thanks-text: "Custom thank you message",  // Optional
  contact-author: "Presenter Name",
  email: "email@leibniz-bips.de",
  qr-url: "https://your-slides-url.com",   // Optional: generates QR code
)
```

**QR Code Feature**: When `qr-url` is provided, a QR code is automatically generated and replaces the website URL in the center of the thanks slide. The bottom layout (contact info + BIPS logo) remains unchanged. Perfect for sharing presentation links with the audience!

### Empty Slides (no logo/page number)

```typst
#empty-slide[
  Content for completely clean slide
]
```

## Color Utilities

The theme provides convenient color functions using the official BIPS colors:

```typst
// Apply BIPS colors to text
#blue[This text is blue]
#orange[This text is orange]  
#green[This text is green]
#gray[This text is gray]

// Combine with other formatting
#blue[*Bold blue text*]
#orange[_Italic orange text_]
```

## Customization

The BIPS theme provides a hierarchical font customization system:

### 1. Global Font Size Overrides

Set presentation-wide font size overrides using `bips-theme.with()`:

```typst
#show: bips-theme.with(
  base-size: 16pt,           // Override base text size (default: 18pt)
  slide-title-size: 22pt,    // Override slide titles (default: 24pt)
  slide-subtitle-size: 16pt, // Override slide subtitles (default: 18pt)
  heading-1-size: 18pt,      // Override heading level 1 (default: 20pt)
  heading-2-size: 16pt,      // Override heading level 2 (default: 18pt)
  heading-3-size: 14pt,      // Override heading level 3 (default: 16pt)
  small-size: 12pt,          // Override small text (default: 14pt)
  tiny-size: 11pt,           // Override tiny text (default: 13pt)
)
```

### 2. Individual Slide Font Size Overrides

Override font sizes for specific slides:

```typst
#bips-slide(
  title: "Custom Sized Slide",
  title-size: 26pt,    // Override just this slide's title
  subtitle-size: 20pt, // Override just this slide's subtitle
  text-size: 20pt,     // Override just this slide's content text
)[
  Content with custom sizing
]
```

### 3. Theme Variable Customization

For advanced customization, edit variables at the top of `bips-theme.typ`:

```typst
// Font sizes
#let font-size-base = 18pt
#let font-size-slide-title = 24pt
#let font-size-slide-subtitle = 18pt
// ... many more

// Colors  
#let font-color-base = bips-text-gray
#let font-color-slide-title = bips-blue
// ... many more

// Weights
#let font-weight-slide-title = 600
#let font-weight-base = "regular"
// ... many more

// Spacing
#let list-spacing = 0.8em
#let enum-spacing = 0.8em
```

### Customization Hierarchy

The font size system follows this hierarchy (later overrides earlier):

1. **Theme defaults** (defined in `bips-theme.typ`)
2. **Global overrides** (via `bips-theme.with()`)
3. **Individual slide overrides** (via slide function parameters)

### Text Formatting

- `*text*` - Bold text (appears in blue by default, customizable)
- `_text_` - Emphasized text (appears in blue italic by default, customizable)
- `#link("url")[text]` - Links (appear in blue with underline to distinguish from emphasis)
- All preserve their semantic meaning while adding BIPS styling

## Convenience Helpers

### Callout Blocks

The theme includes Quarto-style callout blocks for highlighting important information:

```typst
// Basic usage
#callout(type: "note")[
  Additional information or research notes
]

// Available types with their default styling:
#callout(type: "note")[...]     // 📝 Blue border/background
#callout(type: "tip")[...]      // 💡 Green border/background  
#callout(type: "warning")[...]  // ⚠ Orange border/background
#callout(type: "important")[...] // ❗ Red border/background

// Custom title
#callout(type: "warning", title: "Data Limitation")[
  Sample size limited to n=50
]

// Custom icon
#callout(type: "tip", icon: "🔬")[
  Laboratory protocols available
]
```

### Multi-Column Layouts

Simple helpers for common column layouts:

```typst
// Two equal columns
#two-columns[
  Left column content
][
  Right column content
]

// Custom column widths
#two-columns(
  columns: (2fr, 1fr),  // 2:1 ratio
  gutter: 2em,          // spacing between
)[
  Wide left column
][
  Narrow right column
]

// Three columns
#three-columns[
  Left
][
  Center  
][
  Right
]

// Custom three columns
#three-columns(
  columns: (1fr, 2fr, 1fr),  // narrow-wide-narrow
)[Left][Center][Right]
```

These helpers are cleaner than using raw `grid()` and provide sensible defaults while remaining fully customizable.

## File Structure

- `bips-theme.typ` - Main theme file
- `bips-logo.png` - BIPS institutional logo  
- `gallery/` - Demo presentations showcasing different features
  - `basic.typ` - Simple introduction example
  - `complete.typ` - Comprehensive feature showcase
  - `multi-author.typ` - Multiple authors with affiliations
  - `qr-code.typ` - QR code integration example
  - `animations.typ` - Animation and reveal features
  - `content-elements.typ` - Images, tables, footnotes, and references
  - `font-customization.typ` - Font size customization
  - `customization.typ` - Theme customization options
  - `callouts.typ` - Callout blocks demonstration
  - `columns.typ` - Multi-column layout helpers
  - `bibliography.typ` - Bibliography slide examples
  - `aspect-ratio.typ` - 4:3 aspect ratio presentation
  - `justfile` - Build automation for all demos
- `tests/` - Test suite for theme functionality
  - `test-suite.typ` - Comprehensive test cases
- `justfile` - Project automation (compile all, test, clean)

## Links

- [Typst](https://typst.app/) - The typesetting system
- [Touying](https://touying-typ.github.io/) - Presentation package for Typst

## License

This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License.

## Contact

For questions or issues related to this Typst template, please open an issue in the repository.
