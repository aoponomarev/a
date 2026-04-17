# Android shell-updater channel

This folder is polled by the `executor-shell.apk` every 30 minutes (WorkManager) and on app startup.

Files:

- `manifest.json` — current release manifest (see schema below).
- `manifest.json.sig` — Ed25519 detached signature of the exact byte content of `manifest.json`.
- `public-key.pem` — public key for signature verification. The APK has the same key hardcoded in `BuildConfig.BUNDLE_PUBLIC_KEY`; this file is informational (audit / rotation tracking).
- `v/<YYMMDDNN>.zip` — the actual JS/HTML/Vue bundle. Filename encodes UTC calendar day + intra-day publish slot (`YY`=year mod 100, `MM`=01..12, `DD`=01..31, `NN`=01..99) and is equal to `manifest.version` as an integer. See `#for-bundle-filename-yymmddnn-encoding`.

## manifest.json schema

```json
{
  "version": 26041701,
  "sha256": "<hex-lowercase sha256 of 26041701.zip>",
  "url": "https://aoponomarev.github.io/a/d/a/v/26041701.zip",
  "releasedAt": "2026-04-17T10:00:00Z",
  "minShellVersion": 1
}
```

- `version` — 8-digit `YYMMDDNN` integer (UTC). Monotonically increasing by calendar day; hard ceiling of 99 publishes per day to surface runaway retry loops. Holds within `Int32` until the year 2048 with the current fleet.
- `sha256` — lowercase hex sha256 of the bundle zip file (the shell recomputes after download and aborts on mismatch).
- `url` — absolute URL of the bundle (same origin as this folder). Always matches `https://aoponomarev.github.io/a/d/a/v/<version>.zip`.
- `releasedAt` — ISO-8601 UTC timestamp.
- `minShellVersion` — shells with a lower `BuildConfig.SHELL_VERSION` will refuse the update and wait for a manual `adb install` of a newer shell. Defaults to `1`.

## Signature format

Ed25519 detached signature of the *raw bytes* of `manifest.json` (no canonicalization beyond serving exactly the bytes that were signed). The signature file (`manifest.json.sig`) is **base64** encoded (no line wrap, no `---BEGIN---` header).

## Rollback policy

If the shell detects ≥3 Activity crashes within 10 minutes after applying a new bundle, it reverts to `bundle/previous/` automatically (see `BundleRollbackGuard` in the `mmb` repo). The failed bundle is moved to `bundle/broken-<version>/` for forensic review.

## Bundle retention

Old bundles in `v/` are kept indefinitely to support manual forced rollback (operator can edit `manifest.json` to an older version). Trim manually via `git rm` if storage becomes a concern. History note: the legacy `bundles/bundle-vN.zip` layout was removed on 2026-04-17 in favor of `v/<YYMMDDNN>.zip` (Level-1 clean-slate migration, no shim kept).
