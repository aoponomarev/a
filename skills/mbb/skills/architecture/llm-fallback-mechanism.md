---
id: llm-fallback-mechanism
title: LLM Fallback Mechanism
description_ru: Механизм обработки ошибок и отказов в LLM, обеспечивающий плавное переключение на альтернативные методы при неудачах основного моделирования.
scope: architecture, reliability
tags: [architecture, error-handling, reliability, LLM]
priority: high
created_at: 2026-02-01
updated_at: 2026-02-01
---

# LLM Fallback Mechanism

## Overview
This skill defines a robust fallback mechanism for Large Language Models (LLMs) to handle various failure scenarios including:
- Generation timeouts
- Content filtering failures
- Model unavailability
- Quality degradation
- Context window limitations

The mechanism ensures graceful degradation of service while maintaining user experience.

## Steps

### 1. Error Detection
- Implement real-time monitoring of LLM responses with these checks:
  ```javascript
  function handleAPIResponse(body) {
      try {
          const json = JSON.parse(body);
          if (json.error) {
              throw new Error(json.error.message || JSON.stringify(json.error));
          }
          if (json.choices && json.choices[0]) {
              return json.choices[0].message.content;
          }
          throw new Error('Invalid API response format');
      } catch (e) {
          throw new Error(`Failed to parse response: ${e.message}`);
      }
  }
  ```

### 2. Fallback Strategy Selection
- Use a tiered fallback approach based on model health:
  ```javascript
  // Healthy models first, then by priority
  const sortedModels = [...MODEL_FALLBACK_CHAIN].sort((a, b) => {
    const healthA = modelHealth.get(a.name);
    const healthB = modelHealth.get(b.name);
    // Prefer models with recent success
    if (healthA.lastSuccess > now - RECOVERY_TIME && healthB.lastSuccess <= now - RECOVERY_TIME) return -1;
    // ... then fewer failures
    if (healthA.failures !== healthB.failures) return healthA.failures - healthB.failures;
    return MODEL_FALLBACK_CHAIN.indexOf(a) - MODEL_FALLBACK_CHAIN.indexOf(b);
  });
  ```

### 3. Fallback Execution
- Implement specific fallback handlers based on the priority chain (e.g., Mistral -> Groq -> OpenRouter).
- Track health metrics (failures, last success) for each model to optimize selection.

### 4. Response Synthesis
- Combine fallback results with original response when appropriate or choose the best available output.

## Validation
### Success Criteria
1. Fallback mechanism triggers only when necessary (false positive rate < 1%).
2. Fallback responses maintain acceptable quality (at least 70% of original).
3. System availability improves significantly (targeting 99.9% uptime).

### Monitoring
- Implement metrics for tracking:
  - `fallback_trigger_rate`
  - `fallback_success_rate`
  - `latency_with_fallback`
  - `provider_availability_heatmap`
