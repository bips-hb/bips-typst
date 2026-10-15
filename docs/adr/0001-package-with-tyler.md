# ADR 0001: Package and publish with tyler

Date: 2026-04-07 (recorded 2026-10-15)

## Status

Accepted

## Context

Releasing to Typst Universe means assembling a clean bundle (honouring an ignore list), installing it locally for testing, and opening a PR against `typst/packages`.
Doing this by hand is error-prone, and gitignored files on disk leak into a hand-built bundle.
tyler was tried first and is now wired into `just install` and the release process in `AGENTS.md`.

## Decision

We will use tyler for local installs, bundle builds and publishing.

## Options considered

- typship (`sjfhsjfh/typship`): Rust binary, functionally on par; no node dependency.
- utpm (`typst-community/utpm`): Rust binary, functionally on par; no node dependency.
- Manual copy into a `typst/packages` clone: no ignore handling, easy to ship stray files.

## Consequences

- One command builds, checks and opens the Universe PR; re-running it updates the same PR.
- tyler runs under node, so the active node version matters; a node-side image-size bug in tyler 0.7.2 already cost a release round-trip.
- Switching to typship or utpm stays cheap. Do it only if tyler's node toolchain becomes a recurring problem, not for parity.
