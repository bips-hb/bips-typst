#import "@preview/touying:0.7.3": *
#import "@preview/codetastic:0.2.2": qrcode

// ===================================================================
// BYPST — BIPS PRESENTATION THEME
// ===================================================================
//
// A modern presentation template for BIPS using Typst and Touying
// https://github.com/bips-hb/bips-typst
//
// ===================================================================

// ===================================================================
// INSTITUTIONAL SHORTCUTS
// ===================================================================

#let bips-en = [Leibniz Institute for Prevention Research and Epidemiology --- BIPS]
#let bips-de = [Leibniz-Institut für Präventionsforschung und Epidemiologie --- BIPS]

// ===================================================================
// COLOR DEFINITIONS
// ===================================================================

#let bips-blue = rgb(23, 99, 170)
#let bips-logo-blue = rgb(65, 125, 177)
#let bips-text-gray = rgb(66, 66, 66)
#let bips-orange = rgb(250, 133, 55)
#let bips-green = rgb(49, 210, 57)

// ===================================================================
// TYPOGRAPHY CONFIGURATION
// ===================================================================

// Font families (with fallbacks for systems without Fira fonts)
// Fallback chains: preferred → common alternatives → Typst built-in
#let font-family-text = ("Fira Sans", "Noto Sans")
#let font-family-code = ("Fira Mono", "DejaVu Sans Mono")
#let font-family-math = ("New Computer Modern Math",)

// Main content styling
#let font-size-base = 18pt
#let font-color-base = bips-text-gray

#let font-size-small = 14pt

#let font-size-tiny = 12pt
#let font-size-large = 22pt
#let font-size-huge = 26pt

// Heading styling (sizes are em-based in show rules, so they scale with base-size)
// h1: 1.11em, h2: 1em, h3: 1em (h3 distinguished by color, not size)
#let heading-color-1 = bips-blue
#let heading-weight-1 = "bold"
#let heading-color-2 = bips-blue
#let heading-weight-2 = "bold"
#let heading-color-3 = bips-text-gray
#let heading-weight-3 = "bold"

// Slide title and subtitle styling
#let font-size-slide-title = 26pt
#let font-size-slide-title-only = 30pt  // Slightly larger when no subtitle
#let font-color-slide-title = bips-blue
#let font-weight-slide-title = 600

// Height of the title area (keeps the divider at a consistent position).
// Tuned with _title-divider-gap so the divider meets the logo's lower edge:
// 1.55cm top margin + 1.6cm + 0.35cm gap = 3.5cm = logo bottom (3cm @ dy 0.5cm).
#let slide-title-area-height = 1.6cm

#let font-size-slide-subtitle = 20pt
#let font-color-slide-subtitle = bips-blue
#let font-weight-slide-subtitle = "regular"

// Title slide styling
#let font-size-title-slide-main = 26pt
#let font-color-title-slide-main = bips-blue
#let font-weight-title-slide-main = 500

#let font-size-title-slide-subtitle = 20pt
#let font-color-title-slide-subtitle = bips-blue
#let font-weight-title-slide-subtitle = 400

#let font-size-title-slide-author = 20pt
#let font-color-title-slide-author = bips-blue
#let font-weight-title-slide-author = 500

#let font-size-title-slide-institute = 18pt
#let font-color-title-slide-institute = bips-text-gray
#let font-weight-title-slide-institute = "regular"

#let font-size-title-slide-date = 16pt
#let font-color-title-slide-date = bips-text-gray
#let font-weight-title-slide-date = "regular"

// Section slide styling
#let font-size-section-slide = 40pt
#let font-color-section-slide = bips-blue
#let font-weight-section-slide = "bold"

// Thanks slide styling
#let font-size-thanks-slide-main = 24pt
#let font-color-thanks-slide-main = bips-blue
#let font-weight-thanks-slide-main = "bold"

#let font-size-thanks-slide-website = 20pt
#let font-color-thanks-slide-website = bips-blue
#let font-weight-thanks-slide-website = "regular"

#let font-size-thanks-slide-contact = 14pt
#let font-color-thanks-slide-contact = bips-text-gray
#let font-weight-thanks-slide-contact = "regular"

// Page number styling
#let font-size-page-number = 18pt
#let font-color-page-number = bips-text-gray
#let font-weight-page-number = "regular"

// Code styling
#let font-scale-code-inline = 1
#let font-scale-code-block = 0.8

// List and enumeration spacing
#let list-spacing = 0.6em
#let enum-spacing = 0.6em

// Emphasis and strong text styling
#let font-color-emphasis = bips-blue
#let font-color-strong = bips-blue

// ===================================================================
// UTILITY FUNCTIONS
// ===================================================================

/// Choose first non-none value from list of options
/// This simplifies the common pattern: if override != none { override } else { default }
/// Usage: #pick-first(user-override, theme-default)
#let pick-first(..options) = {
  for option in options.pos() {
    if option != none {
      return option
    }
  }
  return none
}

