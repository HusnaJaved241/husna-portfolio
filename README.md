# Husna's Portfolio — Flutter (Web + Mobile)

A cross-platform portfolio app built in Flutter, showcasing teaching
materials, certificates, and technical/data projects. Deploys to
GitHub Pages as a static web app, and can also run as an Android app.

---

## 1. Run it locally (preview before deploying)

You already have Flutter installed (from your finance app project), so:

```bash
cd husna_portfolio
flutter pub get
flutter run -d chrome
```

This opens the portfolio in Chrome so you can see it live and make changes.

---

## 2. Add your real content

Open **`lib/data/portfolio_data.dart`**. This single file holds everything:

- Your name, tagline, and intro paragraph
- `teachingItems` — lesson plans, worksheets, activities, presentations
- `techProjects` — your ICU dashboard, this portfolio, your finance app
- `certificates` — appreciation letters and certificates
- Your LinkedIn, GitHub, email, and CV download links

**For file links (lesson plans, certificates, etc.):**
The easiest approach — upload your PDFs/PPTs into the repo itself under a
new folder, e.g. `assets/docs/`, then link to them like:

```
https://github.com/yourusername/portfolio/raw/main/assets/docs/binary-numbers.pdf
```

Or upload to Google Drive, set sharing to "Anyone with the link," and paste
that link in instead. Either works — Drive is faster to set up, GitHub
keeps everything in one place.

**For images/thumbnails:** drop image files into `assets/images/` and
reference them via `thumbnailAsset` in the data file (image rendering
wiring can be added once you have real images — ask me when you're ready).

---

## 3. Push to GitHub

```bash
cd husna_portfolio
git init
git add .
git commit -m "Initial portfolio"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git push -u origin main
```

---

## 4. Update the base-href in the workflow (IMPORTANT)

Open **`.github/workflows/deploy.yml`** and replace:

```
--base-href "/REPLACE_WITH_REPO_NAME/"
```

with your actual repo name, e.g. if your repo is `husna-portfolio`:

```
--base-href "/husna-portfolio/"
```

This must match exactly or your deployed site will show a blank page.

---

## 5. Enable GitHub Pages

1. Go to your repo on GitHub → **Settings** → **Pages**
2. Under "Build and deployment", set **Source** to **GitHub Actions**
3. Push any commit to `main` (or go to the **Actions** tab and manually
   run the "Deploy Flutter Web to GitHub Pages" workflow)
4. After it finishes (1-3 minutes), your site will be live at:

```
https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/
```

That's the link to put on your CV.

---

## 6. Every time you update content

```bash
git add .
git commit -m "Update portfolio content"
git push
```

GitHub Actions will automatically rebuild and redeploy. No manual steps.

---

## Project structure

```
lib/
  main.dart                    # Entry point
  theme/app_theme.dart         # Colors, gradients, text styles
  models/portfolio_models.dart # Data shapes (TeachingItem, TechProject, Certificate)
  data/portfolio_data.dart     # <-- YOUR CONTENT GOES HERE
  widgets/
    hero_section.dart          # Top banner with name + intro
    teaching_section.dart      # Filterable teaching portfolio grid
    tech_projects_section.dart # ICU dashboard, this site, finance app
    certificates_section.dart  # Appreciation certificates
    footer_section.dart        # Contact links
    section_header.dart        # Reusable section title component
    gradient_card.dart         # Reusable card component
  screens/home_screen.dart     # Assembles all sections, handles scroll-to-section
```

---

## Notes

- The "Available for opportunities in KSA" badge in the hero section
  is hardcoded — update or remove it in `hero_section.dart` if needed.
- The site is fully responsive — mobile breakpoint is set at 700px width
  across all sections.
- To also ship this as an Android app (since it's Flutter), run:
  `flutter build apk --release` — same codebase, no extra work needed.
