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

echo "Copying PDFs into docs/..."
cp detailed.pdf docs/detailed.pdf
cp highlevel.pdf docs/highlevel.pdf

echo "Done. docs/ now contains the HTML site plus detailed.pdf and highlevel.pdf."
