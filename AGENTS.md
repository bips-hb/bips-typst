# AGENTS.md

Guidance for coding agents working on this repository. `CLAUDE.md` is a symlink
to this file.

**No version numbers live in this document on purpose.** `typst.toml` owns the
Typst floor and the package version; `src/theme.typ` owns the Touying version.
Read them instead of trusting a number written here. Anything this file pins
would rot at the next bump, unchecked by any gate.

## Project Overview

BIPS Typst presentation template for 16:9 institutional presentations, built on
Touying. Targets academic users familiar with LaTeX Beamer who want a modern
alternative with BIPS branding (colors, fonts, logo placement).

## Toolchain

A minimal environment may ship **none** of these except `just`. Before running a
task that needs one, check with `command -v` and install what is missing. Do not
skip a verification step because its tool is absent, and never report tests,
formatting, or a release gate as passing when the tool never ran.

| Task | Needs |
|---|---|
| compile anything, `just all`, `just compile-check` | `typst` |
| `just test`, `tt run` | `tt` (tytanic) |
| `just format`, `just format-check` | `typstyle` |
| `just check-deps` | `curl`, `jq` |
| `just install`, `just publish`, release tasks | `tyler` (runs under node; install via bun) |
| `just release-check` | all of the above |

CI installs tytanic and typstyle with `cargo install --locked`. Where there is no
cargo, fetch the release binaries. This derives both the architecture and the
Typst floor rather than hardcoding either:

```sh
arch=$(uname -m)                                              # x86_64 | aarch64
floor=$(grep -oE '^compiler = "[0-9.]+"' typst.toml | grep -oE '[0-9.]+')

# typst: pin to the floor, so a feature that needs a newer Typst fails here
# rather than on a user's machine. For compat checks install the current
# release as a second binary (e.g. /usr/local/bin/typst-latest) and put it
# first on PATH for one `just compile-check` run.
curl -sSL -o /tmp/t.tar.xz \
  "https://github.com/typst/typst/releases/download/v$floor/typst-$arch-unknown-linux-musl.tar.xz"
tar xf /tmp/t.tar.xz -C /tmp
sudo install -m755 "/tmp/typst-$arch-unknown-linux-musl/typst" /usr/local/bin/typst

# typstyle: single binary, gnu build (no musl asset published)
curl -sSL -o /tmp/typstyle \
  "https://github.com/Enter-tainer/typstyle/releases/latest/download/typstyle-$arch-unknown-linux-gnu"
sudo install -m755 /tmp/typstyle /usr/local/bin/typstyle

# tytanic: the binary is `tt`, inside a versioned directory like typst's
curl -sSL -o /tmp/tt.tar.xz \
  "https://github.com/tingerrr/tytanic/releases/latest/download/tytanic-$arch-unknown-linux-musl.tar.xz"
tar xf /tmp/tt.tar.xz -C /tmp
sudo install -m755 "/tmp/tytanic-$arch-unknown-linux-musl/tt" /usr/local/bin/tt

# tyler (release/publish only)
bun install -g @mkpoli/tyler@latest && export PATH="$HOME/.bun/bin:$PATH"
```

On macOS swap `unknown-linux-musl` for `apple-darwin`, or use a package manager.

### Working in a restricted environment

Sandboxes and locked-down machines tend to hit the same walls. None of these are
reasons to skip a check — each has a substitute:

- **Missing fonts.** Where Fira Sans, Fira Mono and Noto Sans are absent, every
  compile emits `unknown font family` warnings. Judge success by exit code and
  the absence of `error:` lines, never by warning count.
- **No `pdfinfo`.** For page counts, render PNGs and count them instead:
  `typst compile --root . f.typ '/tmp/p-{n}.png'`. For pixel diffing, Pillow
  works; a PEP 668 system needs `pip install --break-system-packages pillow`.
- **No push access** (SSH remotes without a key, or a policy against it). Commit
  locally and leave pushing to the human.
- **Scratch files must live in the repo.** Typst refuses files outside `--root`,
  so put throwaway `.typ` files in the gitignored `debug/`, not in a system temp
  directory. Clean up when done.

