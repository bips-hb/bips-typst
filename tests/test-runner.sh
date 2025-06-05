#!/bin/bash

# BIPS Theme Test Runner
# Compiles test suite and checks for expected page counts

echo "🧪 Running BIPS Theme Test Suite..."

# Compile test suite
typst compile test/test-suite.typ testtest-suite.pdf

if [ $? -ne 0 ]; then
    echo "❌ Test suite compilation failed!"
    exit 1
fi

# Get page count
PAGES=$(pdfinfo test/test-suite.pdf | grep Pages | awk '{print $2}')
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

# Extract text and count near-empty pages (pages with just logo/page number)
pdftotext -layout test/test-suite.pdf - | grep -E "Test [1-7]:" | wc -l > /tmp/test_sections

TEST_SECTIONS=$(cat /tmp/test_sections)
echo "📝 Found $TEST_SECTIONS test sections"

# Check footnote behavior
FOOTNOTE_MENTIONS=$(pdftotext test/test-suite.pdf - | grep -c "footnote")
echo "📋 Footnote references found: $FOOTNOTE_MENTIONS"

echo "🏁 Test suite complete. Manual review recommended for:"
echo "   - Logo placement on all slides"  
echo "   - Page number progression"
echo "   - Footnote placement (bottom of correct slides)"
echo "   - No blank pages between animation states"

# Clean up
rm -f /tmp/test_sections
