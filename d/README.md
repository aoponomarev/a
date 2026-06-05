# GitHub Pages tree (`repo a` `d/`)

Static assets and bundle payloads served under `https://aoponomarev.github.io/a/d/`.

| Path | Role |
| --- | --- |
| `fonts/` | Self-hosted `woff2` / TTF (Roboto Condensed subsets, Material Icons, Font Awesome 6 Free, Segoe Fluent Icons) → PF `main-vue/public/fonts/` (`#for-mob-ui-bundle-fonts-repo-a-d-fonts`). **Mobile shell glyphs use these fonts only** — no separate SVG icon tree. |
| `img/` | Atom-layer raster/SVG for `AImage`: HTTPS `https://…/a/d/img/…` (`#for-mob-ui-tatc-atoms-remote-img`) and/or `./img/…` in the shipped zip (`#for-mob-ui-bundle-img-repo-a-d-img`) → PF `main-vue/public/img/`. |
| `a/` | Signed shell `manifest.json` + `v/<YYMMDDNN>.zip`. |
| `mobile.html` | Gitignored workstation smoke shell (PF `npm run android-shell:dev-browser`). `./img/*` / `url(fonts/*)` resolve against `d/img/`, `d/fonts/` (same-repo SSOT). WebView zip root keeps `index.html`. |
