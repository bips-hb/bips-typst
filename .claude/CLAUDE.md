# CLAUDE.md

Guidance for Claude Code when working on this repository.

## Project Overview

BIPS Typst presentation template for 16:9 institutional presentations using Typst and Touying. Targets academic users familiar with LaTeX Beamer who want a modern alternative with BIPS branding (colors, fonts, logo placement).

## Development Commands

### Package Management
- `just install` - Install package locally for development (run after cloning or modifying the theme)
- `just uninstall` - Remove local package installation

### Build and Test
- `just all` - Compile all 5 gallery demos
- `just test` - Run tytanic test suite (13 compile-only feature tests + 1 template test)
- `just test-verbose` - Run tests with verbose output
- `just clean` - Remove all generated PDFs
- `typst compile file.typ` - Compile single file
- `typst watch file.typ` - Live preview during editing
- `tt run <name>` - Run a single tytanic test (e.g. `tt run animations`)
- `tt new --compile-only <name>` - Add a new compile-only test

### Code Formatting
- `just format` - Format all `.typ` files with typstyle
- `just format-check` - Check formatting without modifying files
- `typstyle -i file.typ` - Format a single file in-place

### Validation Tools
- `ferrules` - Convert PDF to JSON for structure analysis
- `diff-pdf` or `diff-pdf-visually` - Visual comparison of PDF outputs
- `pdfinfo file.pdf` - Check page counts

## Architecture

### Core Files

The theme is split into focused modules. `theme.typ` is the orchestrator: it imports and re-exports the submodules and defines `bips-theme()`.

- **theme.typ** - Entrypoint/orchestrator: `#import`s the submodules (re-exporting them), defines the `bips-theme()` show-rule function. Submodules use named Touying imports (not `#import touying: *`), so import order is not significant.
- **config.typ** - Branding/tuning constants (colors, fonts, sizes, spacing). No dependencies.
- **helpers.typ** - Internal plumbing: page number, gradient divider, `_title-area` (with shrink-to-fit), `bips-background`, `_aligned`, `_slide-overrides`, and the `small`/`tiny`/`large`/`huge` text helpers (em-relative, scale with `base-size`).
- **slides.typ** - All slide types: `base-slide` (flexible base) plus presets (`bips-slide`, `empty-slide`) and special slides (`title-slide`, `section-slide`, `thanks-slide`, `bibliography-slide`).
- **extras.typ** - Public layout/color utilities (color helpers, `inst`, columns, `callout`, `compact`, `vfill`/`hfill`).
- **bypst.typ** - Package entrypoint, re-exports theme.typ and additional Touying utilities
- **bips-logo.png** - Institutional logo asset
- **typst.toml** - Package metadata

Dependency DAG: `config` → `helpers` → `slides`; `extras` → `config`; `theme` imports all and adds `bips-theme()`. No cycles. Submodules use named Touying imports, so they no longer re-export Touying's own `title-slide`/`empty-slide` and import order in `theme.typ` is not significant.

### Dependencies
- touying:0.7.3 (presentation framework)
- codetastic:0.2.2 (QR code generation for thanks slides)

### Slide Functions
- `base-slide(title, subtitle, show-logo, page-number, show-line, count)` - Flexible base content slide with every BIPS chrome component independently toggleable; `bips-slide` and `empty-slide` are presets over it
- `bips-slide(title, subtitle)` - Content slide preset: logo on, page-number on, line on, counted. Public signature unchanged from pre-refactor
- `empty-slide[]` - Minimal slide preset: logo off, page-number off, line off, uncounted by default (set `count: true` or `show-logo: true` etc. to selectively add chrome)
- `title-slide()` - Opening slide with multi-author/institute support
- `section-slide()` - Section dividers with configurable logo
- `thanks-slide()` - Contact slide with optional QR code
- `bibliography-slide()` - Reference list

### Layout and Utility Functions
- `two-columns[][]`, `three-columns[][][]` - Multi-column helpers (grid-based)
- `callout(type)` - Styled blocks: note, tip, warning, important
- `blue[]`, `orange[]`, `green[]`, `gray[]` - Color helpers
- `small[]`, `tiny[]` - Text size utilities (scale with `base-size`)
- `inst()` - Author affiliation superscripts
- `vfill` - Vertical fill shorthand
- `compact[]` - Tighter list/enum spacing for dense layouts
- `bips_en`, `bips_de` - Institutional name shortcuts

