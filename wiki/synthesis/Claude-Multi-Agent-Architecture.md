---
type: synthesis
title: Claude Code Multi-Agent Architecture — Settings, Agent Frameworks, SDLC Internals
sources: []
last_updated: 2026-07-21
wiki_ingested: 2026-07-21
created: 2026-07-21T16:44
updated: 2026-07-22T11:23
---

Working notes from a 2026-07-21 session on how Claude Code settings inheritance works across `C:\Projects\SDLC` (work) and `C:\Personal\AIOS` (personal), how their respective "agent" systems compare to Claude Code's native subagents, how Hermes and Paperclip relate inside AIOS, and a deep dive into SDLC's own internal architecture.

## Settings inheritance — global vs. project vs. local

Claude Code has exactly three tiers, and there is **no "these N projects" tier** — a setting is either everywhere or scoped to one repo:

| Tier | File | Scope |
|---|---|---|
| Global | `C:\Users\MarthinusR\.claude\settings.json` | Every project, every repo, automatically |
| Project | `<repo>\.claude\settings.json` | That repo only; committed, shared with team |
| Project local | `<repo>\.claude\settings.local.json` | That repo only; personal, gitignored |

Anything dropped into the global file is instantly live in SDLC, AIOS, and everywhere else — no special syntax, just file placement. Practical rule going forward: generic new permissions/hooks/preferences go straight into the global file (not into AIOS's local settings, which is the smaller of the two) so they don't need re-adding per repo.

**Caveat**: SDLC's project `settings.json` mixes generic tool permissions (Bash/node/npm/python allowlists) with hooks that are meaningful *only* to its own pipeline (Jira gates, manifest guards, `signal-fabrication-guard.py`). Those must stay local to SDLC — promoting them to global would fire SDLC-pipeline checks inside AIOS, which has no Jira, no manifests, none of that machinery.

## Three different "agent" systems — not the same mechanism

| | Native Claude subagents | SDLC's `.agent/agents/` | AIOS's `personas/` + `.agents/` |
|---|---|---|---|
| Form | `.md` + YAML frontmatter in `.claude/agents/` (project) or `~/.claude/agents/` (global — e.g. existing `market-competitive.md`, `market-content.md`, `market-conversion.md`, `market-strategy.md`, `market-technical.md`) | 15 plain markdown role docs, no Claude Code frontmatter | Persona = `CLAUDE.md`/`GEMINI.md` per folder (`au`, `work`, `personal`, `plumb`, `au-finance`) + `AGENTS.md` session rules |
| Invocation | `Agent` tool spawns an **isolated, single-shot context** that returns a result | Orchestrator (`state.json` + Python hooks + triggers) tells whichever session is "playing" a role which file to read | External bots (Discord/Teams/Telegram gateways, Hermes `config.yaml`) point a session at a persona file |
| Lifespan | One call in, one result out — no memory afterward | Persists across a whole pipeline stage (days); state lives in `state.json`, not the agent | Persists for the life of a chat session/channel |

Native subagents are for bounded, one-shot work ("go research X, come back with an answer"). SDLC and AIOS both needed **long-running roles with external state**, which the native mechanism doesn't provide — hence two independently-built custom frameworks. Not a mistake, just a different problem shape.

Open idea: some of SDLC's 15 agents (Researcher Agent looks closest) may actually be bounded one-shot tasks in disguise, and could get a real native subagent definition alongside their markdown role doc for quick isolated use. Not done yet.

## [[Hermes]] vs. [[Paperclip]] (AIOS)

> **Revised 2026-07-21** — the first pass on Hermes below was shallow ("chat runtime and model router"). Deeper research the same day found it's a much larger, fast-moving platform. Corrections/additions are marked inline.

- **Hermes** (`hermes-agent`, NousResearch) — **confirmed version: v0.19.0 (2026.7.20), Python 3.11.14**, git-installed at `C:\Users\MarthinusR\AppData\Local\hermes\hermes-agent`. `hermes --help` reveals **58 top-level commands**, not just a chat/routing CLI:
  - **Skills marketplace**: `skills`, `bundles`, `plugins`, `curator` (background auto-maintenance of installed skills) — per-profile `skills/` directories hold 24,500+ files across categories (apple/computer-use, autonomous-ai-agents, creative/image-gen/video). This is entirely separate from AIOS's own hand-authored ops skills at `.agents/skills/` (`session_recovery`, `gateway_fallback`, `fix-agents`, `fix-hermes-gateway`) and `skills/cron-self-healing` — those manage Hermes itself; the marketplace skills are Hermes' own installed content.
  - **Computer Use** driver (`computer-use`), **MCP server hosting** — Hermes can *run as* an MCP server, not just consume them (`mcp_servers.hermes-studio` in profile config points at `127.0.0.1:8647`, i.e. hermes-web-ui itself is exposed as an MCP server back to Hermes).
  - **Built-in cron** (`cron`), **kanban** (`kanban`), **ACP server mode** (`acp`), **Nous Portal OAuth** (`portal`), **supply-chain security scanning** (`security` — OSV.dev audit of venv/plugins/MCP servers), credential pooling across providers (`auth`), git-worktree-isolated agent runs, a TUI, and — genuinely — a "pets" feature.
  - Per-profile `config.yaml` also has a **`command_allowlist`** (dangerous-operation gate: SQL DROP, recursive delete, `execute_code`, etc. require approval) and a commented-out **`tirith`** pre-exec command scanner — i.e. Hermes has its own guard-rail layer, conceptually parallel to SDLC's hooks, just config-driven rather than Claude-Code-hook-driven.
- **`hermes-web-ui`** ("Hermes Studio", v0.6.13, BSL-1.1) is far more than a dashboard: **8 unified platform channels** (Telegram, Discord, Slack, WhatsApp, Matrix, Feishu/Lark, WeChat, WeCom), **group chat rooms** with multi-agent @mention routing and context compression, dedicated **Codex and Claude Code proxy runners**, **voice input/output** (TTS/STT, `node-edge-tts`), a real web terminal (`node-pty`/`xterm`), usage-analytics dashboards (cost/cache-hit/model distribution), and its own SQLite session DB. Recent git history shows active work on voice/STT, coding-agent chat sessions, and remote device pairing — it's a fast-moving bilingual (EN/ZH) product, not a static internal tool.
- **Paperclip** — self-hosted, multi-tenant task/agent orchestration backend: Node/React + embedded Postgres. Dev repo at `C:\Personal\AIOS\paperclip` (docs only); real running instance at `C:\Users\MarthinusR\.paperclip\instances\default` (port ~3101, `companies/` → `agents/` → `projects/`/`workspaces/` as UUID records). Wakes Worker Agents on a heartbeat to execute tickets via `agy`.
- **Correction — they're already integrated, not just personas-in-common**: `hermes-web-ui\packages\client\src\views\hermes\PaperclipView.vue` is a full Kanban view calling Paperclip's API directly, with agent/project ID mappings for all 6 personas. The Phase 4 "embed Paperclip's dashboard as a tab inside hermes-web-ui" plan from `paperclip-todo.md` is **already built**, not just scoped.

> ⚠️ **Security finding**: `PaperclipView.vue` has a **live Paperclip API key and a Todoist token hardcoded in plaintext** in the Vue source (not an env var). If `hermes-web-ui` is a git repo, that secret is likely in commit history too. Worth rotating both tokens and moving them to `.env`/secure config — flagged here, not yet actioned.

**Revised verdict**: still complementary in *role* (Hermes = chat/model-routing + multi-channel + voice; Paperclip = durable task/state backend), but no longer "don't merge, they're separate" — Hermes Studio already embeds a live Paperclip view. The remaining boundary is real: Hermes doesn't have Paperclip's relational task model, and Paperclip doesn't do chat/voice/multi-channel routing. Rebuilding either one's core job inside the other still isn't worth it; the dashboard-level integration already gives you the "fewer moving parts" win without a backend merge.

## SDLC internals — the moving parts

`C:\Projects\SDLC` is the **Powerfleet Agentic SDLC** — it holds no application code, only the definitions/state that coordinate autonomous agents working on real repos under `Repos/`.

### Plain-English glossary

| Term | What it is, in one line | Analogy |
|---|---|---|
| **Agents** | 15 job roles, each with exactly one responsibility (write code, review PRs, run tests...) | Employees — each with their own job description, never doing someone else's job |
| **Skills** | Step-by-step how-to guides an agent reads before doing a specific task | SOP binder / training manual on the shelf |
| **Hooks** | Scripts that automatically run whenever Claude tries to do something (save a file, run a command) | Security guards standing at every doorway |
| **Triggers** | The specific hooks that "listen" for command words you type (`code`, `test`, `review`) | The receptionist who hears you and pages the right person |
| **State** (`state.json`) | One shared file recording what's happening on every ticket right now | The big whiteboard in the office everyone checks before doing anything |
| **Workflows** | Written-out step sequences for a whole process, start to finish | The recipe card the manager follows |
| **Rules** (`rules.md`) | Company policy — deadlines, who can approve what, governance | The employee handbook |

### Wireframe — how a `code OPEN-1234` command flows through all of it

```
 YOU type: "code OPEN-1234"
        │
        ▼
 ┌──────────────────────────┐
 │        TRIGGERS           │   "the receptionist"
 │   code-trigger.py hears   │   hears the word "code", pages the
 │   the word, wakes things  │   manager with the full instructions
 │   up                      │
 └────────────┬──────────────┘
              │
              ▼
 ┌──────────────────────────┐        ┌───────────────────────────┐
 │  CENTRAL ORCHESTRATOR     │──────► │          STATE             │
 │      "the manager"        │  reads │        state.json           │
 │  checks the whiteboard    │◄───────│   "is anyone already on     │
 │  before assigning work    │        │    this ticket?"            │
 └────────────┬──────────────┘        └───────────────────────────┘
              │ assigns the job to a specialist
              ▼
 ┌──────────────────────────┐        ┌───────────────────────────┐
 │         AGENT              │◄─────► │          SKILLS             │
 │   e.g. Coding Agent        │  reads │   e.g. coding-skill.md       │
 │      "the specialist"      │  the   │   "here's exactly how to    │
 │                            │  manual│    do this task"            │
 └────────────┬──────────────┘        └───────────────────────────┘
              │ tries to act: write code, open a PR...
              ▼
 ┌──────────────────────────┐
 │          HOOKS              │   "the security guard at the door"
 │  guard hooks can BLOCK you  │   e.g. manifest-step-guard.py stops
 │  if a step was skipped      │   you skipping ahead
 │  signal hooks record what   │   e.g. write_review_signal.py logs
 │  really happened            │   the real verdict, no faking it
 └────────────┬──────────────┘
              │ allowed through → result written down
              ▼
 ┌──────────────────────────┐
 │          STATE              │   the whiteboard gets updated
 │        state.json            │   "Coding done, Review's turn"
 └────────────┬──────────────┘
              │
              ▼
   Manager checks the whiteboard again → pages the NEXT specialist
   (Review Agent → QA Agent → PO Agent → Deployment Agent...)
```

**The one-sentence version**: Triggers notice you spoke, the Manager (Orchestrator) checks the whiteboard (State) to see what's already happening, hands the job to the right specialist (Agent), who follows the manual (Skills) for that task — while security guards (Hooks) stand at every door making sure nobody skips a step or fakes a result — and every outcome gets written back onto the whiteboard so the Manager knows who to page next.

### Agents (`.agent/agents/`, 15 files)

Plain markdown role docs, each with a **Capabilities** line (declarative tags, e.g. Coding Agent: `csharp-dotnet-expert, python-expert, database-mssql, hotfix-execution, branch-management`) and a **Tools** line (e.g. `dotnet-cli, roslyn-analyzers, sqlcmd`). These are documentation-only labels — not an enforced permission mechanism. Real behavioral gating lives in each agent's **CONSTRAINTS** section plus hooks (below).

- **Central Orchestrator** — pure supervisor. Never writes/reads/modifies code; sole entity authorised to trigger Azure DevOps deployment pipelines. Dispatch is gated by three things baked into its own file: a Duplicate-Agent Guard (checks `state.json.agent_instances` before spawning, treats a >4h stale `in_progress` as hung), Effort Tier computation (T0–T3 from Jira story points via `@skills/coding-effort-tier.md`, threaded through Coding→Review→QA), and a fixed base-instructions load (`@instructions/central-orchestrator-instructions.md`).
- **Coding Agent** — sole agent authorised to write/commit code, one repo per instance. Runs `coding-skill/SKILL.md` in full, writes a checkbox task manifest, emits `CODING_COMPLETE`. Never merges its own PR or deploys.
- **Review Agent** — PR gatekeeper. Must pull the real diff before writing findings ("a verdict rendered without this step is a fabricated verdict"); security/build-contract/scope violations are always-blocking regardless of effort tier. Emits `REVIEW_SIGNAL`.
- **QA Agent** — quality gate between dev and deployment, test depth scaled by `effort_tier` (T0 ≈ 20k-token unit-scoped, T3 = full multi-repo suite). Owns `In Progress QA` → `Ready for Review`/`Done` transitions, opens defects on DoD failure.
- **PO Agent** — requirements/grooming/UAT sign-off. Owns the `Proposed → Ready for Grooming` transition itself during intake; everywhere else only emits signals for the orchestrator to act on. Cannot emit `Grooming Complete` without a non-zero story-point value.
- Remaining 10: Architect, Compliance, Documentation, Deployment, Self-Healing, Triage, UI Test, Researcher, Scenario Test, Data Quality, Scrum Master — each scoped to one lifecycle concern (sizing, GDPR/security audits, docs, pipeline triggers, broken-test-infra fixes, incident classification, Playwright E2E, cross-repo data pulls, persona-aware UI scenarios, SDLC data-integrity audits, sprint ceremonies).

### Skills (`.agent/skills/`, ~170 files/folders)

Reusable instruction files, either flat `.md` or folder-based `<name>/SKILL.md` + `scripts/`. Categories: Jira formatting (`jira-story-format.md`, `jira-defect-format.md`, …), coding (`coding-skill/`, `database-skill.md`, `coding-effort-tier.md`), review (`code-review-standards.md`, `security-review-standards.md`), PO/grooming (`po-grooming-skill.md`, `po-uat-signoff-skill.md`), QA (`qa-testing-skill.md`, `qa-evidence-collection-skill.md`), compliance, notification/escalation/rollback protocols, sprint ceremonies, scenario/UI testing, self-healing, triage, plus a batch of imported `w-*` personal-utility skills. `coding-skill/SKILL.md` defines a "disk is the source of truth" resume protocol — work-log JSONL + task-manifest checkboxes are the *only* two sources of resume position after a session drop.

### Workflows (`.agent/workflows/`)

Numbered runbooks the orchestrator follows: `orchestrator.md` (full lifecycle: webhook routing → per-repo Coding Agent spawn → pre-merge rebase → QA cron detection → defect loop → PO sign-off → deployment gate → hotfix back-sync → DQ gates → doc triggers), `incident-triage.md`, `qa-workflow.md` (DoD + QA handoff), `documentation-workflow.md`.

### Triggers (`.agent/triggers/`)

Manifest files tracking live intake/QA state: `qa-manifest.json` (every ticket ever dispatched to QA, status `qa_in_progress`/`qa_approved`/`qa_failed`/`qa_complete`), `qa-watcher.md` (the cron mechanism — poll Jira for `Ready for QA`, diff against the manifest, dispatch QA Agent for unseen tickets), `advisories-manifest.json`, `refactorings-manifest.json`. Separately, `.claude/hooks/*-trigger.py` scripts are what actually fire on a **user prompt** (e.g. `code-trigger.py` regex-matches `code <KEY>` and injects the full instruction block as `additionalContext` before the orchestrator's turn even starts).

### State (`.agent/shared-memory/state.json` + `schema.md`)

Single JSON file, sectioned by concern: `sprints`, `agent_instances` (the primary coordination table — per-instance status/branch/PR/review/QA verdict), `dependency_locks`, `back_sync`, `requirements_intake`, `third_party_registry`, `po_signals`/`po_signals_grooming`, `review_signals`/`review_patterns`, `compliance_verdicts`, `deployment_outcomes`, `dq_audit_instances`, `velocity_history`, `triage_incidents`, `flakiness_markers`, and more. Write ownership is explicit: the Orchestrator writes general sections; ~10 "ephemeral handshake" sections are written only by their owning agent. **Every write anywhere must be preceded by a backup** (auto via a `PreToolUse` hook for Write/Edit tools, or via `state_writer.write_state()` for Python) — backups kept in `state-backups/`, last 10 retained.

### Hooks (`.claude/hooks/*.py`, ~55 scripts)

Wired to Claude Code's `PreToolUse`/`PostToolUse`/`UserPromptSubmit` events. Three functional groups:
1. **Trigger hooks** (`code-trigger.py`, `qa-trigger.py`, `close-trigger.py`, …) — fire on `UserPromptSubmit`, regex-match a command, inject the relevant instruction block.
2. **Guard hooks** (`manifest-step-guard.py`, `manifest-exists-guard.py`, `manifest-worklog-guard.py`, `secret-scan-hook.py`, `sta-gate-hook.py`) — fire on `PreToolUse`, block a tool call outright if a precondition on disk isn't met (e.g. a manifest checkbox still unticked).
3. **Signal-writer hooks** (`write_po_signal.py`, `write_review_signal.py`, `write_dq_audit_instance.py`, …) — the *only* legitimate path to commit a decision-signal section of `state.json`. Direct Edit/Write to those keys is hard-blocked by `signal-fabrication-guard.py`, specifically so no agent can fabricate a sign-off it never actually produced.

### Rules (`.agent/rules.md`)

The engineering-operations manual: team/project/repo/pipeline mapping, governance (Architect sizing, GDPR), the 2-week staggered sprint lifecycle (`yy.x` naming, dev→UAT→production), incident SLAs by priority (Urgent=1 day, High=10, Normal=42), cache-first Jira reads, repo-specific conventions, deployment/sync rules, and a **Self-Healing Autonomy Boundary Policy** table — e.g. build auto-patch is autonomous, but production rollback always requires explicit human approval.

### End-to-end trace: `code OPEN-1234`

1. `code-trigger.py` fires on the user's prompt, checks `state.json.po_signals` for `Grooming Complete`, injects the coding instruction block.
2. Orchestrator computes `effort_tier`, checks the Duplicate-Agent Guard against `agent_instances`, spawns an isolated Coding Agent subagent.
3. Coding Agent runs `coding-skill/SKILL.md`, writes a task manifest, works through branch/implement/build/test/commit/PR — each step gated by `manifest-step-guard.py` before it can proceed to the next.
4. `CODING_COMPLETE` lands in `state.json.agent_instances[OPEN-1234]`; Review Agent is invoked, pulls the real diff, and its `REVIEW_SIGNAL` is committed only via `write_review_signal.py` (direct writes blocked by `signal-fabrication-guard.py`).
5. A cron-driven orchestrator re-invocation (`qa-watcher.md`) polls Jira for `Ready for QA`, diffs against `qa-manifest.json`, dispatches QA — closing the loop back to PO sign-off and deployment.

**General pattern**: hooks gate/inject at the Claude Code tool-call layer → agents execute skills and produce structured signals → dedicated `write_*.py` scripts (backup-enforced) are the only legitimate path to commit decision-signal state → the orchestrator reads that state to decide the next dispatch.

## 2026-07-22 — Hermes deep dive: can it fully replace Paperclip, and can it grow SDLC-style governance?

**Correction to the 2026-07-21 entry above**: that entry implied Hermes and Paperclip were only linked by shared personas. Deeper research found `hermes-web-ui` already embeds a live Paperclip Kanban view — but there was also a *false lead* worth recording so it isn't re-chased: it looked like the user had already tried Hermes's own native kanban and abandoned it for Paperclip. Checking `kanban/migrate-to-paperclip.py` and `wiki/entities/Paperclip.md` directly disproved this — that migration moved data from the old **markdown file** `kanban/braindump.md` to Paperclip, not away from Hermes's CLI kanban subsystem. Hermes's own `kanban.db` is a *different, currently-live* system running in parallel today (real tasks in it right now; Hermes's own cron runs "Paperclip Watchdog"/"Paperclip DB Backup" jobs to keep Paperclip healthy) — today's architecture treats Paperclip as primary and Hermes cron/kanban as supporting tooling around it, not a rejected alternative.

### Can `hermes kanban` + `hermes cron` replace Paperclip?

`hermes kanban` (33 subcommands) is a real orchestration engine, not a toy: SQLite-backed (`C:\Users\MarthinusR\AppData\Local\hermes\kanban.db`), shared across all profiles/personas, with atomic claim/lock (`claim_lock`/`claim_expires` columns — the same job Paperclip's `/checkout` endpoint does), and an autonomous dispatcher (`hermes kanban dispatch`, running continuously inside `hermes gateway start`) that reclaims stale claims and spawns workers with no human watching — a genuine heartbeat, not a passive board. `hermes-web-ui` already has a full native REST API for it (`packages/server/src/routes/hermes/kanban.ts` + a client store) sitting unused alongside `PaperclipView.vue`. `hermes cron` (11 subcommands) is a plain time-trigger scheduler with **no** claim/checkout semantics of its own — the concurrency-safe piece lives entirely in `kanban`, not `cron`.

**Concrete gaps vs. Paperclip:**
1. Hermes's `tenant`/`project_id` are free-text columns, not FK-enforced UUID entities like Paperclip's `companies→agents→projects` — no schema-level guarantee the 6 personas' data stays partitioned.
2. Today's whole setup (watchdog/backup cron jobs, `PaperclipView.vue`, the vault's own "Paperclip = MAIN SOURCE OF TRUTH" note) assumes Paperclip stays — flipping that is a real migration (retire the Paperclip service, repoint the UI at the already-built native kanban API, migrate live Postgres data into `kanban.db`, drop the now-pointless watchdog jobs), not a settings toggle.
3. Losing Postgres for SQLite is arguably a win at personal scale (fewer services running).

### Can Hermes grow SDLC-style governance (hooks)?

Yes — this is the strongest finding. `hermes hooks` is a **real `PreToolUse`-equivalent**, not a webhook/git-hook system: 16 named lifecycle events (`pre_tool_call`, `post_tool_call`, `pre_llm_call`, `pre_verify`, `subagent_stop`, etc.), each able to return `{"decision": "block", "reason": "..."}` and actually veto the action — documented in full at `website/docs/user-guide/features/hooks.md` with exact Python signatures and a JSON wire protocol for shell hooks. **Zero hooks are configured right now** (`hermes hooks list` → "No shell hooks configured") — the capability exists, fully documented, completely unused. `hermes plugins` additionally allows in-process Python gating via `ctx.register_hook(...)`. The one real limit: `command_allowlist` (the built-in dangerous-command gate) is a fixed category list — no custom conditions — so SDLC-style conditional logic (e.g. "block unless a manifest checkbox is ticked") has to go through the hook/plugin system, not the allowlist.

### ⚠️ Critical reframe — this does NOT solve iCubed's Claude→Copilot decoupling goal

Building governance hooks *inside Hermes specifically* only helps AIOS's personal side — it does not serve [[iCubed]]'s goal of letting SDLC run on Copilot as well as Claude. Per `AIOS-Hackathon-Architecture-Brief.md` (2026-07-10, pre-dating this research): *"we are not copying SDLC's governance layer into AIOS. We are building a new, tool-agnostic version of the same pattern — one that works whichever backend (Claude, Gemini, Hermes, Copilot) AIOS happens to be routing through."* Wiring new governance into Hermes's `pre_tool_call` hooks is exactly the same shape of vendor lock SDLC already has with Claude Code — just relocated to a different vendor (NousResearch instead of Anthropic). It doesn't make SDLC any more Copilot-compatible. See [[SDLC vs. Paperclip vs. Hermes as the orchestrator]] below for the pre-existing runtime-model comparison this builds on, and `AIOS-Hackathon-Architecture-Brief.md` for the full ThePopeBot precedent (a mature third-party project with the same ambition, using hand-wired per-agent conventions rather than a clean interface — the realistic difficulty bar for this kind of work).

## SDLC vs. Paperclip vs. Hermes as the orchestrator

Where would orchestration actually live, and what happens when nobody's watching, under each?

| | **SDLC (current)** | **If Paperclip ran it** | **If Hermes ran it** |
|---|---|---|---|
| Where the "brain" lives | Inside a live Claude Code session — hooks + markdown files + your typed command | A standalone always-on service (Node + Postgres) with its own heartbeat | A chat/model-router + multi-channel gateway — no task brain, but does have its own cron/skills/MCP-hosting layer |
| When it can act | Only while a Claude Code session is open and someone types a trigger word (or a scheduled `/loop` wakeup) | All the time — wakes itself on a timer, dispatches work whether or not anyone's watching | All the time for chat/voice/routing; has its own `cron` command too, but that's channel/skill automation, not ticket lifecycle |
| Where state lives | Flat JSON files in the git repo (`state.json`, `qa-manifest.json`) — git-diffable, but real merge conflicts across branches | A real Postgres database — relational, concurrent-safe, queryable | Its own SQLite session DB (hermes-web-ui) — tracks chat/session state, not tickets |
| How rules get enforced | Claude Code's hook system physically blocks a tool call if a step's skipped or a signal's faked (`manifest-step-guard.py`, `signal-fabrication-guard.py`) | No equivalent — you'd build gate logic into its API yourself | Has its own gate: `command_allowlist` + `tirith` scanner block dangerous shell ops, but this is a generic safety net, not a step-sequence/sign-off gate |
| Domain knowledge | Deeply Jira/Azure-DevOps/C#-specific — story-point tiers, ADO PR conventions, hotfix protocol | Generic — companies/projects/agents as plain UUIDs; you'd re-encode all of SDLC's process knowledge yourself | Generic — its skill marketplace is broad-purpose (computer-use, image-gen, automation), nothing Jira/ADO-specific |
| Human-in-the-loop | Built in — PO sign-off, Review Agent verdict, human-approved production PRs, watchable turn by turn | Weaker fit — built for fire-and-forget async workers | N/A — it's the entry channel (Discord/Slack/etc.), not a review gate |

**The core difference**: SDLC's orchestration is *pull* — nothing happens until a human (or scheduled wakeup) triggers a Claude Code session, and its whole guarantee system rides on Claude Code's own hook mechanism. Paperclip's orchestration is *push* — a real service that wakes itself and dispatches with nobody home, which is what it's built for, but it ships none of SDLC's process guardrails out of the box. Hermes isn't a real candidate for *running* the orchestration at all — it's the layer that decides which model answers and which channel a message came in on; it could sit in front of either SDLC or Paperclip as an entry point, but it can't replace the task/state/gate layer itself. If SDLC ever needed to run fully unattended, Paperclip's heartbeat model is the right shape to borrow — but the hook-enforced guardrails would need to be rebuilt as application logic, not inherited for free.

## 2026-07-22 — Approved implementation plan

The Hermes-can-replace-Paperclip + hook-safeguards findings above turned into an approved, scoped implementation plan: [[AIOS-Paperclip-to-Hermes-Migration-Plan]] — migrate Paperclip's live tasks into Hermes's native kanban, formalize AIOS's personas as a proper agent/assignee registry, and add Hermes hook safeguards including a human-verification gate. The SDLC-side Copilot-dispatch hardening was explicitly parked, not part of this round.

## Open Questions

- Should any of SDLC's 15 agents get a parallel native-subagent definition for quick one-shot use outside the full pipeline?
- Worth formalizing one shared persona-file convention (frontmatter/structure) across SDLC and AIOS, given both independently converged on "markdown role file + external loader"?
- Should the generic-vs-pipeline-specific split of SDLC's `settings.json` actually be carried out (promote generic permissions to global)?
- **Security**: `hermes-web-ui\packages\client\src\views\hermes\PaperclipView.vue` has a live Paperclip API key and a Todoist token hardcoded in plaintext — rotate both and move to secure config/`.env`. Not yet actioned.