/// State used to pass computed sizes from bips-theme() to slide functions.
/// Initialized with module-level defaults; updated by bips-theme() with
/// effective values that account for base-size scaling and explicit overrides.
#let _bips-sizes = state("bips-sizes", (
  slide-title: font-size-slide-title,
  slide-title-only: font-size-slide-title-only,
  slide-subtitle: font-size-slide-subtitle,
  page-number: font-size-page-number,
  small: font-size-small,
  tiny: font-size-tiny,
  large: font-size-large,
  huge: font-size-huge,
  title-align: left,
))

/// The page number, horizontally centered under the logo. The logo is 3cm wide
/// placed at dx -0.5cm, so a 3cm box right-aligned at the same dx spans the
/// logo's width; centering the number within it puts it under the logo's middle.
#let _page-number-content() = box(width: 3cm)[
  // h(1fr) on both sides centers within the fixed-width box (align(center)
  // does not center inline box content).
  #h(1fr)
  #context text(
    size: _bips-sizes.get().page-number,
    fill: font-color-page-number,
    weight: font-weight-page-number,
  )[#utils.slide-counter.display()]
  #h(1fr)
]

/// Page number element for slide content.
/// MUST be placed inside the slide CONTENT (not background/header) so the
/// slide counter is read after Touying's page-preamble steps it, giving
/// correct numbering across #pause states. `place()` positions it absolutely
/// without affecting content flow. See CLAUDE.md for the full rationale.
// dx aligns the number box (in the content frame, inset by the 1.75cm right
// margin) with the logo (in the page frame, 0.5cm from the right edge):
// 1.75cm - 0.5cm = 1.25cm. So the number centers under the logo.
#let _page-number() = place(
  top + right,
  dx: 1.25cm,
  dy: 2.2cm,
  _page-number-content(),
)

/// The BIPS gradient divider line (grey fading to white). Used by base-slide's
/// header (as its bottom edge), which all content-slide presets route through.
#let _divider-line() = rect(
  width: 85%,
  height: 0.75pt,
  fill: gradient.linear(bips-text-gray, white, angle: 0deg),
)

// Vertical gap between the title area's lower edge and the divider line.
// Explicit (not the default ~1.2em block gap) so the divider lands at the
// logo's lower edge while leaving the subtitle some breathing room.
#let _title-divider-gap = 0.35cm

