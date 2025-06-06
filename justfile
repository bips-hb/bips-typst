# BIPS Typst Theme

# Compile all demos including top-level demo
all:
    #!/bin/bash
    echo "Compiling all demos (showing Typst's speed!)..."
    echo ""
    total_start=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
    count=0
    failed=0
    
    # Compile top-level demo first
    echo "📄 Compiling demo-bips.typ..."
    start_time=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
    if typst compile demo-bips.typ; then
        end_time=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
        duration=$((end_time - start_time))
        echo "   ✅ Compiled in ${duration}ms"
        ((count++))
    else
        echo "   ❌ Compilation failed"
        ((failed++))
    fi
    echo ""
    
    # Compile gallery demos
    for file in gallery/*.typ; do
        basename=$(basename "$file")
        # Skip the theme file itself  
        if [[ "$basename" == "bips-theme.typ" ]]; then
            continue
        fi
        echo "📄 Compiling $basename..."
        start_time=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
        if typst compile "$file"; then
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
        echo "⚡ LaTeX would take minutes, Typst took under a second."
        echo "📁 Check gallery/ and root directory for generated PDFs"
    else
        echo "⚠️  $count compiled successfully, $failed failed (${total_duration}ms total)"
        echo "❌ Check error messages above for details"
        exit 1
    fi

# Run comprehensive test suite
test:
    #!/bin/bash
    echo "🧪 Running BIPS Theme Test Suite..."
    
    # Compile test suite
    typst compile tests/test-suite.typ tests/test-suite.pdf
    
    if [ $? -ne 0 ]; then
        echo "❌ Test suite compilation failed!"
        exit 1
    fi
    
    # Get page count
    PAGES=$(pdfinfo tests/test-suite.pdf | grep Pages | awk '{print $2}')
    echo "📄 Total pages generated: $PAGES"
    
    # Expected range (rough estimate)
    MIN_EXPECTED=11
    MAX_EXPECTED=13
    
    if [ $PAGES -ge $MIN_EXPECTED ] && [ $PAGES -le $MAX_EXPECTED ]; then
        echo "✅ Page count within expected range ($MIN_EXPECTED-$MAX_EXPECTED)"
    else
        echo "⚠️  Page count outside expected range ($MIN_EXPECTED-$MAX_EXPECTED)"
        echo "   This might indicate spurious pages or content overflow"
    fi
    
    # Quick content check for spurious blanks
    echo "🔍 Checking for potential issues..."
    
    # Extract text and count test sections
    TEST_SECTIONS=$(pdftotext -layout tests/test-suite.pdf - | grep -E "Test [1-7]:" | wc -l)
    echo "📝 Found $TEST_SECTIONS test sections"
    
    # Check footnote behavior
    FOOTNOTE_MENTIONS=$(pdftotext tests/test-suite.pdf - | grep -c "footnote")
    echo "📋 Footnote references found: $FOOTNOTE_MENTIONS"
    
    echo "🏁 Test suite complete. Manual review recommended for:"
    echo "   - Logo placement on all slides"  
    echo "   - Page number progression"
    echo "   - Footnote placement (bottom of correct slides)"
    echo "   - No blank pages between animation states"
    echo "📁 Test output: tests/test-suite.pdf"

# Clean all generated PDFs
clean:
    rm -f *.pdf gallery/*.pdf test/*.pdf
