---
type: synthesis
title: AIOS — Paperclip → Hermes-kanban Migration + Agents + Safeguards (approved plan)
sources: []
last_updated: 2026-07-23
wiki_ingested: 2026-07-22
status: complete
created: 2026-07-23T11:32
updated: 2026-07-23T11:33
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

---

## Outcomes (2026-07-22 → 2026-07-23) — all 12 tracked tasks done

The plan above was followed with one real deviation, described under Part 4 below. Full session-by-session detail (including a live-dispatch incident and its fix) lives in Claude's cross-session memory: `project_paperclip_hermes_migration_pause` and `reference_hermes_kanban_dispatch_behavior`, in `C:\Users\MarthinusR\.claude\projects\C--Personal-AIOS\memory\`. This section is the durable summary.

### Part 1 — Migration: done, 109/109 issues

All 109 Paperclip issues now live on the Hermes native kanban board `aios` (`C:\Users\MarthinusR\AppData\Local\hermes\kanban\boards\aios\kanban.db`), created with `created_by='paperclip-migration'`. Final status breakdown at completion: `archived` 57 (includes the intentionally-inert triage-target rows, see below), `blocked` 21, `done` 31.

**A real incident happened mid-migration and is worth knowing about even after the fact**: the original assumption that `hermes kanban create --triage` lands a task inertly turned out to be wrong — triage rows get auto-promoted and claimed by the live Hermes Gateway dispatcher within roughly 100 seconds. During the first full bulk-commit attempt, two migrated tasks were actually auto-dispatched and run as real agent work before this was caught (no confirmed external side effects — full detail in the memory file above). Fixed by rewriting `C:\Personal\AIOS\scripts\migrate-paperclip-to-kanban.py` so every row is created and then *immediately archived* (`archived` is the only status confirmed genuinely inert against the dispatcher) — terminal-status rows get their real historical status/timestamps backfilled via direct SQL afterward, and triage-target rows (31 of them, from Paperclip's `todo`/`in_progress`) now stay `archived` on purpose, pending the un-archive tooling built under Part 4.

### Part 1, A2/A3 — hermes-web-ui repointed, Paperclip retired

`hermes-web-ui`'s native `KanbanView.vue` turned out to already be board-agnostic (board switcher, `?board=` query param) — no server changes were needed. Only the client-side default changed: `DEFAULT_KANBAN_BOARD` in `packages/client/src/stores/hermes/kanban.ts` → `'aios'`. Per the user's explicit call, the old Paperclip tab was **not** removed from the sidebar — it's kept, labeled "Paperclip [migrated]", as a read-only reference.

Paperclip itself was retired 2026-07-23: its dev-watch process tree (embedded Postgres + server/UI file watchers) was stopped. Its embedded Postgres was actually found crashed again at retirement time (same "corrupted shared memory" class of bug documented elsewhere in this vault, needing a full reboot to truly clear) — a fresh final backup couldn't be taken because of this, so retirement proceeded on the existing (5-day-old) backup plus the already-independently-verified 109/109 migration. `C:\Personal\paperclip`'s code, data directory, and backups are all untouched on disk — retirement means the processes were stopped, nothing was deleted.

### Part 2/3 — Agent registry & project convention: done as planned

Six formal agent definitions exist at `C:\Personal\AIOS\.agents\definitions\*.md`; `kanban-project-map.json` is the canonical validation shim. No deviation from the plan here.

### Part 4 — Safeguards: guard #1 + Human Verification Gate, built differently than planned

The plan's Part 4 assumed these would be built as real Hermes hooks (`hermes hooks`, 16 lifecycle events, veto-capable). **In practice, patching Hermes's own installed CLI/DB code was deliberately avoided** — it's a separate product with its own update cycle, and a hook change would apply to every board on the machine, not just `aios`. Instead, both guards were built as an AIOS-level convention layered on Hermes's *existing* CLI, in `C:\Personal\AIOS\scripts\`:

- **The convention**: an agent that believes a task is done does not call `hermes kanban complete` on its own work. Instead, while the task is `running`, it calls `hermes kanban --board aios block <id> "review-required: <summary>" --kind needs_input` — a real, Hermes-native "route to a human" block kind, not the same thing as Hermes's own `review` status (which auto-dispatches *another agent*, not a human).
- `kanban-review-queue.py` — lists everything awaiting human review (reads the board's SQLite directly, since `block_kind` isn't exposed by the CLI's own `--json` output).
- `kanban-approve.py <id> [--summary ...] [--reject "..."]` — the sanctioned way a reviewed task becomes `done` (completes directly from `blocked`, deliberately skipping `unblock` first to avoid a brief `ready`/dispatchable window) or gets sent back for rework.
- `kanban-unarchive.py <id> [--status triage]` — brings one of the 31 archived triage-target rows back to a workable status when a human's ready to actually work it (no native `unarchive` verb exists in Hermes's CLI).
- `kanban-audit-unreviewed-done.py` — guard #1, folded in here: a reminder-only audit (not a hard block, matching this user's general preference for reminders over auto-enforcement) that flags any `done` task whose history never shows a `needs_input` block first.

Full usage documented in `C:\Personal\AIOS\.agents\AGENTS.md`'s "Human Verification Gate" section.

## Where to see it / what needs to be running

**To just use the kanban CLI (create/list/block/complete tasks, run the four scripts above)** — nothing extra needs to be running. `hermes kanban --board aios <command>` and the Python scripts in `scripts\` talk straight to the board's SQLite file. This is true even with the Hermes Gateway stopped.

**To browse the kanban board in a browser:**
1. Start the dev server from `C:\Personal\AIOS\hermes-web-ui`:
   ```powershell
   cd C:\Personal\AIOS\hermes-web-ui
   $env:HERMES_WEB_UI_DISABLE_GATEWAY_AUTOSTART = "1"
   npm run dev
   ```
   The env var is required — without it, the server's own boot sequence tries to manage a *separate* per-profile gateway process for each of the 6 AIOS profiles, which fights with the real, manually-run Hermes Gateway and can hang the server for a minute or more once that gateway is actually up.
2. Open **http://127.0.0.1:8649/** — log in with `mraath@gmail.com` (password was reset to the app's own documented default, `123456`, during this work; change it after logging in if you want something else).
3. Sidebar → **Kanban** → lands on the `aios` board by default, showing all migrated + newly-created tasks. The old Paperclip tab is still there too, labeled `[migrated]`, read-only.

**For dispatch (agents actually picking up and running tasks)** — that's the Hermes Gateway (`hermes gateway run --force`), a separate always-on process from hermes-web-ui entirely. It needs to be running for tasks to get claimed/worked automatically; the web UI and CLI both work fine whether it's up or not, they just won't see new dispatch activity if it's down.
