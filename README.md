# BIPS Typst Presentation Template

A modern presentation template for BIPS using [Typst](https://typst.app/) and the [Touying](https://touying-typ.github.io/) package. This template provides the BIPS institutional design with the speed and simplicity of Typst.

## Features

- **Fast compilation**: Milliseconds instead of seconds compared to LaTeX Beamer
- **BIPS branding**: Official colors, logo placement, and institutional styling
- **Multiple slide types**: Title slides, content slides, section slides, and thanks slides
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
#slide(
  title: [Slide Title],
  subtitle: [Optional Subtitle],
)[
  Your content goes here:
  
  - Bullet points work great
  - *Emphasis* appears in BIPS blue
  - Mathematical equations: $ sum_(i=1)^n x_i $
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
#slide(
  title: [Slide Title],
  subtitle: [Optional Subtitle],  // Can be omitted
)[
  Your slide content
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
