# BIPS Theme Gallery

Ready-to-use examples showcasing different features of the BIPS Typst theme. Perfect for getting started or learning specific techniques!

## Essential Examples

| File | What It Shows | When To Use |
|------|--------------|-------------|
| `basic.typ` | Simple starter template | Your first presentation |
| `multi-author.typ` | Multiple authors with affiliations | Academic collaborations |
| `animations.typ` | Step-by-step reveals with `#pause` | Interactive presentations |
| `callouts.typ` | Highlight boxes for notes/warnings | Academic content |
| `columns.typ` | Side-by-side layouts | Comparisons, before/after |

## Advanced Examples

| File | What It Shows | When To Use |
|------|--------------|-------------|
| `complete.typ` | All features in one presentation | Learning everything available |
| `customization.typ` | Font sizes and styling options | Non-standard formatting needs |
| `qr-code.typ` | QR codes for presentation sharing | Conference presentations |

## Quick Start

### Compile Examples
```bash
# Individual files
typst compile basic.typ
typst compile multi-author.typ

# Watch for changes while editing
typst watch basic.typ
```

### Using Just (if available)
```bash
# Compile all examples
just all

# Compile specific example
just basic

# Clean generated PDFs
just clean
```

## Getting Started

1. **Start with `basic.typ`** - Copy and modify for your first presentation
2. **Need multiple authors?** Check `multi-author.typ`
3. **Want animations?** See `animations.typ` 
4. **Adding callouts or columns?** Look at `callouts.typ` and `columns.typ`
5. **Custom fonts/colors?** Use `customization.typ` as reference

## Creating Your Own

1. Copy `basic.typ` as your starting point
2. Import the theme: `#import "bips-theme.typ": *`
3. Customize as needed using examples from other files
4. Compile and present!

## Tips

- All examples use the same import syntax as the main documentation
- Mix and match features from different examples
- The `complete.typ` file shows everything together
- For questions, check the main README or Typst/Touying documentation