/// The fixed-height title area (title and/or subtitle) plus the divider line,
/// styled in BIPS blue. Shared by all header-block slides via `base-slide`.
/// Reads sizes/alignment from `_bips-sizes` state, so it runs in `context`.
///
/// Safeguard: if the title/subtitle would overflow the fixed box height, both
/// are scaled down by a single factor (preserving proportions, down to a 0.55
/// floor) so the divider stays at a static position regardless of title length.
#let _title-area(
  title,
  subtitle,
  show-line: true,
  title-size: none,
  subtitle-size: none,
) = (
  context {
    let sizes = _bips-sizes.get()
    let h-align = sizes.title-align
    // ponytail: linear floor on shrink; titles longer than ~1.8x the box just
    // overflow upward (away from the body), divider still static.
    let min-factor = 0.55

    // Build the inner stack at scale factor `f`.
    let render(f) = {
      if title != none and subtitle != none {
        // Explicit gap between title and subtitle, plus a lift off the divider
        // so the bottom-aligned header breathes instead of hugging the line
        // (the title rises more than the subtitle, filling the space above).
        set block(spacing: 0.6em)
        block(width: 90%)[
          #text(
            size: pick-first(title-size, sizes.slide-title) * f,
            weight: font-weight-slide-title,
            fill: font-color-slide-title,
          )[#title]
        ]
        block(width: 90%)[
          #text(
            size: pick-first(subtitle-size, sizes.slide-subtitle) * f,
            weight: font-weight-slide-subtitle,
            fill: font-color-slide-subtitle,
          )[#subtitle]
        ]
        v(0.18cm)
      } else if title != none {
        text(
          size: pick-first(title-size, sizes.slide-title-only) * f,
          weight: font-weight-slide-title,
          fill: font-color-slide-title,
        )[#title]
      } else if subtitle != none {
        text(
          size: pick-first(subtitle-size, sizes.slide-subtitle) * f,
          weight: font-weight-slide-subtitle,
          fill: font-color-slide-subtitle,
        )[#subtitle]
      }
    }

    // Both -> bottom (stack reads as a unit above the divider); single -> horizon.
    let v-align = if title != none and subtitle != none { bottom } else {
      horizon
    }

    layout(region => {
      // Measure the natural height with the same base text size used below,
      // then compute the shrink factor needed to fit the fixed box.
      let natural = measure(
        box(width: region.width)[
          #set text(size: font-size-base)
          #render(1.0)
        ],
      ).height
      let f = if natural > slide-title-area-height {
        calc.max(min-factor, slide-title-area-height / natural)
      } else { 1.0 }
      box(height: slide-title-area-height, width: 100%)[
        // Fix text size so block spacing (em units) doesn't scale with base-size
        #set text(size: font-size-base)
        #align(v-align + h-align)[#render(f)]
      ]
    })

    // Divider hugs the title box (small explicit gap, not the default block gap)
    if show-line {
      block(above: _title-divider-gap, below: 0pt, _divider-line())
    }
  }
)

/// State for the logo image, settable via bips-theme(logo: ...).
/// Default is the bundled placeholder; users should replace with their own.
#let _bips-logo = state("bips-logo", image("logo.png"))

/// State holding the raw `config-info(...)` values passed to bips-theme().
/// title-slide() reads this as a fallback for fields not passed explicitly,
/// so one `config-info(...)` populates both PDF metadata and the title slide.
#let _bips-info = state("bips-info", (:))

/// Render content at a smaller size (scales with base-size)
#let small(body) = context text(size: _bips-sizes.get().small)[#body]

/// Render content at the smallest size (scales with base-size)
#let tiny(body) = context text(size: _bips-sizes.get().tiny)[#body]

/// Render content at a larger size (scales with base-size)
#let large(body) = context text(size: _bips-sizes.get().large)[#body]

/// Render content at the largest size (scales with base-size)
#let huge(body) = context text(size: _bips-sizes.get().huge)[#body]

// ===================================================================
// BACKGROUND UTILITY FUNCTIONS
// ===================================================================

/// Create background with logo in top-right corner.
/// Page numbers are handled separately via Touying's header system
/// to ensure correct numbering across #pause subslides.
#let bips-background(show-logo: true) = {
  if show-logo {
    context {
      let logo = _bips-logo.get()
      if logo != none {
        // Inset toward the top-right corner (matches the BIPS beamer template).
        // The title area height is tuned so the divider meets the logo's edge.
        place(
          top + right,
          dx: -0.5cm,
          dy: 0.5cm,
          box(width: 3cm, logo),
        )
      }
    }
  }
}

// ===================================================================
// MAIN THEME FUNCTION
// ===================================================================

#let bips-theme(
  aspect-ratio: "16-9",
  /// Logo image displayed in the top-right corner of content slides and on
  /// the thanks slide. Pass an `image()` call to override the default placeholder.
  /// Set to `none` to hide the logo entirely.
  logo: auto,
  // Title alignment inside the title area box (e.g. left, center, right)
  // Applies to the horizontal alignment of slide titles/subtitles.
  title-align: left,
  // Font family overrides (string or array of strings with fallbacks)
  font: none,
  code-font: none,
  math-font: none,
  // Global font size overrides (optional)
  base-size: none,
  slide-title-size: none,
  slide-subtitle-size: none,
  heading-1-size: none,
  heading-2-size: none,
  heading-3-size: none,
  small-size: none,
  tiny-size: none,
  large-size: none,
  huge-size: none,
  page-number-size: none,
  code-block-scale: none,
  code-inline-scale: none,
  // Handout mode: collapse all pauses/uncover/only to final state,
  // emitting one page per slide (no incremental subslides).
  // `auto` (default) reads the `handout` CLI input flag
  // (`typst compile --input handout=true`); `true`/`false` override it.
  handout: auto,
  // Extra Touying config dicts (e.g. config-info(...), config-common(...),
  // config-page(...)) forwarded to touying-slides(). They deep-merge after
  // the theme's own config, so user values override on conflict. This is how
  // you set PDF metadata, enable pdfpc, presenter notes, appendix mode, etc.
  ..args,
  body,
) = {
  // Calculate effective font sizes (use override if provided, otherwise theme default)
  let effective-font-size-base = pick-first(base-size, font-size-base)
  let effective-code-block-scale = pick-first(
    code-block-scale,
    font-scale-code-block,
  )
  let effective-code-inline-scale = pick-first(
    code-inline-scale,
    font-scale-code-inline,
  ) // Resolve font families
  let effective-font = pick-first(font, font-family-text)
  let effective-code-font = pick-first(code-font, font-family-code)
  let effective-math-font = pick-first(math-font, font-family-math)
  // Handout: explicit true/false wins; `auto` falls back to the CLI input flag.
  let effective-handout = if handout == auto {
    sys.inputs.at("handout", default: "false") == "true"
  } else {
    handout
  } // Global text and styling configuration
  show: set text(
    font: effective-font,
    size: effective-font-size-base,
    fill: font-color-base,
  )
  show math.equation: set text(font: effective-math-font) // Heading styles use em-based defaults so they scale proportionally with base-size.
  // Explicit pt overrides take precedence over the em-based defaults.
  show heading.where(level: 1): set text(
    size: pick-first(heading-1-size, 1.11em),
    weight: heading-weight-1,
    fill: heading-color-1,
  )
  show heading.where(level: 2): set text(
    size: pick-first(heading-2-size, 1em),
    weight: heading-weight-2,
    fill: heading-color-2,
  )
  show heading.where(level: 3): set text(
    size: pick-first(heading-3-size, 1em),
    weight: heading-weight-3,
    fill: heading-color-3,
  ) // Publish effective sizes via state so slide functions can read them.
  // Sizes that aren't overridden explicitly use the module-level defaults,
  // which means they don't auto-scale with base-size. Use em-based values
  // in the state to get proportional scaling where appropriate.
  _bips-sizes.update((
    slide-title: pick-first(slide-title-size, font-size-slide-title),
    slide-title-only: font-size-slide-title-only,
    slide-subtitle: pick-first(slide-subtitle-size, font-size-slide-subtitle),
    page-number: pick-first(page-number-size, font-size-page-number),
    small: pick-first(small-size, font-size-small),
    tiny: pick-first(tiny-size, font-size-tiny),
    large: pick-first(large-size, font-size-large),
    huge: pick-first(huge-size, font-size-huge),
    title-align: title-align,
  ))
  // Update logo state: auto = bundled placeholder, none = no logo, image() = custom
  if logo != auto {
    _bips-logo.update(logo)
  }
  // Emphasis (_text_) in BIPS blue (color only, no italic)
  show emph: it => text(
    fill: font-color-emphasis,
    style: "italic",
    weight: "regular",
  )[#it.body] // Strong text (*text*) in BIPS blue (color only, no bold)
  show strong: it => text(fill: font-color-strong, weight: "bold")[#it.body] // Links in BIPS blue with thin underline to distinguish from emphasis
  show link: it => underline(text(fill: bips-blue)[#it]) // Table styling - set elegant defaults
  set table(
    stroke: none,
    fill: (_, y) => if y == 0 { bips-blue.lighten(85%) } else { none },
    inset: (x: 0.7em, y: 0.6em),
  ) // Add subtle borders around tables
  show table: it => block(
    stroke: (
      top: 1pt + bips-blue.lighten(50%),
      bottom: 1pt + bips-blue.lighten(50%),
    ),
    inset: 0pt,
    it,
  ) // List styling with configurable spacing
  // Spacing uses `set` (not `show`) so users can override with local `#set list(spacing: ...)`
  set list(spacing: list-spacing)
  set enum(spacing: enum-spacing)
  // top-edge/bottom-edge ensure consistent line metrics so bullet markers
  // stay aligned with text even when emojis or other tall glyphs are present.
  // Tighter par leading compensates for the taller ascender line height on line breaks within items.
  show list: set text(
    fill: font-color-base,
    top-edge: "ascender",
    bottom-edge: "descender",
  )
  show list: set par(leading: 0.4em)
  // Nested lists/enums get tighter spacing (including cross-type nesting)
  show list: it => {
    show list: set list(spacing: 0.4em)
    show enum: set enum(spacing: 0.4em)
    it
  }
  show enum: set text(
    fill: font-color-base,
    top-edge: "ascender",
    bottom-edge: "descender",
    // Tabular figures keep the marker gutter a fixed width. With Fira Sans's
    // proportional digits the gutter is sized to the widest marker, so a list
    // revealed item-by-item (Touying #pause) shifts "1." right as "2."/"3."
    // appear. Equal-width digits pin the marker in place.
    number-width: "tabular",
  )
  show enum: set par(leading: 0.4em)
  show enum: it => {
    show enum: set enum(spacing: 0.4em)
    show list: set list(spacing: 0.4em)
    it
  } // Code styling - Fira Mono pairs with Fira Sans for consistent metrics
  show raw: set text(font: effective-code-font)
  show raw.where(block: true): set text(size: effective-code-block-scale * 1em)
  show raw.where(block: false): set text(
    size: effective-code-inline-scale * 1em,
  ) // Stash any config-info(...) values so title-slide() can use them as
  // defaults. config-info(...) returns `(info: (...))` with raw content,
  // before Touying wraps the values for its own pipeline.
  let info = (:)
  for cfg in args.pos() {
    if type(cfg) == dictionary and "info" in cfg {
      info += cfg.info
    }
  }
  _bips-info.update(info)
  // Use Touying's infrastructure with BIPS customizations
  touying-slides(
    config-common(handout: effective-handout),
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: (top: 1.55cm, bottom: 1.55cm, left: 1.55cm, right: 1.75cm),
      background: bips-background(show-logo: true),
    ),
    // User-supplied config dicts override the above via Touying's deep merge.
    ..args.pos(),
    body,
  )
}

// ===================================================================
// SLIDE TYPE DEFINITIONS
// ===================================================================

// Wrap body in `content-align`, adding vertical fills when the alignment has a
// vertical component (horizon/bottom) so content centers/bottoms within the
// slide. Returns body unchanged when content-align is none. Shared by all slide
// types so alignment behaves consistently. Kept outside any `context` block so
// Touying can still split body content at #pause boundaries.
#let _aligned(content-align, body) = {
  if content-align == none {
    body
  } else {
    let has-vertical = (
      content-align == horizon
        or content-align == bottom
        or content-align
          in (
            center + horizon,
            center + bottom,
            left + horizon,
            left + bottom,
            right + horizon,
            right + bottom,
          )
    )
    if has-vertical { v(1fr) }
    align(content-align)[#body]
    if has-vertical { v(1fr) }
  }
}

// Pull Touying `slide()` overrides (config, repeat, setting) out of a slide
// function's `..args`, so the non-content slide types are as composable as
// `bips-slide`. `config` is returned separately for the caller to merge into
// its own base config; the rest default to slide()'s own defaults (no-ops).
// `composer` is intentionally omitted: it only matters with multiple body
// blocks, which the fixed-layout slides don't take. `empty-slide` handles
// `composer` itself (see below).
#let _slide-overrides(args) = {
  let named = args.named()
  (
    config: named.at("config", default: (:)),
    repeat: named.at("repeat", default: auto),
    setting: named.at("setting", default: body => body),
  )
}

// -------------------------------------------------------------------
// Content Slides
// -------------------------------------------------------------------

/// The flexible base content slide: title/subtitle live in a native Touying
/// header block (the divider is the header's bottom edge), over a fully native
/// body. Every BIPS chrome component is independently toggleable. `bips-slide`
/// and `empty-slide` are presets over this function.
///
/// Because the body is native Touying content, `#pause`, `composer` (multi-pane
/// via multiple trailing blocks), and multi-block bodies all work directly.
///
/// Toggles:
/// - `show-logo` — top-right logo (default true).
/// - `page-number` — show the page number (default true).
/// - `show-line` — divider line under the header (default true; no-op with no header).
/// - `count` — advance the slide counter (default true; frozen if false).
///
/// With no `title`/`subtitle` the header is omitted and the body fills from the
/// top margin. Slide-level `config` / `repeat` / `composer` / `setting` overrides
/// are forwarded.
#let base-slide(
  title: none,
  subtitle: none,
  show-logo: true,
  page-number: true,
  show-line: true,
  count: true,
  content-align: none,
  title-size: none,
  subtitle-size: none,
  text-size: none,
  code-block-scale: none,
  code-inline-scale: none,
  ..args,
) = {
  let named = args.named()
  let user-config = named.at("config", default: (:))
  let repeat = named.at("repeat", default: auto)
  let composer = named.at("composer", default: auto)
  let user-setting = named.at("setting", default: body => body)
  let has-header = title != none or subtitle != none

  // The header content is bottom-anchored against the body, so putting body-gap
  // last places the divider that far above the body — at the constant divider
  // position (base margin + title area + gap = flush with the logo).
  let body-gap = 0.8cm
  let top-margin = (
    1.55cm + slide-title-area-height + _title-divider-gap + body-gap
  )

  let header(self) = {
    // Page number centered under the logo, placed flow-free.
    if page-number {
      place(top + right, dx: 1.25cm, dy: 3.75cm, _page-number-content())
    }
    _title-area(
      title,
      subtitle,
      show-line: show-line,
      title-size: title-size,
      subtitle-size: subtitle-size,
    )
    v(body-gap)
  }

  // Per-slide chrome: logo background (show-logo authoritative per slide) and
  // counter participation. bips-background(show-logo: false) renders nothing,
  // suppressing the global theme logo for this slide.
  let chrome-config = utils.merge-dicts(
    config-common(freeze-slide-counter: not count),
    config-page(background: bips-background(show-logo: show-logo)),
  )

  let config = if has-header {
    utils.merge-dicts(
      chrome-config,
      config-common(zero-margin-header: false),
      config-page(
        margin: (top: top-margin, bottom: 1.55cm, left: 1.55cm, right: 1.75cm),
        header-ascent: 0pt,
        header: header,
      ),
      user-config,
    )
  } else {
    utils.merge-dicts(chrome-config, user-config)
  }

  // With no header the page number goes in the content (place is flow-free).
  let content-number = if not has-header and page-number { _page-number() }

  let render-body(body) = {
    let styled = if text-size != none { text(size: text-size)[#body] } else {
      body
    }
    _aligned(content-align, styled)
  }

  if composer == auto {
    let body = args.pos().at(0, default: none)
    slide(config: config, repeat: repeat, setting: user-setting)[
      #content-number
      #show raw.where(block: true): set text(
        size: pick-first(code-block-scale, font-scale-code-block) * 1em,
      )
      #show raw.where(block: false): set text(
        size: pick-first(code-inline-scale, font-scale-code-inline) * 1em,
      )
      #render-body(body)
    ]
  } else {
    // Multi-pane mode: forward all bodies to the composer (content-align and
    // body-level code-scale are ignored — the composer owns the layout).
    slide(
      config: config,
      repeat: repeat,
      composer: composer,
      setting: body => {
        content-number
        user-setting(body)
      },
      ..args.pos(),
    )
  }
}