## Commands

### Build and test

- `just all` — compile every gallery deck, plus the speaker-notes pdfpc sidecar
  and inline-notes preview
- `just test` / `just test-verbose` — tytanic suite (compile-only feature tests
  plus a template test)
- `just compile-check` — compile every gallery deck **and** every test with
  whatever `typst` is on `PATH`. This is the only version-compatibility check:
  `just test` runs tytanic, which embeds its own Typst and therefore pins one
  version regardless of what is installed. CI runs this across the version
  matrix; locally, put another Typst first on `PATH`.
- `just check-deps` — compare every `@preview/…` import against the Typst
  Universe index. Floor-aware: the target is the newest release whose own
  `compiler` requirement still fits our floor, so a major needing a newer Typst
  is reported as held back rather than stale. Shipped deps fail the gate;
  gallery/test deps only warn.
- `just clean` — remove generated PDFs
- `just format` / `just format-check` — typstyle over every tracked `.typ`
- `just install` — install/refresh the local package for development. Overwrites
  a same-version install, so there is no separate uninstall step.
- `tt run <name>` — one tytanic test; `tt new --compile-only <name>` — add one
- `typst compile file.typ` / `typst watch file.typ` — single file, live preview

Gallery and test files use `--root .` (set in the justfile) so `/bypst.typ`
resolves. Compiling one standalone needs it too:
`typst compile --root . gallery/foo.typ`.

### Validating output

- Render PNGs and count them to check page counts (see above)
- `diff-pdf` / `diff-pdf-visually` — visual comparison between two builds
- `ferrules` — PDF to JSON, for structure analysis

## Architecture

The package entrypoint `bypst.typ` lives at the repo root; the implementation
lives in `src/`.

- **`bypst.typ`** (root) — package entrypoint (`typst.toml` `entrypoint`);
  re-exports `src/theme.typ`. Gallery and tests import it as `../bypst.typ` or
  `/bypst.typ`.
- **`src/theme.typ`** — orchestrator: imports and re-exports the submodules,
  defines the `bips-theme()` show-rule function. Owns the Touying import.
- **`src/config.typ`** — branding and tuning constants (colors, fonts, sizes,
  spacing). No dependencies.
- **`src/helpers.typ`** — internal plumbing: page number, gradient divider,
  `_title-area` (shrink-to-fit), `bips-background`, `_aligned`,
  `_slide-overrides`, and the `small`/`tiny`/`large`/`huge` text helpers
  (em-relative, so they scale with `base-size`). References the bundled logo as
  `image("/logo.png")` — package-root absolute, so it resolves from anywhere
  under `src/`.
- **`src/slides.typ`** — all slide types: `base-slide` plus the presets
  (`bips-slide`, `empty-slide`) and special slides (`title-slide`,
  `section-slide`, `thanks-slide`, `bibliography-slide`).
- **`src/extras.typ`** — public layout and color utilities.
- **`logo.png`** (root) — bundled placeholder logo, shipped in the package.
- **`bips-logo.png`** (root) — the real institutional logo, excluded from the
  published package via `typst.toml`.

Dependency DAG, all under `src/`: `config` → `helpers` → `slides`;
`extras` → `config`; `theme` imports all and adds `bips-theme()`. No cycles.
Submodules use *named* Touying imports, so they do not re-export Touying's own
`title-slide`/`empty-slide` and import order in `theme.typ` does not matter.

Dependencies: Touying (presentation framework) and codetastic (QR codes on
thanks slides). Exact versions: `src/theme.typ` and `src/slides.typ`.

### File organization

- `gallery/` — example presentations, one per theme or ecosystem topic. See
  `gallery/README.md` for the current list; it is kept accurate there so this
  file does not have to be.
- `tests/<name>/test.typ` — tytanic tests, one directory per feature
- `template/` — Typst Universe package templates
- `docs/` — design notes too long to belong in a comment
- `debug/` — ad-hoc scratch work (gitignored; clean up when done)

### Public API

