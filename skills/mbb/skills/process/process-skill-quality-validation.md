---
id: process-skill-quality-validation
title: Process: Skill Quality Validation
scope: skills-mbb
tags: [#process, #validation, #quality, #llm]
priority: high
created_at: 2026-02-01
updated_at: 2026-02-01
---

# Process: Skill Quality Validation

> **Context**: Criteria for validating LLM-generated skill extractions.
> **Goal**: Prevent garbage skills from polluting the knowledge base.

## 1. Mandatory Fields Check

Every extracted skill MUST have:

| Field | Format | Example |
|-------|--------|---------|
| `SKILL_ID` | kebab-case | `docker-volume-migration` |
| `CATEGORY` | enum | `architecture`, `integration`, etc. |
| `DESCRIPTION` | 2-3 sentences | Concrete, actionable text |

**If any field missing**: Reject with `incomplete_extraction`.

## 2. Quality Signals (Good)

✅ **Actionable verbs**: "Configure X", "Add Y to Z", "Run command..."
✅ **Specific references**: File paths, config keys, API endpoints
✅ **Clear scope**: "When deploying to Docker...", "For PostgreSQL migrations..."
✅ **Measurable outcome**: "Results in X", "Enables Y"

## 3. Quality Signals (Bad)

❌ **Abstract nouns**: "resilience", "scalability", "modularity"
❌ **Philosophy**: "This pattern demonstrates...", "The value lies in..."
❌ **Vague benefits**: "improves maintainability", "enhances flexibility"
❌ **Missing HOW**: Explains WHAT but not HOW to apply

## 4. Validation Algorithm

```javascript
function validateExtraction(parsed) {
  // 1. Structure check
  if (!parsed.skillId || !parsed.category || !parsed.description) {
    return { valid: false, reason: 'incomplete_extraction' };
  }

  // 2. Category check
  const validCategories = ['architecture', 'integration', 'automation',
                          'security', 'debugging', 'process'];
  if (!validCategories.includes(parsed.category)) {
    return { valid: false, reason: 'invalid_category' };
  }

  // 3. Description quality check
  const abstractWords = ['resilience', 'scalability', 'modularity',
                        'flexibility', 'maintainability'];
  const hasAbstract = abstractWords.some(w =>
    parsed.description.toLowerCase().includes(w));
  if (hasAbstract && parsed.description.length < 100) {
    return { valid: false, reason: 'too_abstract' };
  }

  return { valid: true };
}
```

## 5. Rejection Handling

When extraction is rejected:
1. Log to `skills-events.log` with reason
2. Mark commit as scanned (don't retry)
3. Optionally: Queue for human review

## 6. Human Review Triggers

Flag for manual review when:
- LLM returns `SKILL_EXTRACTABLE: NO` with `unclear_intent`
- Description contains `UPDATE [skill-id]:` (potential skill update)
- Category is `security` (sensitive patterns)

## 7. File Map (V2)

- `n8n/workflows/V2_NEWS_Swarm.json`: Logic for parsing and validating LLM output
- `@logs/skills-events.log`: Rejection audit trail (via n8n)
- `events/SKILL_CANDIDATES.json`: Current queue for skill proposals under review
