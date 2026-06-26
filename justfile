# bypst — BIPS Presentation Theme

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
    typstyle -i *.typ
    typstyle -i gallery/*.typ
    typstyle -i tests/*/test.typ

# Check formatting without modifying files
format-check:
    typstyle --check *.typ

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
