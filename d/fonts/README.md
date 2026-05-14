# Self-hosted fonts (WebView Presentation Layer)

SSOT for **`woff2`** shipped next to **`index.html`** in the signed bundle (`url(fonts/…)` in CSS). Mirrored into PF **`devices/android/bundle-src/main-vue/public/fonts/`** before **`vite build`** (**`#for-mob-ui-bundle-fonts-repo-a-d-fonts`**).

| File | Source / license | Notes |
| --- | --- | --- |
| `roboto-condensed-*.woff2` | Fontdelivery / bundler subset | Log + `font/minimal` column |
| `MaterialIcons-Regular.woff2` | [Google Fonts / Material Icons](https://fonts.google.com/icons) (Apache 2.0) | Ligature icon font; required offline for TATC Material row |
| `fa-solid-900.woff2` | [Font Awesome Free 6](https://fontawesome.com/) (Icons: CC BY 4.0; Fonts: SIL OFL 1.1) | **Solid** PUA stack (**`font-weight`** **900**) for TATC FA row |
| `fa-regular-400.woff2` | [Font Awesome Free 6](https://fontawesome.com/) (same license) | **Regular** PUA stack (**`font-weight`** **400**); **`tatc-icons__radio`** same code point as **`circle`** (**U+F111**) |

Segoe Fluent Icons is **not** redistributed (Microsoft redistribution restrictions). The TATC row uses **Fluent UI System Icons** SVG (MIT); canonical vectors live under sibling **`../icons/fluent/`**.