/// Standard BIPS content slide: title/subtitle header, logo, page number, and
/// gradient divider, over a native Touying body. A preset over `base-slide`
/// with all chrome enabled. Signature is unchanged from earlier versions.
#let bips-slide(
  title: none,
  subtitle: none,
  content-align: none,
  title-size: none,
  subtitle-size: none,
  text-size: none,
  code-block-scale: none,
  code-inline-scale: none,
  show-line: true,
  ..args,
) = base-slide(
  title: title,
  subtitle: subtitle,
  show-logo: true,
  page-number: true,
  show-line: show-line,
  count: true,
  content-align: content-align,
  title-size: title-size,
  subtitle-size: subtitle-size,
  text-size: text-size,
  code-block-scale: code-block-scale,
  code-inline-scale: code-inline-scale,
  ..args,
)

// -------------------------------------------------------------------
// Title Slide
// -------------------------------------------------------------------

#let title-slide(
  title: none,
  subtitle: none,
  author: none,
  authors: none, // Alternative: array of authors for multi-affiliation support
  institute: none,
  institutes: none, // Alternative: array of institutes for multi-affiliation support
  date: none,
  occasion: none,
  // Optional font size overrides
  title-size: none,
  subtitle-size: none,
  author-size: none,
  institute-size: none,
  date-size: none,
  // slide() overrides (config/repeat/composer). `setting` is owned by the
  // title slide layout and is not forwarded.
  ..args,
) = {
  let o = _slide-overrides(args)
  slide(
    config: utils.merge-dicts(
      config-common(freeze-slide-counter: true),
      o.config,
    ),
    repeat: o.repeat,
    setting: body => {
      set align(center)
      // Fix text size so block spacing (1.2em) doesn't scale with base-size
      set text(size: font-size-base)

      // Fall back to the theme's config-info(...) for any field not passed
      // explicitly, so PDF metadata and the title slide share one source.
      // Title slides have no #pause, so wrapping in context is safe here.
      context {
        let info = _bips-info.get()
        let title = pick-first(title, info.at("title", default: none))
        let subtitle = pick-first(subtitle, info.at("subtitle", default: none))
        let author = pick-first(author, info.at("author", default: none))
        let date = pick-first(date, info.at("date", default: none))
        let institute = pick-first(institute, info.at(
          "institution",
          default: none,
        ))

        v(1fr)

        // Title (width constrained to prevent overlap with logo in top-right)
        if title != none {
          block(
            width: 85%,
            text(
              size: pick-first(title-size, font-size-title-slide-main),
              weight: font-weight-title-slide-main,
              fill: font-color-title-slide-main,
            )[
              #title
            ],
          )
        }

        v(0.5fr)

        // Subtitle
        if subtitle != none {
          block(
            width: 85%,
            text(
              size: pick-first(subtitle-size, font-size-title-slide-subtitle),
              weight: font-weight-title-slide-subtitle,
              fill: font-color-title-slide-subtitle,
            )[
              #subtitle
            ],
          )
        }

        v(1fr)

        // Author(s) - support both single and multiple authors
        if authors != none {
          // Multiple authors format
          block(
            text(
              size: pick-first(author-size, font-size-title-slide-author),
              weight: font-weight-title-slide-author,
              fill: font-color-title-slide-author,
            )[
              // #authors.join(linebreak())
              #authors.join([#h(1em)])
            ],
          )
        } else if author != none {
          // Single author format (backward compatibility)
          block(
            text(
              size: pick-first(author-size, font-size-title-slide-author),
              weight: font-weight-title-slide-author,
              fill: font-color-title-slide-author,
            )[
              #author
            ],
          )
        }

        v(1fr)

        // Institute(s) - support both single and multiple institutes
        if institutes != none {
          // Multiple institutes format with numbering
          block(
            text(
              size: pick-first(institute-size, font-size-title-slide-institute),
              weight: font-weight-title-slide-institute,
              fill: font-color-title-slide-institute,
            )[
              #for (i, inst) in institutes.enumerate() [
                #super[#(i + 1)] #inst
                #if i < institutes.len() - 1 [\ ]
              ]
            ],
          )
        } else if institute != none {
          // Single institute format (backward compatibility)
          block(
            text(
              size: pick-first(institute-size, font-size-title-slide-institute),
              weight: font-weight-title-slide-institute,
              fill: font-color-title-slide-institute,
            )[
              #institute
            ],
          )
        }

        v(1fr)

        // Date
        if date != none {
          block(
            text(
              size: pick-first(date-size, font-size-title-slide-date),
              weight: font-weight-title-slide-date,
              fill: font-color-title-slide-date,
            )[
              #date
            ],
          )
        }

        // Occasion
        if occasion != none {
          block(
            text(
              size: pick-first(date-size, font-size-title-slide-date),
              weight: font-weight-title-slide-date,
              fill: font-color-title-slide-date,
            )[
              #occasion
            ],
          )
        }
      }
    },
  )[]
}

