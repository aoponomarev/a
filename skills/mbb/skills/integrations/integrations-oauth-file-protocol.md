---
id: integrations-oauth-file-protocol
title: Integrations: OAuth on `file://`
scope: skills-mbb
tags: [#integrations, #auth, #oauth, #file-protocol]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Integrations: OAuth on `file://`

> **Context**: Handling Google OAuth callbacks when the app runs locally without a web server.

## 1. The Mechanism
Since `file://` cannot receive HTTP redirects, we use a **Popup Bridge**.

1.  **Open**: App opens OAuth URL in a new window (`window.open`).
2.  **Callback**: Cloudflare Worker receives the code, exchanges it for a token.
3.  **Return**: Worker serves an HTML page that sends the token back via `window.opener.postMessage`.
4.  **Save**: Main app receives the message and stores the JWT in `localStorage`.

## 2. Fallback
If `postMessage` fails (e.g., popup blocked/closed prematurely), the Worker saves the token to a temporary cookie/KV, and the app polls for it.

## 3. Hard Constraints
1.  **Security**: The `Origin` of the `postMessage` must be validated.
2.  **User Action**: Popups must be triggered by a direct user click to avoid browser blocks.

## 4. File Map
- `@core/api/cloudflare/auth-client.js`: Client logic.
- `@cloud/cloudflare/workers/src/auth.js`: Server logic.
