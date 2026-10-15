# ADR 0004: Stay on Touying rather than move to mosaic

Date: 2026-08-21 (recorded 2026-10-15)

## Status

Accepted

## Context

mosaic (Vincent Arel-Bundock) is a newer Typst slide framework, an alternative to Touying.
A read-only exploration of mosaic 0.0.1 found real wins: per-slide numbering with no counter render-order workaround (see [touying-internals.md](../touying-internals.md)), `overflow: "error"` for clipped slides, richer reveal steps.
bypst's own code would barely shrink: the divider, logo and shrink-to-fit title cost the same in either framework.

## Decision

We will keep bypst on Touying.
If mosaic is adopted later, it becomes a separate BIPS theme package alongside bypst, not a rewrite of bypst.

## Options considered

- Rewrite bypst on mosaic: breaks every existing deck. mosaic is at 0.0.1 with one maintainer, and its API will churn.
- Separate mosaic theme now: two artifacts for one brand while mosaic is still immature.

## Consequences

- The page-number counter workaround stays.
- No `overflow: "error"` equivalent; clipped slides must still be caught by eye.
- Revisit when mosaic reaches 0.2+ and has settled. A port would make ADR 0003 moot, since mosaic needs a palette.
- calepin (code execution for Typst) is independent of mosaic and can be tried with bypst now.
