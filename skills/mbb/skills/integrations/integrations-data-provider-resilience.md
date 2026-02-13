---
id: integrations-data-provider-resilience
title: Data Provider Resilience & Health Monitoring
description_ru: Протоколы обеспечения отказоустойчивости и мониторинга здоровья для внешних поставщиков данных (API).
scope: integrations, reliability
tags: [cryptocurrency, data provider, resilience, stability, monitoring, API]
priority: medium
created_at: 2026-02-01
updated_at: 2026-02-01
---

# Data Provider Resilience & Health Monitoring

## Overview
External APIs (e.g., CoinGecko, DexScreener) are critical for system operation. This skill defines how to monitor their health, track response latency, and implement fallback logic when providers fail.

## Key Metrics Monitored
- **API Uptime**: Percentage of successful responses.
- **Latency**: Time-to-first-byte and total response time (tracked in `avgLatency`).
- **Data Consistency**: Cross-referencing values from different providers.
- **Rate Limit Compliance**: Handling 429 errors and exponential backoff.

## Resilience Steps

### 1. Health Tracking
- Store successes/failures per provider in a registry (e.g., `llm-model-stats.json`).
- Log latency for every call to detect degradation:
  ```javascript
  const startTime = Date.now();
  const output = await callAPI(provider);
  const latency = Date.now() - startTime;
  
  health.totalCalls++;
  health.totalSuccesses++;
  health.totalLatency += latency;
  health.avgLatency = Math.round(health.totalLatency / health.totalSuccesses);
  ```

### 2. Fallback Logic
- Implement a fallback chain that sorts by health and priority.
- Use a recovery window (e.g., 5 mins) to re-test degraded providers.

### 3. Graceful Degradation
- If all providers in the chain fail, serve cached data or a minimal response.
- Use log rotation to keep monitoring history under control (e.g., 5MB per file).

## Validation Criteria
- API uptime should be maintained at >99.5%.
- Average response time should stay under defined thresholds (e.g., 1s).
- Fallback must trigger within 1 retry of a failed call.