### Slide Counter and Page Number System

Page numbers use Touying's logical slide counter (`utils.slide-counter`), not `counter(page)`.

**Why page numbers are in the slide content (not background/header/footer):**

Touying renders each `#pause` state as a separate PDF page (subslide). The slide counter is stepped once per logical slide in `page-preamble`, which Touying prepends to the page header. This creates a timing constraint:

- **`background`**: Rendered BEFORE the header, so the counter hasn't been stepped yet on subslide 1. This causes an off-by-one error where the page number increments between pause states.
- **`header`**: The counter is stepped here (in `page-preamble`), so the value is correct. However, `place()` inside the header doesn't work because the header area has zero natural height (since `place()` doesn't contribute to flow), and Touying's `zero-margin-header` wrapping via `block(height: 100%)` collapses it.
- **`footer`**: Counter is correct but the footer is at the bottom of the page, requiring complex coordinate math to position the number elsewhere.
- **slide content** (current approach): Rendered AFTER the header (where the counter is stepped), so the counter value is always correct. Using `place()` in the content positions the number absolutely without affecting content flow.

The page number `place()` is at the start of `base-slide`'s content block (before any `#pause`), so it appears on all subslides. `bips-slide` (the full-chrome preset) always shows page numbers. `empty-slide` defaults to no page number, but the `page-number` and `count` toggles on `base-slide`/`empty-slide` allow selective display. Title, section, and thanks slides omit them naturally.

**Counter freeze:** Slide types that don't count toward the page sequence use `config-common(freeze-slide-counter: true)`. By default: `title-slide`, `section-slide`, `thanks-slide` always freeze. `empty-slide` (and any `base-slide` with `count: false`) also freezes. Setting `count: true` on `empty-slide`/`base-slide` removes the freeze so the slide consumes a counter value. This ensures content slide numbering is sequential without gaps.

## File Organization

- `gallery/` - 5 example presentations: `basic.typ` (starter template), `complete.typ` (full showcase), `bibliography.typ` (citations), `lecture-demo.typ` (realistic scale test), `aspect-ratio.typ` (4:3 format)
- `tests/` - Tytanic test suite with compile-only tests for each theme feature
  - `tests/<name>/test.typ` - Individual test files (one per feature)
  - `tests/test-suite.typ` - Legacy monolithic test file (kept for reference)
- `template/` - Typst Universe package templates (`basic.typ`, `complete.typ`)
- `debug/` - Ad-hoc debugging files (gitignored; create as needed, clean up when done)

### Size Override Architecture

The `bips-theme()` function accepts size override parameters (`base-size`, `slide-title-size`, etc.). These are published into Touying's `config-store(...)` and read by slide wrappers via `self.store` — no hand-rolled `state()` bridges are used. The three state bridges from earlier releases (`_bips-sizes`, `_bips-info`, `_bips-logo`) were removed in 0.4.0.

The `small`/`tiny`/`large`/`huge` text helpers are em-relative (not fixed pt), so they scale automatically when `base-size` changes. The `small-size`, `tiny-size`, `large-size`, and `huge-size` parameters on `bips-theme()` were removed in 0.4.0; use `base-size` to scale all helpers together, or wrap content in an explicit `text(size: ...)`.

**Heading sizes** use em-based defaults in global `show heading` rules inside `bips-theme()`, scaling proportionally with `base-size`. Explicit pt overrides via `heading-*-size` take precedence.

### Slide Structure Patterns

All slide types should follow consistent patterns:

- **`config:` parameter**: Used for page-level overrides and counter freeze. Use `utils.merge-dicts()` to combine multiple configs (e.g., `utils.merge-dicts(config-common(freeze-slide-counter: true), config-page(background: none))`).
- **`setting:` callback**: Used by `title-slide` for `set align(center)` and content layout. The callback receives `body` and must return it. **Do NOT use `set page()` inside `setting:` — it causes ghost blank pages in Touying 0.7.0. Use `config: config-page(...)` instead.**
- **Direct content**: `base-slide` passes body directly to Touying's `slide[]` so `#pause` markers are visible to Touying's content splitter (`bips-slide` delegates to it).

