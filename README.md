# ESA 2026 Aquatic Ecology Guide — Quarto site

This is a small Quarto **website** project with three pages:

- `index.qmd` — landing page
- `detailed.qmd` — every aquatic-ecology talk/poster, sorted by date/time/room
- `highlevel.qmd` — Symposia/Special/Organized/Workshop/Inspire sessions on aquatic ecology

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

## Local preview

Either way, you can preview before publishing with:
```
quarto preview
```
