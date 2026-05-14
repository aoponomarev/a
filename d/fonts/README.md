# Self-hosted fonts (WebView Presentation Layer)

SSOT for **`woff2`** shipped next to **`index.html`** in the signed bundle (`url(fonts/…)` in CSS). Mirrored into PF **`devices/android/bundle-src/main-vue/public/fonts/`** before **`vite build`** (**`#for-mob-ui-bundle-fonts-repo-a-d-fonts`**).

| File | Source / license | Notes |
| --- | --- | --- |
| `roboto-condensed-*.woff2` | Fontdelivery / bundler subset | Log + `font/minimal` column |
| `MaterialIcons-Regular.woff2` | [Google Fonts / Material Icons](https://fonts.google.com/icons) (Apache 2.0) | Ligature icon font; required offline for TATC Material row |

Segoe Fluent Icons is **not** redistributed (Microsoft redistribution restrictions). The TATC row uses **Fluent UI System Icons** SVG (MIT); canonical vectors live under sibling **`../icons/fluent/`**.