## Animation Compatibility

These rules were learned from debugging Touying interaction issues:

1. **Do not use `context` or `query()` in `show` rules.** Complex show rules that query page state interfere with Touying's animation system, creating spurious blank pages between `#pause` states. Use simple `set` rules instead.
2. **Do not wrap user slide body content in a `context` block.** Touying splits content at `#pause` markers during its processing phase, but `context` is opaque — Touying cannot see `#pause` inside it, causing animation splitting to silently fail (all content appears on one page). Note: bypst's own chrome (title area, page number, logo) reads `self.store` and does not use `context` around the slide body, so this constraint applies only to user-authored content inside `bips-slide[]` / `empty-slide[]` etc.
3. **`#pause` works inside `two-columns`/`three-columns`** on Touying 0.7.3 (verified: one pause → 2 subslides, no extra blank pages; reveals follow document flow order across the cells). This was broken in 0.6.1 (the source of the old "don't pause in columns" rule) and is fixed. `#uncover()`/`#only()` remain useful when you want index-driven reveals without consuming a pause step.
4. **Verify animations by page count.** Expected pages = base slides + number of `#pause` commands. If the count is roughly double, animation interference is occurring. If the count equals the number of base slides (no extra pages for pauses), `context` is likely swallowing pause markers.

## Touying Framework Reference

- Custom theme documentation: https://touying-typ.github.io/docs/tutorials/build-your-own-theme
- Look up Typst and Touying documentation online when needed; don't assume API details from memory.

### Touying Rendering Pipeline (v0.7.0)

Understanding the render order is critical for correct counter behavior:

1. **`touying-slide`** processes content, splits by `#pause` markers into subslides
2. For each subslide `i` (1 to `repeat`):
   a. `_get-header-footer(self)` extracts header/footer from `self.page`, calls them via `utils.call-or-display(self, fn)`, applies `zero-margin-header/footer` wrapping
   b. `page-preamble(self)` is prepended to header — this is where `utils.slide-counter.step()` happens (only on subslide 1)
   c. `set page(header: preamble + header, footer: footer)` is applied
   d. Content is rendered via `setting-fn(subslide-preamble + content)`

**Key files in touying source** (installed at `~/Library/Caches/typst/packages/preview/touying/0.7.0/`):
- `src/core.typ`: Subslide loop, counter stepping, `_get-header-footer`, `_get-negative-pad`
- `src/configs.typ`: `config-page`, `config-common` definitions
- `themes/metropolis.typ`: Reference for how built-in themes handle header/footer/counter

### Touying 0.7.0 Migration Notes

**Breaking changes from 0.6.1:**
- `set page()` inside `setting:` callbacks now causes ghost blank pages after the slide. Use `config: config-page(...)` instead.
- `config:` parameter was silently ignored in 0.6.1 — now works correctly. This means `freeze-slide-counter` and page overrides via `config:` are actually applied.
- Aspect ratio: use `..utils.page-args-from-aspect-ratio(aspect-ratio)` instead of `paper: "presentation-" + aspect-ratio` in `config-page()`.
- Multiple configs must be merged with `utils.merge-dicts()` (e.g., combining `config-common(...)` and `config-page(...)`).

**New features available:**
- `#jump(n)` — unified animation control; `#pause`/`#meanwhile` are now sugar on top
- `#item-by-item` — list/enum/terms item-level animation
- `#touying-raw` — animated code block reveals
- Named waypoints (`#waypoint(<label>)`) for referencing subslide positions
- `#handout-only` and `handout-subslides` for handout customization
- Arbitrary aspect ratios (not just 16-9 and 4-3)

### Touying Header/Footer Gotchas

- `zero-margin-header` (default: `true`) wraps header in `pad(x: -margin, block(width: 100%, height: 100%)(header))`. If header content has no natural height (e.g., only `place()`), the block collapses to zero and content is invisible.
- Header/footer functions must have signature `(self) => content` to be called by `utils.call-or-display`.
- `config-common(freeze-slide-counter: true)` prevents counter stepping for a slide — use on all non-content slides.
- `set page(header: none)` inside a slide's `setting` function does NOT suppress `page-preamble` — Touying adds it at a higher level.

