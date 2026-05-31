---
wiki_ingested: 2026-05-28
created: 2026-03-05T07:13
updated: 2026-03-05T07:13
---
# Marty-Mix Rules

## Second Brain Policy

- **Daily Notes**: When documenting work, always append new content to the current daily note: `C:\Projects\marty-mix\DailyNotes\YYYY-MM-DD.md`. Do not overwrite.
- **Wiki Links**: Whenever you create new markdown files, update the daily note with a link.
  - Section: `### Notes created today`
  - Format: `[[NoteFilenameWithoutExtension]]  brief one-line description`
- **Knowledge Capture**: Save copies of useful knowledge (guides, technical summaries, architecture docs) into appropriate folders within `C:\Projects\marty-mix\`.
- **References**: Use Obsidian style `[[WikiLinks]]` for internal cross-linking.

## Investigation Workflow

When investigating any issue or ticket:
- **Always create a new dedicated `.md` file** for the investigation (e.g., `ETS-1234 Issue Description.md`).
- **Link it immediately** in today's daily note (`DailyNotes/YYYY-MM-DD.md`) under `### Notes created today` using a `[[WikiLink]]`.
- **Keep the note up to date** as new findings are made during the session — do not let it go stale.
- **Always maintain a `## Start Here Tomorrow — Priority Checklist`** section at the top of the investigation note (after any frontmatter/header) with `- [ ]` task items for outstanding actions. Update this list as tasks are completed or new blockers are discovered.

## Project Context

- **Issue Tracking**: Reference JIRA tickets as `[TICKET-NUMBER] Description`.
- **Search Strategy**: Search `DailyNotes/` for recent activity and `SRs/` for service request history.
- **Structure**:
  - `DailyNotes/`: Daily logs.
  - `SQL/`: Reusable database queries.
  - `SRs/`: Solution histories for service requests.

## Tech Stack & Environment

- **OS**: Windows (use absolute paths starting with `C:\Projects\...`).
- **Core Systems**: MiX Telematics (Config, Frangular UI, Powerfleet Automation).
- **Frontend**: Angular + Unity.
- **Backend**: .NET Framework, C#, SQL Server.
- **DevOps**: Azure DevOps, AWS (ECR, ECS).
