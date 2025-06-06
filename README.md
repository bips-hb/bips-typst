# BIPS Typst Presentation Template

A modern, fast presentation template for BIPS using [Typst](https://typst.app/). Think PowerPoint meets LaTeX, but actually fast and simple.

## Why Use This?

- **Lightning fast**: Compiles in milliseconds, not minutes like LaTeX Beamer
- **BIPS branded**: Official colors, fonts, and logo placement
- **Simple syntax**: Much easier than LaTeX, cleaner than PowerPoint
- **Version control friendly**: Plain text format that works great with Git
- **Animations included**: Incremental reveals with `#pause`

## Getting Started

1. **Download** the theme files (`bips-theme.typ` and `bips-logo.png`)
2. **Create** your presentation file:

```typst
#import "bips-theme.typ": *
#show: bips-theme

#title-slide(
  title: "Your Presentation Title",
  author: "Your Name",
  institute: "BIPS",
  date: "December 2024",
)

#bips-slide(title: "Your First Slide")[
  - Easy bullet points
  - *Bold text* automatically appears in BIPS blue
  - Mathematical equations: $ sum_(i=1)^n x_i $
  
  #pause
  
  - Use `#pause` for step-by-step reveals
]

#bips-slide(title: "Two Column Layout")[
  #two-columns[
    === Left Side
    - Your content here
    - Works great for comparisons
  ][
    === Right Side
    - More content here
    - Images, tables, whatever you need
  ]
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.email@leibniz-bips.de",
)
```

3. **Compile** your presentation:
```bash
typst compile my-presentation.typ
```

Or use the free [Typst web editor](https://typst.app/) (like Overleaf, but fast).

## Essential Features

### Slide Types

```typst
// Regular content slide
#bips-slide(title: "Slide Title")[
  Your content here
]

// Title slide
#title-slide(
  title: "Presentation Title",
  author: "Your Name",
  institute: "BIPS",
  date: "Date",
)

// Section divider
#section-slide[New Section]

// Thanks slide with contact info
#thanks-slide(
  contact-author: "Your Name",
  email: "your.email@leibniz-bips.de",
)
```

### Useful Helpers

```typst
// Highlight boxes
#callout(type: "note")[Important research finding]
#callout(type: "warning")[Study limitations]
#callout(type: "tip")[Future research directions]

// Column layouts
#two-columns[Left content][Right content]
#three-columns[Left][Center][Right]

// BIPS colors
#blue[Blue text] #orange[Orange text] #green[Green text]
```

### Multiple Authors

```typst
#title-slide(
  title: "Multi-Author Study",
  authors: (
    "Jane Doe" + inst(1,2),
    "John Smith" + inst(1),
    "Alice Johnson" + inst(3)
  ),
  institutes: (
    "BIPS",
    "University of Bremen", 
    "Another Institution"
  ),
  date: "December 2024",
)
```

### Animations

```typst
#bips-slide(title: "Step by Step")[
  First, we see this content.
  
  #pause
  
  Then this appears on click.
  
  #pause
  
  Finally, this shows up.
]
```

## Examples

Check out the `gallery/` folder for ready-to-use examples:

- `gallery/basic.typ` - Simple starter template
- `gallery/complete.typ` - All features showcased
- `gallery/multi-author.typ` - Multiple authors example
- `gallery/animations.typ` - Animation examples

Compile any example:
```bash
typst compile gallery/basic.typ
```

## Customization

### Font Sizes

Want different font sizes? Easy:

```typst
#show: bips-theme.with(
  base-size: 20pt,        // Bigger base text
  slide-title-size: 28pt, // Bigger slide titles
)
```

### Individual Slides

```typst
#bips-slide(
  title: "Small Text Slide",
  text-size: 14pt,     // Just this slide
)[
  Lots of detailed content that needs smaller text
]
```

## Tips

- Use `*bold*` and `_italic_` text - they automatically use BIPS blue
- Mathematical equations work just like LaTeX: `$ x = y + z $`
- Images: `#image("path/to/image.png", width: 50%)`
- Tables get automatic BIPS styling
- Don't forget `#pause` for animations!

## Need Help?

- [Typst Documentation](https://typst.app/docs/) - Learn the basics
- [Touying Guide](https://touying-typ.github.io/) - Advanced presentation features
- Check the `gallery/` examples for inspiration

Made with ❤️ for BIPS researchers who want beautiful presentations without the LaTeX headaches.