`README.md` is the API reference and ships inside the package, so it always
matches the version a deck compiles against. Read it rather than restating the
signatures here. When you change a public signature, update the README in the
same commit.

### Size override architecture

`bips-theme()`'s size overrides (`base-size`, `slide-title-size`, …) are
published into Touying's `config-store(...)` and read by slide wrappers via
`self.store`. No hand-rolled `state()` bridges.

The `small`/`tiny`/`large`/`huge` helpers are em-relative rather than fixed pt,
so they scale with `base-size`. Heading sizes work the same way, via em-based
defaults in global `show heading` rules inside `bips-theme()`; explicit pt
overrides take precedence.

`footnote-scale` sizes footnote entry text as `footnote-scale ×
effective-font-size-base`, via `show footnote.entry: set text(size: ...)`. It
multiplies the base *length*, not `1em`, on purpose: inside `footnote.entry`,
`1em` is Typst's already-reduced footnote size, so `× 1em` would compound.
Multiplying the base length gives predictable "fraction of base" semantics.

### Slide structure patterns

- **`config:`** — page-level overrides and counter freeze. Combine multiple
  configs with `utils.merge-dicts()`.
- **`setting:`** — a callback receiving `body` that must return it. Style the
  body through this rather than wrapping it: a wrapper can hide the body from
  Touying's parser. Do **not** `set page()` inside it; use
  `config: config-page(...)` instead.
- **Direct content** — `base-slide` is a `touying-slide-wrapper` passing the body
  straight to `touying-slide(self: self, ...)`, never inside `context`, so
  `#pause` markers stay visible to the content splitter.

Page numbers use Touying's logical slide counter, not `counter(page)`, and are
`place()`d inside the slide content rather than in a header, footer or
background. The reason is a render-order constraint —
see [docs/touying-internals.md](docs/touying-internals.md).

## Animation rules

Learned from debugging; each is cheap to re-verify and worth re-verifying after a
Touying bump.

1. **No `context` or `query()` in `show` rules.** Show rules that query page
   state interfere with the animation system and produce spurious blank pages.
   Use plain `set` rules.
2. **Never wrap a user slide body in `context`.** Touying splits content at
   `#pause` during parsing, and `context` is opaque to it, so splitting fails
   silently — everything lands on one page. bypst's own chrome reads
   `self.store` and does not wrap the body, so this constrains user-authored
   content inside `bips-slide[]` / `empty-slide[]`.
3. **`#pause` works inside `two-columns` / `three-columns`.** Reveals follow
   document flow order across the cells. `#uncover()` / `#only()` remain useful
   for index-driven reveals that should not consume a pause step.
4. **Verify animations by page count.** Expected pages = base slides + number of
   `#pause` commands. Roughly double means animation interference; equal to the
   base slide count means `context` swallowed the pause markers. Note that
   `counter(page).final()` does **not** work for this — Touying manages the page
   counter, and it returns the same value regardless of subslide count. Render
   PNGs and count them.

## Touying

- Build-your-own-theme docs:
  <https://touying-typ.github.io/docs/tutorials/build-your-own-theme>
- Look up current Typst and Touying documentation online rather than recalling
  API details from memory — both move fast.
- Render pipeline, counter timing, and header/footer gotchas:
  [docs/touying-internals.md](docs/touying-internals.md)
- Upgrading Touying: read the release's changelog **and** its theme-author
  migration guide, then run `just compile-check`, `just test`, and a page-count
  comparison against the previous version. Compile success alone does not prove
  compatibility — animation semantics change without producing errors.

## Content guidelines

- Formal, concise academic tone
- No sensationalism, influencer speak, or marketing language
- BIPS color palette: blue (primary), orange, green, gray
- Math notation and academic formatting prioritized

## Development workflow (branch model)

**`main` is ALWAYS the currently published release.** It matches
`@preview/bypst:<version>` on Typst Universe exactly — same code, same README,
same version number. Never develop on `main`.

**All development happens on `dev`** (and short-lived feature branches off it).
`dev` represents the *upcoming* release: its `typst.toml` version and all
`bypst:` import refs are already set to the next version, and its README and
docs describe the upcoming features.

