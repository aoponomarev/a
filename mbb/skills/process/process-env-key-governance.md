# Process: Env Key Governance (EIP)

> **Context**: Prevent key drift between root `.env` and service-level `.env` files.
> **Goal**: One authoritative key source, deterministic rotation, mandatory verification.

## 1. SSOT Rule
- Root file `MBB/.env` is the single source of truth for shared keys:
  - `N8N_API_KEY`
  - `N8N_API_URL`
  - other cross-service integration keys
- Service-local `.env` files may contain only service-specific toggles (timeouts, feature flags, safety gates).
- Service-local `.env` MUST NOT redefine shared keys unless temporary emergency override is explicitly documented.

## 2. Rotation Protocol (Mandatory)
1. Generate new key in provider UI.
2. Update root `MBB/.env` first.
3. Remove stale duplicates from service `.env` files.
4. Search repo for stale token fingerprints and old key IDs.
5. Run console verification suite (Section 4).
6. Update docs/skills if behavior or policy changed.

## 3. Drift Detection
- Detect duplicate key declarations via scan:
  - `**/.env*` files
  - scripts/docs containing hardcoded token fragments
- If drift is found:
  - fix root key first
  - eliminate/align duplicates
  - log change in `docs/project-evolution.txt`

## 4. Verification Suite
- `control-plane`: health probe must return auth-success with current key.
- n8n API direct probe from root env must return workflow data, not 401.
- Service startup smoke test must pass with key sourced from root `.env`.
- `.env.example` must have the same key set as `.env` (placeholder values allowed).
- Run `npm run env:check` after any key add/remove/rename.

## 5. Security Constraints
- Never commit real keys into tracked docs/examples.
- Replace leaked values immediately and rotate compromised keys.
- Keep placeholders in `*.example` files.

## 6. File Map
- `@.env` (SSOT)
- `@control-plane/.env` (service-only overrides)
- `@control-plane/src/config.js` (env loading precedence)
- `@scripts/validate-env-example.js` (strict key-set parity check)
