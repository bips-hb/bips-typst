# BIPS Theme Gallery

This directory contains various demonstration files showcasing different features and use cases of the BIPS Typst theme.

## Demo Files

| File | Description |
|------|-------------|
| `basic.typ` | Simple introduction to the BIPS theme |
| `complete.typ` | Comprehensive showcase of all theme features |
| `multi-author.typ` | Multiple authors with institutional affiliations |
| `qr-code.typ` | QR code integration for presentation sharing |
| `animations.typ` | Animation and incremental reveal features |
| `content-elements.typ` | Images, tables, footnotes, and references |
| `font-customization.typ` | Font size customization examples |
| `aspect-ratio.typ` | 4:3 aspect ratio presentation |

## Quick Start

### Using Just (recommended)

```bash
# Compile all demos
just all

# Compile individual demo
just basic
just qr-code

# Watch for changes and recompile
just watch basic-demo

# Clean generated PDFs
just clean

# List available commands
just list
```

### Using Typst directly

```bash
# Compile individual files
typst compile basic.typ
typst compile qr-code.typ

# Watch for changes
typst watch complete.typ
```

## File Structure

- **Symlinks**: `bips-theme.typ` and `bips-logo.png` are symlinked from the parent directory
- **Import compatibility**: All demos use `#import "bips-theme.typ": *` (same as examples in documentation)
- **Self-contained**: Each demo is a complete, focused example of specific features

## Creating New Demos

1. Create a new `.typ` file in this directory
2. Import the theme: `#import "bips-theme.typ": *`
3. Add your demo to the `justfile` for easy compilation
4. Update this README with a description

## Notes

- All demos use the same import path for consistency with documentation
- Symlinks ensure theme changes are automatically reflected in all demos
- Use `just` for convenient batch operations and development workflow