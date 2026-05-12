# Static images for WebView Presentation Layer

Raster/SVG referenced by the signed shell bundle via absolute HTTPS (see id:ais-9b7c4d, `#for-mob-ui-tatc-atoms-remote-img`):

- `https://aoponomarev.github.io/a/d/img/ui-keyboard.png`
- `https://aoponomarev.github.io/a/d/img/logo-mmb.svg`

Canonical edits live in repo **mmb** at `devices/android/bundle-src/main-vue/src/assets/atoms/`; `publish-bundle.ps1` copies them here on each bundle publish so GitHub Pages stays aligned with the zip.

To refresh from **Figma** (same pixels as prototype `392:4875`): run MCP `get_design_context` on nodes `316:10149` (keyboard) and `316:10151` (logo), take the `figma.com/api/mcp/asset/<uuid>` URLs from the response, `Invoke-WebRequest` into `src/assets/atoms/` in **mmb**; for SVG, replace `fill="var(--fill-0, #…)"` with fixed `#008800` / `#AA0044` so `file://` / static hosting resolve colors without Figma CSS variables.
