# Wiki Schema — Powerfleet Engineering Knowledge Base

> This file governs all LLM operations in this vault. Edit it to evolve the rules.
> Last updated: 2026-05-28

## Domain

Work knowledge base for Powerfleet/MiX Telematics engineering — device configuration, AWS infrastructure, operations tools, Jira tickets, daily notes, and personal learning. Primary engineer: Marthinus Raath.

## Folder Conventions

| Folder | Purpose |
|--------|---------|
| `raw/` | Immutable source files. Drop articles, PDFs, clips, exports here. Never modified. |
| `wiki/entities/` | One page per Person, Project, System, Ticket, or Concept entity. |
| `wiki/concepts/` | One page per topic, technology, or idea. |
| `wiki/sources/` | One summary page per ingested source. |
| `wiki/synthesis/` | Cross-source analysis, comparisons, theses, timelines. |

## Entity Types

| Type | Examples |
|------|---------|
| **Person** | Paul, Olga, Unathi, Zonika, Shaun |
| **Project** | Automation API, Config Tools, DynaMiX, Frangular UI, Ops Tools |
| **System** | AWS ECS, DSINTSQL01, ALB, Queclink GV75, Config API, DynaMiX Backend |
| **Ticket** | OPEN-xxxx Jira issues, SR-xxxx service requests, CONFIG-xxxx |
| **Concept** | DST, device config, config groups, alerts, ECS health checks |

## Page Formats

### Entity page (`wiki/entities/{Name}.md`)

```yaml
---
type: entity
entity_type: Person|Project|System|Ticket|Concept
name: {canonical name}
aliases: []
sources: []
last_updated: {date}
---
```

One-paragraph description. Then:
- `## Key Facts` — bullet list of the most important facts
- `## Connections` — `[[WikiLink]]` references to related entities/concepts
- `## Timeline` — chronological events (if relevant)
- `## Open Questions` — unresolved items

### Concept page (`wiki/concepts/{Topic}.md`)

```yaml
---
type: concept
name: {topic}
sources: []
last_updated: {date}
---
```

Definition (1–2 sentences). Then:
- `## Core Ideas`
- `## Connections`
- `## Open Questions`

### Source summary (`wiki/sources/{slug}.md`)

```yaml
---
type: source
title: {title}
date_ingested: {date}
original_file: raw/{filename}
---
```

- `## Summary` — 3–5 sentences
- `## Key Takeaways` — bullets
- `## New Entities/Concepts` — what was created
- `## Wiki Pages Updated` — what was touched

## Tracking Ingestion — Vault-Native Notes

Do NOT move existing vault notes to `raw/` — that breaks Obsidian `[[WikiLinks]]`. Instead, after ingesting any vault-native `.md` file, add `wiki_ingested: YYYY-MM-DD` to its YAML frontmatter:

```yaml
---
created: 2026-01-01
wiki_ingested: 2026-05-28
---
```

Notes without `wiki_ingested` = pending ingest. Find them with:
```powershell
Get-ChildItem -Recurse -Filter "*.md" | Where-Object { (Get-Content $_.FullName -Raw) -notmatch "wiki_ingested" -and $_.FullName -notmatch "\\wiki\\" }
```

`raw/` is reserved for truly external sources (web clips, PDFs, exports) that don't already exist as vault notes.

## Ingestion Rules

- Process one source at a time.
- Read the source fully before touching any wiki pages.
- Update or create entity pages for every named entity.
- Update or create concept pages for every key idea.
- Add a source summary page in `wiki/sources/`.
- **Tag the source file** with `wiki_ingested: YYYY-MM-DD` in its YAML frontmatter.
- Update `wiki/index.md`.
- Append to `wiki/log.md`.
- Flag contradictions with `> ⚠️ Contradiction:` blockquotes.
- Cross-link liberally using `[[WikiPageName]]`.

## Query Rules

- Read `wiki/index.md` first to find relevant pages.
- Synthesise from wiki pages — do not re-read raw sources unless necessary.
- Cite pages inline: `(→ [[PageName]])`.
- Offer to file non-trivial answers to `wiki/synthesis/`.

## Lint Rules

Check for:
- Orphan pages (no inbound `[[links]]` from other pages)
- Missing pages (`[[WikiLink]]` targets that don't exist)
- Stale claims (page `last_updated` older than 90 days with no recent source)
- Unresolved `⚠️ Contradiction:` blocks older than 30 days
- Concepts mentioned frequently but lacking a dedicated page
- Broken `sources:` frontmatter entries pointing to non-existent files

## Source Types

- Daily / Weekly / Monthly notes (personal journal entries)
- Jira tickets & SR notes (OPEN-xxxx, SR-xxxx)
- Technical guides & SOPs (setup guides, walkthroughs, troubleshooting)
- Confluence pages (synced from Atlassian)
- Web articles & research (fetched URLs)
- Chat / meeting notes (WhatsApp exports, session notes)
- Code analysis & AI sessions (Roo Code, Claude sessions)

## Special Output Formats

When the user requests a specific format, generate it and offer to file it:

| Request | Format |
|---------|--------|
| "dataview" / frontmatter query | Dataview-friendly YAML frontmatter on all pages; use `type`, `entity_type`, `sources`, `last_updated` fields consistently |
| "slide deck" / "marp" | Marp markdown with `<!-- headingDivider: 2 -->` and `---` slide separators; save to `wiki/synthesis/{title}.marp.md` |
| "comparison table" | Markdown table with columns per entity/system and source citations in footer |
| "timeline" | Chronological list with **bold dates**, grouped by month/year |
| "standard markdown" | Plain markdown, no special syntax |

All pages default to Dataview-compatible frontmatter regardless of output format requested.
