# repo `a` — public asset & dataset channel

This repository is the **public distribution channel** for the MMB (meta-market-bot) project.
It is served as a static site via **GitHub Pages** at `https://aoponomarev.github.io/a/`.

Two independent contours live here:

## 1. `d/a/` — Android shell-updater channel

- `d/a/manifest.json` — current bundle manifest (version, sha256, url, releasedAt).
- `d/a/manifest.json.sig` — Ed25519 detached signature of `manifest.json` (base64).
- `d/a/public-key.pem` — Ed25519 public key (for out-of-band verification and audits).
- `d/a/bundles/bundle-vN.zip` — versioned JS/HTML/Vue bundles consumed by the `executor-shell.apk`.

The Android shell (`devices/android/app/.../update/BundleUpdater.kt` in the `mmb` repo) polls `manifest.json`, verifies the signature with the baked-in public key, downloads the referenced bundle, verifies `sha256`, and atomically swaps `bundle/current`.

Private signing keys **never** live in this repository. They stay in `.secrets/` of the dev machine of the operator.

## 2. `data/` — dataset archive

- `data/coins.json` — cached static catalogue (pre-existing).
- `data/metrics/<metric>/<YYYY>-<MM>.ndjson` — cold archive of time-series metrics, appended nightly by the `datasets-archiver` Cloudflare Worker (`is/cloudflare/datasets-archiver/` in the `mmb` repo).

Hot data (last ~24 h) lives in Cloudflare KV (`DATASETS_KV` binding of the `edge-api` Worker). The archiver flushes KV → GitHub via the Contents API once per night (cron `0 2 * * *` UTC).

## Contracts

- This repo is **public** and contains no secrets.
- `d/a/manifest.json` is the sole integrity anchor for Android updates. Tampering is detected by the shell and aborts the update.
- `data/metrics/*.ndjson` is append-only; rewriting history breaks query assumptions.

## Related specs (in the `mmb` repo)

- `docs/ais/ais-shell-updater-and-datasets.md` (id:ais-5e1d39) — full architecture.
- `docs/plans/plan-shell-updater-and-datasets-backend.md` — execution plan.
