# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- **Upgraded Touying from 0.6.1 to 0.7.0** — gains named waypoints, `#item-by-item`, `#jump()`, improved handout mode, and many bugfixes
- Slide types that don't show page numbers (`section-slide`, `thanks-slide`, `empty-slide`) now freeze the slide counter, so content slide numbering is sequential without gaps
- Page background overrides use `config: config-page(...)` instead of `set page()` in `setting:` callbacks (required for Touying 0.7.0 compatibility — the old approach caused ghost blank pages)
- Aspect ratio uses `utils.page-args-from-aspect-ratio()` instead of `paper: "presentation-..."` (new Touying API supporting arbitrary aspect ratios)

### Fixed
- Content overflow in `gallery/complete.typ` that caused spurious blank pages and incorrect slide numbering

## [0.2.0] - 2026-04-02

### Added
- `#small[]` and `#tiny[]` text size utility functions that scale proportionally with `base-size`
- Heading show rules for levels 1, 2, and 3 — headings now render in BIPS blue at all levels
- Headings use em-based defaults (1.11em, 1em, 0.89em) so they scale with `base-size`
- All `bips-theme()` size parameters (`base-size`, `heading-*-size`, `slide-title-size`, etc.) now actually take effect
- New test slides covering `#small`, `#tiny`, `#compact`, `content-align`, `#vfill`, and heading levels

### Changed
- Font size overrides use a state bridge (`_bips-sizes`) to pass computed values from `bips-theme()` to slide functions
- `thanks-slide` now uses the `setting:` callback pattern consistently with other slide types
- `empty-slide` simplified from variadic `..content` to single `body` parameter passed through Touying normally
- `title-slide` no longer redundantly re-sets the page background (global already provides it)
- Renamed second "UTILITY FUNCTIONS" section header to "LAYOUT AND COLOR UTILITIES"
- Gallery and test files now use relative imports (`../bips-typst.typ`) instead of versioned `@local` imports, eliminating version bumps in those files

### Removed
- Dead `show-page-number` parameter from `section-slide` (was accepted but silently ignored)
- Unused typography variables: `font-weight-base`, `font-color-small`, `font-weight-small`, `font-color-tiny`, `font-weight-tiny`
- Stale comment about page number architecture limitations (no longer accurate)

### Fixed
- Size override parameters in `bips-theme()` were silently ignored — now functional
- Heading levels 1 and 2 had no styling (rendered as default black text) — now styled globally
- Gallery documentation referenced non-existent `bips-theme.typ` instead of `theme.typ`
- Fixed typo "numebrs" in `complete.typ`, stale "buggy" animation note, incorrect inline code scale, wrong QR URL
- Justfile contained dead guard for non-existent `bips-theme.typ` in gallery
- Gallery README had stale import instruction and was missing 6 demos from the tables

## [0.1.1] - 2026-04-01

### Changed
- Restructured project layout: moved theme files from `lib/` to project root
- Improved slide number logic to correctly handle presentations with or without title slide
- Expanded and consolidated test suite into single `test-suite.typ`
- Cleaned up redundant debug and test files

### Fixed
- Slide counter now properly adjusts numbering based on title slide presence

## [0.1.0] - 2025-01-06

### Added
- Initial release of BIPS Typst presentation template
- Core slide types: title-slide, bips-slide, section-slide, thanks-slide, empty-slide
- Multi-author support with institute affiliations
- Callout boxes (note, tip, warning, important)
- Two-column and three-column layout helpers
- QR code generation for contact slides
- Animation support with #pause
- Bibliography slide helper
- Customizable font sizes and styling
- BIPS branding (colors, logo, fonts)
- Gallery of 13 example presentations
- Test suite for validation

### Fixed
- Touying animation compatibility issues
- Double title rendering in refactored theme
- Header spacing and gradient line positioning
- PDF outline structure for proper navigation

[0.2.0]: https://github.com/bips-hb/bips-typst/releases/tag/v0.2.0
[0.1.1]: https://github.com/bips-hb/bips-typst/releases/tag/v0.1.1
[0.1.0]: https://github.com/bips-hb/bips-typst/releases/tag/v0.1.0