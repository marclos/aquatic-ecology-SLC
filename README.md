# ESA 2026 Aquatic Ecology Guide — Quarto site

This is a small Quarto **website** project with three pages:

- `index.qmd` — landing page
- `detailed.qmd` — every aquatic-ecology talk/poster, sorted by date/time/room
- `highlevel.qmd` — Symposia/Special/Organized/Workshop/Inspire sessions on aquatic ecology

## Render locally in RStudio

1. Put this whole folder somewhere on disk and open it as a Project in RStudio (or just open the folder — RStudio detects `_quarto.yml` and shows a **Build** tab).
2. Make sure you have the [Quarto CLI](https://quarto.org/docs/get-started/) installed (RStudio ≥ 2022.07 bundles it, but `quarto --version` in the R console/terminal confirms).
3. In the RStudio **Build** tab, click **Render Website** (or run `quarto render` in the terminal from this folder).
4. Rendered HTML lands in `docs/` (set via `output-dir: docs` in `_quarto.yml`) — this is the folder GitHub Pages will serve.
5. Preview locally with `quarto preview` before publishing.

## Publish to GitHub Pages

1. Push this whole repo (including the rendered `docs/` folder) to GitHub.
2. In the repo settings → **Pages**, set:
   - **Source:** `Deploy from a branch`
   - **Branch:** `main` (or whichever), folder **`/docs`**
3. Save — GitHub will publish the site at `https://<username>.github.io/<repo>/` within a minute or two.
4. Any time you edit a `.qmd` file, re-run `quarto render`, commit the updated `docs/` folder, and push again.

(Alternative: use `quarto publish gh-pages` from the terminal, which creates/updates a `gh-pages` branch for you automatically instead of using the `/docs` folder approach — either works, just pick one.)
