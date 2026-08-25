# bypst — BIPS Presentation Theme

# Every Typst source that is formatted and checked. `format` and `format-check`
# share this list so the gate can never cover less than the formatter writes.
typst_sources := "*.typ src/*.typ gallery/*.typ template/*.typ tests/*.typ tests/*/test.typ"

# Compile all gallery demos
all:
    #!/bin/bash
    echo "Compiling all gallery demos..."
    echo ""
    total_start=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
    count=0
    failed=0
    
    # Compile gallery demos
    for file in gallery/*.typ; do
        basename=$(basename "$file")
        echo "📄 Compiling $basename..."
        start_time=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
        if typst compile --root . "$file"; then
            end_time=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
            duration=$((end_time - start_time))
            echo "   ✅ Compiled in ${duration}ms"
            ((count++))
        else
            echo "   ❌ Compilation failed"
            ((failed++))
        fi
        echo ""
    done

    # Speaker-notes deck: build the pdfpc presenter artifacts. The 16:9 PDF is
    # compiled in the loop above; here we add the .pdfpc sidecar pdfpc reads, and
    # an inline-notes preview (notes beside each slide) for quick verification.
    echo "📝 Speaker notes: pdfpc sidecar + inline-notes preview..."
    # `typst query` is deprecated in favor of `typst eval --in`, but `eval` was
    # added after our 0.14.0 floor — `query` works on 0.14.0+, so keep it (it
    # only warns on newer Typst). Switch to `eval` once the floor rises past it.
    if typst query --root . gallery/speaker-notes.typ --field value --one "<pdfpc-file>" > gallery/speaker-notes.pdfpc; then
        echo "   ✅ gallery/speaker-notes.pdfpc  (try it: pdfpc gallery/speaker-notes.pdf)"
    else
        echo "   ❌ pdfpc sidecar export failed"; ((failed++))
    fi
    if typst compile --root . --input notes=true gallery/speaker-notes.typ gallery/speaker-notes-notes.pdf; then
        echo "   ✅ gallery/speaker-notes-notes.pdf  (notes rendered inline)"
    else
        echo "   ❌ inline-notes preview failed"; ((failed++))
    fi
    echo ""

    total_end=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
    total_duration=$((total_end - total_start))
    
    if [ $failed -eq 0 ]; then
        echo "🚀 All $count demos compiled successfully in ${total_duration}ms total!"
        echo "📁 Check gallery/ for generated PDFs"
    else
        echo "⚠️  $count compiled successfully, $failed failed (${total_duration}ms total)"
        echo "❌ Check error messages above for details"
        exit 1
    fi

# Run tytanic test suite (compile-only tests for all theme features)
test:
    tt run --use-system-fonts

# Run tytanic tests with verbose output
test-verbose:
    tt run --use-system-fonts -v

# Format all Typst source files with typstyle
format:
    typstyle -i {{ typst_sources }}

# Check formatting without modifying files
format-check:
    typstyle --check {{ typst_sources }}

# Compile every gallery deck AND every test with whatever `typst` is on PATH,
# discarding output. CI runs this once per Typst version in the matrix.
# tytanic embeds its own Typst, so `just test` pins one version no matter what
# is installed — this recipe is the only thing that proves version compatibility.
compile-check:
    #!/usr/bin/env bash
    set -uo pipefail
    echo "$(typst --version)"
    rc=0
    out=$(mktemp -d)
    trap 'rm -rf "$out"' EXIT
    for f in gallery/*.typ tests/*/test.typ; do
        if typst compile --root . "$f" "$out/out.pdf" >/dev/null 2>/tmp/typst-compile-err; then
            printf '  ✅ %s\n' "$f"
        else
            printf '  ❌ %s\n' "$f"
            grep '^error' /tmp/typst-compile-err | head -3
            rc=1
        fi
    done
    exit "$rc"

