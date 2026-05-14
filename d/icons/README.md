# Application icons (repo **a**)

Canonical storage for WebView bundle icons **regardless of format** (SVG today; PNG/WebP allowed).

Consumed by **mmb** `npm run android-shell:bundle:vue:build`: `build-vue-bundle.js` mirrors **`fa6/`** and **`fluent/`** into `devices/android/bundle-src/main-vue/public/icons/` before Vite.

Layout:

- `fa6/` — Font Awesome Free 6 SVG glyphs referenced by `ASymbol.vue`
- `fluent/` — Fluent UI System Icons (MIT) stand-ins for Segoe in offline zip

Self-hosted **`woff2`** fonts SSOT: sibling **`../fonts/`** (mirrored into **`main-vue/public/fonts/`** and zip-root **`fonts/`** per **`#for-mob-ui-bundle-fonts-repo-a-d-fonts`**).