// -------------------------------------------------------------------
// Section Slide
// -------------------------------------------------------------------

#let section-slide(
  section-title,
  show-logo: true, // Show BIPS logo by default (institutional default)
  // Optional secondary content (centered, below the title) as a trailing
  // block, plus any slide() overrides (config/repeat/composer/setting).
  ..args,
) = {
  // Treat an empty content block (`[]`) the same as no body, so
  // `#section-slide("foo")` and `#section-slide("foo")[]` render identically.
  let body = args.pos().at(0, default: none)
  if body == [] { body = none }
  let o = _slide-overrides(args)
  slide(
    config: utils.merge-dicts(
      config-common(freeze-slide-counter: true),
      config-page(background: bips-background(show-logo: show-logo)),
      o.config,
    ),
    repeat: o.repeat,
    setting: o.setting,
  )[
    // Invisible heading for PDF outline/bookmarks
    #place(hide[#heading(level: 1, outlined: true)[#section-title]])

    #align(center + horizon)[
      #text(
        size: font-size-section-slide,
        weight: font-weight-section-slide,
        fill: font-color-section-slide,
      )[#section-title]
      #if body != none {
        v(0.6em)
        body
      }
    ]
  ]
}

// -------------------------------------------------------------------
// Bibliography Slide
// -------------------------------------------------------------------

