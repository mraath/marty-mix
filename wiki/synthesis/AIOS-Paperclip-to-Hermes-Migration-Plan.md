---
type: synthesis
title: AIOS — Paperclip → Hermes-kanban Migration + Agents + Safeguards (approved plan)
sources: []
last_updated: 2026-07-22
wiki_ingested: 2026-07-22
status: approved, in progress
---

Approved implementation plan (2026-07-22), tracked live at `C:\Users\MarthinusR\.claude\plans\generic-mapping-anchor.md` and via Claude Code tasks in this session. See [[Claude-Multi-Agent-Architecture]] for the research that led here (Hermes capability deep-dive, Paperclip comparison, SDLC governance patterns).

## Handoff background (for a reader with no prior context)

**Environment**: Windows machine, personal AI workspace at `C:\Personal\AIOS`. Two task-tracking systems currently coexist:
- **Paperclip** — a self-hosted Node/React + Postgres task backend. Dev repo `C:\Personal\paperclip` (Node/TS monorepo, Drizzle ORM migrations under `packages/db/src/migrations/`). Real running instance at `C:\Users\MarthinusR\.paperclip\instances\default`, port ~3100/3101. Data model: `companies → projects/agents → issues`, all FK-enforced UUIDs. Currently the declared "main source of truth" for tasks across 6 personal/work personas.
- **Hermes** (`hermes-agent`, NousResearch, CLI tool `hermes`, v0.19.0+, installed at `C:\Users\MarthinusR\AppData\Local\hermes\hermes-agent`) — a separate, far more capable agent runtime than its "chat tool" reputation suggests. It has its own `kanban` subsystem (SQLite at `C:\Users\MarthinusR\AppData\Local\hermes\kanban.db`, schema in `hermes_cli\kanban_db.py`) with atomic claim/lock columns and an autonomous dispatcher, its own `cron` scheduler, and its own extensible hook system (`hermes hooks` — 16 lifecycle events, e.g. `pre_tool_call`, each able to return `{"decision":"block","reason":"..."}` and veto an action).
- **`hermes-web-ui`** ("Hermes Studio", `C:\Personal\AIOS\hermes-web-ui`, Vue + Koa monorepo) is the dashboard used to interact with Hermes day-to-day. It already has a live Paperclip Kanban view (`packages/client/src/views/hermes/PaperclipView.vue`) AND a full, already-built-but-currently-unused native Kanban view for Hermes's own `kanban.db` (`packages/client/src/views/hermes/KanbanView.vue` + `packages/server/src/routes/hermes/kanban.ts`).

**Why this plan exists**: Hermes's own kanban+hooks turned out capable enough to replace Paperclip and to host safeguards similar in spirit to [[SDLC vs. Paperclip vs. Hermes as the orchestrator|SDLC's]] hook-based governance system — so this plan migrates task-tracking onto Hermes, formalizes a proper agent/assignee registry (today it's just loose persona folders), and adds a small set of hook-based safeguards, including a human-verification gate for anything that shouldn't be marked "done" purely on an AI agent's own say-so.

## Part 1 — Paperclip → Hermes-kanban migration

**A0 — Inventory & mapping.** Paperclip's schema (`C:\Personal\paperclip\packages\db\src\migrations\0000_mature_masked_marvel.sql`) is `companies → projects/agents → issues`, all FK-enforced UUIDs. Hermes's `kanban.db` (schema in `hermes_cli\kanban_db.py`) is looser — **no `project_id` column at all**, just a free-text `tenant`. Mapping: `company → board slug` (Hermes boards are separate SQLite files) or fold into `tenant`; `project → tenant` string via a `"<company_slug>:<project_slug>"` convention; `agent → assignee` (free text, no FK — fixed properly in Part 2, not just patched); `status`/`priority` → Hermes's fixed enum via an explicit lookup table (vocabularies aren't 1:1).

**A1 — Migration script, staged (test batch → bulk).** `C:\Personal\paperclip\scripts\export-issues.ts` dumps **every** `issues` row regardless of status — done, blocked, on-hold, and active alike — joined to `projects`/`agents`/`companies`, preserving the Paperclip `identifier` (e.g. "PAP-142") and UUID as provenance in the task body. `C:\Personal\AIOS\scripts\migrate-paperclip-to-kanban.py` reads the dump and calls Hermes's kanban functions per row — dry-run by default, `--commit` to actually write, plus `--limit N`. **Run order: test batch first** (3-5 tasks, mix of statuses), manually verify, only then bulk.
*Verify*: `hermes kanban list --board <slug> --tenant <company>:<project>` row count matches Paperclip's Postgres count (all statuses included); spot-check 5 migrated issues via `hermes kanban show <id>`.

