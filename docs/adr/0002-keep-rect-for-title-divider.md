# ADR 0002: Keep `rect` for the title divider line

Date: 2026-08-25

## Status

Accepted

## Context

The gradient line under each slide title is drawn as a `rect` with an explicit height (`src/helpers.typ`).
Typst's `divider` element looked like the semantic replacement.
It can reproduce the look: gradient via `show divider: set line(stroke: ..)`, length via `box` (not `block`).

## Decision

We will keep the explicit-height `rect` and not use `divider`.

## Options considered

- `divider` in a `box`: its layout contribution differs from the `rect`, shifting the header by about 1px on every content slide (80 of 107 gallery pages). Four different wrappers all gave the same shift. It also took 7 lines to replace 5.

## Consequences

- Header geometry stays pixel-identical across releases.
- The line is not a semantic divider. That has no practical cost in a slide deck.
- Revisit only if a future Typst changes `divider`'s layout so that it matches `rect` exactly, checked by pixel diff of the gallery.