/// Display a bibliography slide with references.
///
/// Two ways to supply the references:
///
/// 1. Pass the bib file via `bib:` and let the slide call `bibliography()`
///    for you, forwarding `style`/`full` and defaulting bibliography's own
///    heading off (the slide title already says "References"). You must read
///    the file in your own document with `read("references.bib")` — a bare
///    path string can't be forwarded because `bibliography()` resolves paths
///    relative to where it is *called* (here, inside the package), not your
///    document. `read()` runs in your document, so its path resolves there.
///
///    ```
///    #bibliography-slide(
///      bib: read("references.bib"),
///      text-size: 9pt,
///    )
///    ```
///
/// 2. Or build the bibliography yourself and pass it as content (useful for
///    full control over `bibliography()` arguments):
///
///    ```
///    #bibliography-slide(text-size: 14pt)[
///      #bibliography("references.bib", title: none, style: "apa", full: true)
///    ]
///    ```
#let bibliography-slide(
  title: "References",
  text-size: none,
  content-align: horizon,
  bib: none, // `read("references.bib")` (string or bytes); builds the bibliography internally
  style: "springer-basic-author-date", // forwarded to bibliography(); `auto` uses its built-in default
  full: false, // forwarded to bibliography() when `bib` is given
  bib-title: none, // bibliography()'s own heading; off by default (slide already has a title)
  ..body, // or pass pre-built bibliography content as a trailing block
) = {
  let refs = if bib != none {
    // read() returns a string by default; bibliography() needs bytes (a plain
    // string would be read as a path). bytes() preserves UTF-8 content.
    let src = if type(bib) == str { bytes(bib) } else { bib }
    // `style: auto` means "use bibliography's built-in default" — omit the arg.
    if style == auto {
      bibliography(src, title: bib-title, full: full)
    } else {
      bibliography(src, title: bib-title, style: style, full: full)
    }
  } else {
    body.pos().at(0, default: none)
  }
  bips-slide(title: title, text-size: text-size, content-align: content-align)[
    #refs
  ]
}

