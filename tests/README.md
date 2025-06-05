# Debug Directory

This directory contains minimal test files for debugging specific issues with the BIPS Typst theme and Touying integration.

## Test Files

| File | Purpose |
|------|---------|
| `footnote-test.typ` | Debug footnote layout issues with BIPS theme |
| `footnote-touying-test.typ` | Test footnotes with pure Touying (no custom theme) |

## Known Issues

### Footnotes in Presentations
- **Problem**: Footnotes can cause content to appear on wrong slides in Touying
- **Symptoms**: Footnote content appears on slide N, actual slide content on slide N+1
- **Workaround**: Use inline parenthetical notes instead of traditional footnotes
- **Status**: Known Touying limitation, not specific to BIPS theme

## Usage

```bash
# Compile individual debug files
typst compile testfootnote-test.typ
typst compile testfootnote-touying-test.typ

# Watch for changes during debugging
typst watch testfootnote-test.typ
```

## Notes

- Debug files use symlinked theme files from parent directory
- Keep this directory separate from gallery demos
- Focus on minimal reproducible examples for specific issues