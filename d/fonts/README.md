# Self-hosted fonts (WebView Presentation Layer)

SSOT for `woff2` / TTF shipped next to `index.html` in the signed bundle (`url(fonts/…)` in CSS). Mirrored into PF `devices/android/bundle-src/main-vue/public/fonts/` before `vite build` (`#for-mob-ui-bundle-fonts-repo-a-d-fonts`).

**Mobile shell glyphs** (FAB, `ASymbol` / `TokenIconsRows`) use **only** these font files — Fluent-style glyphs come from `SegoeFluentIcons.woff2` (Segoe MDL v2 redistribution under Windows font-license terms applied to bundled copies for WebView `file:` parity), **not** from a sibling SVG repo tree.

| File | Source / license | Notes |
| --- | --- | --- |
| `roboto-condensed-*.woff2` | Fontdelivery / bundler subset | Log + `font/minimal` column |
| `MaterialSymbolsOutlined-mob-ui.ttf` | [Material Symbols Outlined](https://fonts.google.com/icons) (Apache 2.0) | Unified mob-ui subset; manifest `is/contracts/mobile-ui-material-glyphs.json`; regen `npm run android-shell:material-glyphs:subset` |
| `fa-solid-900.woff2` | [Font Awesome Free 6](https://fontawesome.com/) (Icons: CC BY 4.0; Fonts: SIL OFL 1.1) | **Solid** PUA stack (`font-weight` **900**) for TATC FA row |
| `fa-regular-400.woff2` | [Font Awesome Free 6](https://fontawesome.com/) (same license) | **Regular** PUA stack (`font-weight` **400**); `tatc-icons__radio` uses `circle` (**U+F111**) |
| `fa-brands-400.woff2` | [Font Awesome Free 6](https://fontawesome.com/) (same license) | **Brands** PUA stack (`font-weight` **400**); OAuth marks e.g. Google (**U+F1A0**) |
| `SegoeFluentIcons.woff2` | Segoe Fluent Icons (**Segoe MDL 2 Assets System**); redistribution per Microsoft supplemental font-license terms bundled with `SegoeFluentIcons.license.txt` | PUA Fluent-style glyphs (`fluent()` mixin, shell nav, search, close tiles) |

**Material mob-ui glyph inventory (PUA):** caret U+E5C5, num-sort U+E5D7, help U+E887, ok U+E86C, back U+E5C4, next U+E5C8, slide U+E8D5, logout U+E9BA, drag-indicator U+E945, brick U+F388. Style contract: Outlined, FILL=0, wght=400, opsz=24.