// -------------------------------------------------------------------
// Thanks Slide
// -------------------------------------------------------------------

#let thanks-slide(
  thanks-text: "Thank you for your attention!",
  contact-author: "",
  email: "",
  qr-url: none, // Optional: URL to generate QR code for (replaces website URL)
  ..args, // slide() overrides (config/repeat/composer/setting)
) = {
  let o = _slide-overrides(args)
  slide(
    config: utils.merge-dicts(
      config-common(freeze-slide-counter: true),
      config-page(background: none),
      o.config,
    ),
    repeat: o.repeat,
    setting: o.setting,
  )[
    // 3-row grid layout: thanks text, QR/website, contact+logo
    #grid(
      rows: (1fr, 1fr, auto),
      row-gutter: 2em,
      [
        // Row 1: Thanks message (centered, taking up available space)
        #align(center + horizon)[
          #text(
            size: font-size-thanks-slide-main,
            weight: font-weight-thanks-slide-main,
            fill: font-color-thanks-slide-main,
          )[
            #thanks-text
          ]
        ]
      ],
      [
        // Row 2: QR code or website (centered)
        #align(center + bottom)[
          #if qr-url != none [
            // Show QR code when URL is provided
            #qrcode(qr-url, width: 4cm, debug: false, quiet-zone: 0, colors: (
              white,
              bips-blue,
            ))
          ] else [
            // Show website URL as before
            #text(
              size: font-size-thanks-slide-website,
              weight: font-weight-thanks-slide-website,
              fill: font-color-thanks-slide-website,
            )[
              www.leibniz-bips.de
            ]
          ]
        ]
      ],
      [
        // Row 3: Contact information and logo
        #grid(
          columns: (1fr, 1fr),
          align: (right, left),
          gutter: 2em,
          [
            #align(right)[
              #text(
                size: font-size-thanks-slide-contact,
                weight: font-weight-thanks-slide-contact,
                fill: font-color-thanks-slide-contact,
              )[
                *Contact*

                #text(fill: font-color-thanks-slide-website)[#contact-author]\
                Leibniz Institute for Prevention Research\
                and Epidemiology -- BIPS\
                Achterstraße 30\
                28359 Bremen\
                Germany

                #if email != "" [
                  #text(fill: font-color-thanks-slide-website)[#email]
                ]
              ]
            ]
          ],
          [
            #align(left)[
              #context {
                let logo = _bips-logo.get()
                if logo != none { box(width: 5.5cm, logo) }
              }
            ]
          ],
        )
      ],
    )
  ]
}

// -------------------------------------------------------------------
// Empty Slide
// -------------------------------------------------------------------

/// Minimal slide built on `base-slide`: no header, divider off, and (by default)
/// no logo or page number — just the body. Useful for full-bleed images or
/// transition screens.
///
/// By default the slide counter is frozen (unnumbered, does not advance). Set
/// `count: true` to keep it in the numbered sequence; the page number then
/// shows too (set `page-number: false` to suppress it). Toggle `show-logo: true`
/// to keep the BIPS logo on an otherwise minimal slide.
///
/// Pass a `composer` (e.g. `composer: (1fr, 1fr)`) with multiple trailing blocks
/// for a full-bleed multi-pane layout; in that mode `content-align` is ignored.
#let empty-slide(
  count: false,
  show-logo: false,
  page-number: auto, // auto = follow `count` (number shows iff counted)
  content-align: none,
  ..args,
) = base-slide(
  show-logo: show-logo,
  page-number: if page-number == auto { count } else { page-number },
  show-line: false,
  count: count,
  content-align: content-align,
  ..args,
)

