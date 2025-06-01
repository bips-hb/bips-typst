# BIPS Typst Presentation Template

A modern presentation template for BIPS using [Typst](https://typst.app/) and the [Touying](https://touying-typ.github.io/) package. This template provides the BIPS institutional design with the speed and simplicity of Typst.

## Features

- **Fast compilation**: Milliseconds instead of seconds compared to LaTeX Beamer
- **BIPS branding**: Official colors, logo placement, and institutional styling
- **Multiple slide types**: Title slides, content slides, section slides, and thanks slides
- **Configurable typography**: All font sizes, colors, and weights easily customizable
- **Color utilities**: Convenient functions for BIPS colors (`#blue[]`, `#orange[]`, `#green[]`, `#gray[]`)
- **Smart page numbering**: Title slide shows logo only, content slides start at page 1
- **Professional animations**: Incremental reveals with `#pause` and `#meanwhile`
- **Version control friendly**: Text-based format that works well with Git

## Requirements

- [Typst](https://typst.app/) (latest version recommended)
- The Touying package (automatically downloaded: `@preview/touying:0.6.1`)

## Quick Start

1. Import the BIPS theme and apply it to your document:

```typst
#import "bips-theme.typ": *

#show: bips-theme

// Create title slide
#title-slide(
  title: [Your Presentation Title],
  subtitle: [Your Subtitle],
  author: [Your Name],
  institute: [Leibniz Institute for Prevention Research & Epidemiology -- BIPS],
  date: datetime.today().display(),
  occasion: [Conference or Meeting Name],
)

// Regular content slides
#slide[
  = Slide Title
  == Optional Subtitle
  
  Your content goes here:
  
  - Bullet points work great
  - *Bold text* appears in BIPS blue  
  - _Emphasized text_ appears in BIPS blue
  - Use color utilities: #blue[blue], #orange[orange], #green[green]
  - Mathematical equations: $ sum_(i=1)^n x_i $
  
  #pause
  
  - Incremental reveals with #pause
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

## Available Slide Types

### Content Slides

```typst
#slide[
  = Slide Title
  == Optional Subtitle  // Can be omitted
  
  Your slide content
  
  #pause  // For incremental reveals
  
  More content appears on click
]
```

### Title Slide

```typst
#title-slide(
  title: [Presentation Title],
  subtitle: [Subtitle],
  author: [Author Names],
  institute: [Institution],
  date: [Date],
  occasion: [Event/Conference],  // Optional
)
```

### Section Slides

```typst
#section-slide[Section Name]
```

### Thanks Slide

```typst
#thanks-slide(
  thanks-text: "Custom thank you message",  // Optional
  contact-author: "Presenter Name",
  email: "email@leibniz-bips.de",
)
```

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

All typography settings are configurable through variables at the top of `bips-theme.typ`:

### Typography Variables

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

### Text Formatting

- `*text*` - Bold text (appears in blue by default, customizable)
- `_text_` - Emphasized text (appears in blue by default, customizable)  
- Both preserve their semantic meaning while adding BIPS styling

### Layout Features

- **Smart page numbering**: Title slide shows logo only, content slides start at 1
- **Automatic gradient lines**: Appear after titles/subtitles on all content slides
- **Flexible spacing**: Use `#v(1fr)` for flexible vertical spacing (like LaTeX's `\vfill`)
- **Professional animations**: Use `#pause` for incremental reveals

## File Structure

- `bips-theme.typ` - Main theme file
- `bips-logo.png` - BIPS institutional logo
- `demo-bips.typ` - Example presentation
- `demo-bips.pdf` - Compiled example

## Links

- [Typst](https://typst.app/) - The typesetting system
- [Touying](https://touying-typ.github.io/) - Presentation package for Typst

## License

This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License.

## Contact

For questions or issues related to this Typst template, please open an issue in the repository.
