# Self-hosted fonts (WebView Presentation Layer)

SSOT for `woff2` / TTF shipped next to `index.html` in the signed bundle (`url(fonts/вЂ¦)` in CSS). Mirrored into PF `devices/android/bundle-src/main-vue/public/fonts/` before `vite build` (`#for-mob-ui-bundle-fonts-repo-a-d-fonts`).

**Mobile shell glyphs** (FAB, `ASymbol` / `TokenIconsRows`) use **only** these font files вЂ” Fluent-style glyphs come from `SegoeFluentIcons.woff2` (Segoe MDL v2 redistribution under Windows font-license terms applied to bundled copies for WebView `file:` parity), **not** from a sibling SVG repo tree.

| File | Source / license | Notes |
| --- | --- | --- |
| `roboto-condensed-*.woff2` | Fontdelivery / bundler subset | Log + `font/minimal` column |
| `MaterialIcons-Regular.woff2` | [Google Fonts / Material Icons](https://fonts.google.com/icons) (Apache 2.0) | Ligature icon font for TATC Material row |
| `fa-solid-900.woff2` | [Font Awesome Free 6](https://fontawesome.com/) (Icons: CC BY 4.0; Fonts: SIL OFL 1.1) | **Solid** PUA stack (`font-weight` **900**) for TATC FA row |
| `fa-regular-400.woff2` | [Font Awesome Free 6](https://fontawesome.com/) (same license) | **Regular** PUA stack (`font-weight` **400**); `tatc-icons__radio` uses `circle` (**U+F111**) |
| `SegoeFluentIcons.woff2` | Segoe Fluent Icons (**Segoe MDL 2 Assets System**); redistribution per Microsoft supplemental font-license terms bundled with `SegoeFluentIcons.license.txt` | PUA Fluent-style glyphs (`fluent()` mixin, shell nav, search, close tiles) |