// ===================================================================
// LAYOUT AND COLOR UTILITIES
// ===================================================================

// -------------------------------------------------------------------
// Color Utility Functions
// -------------------------------------------------------------------

/// Apply BIPS blue color to text
/// Example: #blue[This text is blue]
#let blue(content) = text(fill: bips-blue)[#content]

/// Apply BIPS logo blue color to text
/// Example: #logo-blue[This text is the same shade of blue as the BIPS logo]
#let logo-blue(content) = text(fill: bips-logo-blue)[#content]

/// Apply BIPS orange color to text
/// Example: #orange[This text is orange]
#let orange(content) = text(fill: bips-orange)[#content]

/// Apply BIPS green color to text
/// Example: #green[This text is green]
#let green(content) = text(fill: bips-green)[#content]

/// Apply gray color to text
/// Example: #gray[This text is gray]
#let gray(content) = text(fill: bips-text-gray)[#content]

// -------------------------------------------------------------------
// Author Affiliation Helper
// -------------------------------------------------------------------

/// Helper function to format author with superscript affiliations
/// Can take single number: inst(1) or multiple numbers: inst(1,4,5)
#let inst(..numbers) = {
  let nums = numbers.pos()
  if nums.len() == 0 {
    ""
  } else {
    super[#nums.map(str).join(",")]
  }
}

// -------------------------------------------------------------------
// Multi-Column Layout Helpers
// -------------------------------------------------------------------

/// Two-column layout with equal columns by default
///
/// Example: #two-columns[Left content][Right content]
/// With options: #two-columns(gutter: 2em)[Left][Right]
#let two-columns(
  gutter: 1em,
  columns: (1fr, 1fr),
  ..args,
  left,
  right,
) = {
  grid(
    columns: columns,
    gutter: gutter,
    ..args,
    left,
    right,
  )
}

/// Three-column layout with equal columns by default
///
/// Example: #three-columns[Left][Center][Right]
/// With options: #three-columns(gutter: 1.5em, columns: (1fr, 2fr, 1fr))[L][C][R]
#let three-columns(
  gutter: 1em,
  columns: (1fr, 1fr, 1fr),
  ..args,
  left,
  center,
  right,
) = {
  grid(
    columns: columns,
    gutter: gutter,
    ..args,
    left,
    center,
    right,
  )
}

// -------------------------------------------------------------------
// Callout Blocks
// -------------------------------------------------------------------

/// Create compact styled callout blocks with inline icons
///
/// Available types: note, tip, warning, important
/// Displays icon inline with content for space efficiency
///
/// Example: #callout(type: "warning")[Content here]
#let callout(
  type: "note",
  title: none,
  icon: none,
  body,
) = {
  // Color schemes for different callout types
  let colors = (
    note: (border: bips-blue, bg: bips-blue.lighten(90%), icon: bips-blue),
    tip: (border: bips-green, bg: bips-green.lighten(90%), icon: bips-green),
    warning: (
      border: bips-orange,
      bg: bips-orange.lighten(90%),
      icon: bips-orange,
    ),
    important: (border: red, bg: red.lighten(90%), icon: red),
  )

  // Default icons for each type
  let icons = (
    note: "📝",
    tip: "💡",
    warning: "⚠",
    important: "❗",
  )

  let color-scheme = colors.at(type, default: colors.note)
  let default-icon = icons.at(type, default: icons.note)
  let display-icon = pick-first(icon, default-icon)

  block(
    width: 100%,
    stroke: (left: 4pt + color-scheme.border),
    fill: color-scheme.bg,
    inset: (left: 0.8em, right: 0.8em, top: 0.5em, bottom: 0.5em),
    radius: (right: 4pt),
    below: 0.8em,
  )[
    #if title != none {
      // When title is provided, show icon + title on separate line as before
      text(
        size: 0.9em,
        weight: "bold",
        fill: color-scheme.icon,
      )[
        #if display-icon != none [#display-icon ]
        #title
      ]
      v(0.3em)
      body
    } else {
      // Default: icon inline with content, no title
      if display-icon != none [
        #text(fill: color-scheme.icon, size: 0.9em)[#display-icon] #h(0.5em)
      ]
      body
    }
  ]
}

// -------------------------------------------------------------------
// Miscellaneous Helpers
// -------------------------------------------------------------------

/// Convenience function for vertical fill
#let vfill = v(1fr)

/// Compact list/enum spacing for tight layouts (e.g. multi-column slides)
///
/// Example: #compact[- Item A \ - Item B \ - Item C]
#let compact(spacing: 0.4em, leading: 0.4em, body) = {
  show list: set list(spacing: spacing)
  show enum: set enum(spacing: spacing)
  set par(leading: leading)
  show list: set text(top-edge: "cap-height", bottom-edge: "baseline")
  // Tabular figures keep the enum marker gutter fixed; see the main `show enum`
  // rule above for why (proportional digits shift the marker under #pause).
  show enum: set text(
    top-edge: "cap-height",
    bottom-edge: "baseline",
    number-width: "tabular",
  )
  body
}
