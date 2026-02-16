---
id: process-project-evolution-aggregation
title: Process - Project Evolution Aggregation
scope: skills-mbb
tags: [#process, #logging, #evolution, #aggregation, #docs]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-16
---

# Process - Project Evolution Aggregation

> **Goal**: Keep `docs/project-evolution.txt` cumulative, compact, and non-duplicative.
> **SSOT**: `docs/project-evolution.txt`

## 1. Core Rule

- **One date = one record**.
- New session outcomes for an existing date must be merged into the existing date record, not appended as a new duplicate date line.

## 2. Aggregation Algorithm

1. Find date record `DD/MM/YY`.
2. Extract new milestones from current session.
3. Merge milestones into existing date narrative:
   - remove repeated phrasing,
   - preserve unique architectural decisions/integrations/protocol upgrades.
4. Compress wording while keeping technical meaning.
5. Keep reverse chronology intact.

## 3. Compression Rules

- Prefer one dense paragraph per date with semicolon-separated milestone clusters.
- Avoid low-value operational noise (micro-fixes, transient debug notes).
- Keep names of critical files/protocols/skills that define architecture history.

## 3.1 Significance-Aware Compression

When compressing a date block, apply weighted ordering:

- **Tier A (System-critical)**: architecture boundaries, infrastructure changes, security/safety model, protocol/version upgrades.
- **Tier B (Structure-important)**: integration links, reliability gates, major refactors, new process/skill families.
- **Tier C (Operational-minor)**: local quality-of-life tweaks, small non-breaking adjustments, low-impact housekeeping.

Rules:

1. Keep Tier A items explicit and closer to the beginning of the date record.
2. Keep Tier B items in the middle as grouped clusters.
3. Aggregate Tier C items into one short tail phrase ("прочие улучшения...") and let them sink to the end of the date block.
4. On repeated compressions, Tier C details should be merged first; Tier A details should be preserved longest.

## 4. Acceptance

- No duplicate date headers/records.
- Date record remains readable and technically complete.
- Net log growth is controlled via cumulative compression over time.
- Critical/system-significant changes remain visible after compression.

