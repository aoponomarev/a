---
id: cloudflare-kv-key-limit
title: Troubleshooting - Cloudflare KV Key Length Limit (512 bytes)
scope: skills-mbb
tags: [#troubleshooting, #cloudflare, #kv, #cache, #coingecko]
priority: high
created_at: 2026-02-14
updated_at: 2026-02-14
---

# Troubleshooting: Cloudflare KV Key Length Limit (512 bytes)

> **Context**: API proxy caches CoinGecko responses in Cloudflare KV. Long URLs break caching.

## 1. Problem
Cloudflare Workers KV enforces a **512-byte key length limit**. When the cache key is built from the full URL (path + query string), requests with many coin IDs exceed this limit.

### Symptoms
- Worker returns `500 Internal Server Error`.
- Error body: `{"error":"Proxy Error","message":"KV GET failed: 414 UTF-8 encoded length of 737 exceeds key length limit of 512."}`.
- Affects `/coins/markets?ids=<50+ coins>` — the most common initial page load request.
- Smaller requests (2-10 coins) work fine, masking the issue in basic tests.

## 2. Root Cause
`generateCacheKey()` in `api-proxy.js` concatenated the full query string into the KV key:
```
api-cache:coingecko:/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,...50 more...
```
This produced keys of 700+ bytes.

## 3. Solution
Hash the query string with SHA-256 when the key approaches the limit:

```javascript
async function generateCacheKey(apiType, path, queryString) {
  const prefix = `api-cache:${apiType}:${path}`;
  if (!queryString) return prefix;
  const fullKey = `${prefix}?${queryString}`;
  if (fullKey.length <= 480) return fullKey;  // readable for short keys
  // SHA-256 hash for long keys
  const data = new TextEncoder().encode(queryString);
  const hash = await crypto.subtle.digest('SHA-256', data);
  const hex = Array.from(new Uint8Array(hash)).map(b => b.toString(16).padStart(2, '0')).join('');
  return `${prefix}?h=${hex}`;
}
```

Key properties:
- **Deterministic**: same query string always produces same hash.
- **Compact**: SHA-256 hex = 64 chars, total key well under 512.
- **Backward-compatible**: short keys remain human-readable.
- **Async**: uses `crypto.subtle.digest` (available in Workers runtime).

## 4. Prevention Checklist
- [ ] Any new KV caching code MUST account for the 512-byte key limit.
- [ ] Test with maximum-size requests (50+ coin IDs, long query params).
- [ ] Use `X-Cache-Key` response header to verify key format during debugging.

## 5. File Map
- `@cloud/cloudflare/workers/src/api-proxy.js`: `generateCacheKey()` function.
