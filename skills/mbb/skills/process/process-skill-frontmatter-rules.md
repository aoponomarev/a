---
id: process-skill-frontmatter-rules
title: Process - Skill Frontmatter Format Rules
scope: skills-mbb
tags: [#process, #skills, #frontmatter, #yaml]
priority: medium
created_at: 2026-02-14
updated_at: 2026-02-14
---

# Process: Skill Frontmatter Format Rules

> **Context**: MCP skills server parses YAML frontmatter with a simple regex, not a full YAML parser. Certain YAML features break title extraction.

## 1. Title Field Rules

**NEVER use colons (`:`) in the `title` field.** The MCP parser splits on the first colon, so `title: "Foo: Bar"` is parsed as `title` = `"Foo` (with a quote), causing fallback to `id`.

### Correct
```yaml
title: Process - Skill Frontmatter Format Rules
title: Troubleshooting - Docker Container Ignoring Code Changes
title: Cloud - Yandex mbb-api Function Deployment
```

### Incorrect (title will be lost)
```yaml
title: "Process: Skill Frontmatter Format Rules"
title: Troubleshooting: Docker Issues
```

**Rule**: Replace `:` with ` -` in title values. No quotes needed.

## 2. Required Frontmatter Fields
```yaml
---
id: kebab-case-unique-id
title: Human Readable Title Without Colons
scope: skills-mbb
tags: [#tag1, #tag2]
priority: high | medium | low
created_at: YYYY-MM-DD
updated_at: YYYY-MM-DD
---
```

## 3. Known Gotcha - propose_skill
The `propose_skill` MCP tool auto-generates frontmatter with **quoted title and scope**. Always edit the draft to remove quotes before promoting to a skill.

## 4. Validation
After creating/editing a skill, verify title is parsed correctly:
```
search_skills("exact phrase from title")
```
If the skill appears with `id` as title instead of the real title, the frontmatter is broken.
