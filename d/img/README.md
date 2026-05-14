# Static images for WebView Presentation Layer

Sibling SSOT trees: **`../icons/`** (FA6 / Fluent SVG), **`../fonts/`** (offline **`woff2`**). This folder uses the **`img`** segment so **`https://…/a/d/img/<file>`** matches **`d/img/`** on disk (parallel to **`d/icons/`**, **`d/fonts/`**).

The same bytes ship next to inlined **`index.html`** as **`./img/<file>`** in the signed WebView zip when **mmb** runs **`npm run android-shell:bundle:vue:build`** (**`#for-mob-ui-bundle-img-repo-a-d-img`**), so **`src` may omit HTTPS** during **`file://`** work.

**Primary in shipped WebView / workstation `file:`:** `./img/ui-keyboard.png`, `./img/logo-mmb.svg` next to unpacked **`index.html`**.

Equivalent on GitHub Pages (optional when HTML has no sibling **`img/`** tree):

- `https://aoponomarev.github.io/a/d/img/ui-keyboard.png`
- `https://aoponomarev.github.io/a/d/img/logo-mmb.svg`

Canonical edits live in repo **mmb** at `devices/android/bundle-src/main-vue/src/assets/atoms/`; `publish-bundle.ps1` copies them here on each bundle publish so GitHub Pages stays aligned with the zip.

## Figma refresh (cropped Image fills)

**Important:** When a layer uses **Image → Crop** (or a clipped frame), URLs from `get_design_context` often point at the **full** underlying bitmap, not the cropped rectangle on the canvas (`#for-mob-ui-figma-raster-crop-parity`, id:sk-f3c8a1).

**Preferred:**

1. MCP **`get_screenshot`** on the visible node (e.g. `image=ui-keyboard` **316:10149**) with `maxDimension` large enough (≥ ~1024) so the PNG matches the frame; download the URL with `Invoke-WebRequest` → `mmb` `src/assets/atoms/ui-keyboard.png`.
2. Or export that node from Figma desktop.
3. Or accept an author-supplied crop PNG.

**Logo SVG:** `get_design_context` on **316:10151** is usually fine; replace `fill="var(--fill-0, #…)"` with fixed `#008800` / `#AA0044` for static hosting / `file://`.
