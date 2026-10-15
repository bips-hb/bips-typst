# ADR 0003: Keep brand colors as constants, not `config-colors`

Date: 2026-08 (0.4.0 internals refactor; recorded 2026-10-15)

## Status

Accepted

## Context

Touying themes usually declare their palette with `config-colors(primary: ..)` and read it back as `self.colors`.
bypst defines `bips-blue` and friends as constants in `src/config.typ`.
The 0.4.0 refactor moved sizes and metadata to `self.store` / `self.info`, but colors are referenced in about 20 show rules and in the user helpers `blue[]` / `orange[]` / `green[]`, which run outside slide wrappers and cannot see `self`.

## Decision

We will keep the colors as constants in `src/config.typ`.

## Options considered

- `config-colors` everywhere: the idiomatic Touying route, and it would let users recolour through the standard mechanism. Lost because it touches every color reference, and the user helpers would need a second path anyway.

## Consequences

- Recolouring the theme means overriding constants, not passing `config-colors`. For a brand-locked institutional theme that is rarely wanted.
- The theme diverges from the Touying idiom in one visible place.
- Revisit if users ask to recolour, or if bypst ever moves to a framework that requires a palette (mosaic validates a closed palette, see ADR 0004).