# Check every @preview dependency against the latest Typst Universe release.
# Shipped deps (bypst.typ, src/, template/) are an ERROR when stale — the
# typst/packages CI flags them on the release PR. Gallery/test deps only WARN:
# they never enter the bundle, so they cannot block a release.
check-deps:
    #!/usr/bin/env bash
    set -uo pipefail
    command -v jq >/dev/null || { echo "❌ jq is required"; exit 1; }
    index=$(mktemp)
    trap 'rm -f "$index"' EXIT
    curl -sSfL https://packages.typst.org/preview/index.json -o "$index" \
      || { echo "❌ could not fetch the Typst Universe index"; exit 1; }
    floor=$(grep -oE '^compiler = "[0-9.]+"' typst.toml | grep -oE '[0-9.]+')
    echo "Typst floor (typst.toml compiler): $floor"
    echo ""
    rc=0
    # True when $1 <= $2 as semver.
    ver_le() { [ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | head -1)" = "$1" ]; }
    scan() {
        local label="$1" mode="$2"
        shift 2
        echo "$label"
        while IFS=: read -r pkg ver; do
            name="${pkg#@preview/}"
            [ "$name" = "bypst" ] && continue
            # Newest release overall, and newest whose own compiler requirement
            # still fits our floor. Upgrading past the latter would break the
            # floor, so it — not the absolute newest — is the target.
            newest=$(jq -r --arg n "$name" '.[] | select(.name==$n) | .version' "$index" | sort -V | tail -1)
            best=""
            while read -r v c; do
                if [ "$c" = "null" ] || ver_le "$c" "$floor"; then best="$v"; fi
            done < <(jq -r --arg n "$name" '.[] | select(.name==$n) | "\(.version) \(.compiler)"' "$index" | sort -V)
            if [ -z "$newest" ]; then
                echo "  ⚠️  $name $ver — not found in the index"
            elif [ "$ver" = "$best" ]; then
                if [ "$newest" != "$best" ]; then
                    blocked=$(jq -r --arg n "$name" --arg v "$newest" '.[] | select(.name==$n and .version==$v) | .compiler' "$index")
                    echo "  ✅ $name $ver (newest is $newest, needs Typst $blocked — held by our $floor floor)"
                else
                    echo "  ✅ $name $ver"
                fi
            elif [ "$mode" = error ]; then
                echo "  ❌ $name $ver → $best"
                rc=1
            else
                echo "  ⚠️  $name $ver → $best"
            fi
        done < <(grep -rhoE '@preview/[a-z0-9-]+:[0-9]+\.[0-9]+\.[0-9]+' "$@" 2>/dev/null | sort -u)
    }
    scan "Shipped (must be current):" error bypst.typ src template
    echo ""
    scan "Gallery/tests (advisory):" warn gallery tests
    echo ""
    if [ "$rc" -ne 0 ]; then
        echo "❌ a shipped dependency is out of date — update it before publishing"
    else
        echo "✅ all shipped dependencies are at their latest release"
    fi
    exit "$rc"

# Install package locally for development
install:
    tyler build . --no-bump --install --no-check

# Clean all generated PDFs
clean:
    rm -f *.pdf gallery/*.pdf tests/*.pdf gallery/*.pdfpc

# --- Release ---

# Pre-release gate: tests + format-check + all gallery demos compile (no install needed)
release-check:
    just test
    just format-check
    just check-deps
    just all
    @echo "✅ release-check passed"

# Set the package version everywhere (typst.toml + import refs). Usage: just set-version 0.5.0
set-version VERSION:
    perl -i -pe 's/^version = "[^"]*"/version = "{{VERSION}}"/' typst.toml
    perl -i -pe 's{bypst:\d+\.\d+\.\d+}{bypst:{{VERSION}}}g' README.md gallery/README.md template/basic.typ template/complete.typ
    @echo 'Version set to {{VERSION}} — verify: grep -rn "bypst:" README.md gallery/README.md template/ ; grep "^version" typst.toml'

# Publish to Typst Universe (opens/updates the typst/packages PR). Needs tyler >=0.10 + GitHub auth.
publish:
    tyler build . --no-bump --publish

# Print the ordered release checklist (human-judgment steps stay manual).
release:
    @echo "Release checklist (publish to Typst Universe first, then tag):"
    @echo "  1. just set-version X.Y.Z   — bump typst.toml + all import refs"
    @echo "  2. Edit CHANGELOG.md: move [Unreleased] -> [X.Y.Z] - DATE, update compare links"
    @echo "  3. just release-check       — tests + format-check + gallery all green"
    @echo "  4. Commit the release changes, then merge to main"
    @echo "  5. just publish             — tyler build --no-bump --publish (opens typst/packages PR)"
    @echo "  6. Wait for the typst/packages PR checks; fix + re-run 'just publish' if flagged"
    @echo "  7. Only once the published commit is final: tag + GitHub release"
    @echo "       git tag -a vX.Y.Z -m 'Release vX.Y.Z' && git push origin vX.Y.Z"
    @echo "       gh release create vX.Y.Z"
