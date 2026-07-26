# ESA 2026 Aquatic Ecology Guide — Quarto site

This is a small Quarto **website** project with three pages:

- `index.qmd` — landing page
- `detailed.qmd` — every aquatic-ecology talk/poster, sorted by date/time/room
- `highlevel.qmd` — Symposia/Special/Organized/Workshop/Inspire sessions on aquatic ecology

The two content pages read their data from `data/detailed.csv` and
`data/highlevel.csv` and render it with an R chunk using **kableExtra**
(striped rows, repeated header on each page in PDF, fixed column widths).

## R packages required

```r
install.packages(c("readr", "knitr", "kableExtra"))
```

## Why the Jekyll build failed

GitHub Pages (in "Deploy from a branch" mode) just serves whatever static files
are already sitting in your repo — it never runs Quarto for you. If you push
the `.qmd` source files without first rendering, there's no `docs/` folder in
the repo, GitHub's Jekyll step tries to `cd` into it, and you get exactly the
error you saw (`No such file or directory ... /docs`).

There are two ways to fix this. **Option A (GitHub Actions) is recommended** —
it renders automatically on every push, so you never have to remember to
render locally again.

## Option A: Auto-render with GitHub Actions (recommended)

This repo includes `.github/workflows/publish.yml`, which renders the site
with Quarto and deploys it on every push to `main`.

1. Push this whole folder (including `.github/workflows/publish.yml`) to your
   GitHub repo.
2. In the repo, go to **Settings → Pages** and set:
   - **Source:** `GitHub Actions` (not "Deploy from a branch")
3. Push a commit (or go to the **Actions** tab and run the workflow manually)
   — it will render the site and publish it.
4. Your site will be live at `https://<username>.github.io/<repo>/`.

With this option you don't need to commit a `docs/` folder at all — Actions
builds it fresh on GitHub's servers each time. `output-dir: docs` in
`_quarto.yml` is only used as Actions' internal build location in this setup.

## Option B: Render locally, then push

If you'd rather not use Actions:

1. Open this folder as a Project in RStudio (it detects `_quarto.yml` and
   adds a **Build** tab), or just use a terminal with Quarto installed.
2. Click **Render Website** in RStudio's Build tab, or run:
   ```
   quarto render
   ```
3. Confirm a `docs/` folder now exists and contains `index.html`,
   `detailed.html`, `highlevel.html`, plus a `.nojekyll` file (Quarto adds
   this automatically for git-tracked projects, which tells GitHub Pages to
   skip the Jekyll build entirely).
4. Commit **both** the source files and the rendered `docs/` folder, and push.
5. In **Settings → Pages**, set:
   - **Source:** `Deploy from a branch`
   - **Branch:** `main`, folder **`/docs`**
6. Every time you edit a `.qmd` file, re-render, commit the updated `docs/`
   folder, and push again.

## Rendering to PDF

Both `detailed.qmd` and `highlevel.qmd` render their tables through R +
kableExtra, with striped rows, a repeated header on every page, and fixed
column widths (landscape orientation, small font since these are wide data
tables). A couple of things to know:

- **Forced to `pdf-engine: pdflatex`.** Both pages set this explicitly in their
  YAML. Without it, Quarto defaults to `lualatex`, which crashes on some older
  system-wide TeX Live installs (specifically TeX Live 2018) with a
  `microtype.lua: attempt to call field 'warning' (a nil value)` error —
  a known incompatibility between that TeX Live version's `microtype` package
  and its bundled LuaTeX. `pdflatex` doesn't use microtype's Lua module at
  all, so it sidesteps the bug entirely. If you ever see that specific error
  again, this setting is the fix.
- **PDF rendering needs LaTeX.** If you don't already have it, install
  [TinyTeX](https://quarto.org/docs/output-formats/pdf-engine.html) once via
  the R console:
  ```r
  tinytex::install_tinytex()
  ```
- **PDF output location can vary.** Sometimes Quarto drops `detailed.pdf` next
  to the `.qmd` source in the project root; sometimes (e.g. after a full
  `quarto render` has already run) it goes straight into `docs/`. Both have
  been observed. `render_all.sh` (and the GitHub Actions workflow) handle
  either case automatically — they check `docs/` first, and only copy from
  the project root if the PDF isn't already there.
- **Easiest fix: use `render_all.sh`.** This repo includes a script that
  renders the website, renders both PDFs, and makes sure both end up in
  `docs/` in one go.
  ```
  ./render_all.sh
  ```
  Run this instead of clicking Render on each file individually. The GitHub
  Actions workflow does the equivalent automatically on every push.
- **I couldn't test-render this myself** — R isn't available in the sandbox
  I write these files in, so I can't confirm the LaTeX output looks exactly
  right end-to-end. If the table overflows the page width or the striping
  looks off, the most likely fixes are: lowering `fontsize` in the YAML,
  adjusting the `column_spec(...)` widths in the R chunk (they need to sum to
  a bit less than the usable page width — roughly 10.2in for detailed.qmd's
  0.4in margins, 10.0in for highlevel.qmd's), or running
  `tinytex::tlmgr_install("booktabs")` if you get a missing-package LaTeX
  error.

## Local preview

Either way, you can preview the website before publishing with:
```
quarto preview
```
