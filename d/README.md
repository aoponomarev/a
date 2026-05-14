# GitHub Pages tree (`repo a` `d/`)

Static assets and bundle payloads served under **`https://aoponomarev.github.io/a/d/`**.

| Path | Role |
| --- | --- |
| **`icons/`** | FA6 / Fluent / atoms SVG SSOT → PF **`main-vue/public/`** (`icons/`, `atoms/`) via **`npm run android-shell:bundle:vue:build`** (**`#for-mob-ui-app-icons-repo-a-d-ico`**). |
| **`fonts/`** | Self-hosted **`woff2`** (Roboto Condensed subsets, Material Icons) → PF **`main-vue/public/fonts/`** (**`#for-mob-ui-bundle-fonts-repo-a-d-fonts`**). |
| **`img/`** | Atom-layer raster/SVG for **`AImage`** absolute HTTPS (**`https://…/a/d/img/…`**, **`#for-mob-ui-tatc-atoms-remote-img`**). |
| **`a/`** | Signed shell **`manifest.json`** + **`v/<YYMMDDNN>.zip`**. |
| **`dev/`** | Gitignored workstation smoke (PF **`npm run android-shell:dev-browser`**) — **`index.html`** plus mirrored **`icons/`**, **`fonts/`**, **`atoms/`**. |
