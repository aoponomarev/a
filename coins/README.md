# Coin icons (`coins/`)

Static PNG assets served by GitHub Pages at:

`https://aoponomarev.github.io/a/coins/<id>.png`

## Naming

- Primary filename = CoinGecko coin `id` (lowercase), e.g. `cardano.png`, `celestia.png`, `dogwifcoin.png`.
- Optional ticker aliases for shorthand `coinId` values used in portfolios/tests: `ada.png`, `tia.png`, `wif.png`.
- Stablecoin filename aliases consumed by `#JS-1dttw1ah` / mobile `presentation-coin-icons.js`: `usdt.png`, `usdc.png`, `busd.png` (not yet published).

Target size: **128×128 PNG**, transparent background, contain-fit (same contract as desktop Icon Manager modal).

## Test-minimal set (workstation sync pass)

| Ticker | CoinGecko id | CDN files |
| --- | --- | --- |
| ADA | `cardano` | `cardano.png`, `ada.png` |
| TIA | `celestia` | `celestia.png`, `tia.png` |
| WIF | `dogwifcoin` | `dogwifcoin.png`, `wif.png` |

## Sync script

From repo `a` root (Windows / PowerShell):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\sync-coin-icons.ps1
```

Sources images from CoinGecko `coin-images.coingecko.com` (public metadata URLs). Review output under `coins/` before `git commit` and push to `main` (GitHub Pages propagates in ~1–2 minutes).

## License note

Icons are third-party brand assets fetched from CoinGecko for UI display only. Keep the published set minimal; do not bulk-mirror the full CoinGecko catalog in this public repo.
