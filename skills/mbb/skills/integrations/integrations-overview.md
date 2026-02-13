---
id: integrations-overview
title: Integrations: External Strategy
scope: skills-mbb
tags: [#integrations, #architecture, #strategy]
priority: high
created_at: 2026-01-26
updated_at: 2026-02-01
---

# Integrations: External Strategy

> **Context**: High-level map of MBB's external dependencies and failover logic.

## 1. Core Principles
- **On-Demand**: Integrate only what is necessary for the current phase.
- **Resilience**: Every cloud service must have a local or secondary fallback.
- **Geo-Selection**: Use Yandex Cloud for CIS-region tasks and Cloudflare for Global Edge.

## 2. Current Stack
- **Auth**: Google OAuth via Cloudflare Workers.
- **AI**: YandexGPT (Primary) + Perplexity (Fallback).
- **Data**: CoinGecko (Market) + Yahoo Finance (Charts).
- **Storage**: Cloudflare D1 (Relational) + OneDrive (Files/SSOT).

## 3. Command `EI:` (External Insights)
Trigger for Agents to analyze new integration candidates, compare costs, and design fallback chains.

## 4. Hard Constraints
1.  **No Vendor Lock-in**: Business logic must remain provider-agnostic via `BaseProvider` classes.
2.  **Secrets Hygiene**: No API keys in code. Use `.env` and Wrangler Secrets.

## 5. File Map
- `@core/api/`: Implementation adapters.
- `@docs/A_MASTER.md`: Topology.
