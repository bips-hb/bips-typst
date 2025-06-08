# BIPS Typst Presentation Template

Fast, modern presentation template for BIPS (Leibniz Institute for Prevention Research and Epidemiology) using Typst and Touying.

## Usage

```typst
#import "@preview/bips-typst:0.1.0": *

#show: bips-theme

#title-slide(
  title: "Your Presentation Title",
  author: "Your Name",
  institute: bips_en,
  date: datetime.today().display(),
)

#bips-slide(title: "Introduction")[
  - Bullet points
  - Math: $x^2 + y^2 = z^2$
  - *Bold* and _italic_ text
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.email@leibniz-bips.de",
)
```

## Features

- **Lightning fast** compilation
- **BIPS branded** with official colors and logo
- **Full-featured** with animations, multi-author support, callout boxes
- **Git-friendly** plain text format

## Slide Types

- `title-slide()` - Opening slide
- `bips-slide()` - Content slides  
- `section-slide()` - Section dividers
- `thanks-slide()` - Closing slide
- `empty-slide[]` - Blank slide

## Templates

Use the provided templates to get started:
- `basic` - Simple starter template
- `complete` - Full feature showcase

## Documentation

See the [GitHub repository](https://github.com/bips-hb/bips-typst) for complete documentation and examples.

## License

CC BY-SA 4.0