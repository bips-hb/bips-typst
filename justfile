# BIPS Typst Theme

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
    typstyle -i theme.typ bips-typst.typ
    typstyle -i gallery/*.typ
    typstyle -i tests/*/test.typ

# Check formatting without modifying files
format-check:
    typstyle --check theme.typ bips-typst.typ

# Install package locally for development
install:
    tyler build . --no-bump --install --no-check

# Clean all generated PDFs
clean:
    rm -f *.pdf gallery/*.pdf tests/*.pdf
