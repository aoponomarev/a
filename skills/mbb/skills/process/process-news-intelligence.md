---
id: process-news-intelligence
title: Process: News Intelligence
scope: skills-mbb
tags: [#process, #news, #ai, #filtering]
priority: medium
created_at: 2026-01-30
updated_at: 2026-02-01
---

# Process: News Intelligence

> **Context**: Automated collection and sentiment analysis of crypto news.

## 1. Pipeline
1.  **Fetch**: n8n pulls from RSS/Twitter/Telegram.
2.  **Filter**: AI removes noise and "shill" posts.
3.  **Score**: Sentiment analysis (-1.0 to +1.0).
4.  **Store**: Results saved to `events/news-queue.json`.

## 2. Key Rules
- **Source Weight**: Official project blogs > Tier 1 News > Influencers.
- **Deduplication**: Group similar stories into a single event.

## 3. Hard Constraints
1.  **No FOMO**: AI must flag sensationalist language and reduce its impact score.
2.  **Verification**: High-impact news requires 2+ independent sources.

## 4. File Map
- `@core/api/news-provider.js`: Client-side access.
- `@events/news-queue.json`: Data source.