**README convention:** the README always documents the current branch as if it
were already published — examples import `@preview/bypst:<version>`, never
`@local`, and freely document the branch's features. The only `@local` mention is
in the local-development install instructions. So on `dev` the README describes
the next release; when `dev` merges to `main` at release time, `main`'s README is
already correct. No per-change "is this release-coupled?" juggling.

**Version:** set the whole-repo version with `just set-version X.Y.Z`, which
rewrites `typst.toml` and every `bypst:` import in `README.md`,
`gallery/README.md` and `template/`. Do this on `dev` when a new cycle begins.
Gallery and test files use relative or root-absolute imports, so they are
version-agnostic and untouched. Verify with
`grep -rn "bypst:" README.md gallery/README.md template/`.

## Publishing to Typst Universe

Packaging guidelines:
<https://github.com/typst/packages/blob/main/docs/README.md>

Releases are built and published with **tyler**, the same tool `just install`
uses. `tyler build . --publish` assembles the clean bundle into `dist/` (applying
the `[tool.tyler] ignore` list in `typst.toml`), clones `typst/packages`, creates
a `bypst-<version>` branch, copies the bundle in, and opens the PR.

Before release, verify against the packaging guidelines: the README has examples
and the current version number; template files use absolute imports
(`@preview/bypst:X.Y.Z`), not relative paths; manifest licenses match the license
files; no large or unnecessary files in the bundle.

**Order: publish from `dev` → wait for the `typst/packages` PR to merge → only
then squash-merge to `main` → tag.**

1. On `dev`: confirm the version is set (`grep '^version' typst.toml`).
2. On `dev`: add the release date to the `CHANGELOG.md` section, which is already
   named for the version rather than `[Unreleased]`. After tagging, update its
   compare link from `...HEAD` to `...vX.Y.Z`.
3. `just release-check` (tests, format-check, check-deps, all gallery decks).
4. Inspect the bundle before shipping it:
   `tyler build . --no-bump --no-check --outdir /tmp/bypst-check && find /tmp/bypst-check -type f`.
   Anything gitignored-but-on-disk can leak in.
5. Publish: `tyler build . --no-bump --publish` (needs GitHub auth; `--no-bump`
   keeps the set version).
6. If `typst-package-check` flags anything, fix it on `dev` as an ordinary commit
   and re-run step 5 — tyler force-recreates the branch and updates the same PR.
   No amending, because no release commit exists yet.
7. **Wait for the `typst/packages` PR to actually merge.** Nothing below happens
   before it does.
8. Squash-merge so `main` reads as one commit per release:
   `git switch main && git merge --squash dev && git commit -m "Release vX.Y.Z"`.
9. Tag `main` and cut the GitHub release.
10. Create a fresh `dev` from `main`. Keep the old `dev` as a history archive; do
    not hard-delete it.
11. On the new `dev`, start the next cycle: `just set-version <next>`, plus a
    fresh CHANGELOG section and compare link.

**Why publish before merging to `main`:** `main` is defined as "exactly the
currently published release". Cutting it first would claim a release while the
PR was still unreviewed, and any review fix would mean amending an
already-published-looking commit. Publishing from `dev` keeps `main` truthful.
The squash means `main`'s content still matches the published bundle exactly, and
recreating `dev` from `main` each cycle means no long-lived branch diverges from
the squash commit.

Tagging last also avoids re-tagging HEAD every time a publish round-trip needs
another commit. A `typst-package-check` "failure" with 0 errors and N warnings is
non-blocking, but dep-version warnings are worth clearing before the final tag.

**tyler notes:** tyler runs under node, so the active node version matters. If a
local validation step crashes, upgrade tyler, or pass `--no-check` — the
`typst/packages` CI re-validates on the PR either way.

**Packaging gotcha:** the glob `**` does not match dotfiles, and a bare
`.DS_Store` pattern only matches the top level, so keep both `.DS_Store` and
`**/.DS_Store` in `[tool.tyler] ignore`. Anything gitignored but present on disk
must also appear in `[tool.tyler] ignore` and `[package] exclude`, or it ships.
