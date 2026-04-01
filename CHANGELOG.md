# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[0.1.0]: https://github.com/bips-hb/bips-typst/releases/tag/v0.1.0