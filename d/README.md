# GitHub Pages tree (`repo a` `d/`)

Static assets and bundle payloads served under **`https://aoponomarev.github.io/a/d/`**.

| Path | Role |
| --- | --- |
| **`icons/`** | FA6 / Fluent SVG SSOT → PF **`main-vue/public/icons/`** via **`npm run android-shell:bundle:vue:build`** (**`#for-mob-ui-app-icons-repo-a-d-ico`**). |
| **`fonts/`** | Self-hosted **`woff2`** (Roboto Condensed subsets, Material Icons) → PF **`main-vue/public/fonts/`** (**`#for-mob-ui-bundle-fonts-repo-a-d-fonts`**). |
| **`img/`** | Atom-layer raster/SVG for **`AImage`**: HTTPS **`https://…/a/d/img/…`** (**`#for-mob-ui-tatc-atoms-remote-img`**) and/or **`./img/…`** in the shipped zip (**`#for-mob-ui-bundle-img-repo-a-d-img`**) → PF **`main-vue/public/img/`**. |
| **`a/`** | Signed shell **`manifest.json`** + **`v/<YYMMDDNN>.zip`**. |
| **`index.html`** | Gitignored workstation smoke shell (PF **`npm run android-shell:dev-browser`**). **`./icons/*`**/**`./img/*`**/**`url(fonts/*)`** → **`d/icons/`**, **`d/img/`**, **`d/fonts/`** (same repo SSOT paths). |