**A1a — Dispatcher safety gate (do not skip).** Every migrated task must land in a pre-work status (`todo`/`triage` — not `ready`/`scheduled`/`running`) regardless of its Paperclip status, so nothing gets auto-picked-up by `hermes kanban dispatch` the moment it's imported. Confirm exactly which statuses `hermes kanban dispatch` will actually claim/spawn a worker for before bulk migration — don't assume. Promotion to a dispatchable state stays a manual, explicit action.

**A2 — Repoint hermes-web-ui, transition window.** Promote the already-built `KanbanView.vue`/`kanban.ts` to primary, keep `PaperclipView.vue` running in parallel for 1-2 weeks so nothing's lost mid-migration.
*Verify*: create 2-3 test tasks via the Hermes kanban UI, confirm they land in `kanban.db` and get picked up by `hermes kanban dispatch` (watch `claim_lock` get set).

**A3 — Retire Paperclip.** Stop `C:\Personal\paperclip\server`. **⚠️ Open item**: two research passes this session disagreed on where "Paperclip Watchdog"/"Paperclip DB Backup" actually run — verify via Windows Task Scheduler / docker / pm2 directly before decommissioning, don't assume either finding. Also grep the whole tree for `api-paperclip`/`PAPERCLIP_API_KEY` before dropping the `vite.config.ts` proxy.
*Rollback*: don't delete Paperclip's Postgres, just stop it — no data loss, worst case is going-forward duplication.

## Part 2 — Set up proper AIOS agent definitions

Today's AIOS "agents" are just personas (`personas/<name>/CLAUDE.md`) — loose context files, not a formal registry, which is why Hermes's kanban `assignee` field is free text today.

**B0 — Define each agent formally**, in `C:\Personal\AIOS\.agents\` (name, scope/role, persona `CLAUDE.md` mapping, owned project(s)). Candidate agents (from `PaperclipView.vue`'s existing mapping): Personal-PA, Finance-Bot, CLAUDE-Work, Plumb-Agent, AU-Marketing-Bot, AU-Finance-Bot.

**B1 — Sync into Hermes kanban as the canonical assignee list**, becoming the validation source the `kanban-project-map.json` shim checks against — turning it from a typo-guard into the real registry Paperclip's `agents` table gave for free.

## Part 3 — Kanban structure, modeled on Paperclip

Reuse Paperclip's existing project list as the fixed convention: Personal Life, Finance & Budget, Work-Powerfleet, Plumb Freelance, Africa Unwind Marketing, Africa Unwind Finance — each a fixed `tenant` value/board, matching what's live in Paperclip today.

## Part 4 — Safeguards, including a human verification gate

Hermes exposes 16 real hook events (`hermes hooks`), each able to veto an action. **Zero hooks are configured today.** Candidate guards, to choose from as this is built:

1. **No hand-authored status changes** — block direct SQL writes to `kanban.db` status columns bypassing `hermes kanban complete`/`claim` (mirrors SDLC's `signal-fabrication-guard.py`).
2. **No "done" without a note** — require a completion comment (mirrors SDLC's manifest-checkbox gate).
3. **Assignee must be a registered agent** — enforced via Part 2's registry.
4. **Human Verification Gate** — an agent's own self-check isn't enough for some tasks: a hook blocks the final transition to `done`, routing instead to `needs-human-check`; only an explicit human action releases it to `done`. The standard path for anything needing a manual look before it's finished.

Build order: guard #1 first (smallest), then decide on #2-4, prioritizing #4.

## Suggested order

**Part 2/3 first** (agent registry + project convention, since Part 1's validation shim depends on it) → **Part 1** (migration) → **Part 4** (safeguards, guard #1 then #4).

## Parked (not this round)

SDLC-side Claude→Copilot dispatch hardening (SDLC's fallback today is prose instructions in `code-trigger.py`, not real code, plus `claude-status.json`'s unsafe writes bypassing `state_writer.py`) — a separate, smaller, work-side fix, revisit later.
