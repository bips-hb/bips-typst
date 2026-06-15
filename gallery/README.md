# bypst Gallery

Ready-to-use examples showcasing different features of the bypst theme.

## Examples

| File | Description |
|------|-------------|
| `basic.typ` | Minimal starter template — copy this for your first presentation |
| `complete.typ` | Full feature showcase: text formatting, columns, callouts, images, tables, math, animations, customization |
| `bibliography.typ` | Citations and reference management with `.bib` files |
| `aspect-ratio.typ` | Using 4:3 format instead of the default 16:9 |
| `lecture-demo.typ` | Realistic 100-slide lecture for scale testing |

## Quick Start

```bash
# Compile a single example (from project root)
typst compile --root . gallery/basic.typ

# Watch for live preview
typst watch --root . gallery/basic.typ

# Compile all examples
just all
```

## Creating Your Own

1. Copy `basic.typ` as your starting point
2. Import the theme: `#import "@local/bypst:0.4.0": *`
3. Refer to `complete.typ` for feature examples
4. Compile and present!