## Content Guidelines

- Formal, concise academic tone
- No sensationalism, influencer speak, or marketing language
- BIPS color palette: blue (primary), orange, green, gray
- Math notation and academic formatting prioritized

## Publishing to Typst Universe

**Packaging guidelines**: https://github.com/typst/packages/blob/main/docs/README.md

Releases are built and published with **tyler** (the same tool `just install` uses). `tyler build . --publish` assembles the clean bundle into `dist/` (applying the `[tool.tyler] ignore` list in `typst.toml`), clones `typst/packages`, creates a `bypst-<version>` branch, copies the bundle to `packages/preview/bypst/<version>`, and opens the PR. This replaces the old manual sparse-checkout method.

Before release, verify compliance with the Typst packaging guidelines:
- README.md has examples and shows the current version number
- Template files use absolute imports (`@preview/bypst:X.Y.Z`), not relative paths
- Manifest (`typst.toml`) licenses match license files; author attribution is correct
- No large or unnecessary files in the bundle. Build to a temp dir and inspect:
  `tyler build . --no-bump --no-check --outdir /tmp/bypst-check && find /tmp/bypst-check -type f`
- Package compiles without errors when imported via absolute path

Release checklist (publish to Typst first, then tag + GitHub release):
1. Bump version in `typst.toml`
2. Update all versioned `@preview/bypst:` and `@local/bypst:` imports (see Version references below)
3. Move `CHANGELOG.md` `[Unreleased]` items under a new `[X.Y.Z]` heading and update the compare links at the bottom
4. Verify: `just test` (14/14), `just format-check`, and compile the gallery (`just all`)
5. Commit the release changes
6. **Publish to Typst first**: `tyler build . --no-bump --publish` (needs GitHub auth; `--no-bump` keeps the version set in step 1). This opens/updates the `typst/packages` PR.
7. Wait for the `typst/packages` PR checks. If `typst-package-check` flags anything (e.g. an outdated dep-version warning), fix it, commit, and re-run step 6 (tyler force-recreates the `bypst-<version>` branch, updating the same PR).
8. **Only once the published commit is final**: tag it and cut the GitHub release — `git tag -a vX.Y.Z -m "Release vX.Y.Z" && git push origin vX.Y.Z`, then `gh release create vX.Y.Z`.

Tagging last avoids re-tagging HEAD every time a publish round-trip needs another commit. The `typst-package-check` "failure" with 0 errors / N warnings is non-blocking (warnings are suggestions; a human still reviews), but dep-version warnings are worth clearing before the final tag.

**Known tyler bug (v0.7.2):** the template-thumbnail check crashes with `TypeError: The "list" argument must be ... ArrayBuffer ...` because tyler passes a file path to its bundled `image-size` v2, which now requires a `Uint8Array`. It fires on `check`, `build`, and `publish`, but not on `just install` (which uses `--no-check`), and it is independent of the actual thumbnail. Fix: upgrade tyler (`bun install -g @mkpoli/tyler@latest`; latest is ≥0.10.x). Fallback if not upgrading: add `--no-check` to skip validation locally (the `typst/packages` CI re-validates on the PR). Note tyler runs under node (`#!/usr/bin/env node`), so the active node version matters.

**Packaging gotcha:** glob `**` does not match dotfiles, and a bare `.DS_Store` pattern only matches the top level. Keep both `.DS_Store` and `**/.DS_Store` in `[tool.tyler] ignore` so nested `.DS_Store` files stay out of the bundle. Anything gitignored but present on disk (e.g. `presentations/`) must also be listed in `[tool.tyler] ignore` and `[package] exclude`, or it ships.

**Version references**: Gallery and test files use relative/root imports (`#import "../bypst.typ": *` or `/bypst.typ`), so they don't need updating. Only these files contain versioned imports to bump: `typst.toml`, `README.md` (3 places), `gallery/README.md`, `template/basic.typ`, `template/complete.typ`. Use `grep -rn "bypst:0" .` to find them.

**Note**: Gallery/test files use `--root .` in the justfile to allow `/bypst.typ` imports. For standalone compilation outside the justfile, use `typst compile --root . gallery/foo.typ`.
