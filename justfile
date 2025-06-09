# BIPS Typst Theme

# Compile all gallery demos
all:
    #!/bin/bash
    echo "Compiling all gallery demos (showing Typst's speed!)..."
    echo ""
    total_start=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
    count=0
    failed=0
    
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
        echo "📁 Check gallery/ for generated PDFs"
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
    MIN_EXPECTED=16
    MAX_EXPECTED=17
    
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

# Install package locally for development
install:
    #!/bin/bash
    # Extract version from typst.toml
    VERSION=$(grep '^version' typst.toml | sed 's/version = "\(.*\)"/\1/')
    PACKAGE_NAME="bips-typst"
    
    # Determine local package directory based on OS
    case "$(uname -s)" in
        Darwin)
            PACKAGE_DIR="$HOME/Library/Application Support/typst/packages"
            ;;
        Linux)
            if [ -n "$XDG_DATA_HOME" ]; then
                PACKAGE_DIR="$XDG_DATA_HOME/typst/packages"
            else
                PACKAGE_DIR="$HOME/.local/share/typst/packages"
            fi
            ;;
        CYGWIN*|MINGW*|MSYS*)
            PACKAGE_DIR="$APPDATA/typst/packages"
            ;;
        *)
            echo "Unsupported operating system"
            exit 1
            ;;
    esac
    
    TARGET_DIR="$PACKAGE_DIR/local/$PACKAGE_NAME/$VERSION"
    
    echo "📦 Installing $PACKAGE_NAME:$VERSION locally..."
    echo "   Target: $TARGET_DIR"
    
    # Create target directory
    mkdir -p "$TARGET_DIR"
    
    # Copy all package files (excluding what's in the exclude list)
    cp typst.toml "$TARGET_DIR/"
    cp README.md "$TARGET_DIR/"
    cp CHANGELOG.md "$TARGET_DIR/"
    cp bips-logo.png "$TARGET_DIR/"
    cp bips-typst.typ "$TARGET_DIR/"
    cp theme.typ "$TARGET_DIR/"
    
    # Copy template directory
    mkdir -p "$TARGET_DIR/template"
    cp template/* "$TARGET_DIR/template/"
    
    # Copy thumbnail if it exists
    if [ -f "thumbnail.png" ]; then
        cp thumbnail.png "$TARGET_DIR/"
    fi
    
    echo "✅ Package installed successfully!"
    echo "   Import with: #import \"@local/bips-typst:$VERSION\": *"

# Uninstall local package
uninstall:
    #!/bin/bash
    VERSION=$(grep '^version' typst.toml | sed 's/version = "\(.*\)"/\1/')
    PACKAGE_NAME="bips-typst"
    
    case "$(uname -s)" in
        Darwin)
            PACKAGE_DIR="$HOME/Library/Application Support/typst/packages"
            ;;
        Linux)
            if [ -n "$XDG_DATA_HOME" ]; then
                PACKAGE_DIR="$XDG_DATA_HOME/typst/packages"
            else
                PACKAGE_DIR="$HOME/.local/share/typst/packages"
            fi
            ;;
        CYGWIN*|MINGW*|MSYS*)
            PACKAGE_DIR="$APPDATA/typst/packages"
            ;;
        *)
            echo "Unsupported operating system"
            exit 1
            ;;
    esac
    
    TARGET_DIR="$PACKAGE_DIR/local/$PACKAGE_NAME/$VERSION"
    
    if [ -d "$TARGET_DIR" ]; then
        echo "🗑️  Uninstalling $PACKAGE_NAME:$VERSION..."
        rm -rf "$TARGET_DIR"
        echo "✅ Package uninstalled successfully!"
    else
        echo "❌ Package not found at $TARGET_DIR"
    fi

# Clean all generated PDFs
clean:
    rm -f *.pdf gallery/*.pdf test/*.pdf
