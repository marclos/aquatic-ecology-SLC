#!/usr/bin/env bash
# Renders the full site (HTML -> docs/) plus both PDF versions, then copies
# the PDFs into docs/ so they sit alongside the HTML and get published too.
set -e

echo "Clearing any stale Quarto cache..."
rm -rf .quarto

echo "Rendering website (HTML -> docs/)..."
quarto render

echo "Rendering detailed.qmd -> PDF..."
quarto render detailed.qmd --to pdf --pdf-engine=pdflatex

echo "Rendering highlevel.qmd -> PDF..."
quarto render highlevel.qmd --to pdf --pdf-engine=pdflatex

echo "Making sure PDFs are in docs/..."
# Quarto may drop these next to the .qmd source, or directly into docs/,
# depending on version/setup. Handle both without erroring either way.
for f in detailed.pdf highlevel.pdf; do
  if [ -f "docs/$f" ]; then
    echo "  $f already in docs/"
  elif [ -f "$f" ]; then
    cp "$f" "docs/$f"
    echo "  copied $f into docs/"
  else
    echo "  WARNING: $f not found in project root or docs/ -- check the render output above for errors"
  fi
done

echo "Done. docs/ now contains the HTML site plus detailed.pdf and highlevel.pdf."
