#!/usr/bin/env bash
set -euo pipefail

mkdir -p _site

# Use .fonts directory if present (CI downloads Fira fonts there)
font_args=()
if [ -d .fonts ]; then
  font_args=(--font-path .fonts)
fi

# Compile each gallery demo and generate a thumbnail
for src in gallery/*.typ; do
  name=$(basename "$src" .typ)
  echo "Compiling $name..."
  typst compile --root . "${font_args[@]}" "$src" "_site/${name}.pdf"
  pdftoppm -png -singlefile -r 150 "_site/${name}.pdf" "_site/${name}"
done

# Collect demo names for the HTML page
demos=()
for src in gallery/*.typ; do
  demos+=("$(basename "$src" .typ)")
done

# Generate index.html
cat > _site/index.html <<'HTMLHEAD'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BIPS Typst Gallery</title>
<style>
  *, *::before, *::after { box-sizing: border-box; }
  body {
    font-family: system-ui, -apple-system, sans-serif;
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem 1rem;
    color: #1a1a1a;
    background: #fafafa;
  }
  h1 {
    color: #1763aa;
    font-size: 1.8rem;
    margin-bottom: 0.3rem;
  }
  .subtitle {
    color: #555;
    margin-bottom: 2rem;
  }
  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 1.5rem;
  }
  .card {
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
    transition: box-shadow 0.2s;
  }
  .card:hover {
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }
  .card a {
    display: block;
    text-decoration: none;
    color: inherit;
  }
  .card img {
    width: 100%;
    display: block;
    border-bottom: 1px solid #eee;
  }
  .card .label {
    padding: 0.75rem 1rem;
    font-weight: 500;
    color: #1763aa;
  }
  footer {
    margin-top: 3rem;
    padding-top: 1rem;
    border-top: 1px solid #ddd;
    color: #777;
    font-size: 0.85rem;
  }
  footer a { color: #1763aa; }
</style>
</head>
<body>
<h1>BIPS Typst Gallery</h1>
<p class="subtitle">Preview of gallery demos — click a thumbnail to open the full PDF.</p>
<div class="grid">
HTMLHEAD

for name in "${demos[@]}"; do
  # Pretty-print the demo name: replace hyphens with spaces, title-case
  pretty=$(echo "$name" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')
  cat >> _site/index.html <<CARD
<div class="card">
  <a href="${name}.pdf">
    <img src="${name}.png" alt="${pretty}" loading="lazy">
    <div class="label">${pretty}</div>
  </a>
</div>
CARD
done

cat >> _site/index.html <<'HTMLFOOT'
</div>
<footer>
  Source: <a href="https://github.com/bips-hb/bips-typst">bips-hb/bips-typst</a>
</footer>
</body>
</html>
HTMLFOOT

echo "Gallery built: $(ls _site/*.pdf | wc -l) PDFs, $(ls _site/*.png | wc -l) thumbnails"
