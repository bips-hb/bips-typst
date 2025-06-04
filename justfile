# BIPS Typst Theme

# Compile all gallery demos
all:
    #!/bin/bash
    echo "Compiling all gallery demos (showing Typst's speed!)..."
    echo ""
    total_start=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
    count=0
    for file in gallery/*.typ; do
        basename=$(basename "$file")
        # Skip the theme file itself  
        if [[ "$basename" == "bips-theme.typ" ]]; then
            continue
        fi
        echo "📄 Compiling $basename..."
        start_time=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
        typst compile "$file"
        end_time=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
        duration=$((end_time - start_time))
        echo "   ✅ Compiled in ${duration}ms"
        echo ""
        ((count++))
    done
    total_end=$(gdate +%s%3N 2>/dev/null || date +%s%3N)
    total_duration=$((total_end - total_start))
    echo "🚀 All $count demos compiled in ${total_duration}ms total!"
    echo "⚡ LaTeX would take minutes, Typst took under a second."
    echo "📁 Check gallery/ for generated PDFs"

# Clean all generated PDFs
clean:
    rm -f *.pdf gallery/*.pdf