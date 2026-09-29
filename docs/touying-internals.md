# Touying internals

Background for changing bypst's slide chrome. None of it is needed to *use* the
theme, and most of it only matters when the page number, the counter, or an
animation misbehaves.

Touying moves fast and these are implementation details, not API. Everything
here was observed rather than documented upstream, so re-verify before relying on
it after a version bump — and check the release's theme-author migration guide,
which is where upstream announces changes at this level.

## Render pipeline

Order matters for counter correctness:

1. `touying-slide` processes the content and splits it at `#pause` markers into
   subslides.
2. For each subslide:
   a. Header and footer are extracted from `self.page` and called via
      `utils.call-or-display(self, fn)`, then wrapped per the
      `zero-margin-header` / `zero-margin-footer` settings.
   b. `page-preamble(self)` is prepended to the header. This is where
      `utils.slide-counter.step()` happens, and only on the first subslide.
   c. `set page(header: preamble + header, footer: footer)` is applied.
   d. The content is rendered through the `setting` function.

The Touying source is the reference for all of this. Locate the installed
package rather than guessing the path:

```sh
find "${XDG_CACHE_HOME:-$HOME/.cache}/typst/packages/preview/touying" \
     "$HOME/Library/Caches/typst/packages/preview/touying" \
     -maxdepth 1 -type d 2>/dev/null
```

The interesting parts are the subslide loop and counter stepping, the
`config-page` / `config-common` definitions, and any bundled theme as a worked
example of header/footer handling. Recent versions split the core into several
modules under `src/core/`, so grep for the function rather than opening a fixed
filename.

## Why page numbers live in the slide content

Touying renders each `#pause` state as its own PDF page. The slide counter steps
once per *logical* slide, in `page-preamble`, which is prepended to the header.
That timing rules out three of the four obvious homes for a page number:

- **`background`** — rendered *before* the header, so on the first subslide the
  counter has not stepped yet. The number then increments between pause states:
  an off-by-one that only appears on animated slides.
- **`header`** — the counter is correct here, but `place()` does not work:
  `place()` contributes no height, and the `zero-margin-header` wrapping puts the
  header in a `block(height: 100%)` that collapses to nothing. The number is
  simply invisible.
- **`footer`** — the counter is correct, but the footer sits at the bottom of the
  page, so putting the number anywhere else means coordinate math against the
  page geometry.
- **slide content** — rendered *after* the header, so the counter is always
  correct, and `place()` positions the number absolutely without disturbing
  content flow. This is what bypst does.

The `place()` call sits at the start of `base-slide`'s content block, before any
`#pause`, so the number appears on every subslide.

## Counter freeze

Slide types that should not consume a number use
`config-common(freeze-slide-counter: true)`. `title-slide`, `section-slide` and
`thanks-slide` always freeze. `empty-slide` — and any `base-slide` with
`count: false` — freezes too; setting `count: true` removes the freeze so the
slide takes a counter value. The result is gapless, sequential numbering across
content slides.

## Header and footer gotchas

- `zero-margin-header` (default on) wraps the header in
  `pad(x: -margin, block(width: 100%, height: 100%)(header))`. Header content
  with no natural height — only `place()`, say — collapses to zero and vanishes.
- Header and footer functions need the signature `(self) => content` to be
  called by `utils.call-or-display`.
- `set page(header: none)` inside a slide's `setting` function does **not**
  suppress `page-preamble`; Touying adds it at a higher level.
- Aspect ratio comes from `..utils.page-args-from-aspect-ratio(aspect-ratio)` in
  `config-page()`, not from a `paper:` string.
- `set page()` inside a `setting:` callback produces ghost blank pages after the
  slide. Use `config: config-page(...)` instead.
