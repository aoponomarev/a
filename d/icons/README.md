# Application icons (repo **a**)

Canonical storage for WebView bundle icons **regardless of format** (SVG today; PNG/WebP allowed).

Consumed by **mmb** `npm run android-shell:bundle:vue:build`: `build-vue-bundle.js` mirrors this tree into `devices/android/bundle-src/main-vue/public/` before Vite (`icons/fa6`, `icons/fluent`, `atoms`).

Layout:

- `fa6/` — Font Awesome Free 6 SVG atoms referenced by `ASymbol.vue`
- `fluent/` — Fluent UI System Icons (MIT) stand-ins for Segoe in offline zip
- `atoms/` — Raster/vector paired with `a/image` when shipped inside zip (e.g. `logo-mmb.svg`)

Fonts remain under **PF** `main-vue/public/fonts/` (not icons).
