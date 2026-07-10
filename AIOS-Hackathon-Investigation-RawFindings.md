---
tags: [aios, hackathon, investigation, raw]
created: 2026-07-10
---

# Raw Investigation Findings — AIOS / ThePopeBot / SDLC (2026-07-10)

Verbatim-preserved output from the Explore agent's deep read of all three systems, before it was distilled into [[AIOS-Hackathon-Pitch-Script]] and [[AIOS-Hackathon-Architecture-Brief]]. Keep this as the source-of-truth archive — if a detail is missing from the polished docs, it's probably still here.

---

## 0. Session 2 addendum (2026-07-10) — Claude Code hooks portability + ThePopeBot deep dive

**Q: Do hooks/triggers work with other agents (agy/Gemini, GitHub Copilot, Hermes), or only Claude?**

Verified by reading `C:\Projects\SDLC\.claude\settings.json` directly. `PreToolUse`/`PostToolUse`/`SessionStart`/`UserPromptSubmit` hooks are a **Claude-Code-native mechanism** — only the `claude` binary reads `.claude/settings.json` and fires those events. Gemini CLI/`agy`, GitHub Copilot, and Hermes each have separate, different extensibility models; none would execute these Python hook scripts. What's portable is the *pattern* (shared state file + backup-before-write discipline + keyword-trigger routing), not the code — each target tool needs its own hand-built integration. See [[reference_claude_code_hooks_not_portable]].

**Q: ThePopeBot supports 6 coding agents — is that a real agent-agnostic abstraction?**

Full agent report (verified via direct source reads of `lib/tools/docker.js`, `docker/coding-agent/scripts/agents/*/`, `lib/ai/line-mappers.js`, `lib/ai/sdk-adapters/index.js`, `lib/ai/helper-llm.js`, `lib/llm-providers.js`, `package.json`, `docker/coding-agent/CLAUDE.md`, `api/index.js`):

> **Short answer: it's a real, working abstraction, but it's a convention-based, per-agent-branching abstraction — not a polymorphic/interface-based one.** There's a genuine shared contract that all six agents implement, and the system is fully wired end-to-end for all of them, but "pluggable" is accomplished mostly through parallel `if/else` branches and matching filenames/directory-naming conventions across JS and shell layers, rather than through a single abstract class/interface that a new adapter implements. Compare that to the **Helper LLM** layer, which genuinely is a clean, unified interface via the Vercel AI SDK.

**1. Where agent selection/dispatch happens** — two parallel dispatch layers:
- JS/Docker orchestration: `lib/tools/docker.js` — `runHeadlessContainer()`, `runInteractiveContainer()`, `runAgentJobContainer()`, `runClusterWorkerContainer()`, `runCommandContainer()` all take a `codingAgent` param, compute image tag `stephengpope/thepopebot:coding-agent-{agent}-{version}`, call `buildAgentAuthEnv(agent)` — a straight `if (agent === 'claude-code') {...} else if (...)` chain, not a registry of adapter objects.
- Shell-script layer inside container: `docker/coding-agent/entrypoint.sh` reads `RUNTIME` + `AGENT` env vars, sources `/scripts/${RUNTIME}/*.sh`, which delegate by convention to `/scripts/agents/${AGENT}/run.sh`. Real contract: every agent dir under `docker/coding-agent/scripts/agents/<agent>/` must implement exactly 6 same-named scripts (`auth.sh`, `setup.sh`, `run.sh`, `interactive.sh`, `start-coding-session.sh`, `merge-back.sh`) — documented in `docker/coding-agent/CLAUDE.md` ("Every agent MUST have these 6 scripts").
- Output-parsing layer: `lib/ai/line-mappers.js` — one hand-written mapper per agent (`mapClaudeCodeLine`, `mapPiLine`, `mapGeminiLine`, `mapCodexLine`, `mapOpenCodeLine`, `mapKimiLine`), each against that agent's actual different NDJSON schema. Selected via plain object lookup (`mapperMap`) in `parseHeadlessStream()` (`lib/ai/headless-stream.js`).

**2. Shared interface? What's actually different per agent?**
No TypeScript interface/abstract class exists (plain JS, no TS). Closest things to a contract: the 6-script shell convention (enforced only by a runtime directory-existence check, not a type system), and the normalized chunk shape (`{type: 'text'|'tool-call'|'tool-result'|'meta'|'error'|'auto-run', ...}`) yielded by both `streamViaSdk` and `streamViaContainer` in `lib/ai/index.js` — genuinely useful unification downstream of parsing.
Only Claude Code has an in-process SDK adapter: `lib/ai/sdk-adapters/index.js` — `getSdkAdapter(agentType)` returns `claudeCodeStream` for `'claude-code'`, `null` otherwise. Every other agent always shells out to Docker and parses stdout.

Concretely different per agent (not just config swap):
- CLI flags: Claude Code `-p "$PROMPT" --output-format stream-json --dangerously-skip-permissions`; Codex `codex exec "$PROMPT" --json --dangerously-bypass-approvals-and-sandbox`; Gemini `-p "$PROMPT" --output-format stream-json --approval-mode yolo|plan`.
- Auth mechanics differ structurally: most read API keys/tokens from env vars; **Codex CLI does not** — its `auth.sh` must actively run `codex login --with-api-key` ("Codex does NOT read OPENAI_API_KEY from env").
- System-prompt delivery differs per agent: Claude Code via `--append-system-prompt-file`; Pi via `.pi/SYSTEM.md`; OpenCode/Codex/Kimi via `AGENTS.md` in repo root; Gemini via `~/.gemini/SYSTEM.md` + `GEMINI_SYSTEM_MD` env var.
- Session-resume mechanics differ structurally per agent — 5 distinct patterns: native hooks (Claude Code/Codex/Kimi), a Bun plugin system (OpenCode), per-port `--session-dir` (Pi), an `AfterAgent` hook + filename-scraping hack (Gemini).
- Output format is entirely agent-specific NDJSON, requiring 6 separate hand-written mapper functions.

**3. End-to-end job flow (traced through actual files):**
Telegram message → `POST /api/telegram/webhook` → `handleTelegramWebhook()` in `api/index.js` → `processChannelMessage()` resolves user via `getByChannelChatId()` → calls the **same** `chatStream()` used by the browser chat UI (`lib/ai/index.js`) — one unified live-chat pipeline across web and Telegram, confirmed.
`chatStream()` resolves `CODING_AGENT` config → `getSdkAdapter(codingAgent)`. Claude Code → `streamViaSdk()` (in-process `@anthropic-ai/claude-agent-sdk` `query()`, no Docker). Else → `streamViaContainer()` → `runHeadlessContainer()` in `lib/tools/docker.js` → computes image tag, builds env vars via `buildAgentAuthEnv()`, calls Docker Engine API over Unix socket (`/var/run/docker.sock`) to create+start container, then `tailContainerLogs()` + `parseHeadlessStream()` (agent-specific NDJSON mapper) → normalized chunk stream.
Background/fire-and-forget jobs go through a separate path: `createAgentJob()` in `lib/tools/create-agent-job.js` — pushes an `agent-job/<uuid>` branch via GitHub's Git Data API (single tree commit containing `logs/<id>/agent-job.config.json` as source of truth for job metadata), then `runAgentJobContainer()` (named Docker volume, `RUNTIME=agent-job`). Inside container, `entrypoint.sh` sources `docker/coding-agent/scripts/agent-job/{1..8}_*.sh` in order — clone, agent-auth, agent-setup, build-prompt, agent-run (sources per-agent `run.sh`), commit-and-push, create-pr.
Container calls `gh pr create` (GitHub CLI), then `.github/workflows/auto-merge.yml` runs on GitHub Actions to squash-merge, then `notify-pr-complete.yml` POSTs to `/api/github/webhook` → `handleGithubWebhook()` → `summarizeAgentJob()` (helper LLM call) → `dispatchMessage()` writes a `messages` row and pushes to originating user's channel (Telegram) or broadcasts to admins if no `user_id`.
Note: agent-job containers run locally on the event-handler host, not on GitHub Actions — GitHub Actions only runs merge/notify/rebuild workflows.

**4. Helper LLM layer — cleaner?**
Yes, substantially. `lib/ai/helper-llm.js` uses the **Vercel AI SDK** (`ai` package, `generateText`/`generateObject`) plus official provider packages (`@ai-sdk/anthropic`, `@ai-sdk/openai`, `@ai-sdk/google`, `@ai-sdk/openai-compatible`) confirmed in `package.json`. `resolveModel()` returns a real polymorphic `LanguageModelV2` object — after that, `callHelperLlm()`/`callHelperLlmStructured()` are provider-agnostic with zero per-provider branching beyond `resolveModel()`. Provider metadata centralized in one declarative table, `lib/llm-providers.js`'s `BUILTIN_PROVIDERS`. Adding a new one-shot LLM provider ≈ add an entry to `BUILTIN_PROVIDERS` (+ maybe one branch in `resolveModel()` if not already OpenAI-compatible) — much smaller than adding a coding agent. This layer is used only for one-shot calls (chat titles, agent-job summaries), separate system from coding-agent execution.

**5. Adding a 7th coding agent — what's required:**
`docker/coding-agent/CLAUDE.md` ("Adding a New Coding Agent") lists this explicitly as NOT a small adapter — a checklist of ~8-10 touch points: (1) new `Dockerfile.<agent-name>`; (2) 6 new shell scripts under `docker/coding-agent/scripts/agents/<agent-name>/`, each hand-written against that CLI's actual flags/output format including figuring out its session-tracking mechanism; (3) new registration in `bin/docker-build.js`'s `CODING_AGENTS` array; (4) new branch in `buildAgentAuthEnv()`; (5) new config keys in **three separate places** in `lib/config.js` (`CONFIG_KEYS` allowlist, `DEFAULTS`, `SECRET_KEYS`) — doc calls out that missing the `CONFIG_KEYS` entry causes `getConfig()` to silently return `undefined` even though writes succeed (a real footgun); (6) UI registration in `settings-coding-agents-page.jsx` + `lib/chat/actions.js`; (7) new NDJSON mapper in `line-mappers.js` + entry in `mapperMap` + entry in `providerKeys` in `lib/ai/index.js`. That's a non-trivial, multi-file, "learn this CLI's exact wire format" effort each time — the project's own documentation frames it as an explicit numbered checklist, evidence the maintainers know it's manual, repetitive work rather than a plug-in system.

**Verification caveat (from the investigating agent):** Claude Code, Codex CLI, and Gemini CLI's `run.sh`/`auth.sh` were read directly; Pi, OpenCode, and Kimi CLI were cross-checked against `docker/coding-agent/CLAUDE.md`'s per-agent tables (consistent with the pattern) but not diffed line-by-line against raw script bodies.

**Bottom line used in the pitch:** ThePopeBot demonstrates both patterns side by side — a genuinely universal adapter for simple one-shot LLM calls (Helper LLM/Vercel AI SDK), and hand-wired, convention-based (not interface-based) plumbing for the harder problem of swappable coding agents. Even a serious, actively-developed third-party project hasn't found a clean universal interface for *that* harder problem — useful validation that "build a tool-agnostic governed pipeline" is a real, unsolved, valuable problem, not something to copy wholesale.

---

## 1. What AIOS actually is

AIOS is not a coded framework/engine that the user built — it's an orchestration layer of configuration, routing files, and glue scripts built on top of several third-party tools, centered on Claude Code and a separate open-source CLI agent called "Hermes." The directory `C:\Personal\AIOS` is best described as a personal "mission control" folder — a structured knowledge base + config layer that different AI tools (Claude Code, Hermes CLI, a Discord gateway, "agy" a Gemini-based worker CLI) all read from and route through.

**Origin:** The repo started life as a free public starter-kit template called "AIS-OS" (AI Automation Society OS) by a course creator "Nate Herk" (see `C:\Personal\AIOS\README.md` — this is the template's README, largely unmodified). The user cloned that skeleton (Context / Connections / Capabilities / Cadence — "The Four Cs" — and Mindset/Method/Machine — "The Three Ms") and then heavily extended it into his own personal system. The real operating manual is `CLAUDE.md` at the AIOS root (12KB, actually written by/for the user, last touched 2026-07-08), not the generic README.

**Core abstraction — what makes it "central":**
- It is a directory of context files (`context/`, `connections/`, `personas/`, `routing/`) that any LLM session — Claude Code, Hermes, Gemini via GEMINI.md — reads before acting, so "the AIOS" is really the sum of persistent files on disk that every tool is configured to consult first, not a running process of its own.
- The one piece of actual running infrastructure the user wrote himself is `claude-gateway/gateway.py` (57KB Python/discord.py bot) — a Discord bot that shells out to the `claude` CLI (`subprocess.Popen([CLAUDE_EXE, "--resume", ...])`) per channel/persona. Each Discord channel = a "persona" (fixed working directory + fixed session UUID + optional system prompt), defined in `gateway_personas.json` (aios, work, personal, financial, plumb, au-marketing, au-finance). This is the closest thing to a genuine "central hub" — it's literally routing multiple business domains through one Claude Code binary.
- A second interface, `chat-ui/server.py` + `index.html`, is a small local web chat UI (Flask/FastAPI-style Python server, ~14KB) — a lightweight home-grown alternative to Discord.

**LLM interfacing — is the model swappable?**
- For Claude: not via an API client library — the gateway invokes the installed `claude.exe` CLI as a subprocess with `--dangerously-skip-permissions` or `--permission-mode acceptEdits`, passing prompts over stdin and streaming stdout back to Discord. So "model swapping" for Claude happens at the CLI's own config level, not inside AIOS code.
- For Gemini: there's a parallel `GEMINI.md` (mirrored from `CLAUDE.md` via `scripts/sync_claude_to_gemini.py`) and an "agy" CLI (a free Gemini-based delegate worker, launched with `--dangerously-skip-permissions`, reads `GEMINI.md` not `CLAUDE.md`).
- For "Hermes": a completely separate installed tool at `C:\Users\MarthinusR\AppData\Local\hermes\hermes-agent` (its own git repo, `providers/`, `acp_adapter/`, Docker, i18n locales) — this is a full multi-provider agent CLI in its own right, and AIOS's `scripts/hermes-persona-sync.py`, `hermes-priorities-sync.py`, `hermes-memory-bridge.py` exist purely to push AIOS's context files into Hermes's format so Hermes sessions stay in sync with AIOS's knowledge.
- Net effect: the model is swappable only in the loose sense that AIOS maintains parallel context files (`CLAUDE.md`, `GEMINI.md`) and separate sync scripts per tool. There is no single internal "LLM client" abstraction/interface that AIOS code calls through — each surface (gateway.py, Hermes, agy) has its own separate, hard-coded way of invoking its model.

**Persistence/memory system — yes, and it's the most developed part:**
- Obsidian wiki is the explicit source of truth (`wiki/` folder, using what the user calls the "Karpathy method" — raw docs dropped in `wiki/raw/`, then ingested into linked `wiki/wiki/*.md` pages with an `index.md` hub). CLAUDE.md states explicitly: "All notes, memories, and reference material go to the Obsidian wiki — not Claude memory."
- Three separate wikis exist for Personal / Work / AIOS domains.
- `decisions/log.md` for append-only decision history.
- Session aliasing/session-UUID persistence in the Discord gateway (`session_aliases.json`).
- A "Graphify" knowledge-graph tool indexes the codebase (God nodes, community structure) — `graphify-out/graph.json` — queried before falling back to raw file reads ("70x more tokens" savings, per CLAUDE.md).
- A cron-based "AIOS Dreaming" script (`scripts/aios-dreaming.py`) runs nightly autonomous analysis.
- MemPalace (ChromaDB + SQLite structured memory) is referenced as an additional memory layer in the wiki architecture doc.

**Existing interface layers:**

| Interface | File | Description |
|---|---|---|
| Discord | `claude-gateway/gateway.py` | Multi-persona bot, shells to `claude.exe` CLI |
| Web chat | `chat-ui/server.py` + `index.html` | Local browser chat UI |
| CLI | Claude Code itself, plus `agy` (Gemini worker) and `hermes` (separate agent CLI) | Direct terminal use |
| Telegram | Referenced in CLAUDE.md skill `braindump-kanban` ("Telegram brain dump to Kanban queue execution via agy CLI") — but the actual bot code lives outside AIOS, likely in Hermes or Paperclip | |

**Existing documentation:** `C:\Personal\AIOS\wiki\wiki\aios-architecture-overview.md` is the single best summary the user has already written of his own system (Hermes Agent, Paperclip task management, Three Wikis, agy CLI, Graphify, memory layers, automation/cron layer). There's also `wiki/wiki/aios-enhancement-master.md`, a prioritized roadmap of planned enhancements (Ministry of Experts, Model Routing Table, Dynamic Workflow Orchestrator, "Fable Mode," Board of Directors, etc.).

---

## 2. What ThePopeBot actually is

Important correction to the premise: ThePopeBot is not a project the user built — it is a third-party open-source project (`github.com/stephengpope/thepopebot`, npm package `thepopebot`, currently v1.2.82, MIT-ish licensed, tied to a paid community "AI Architects" on Skool). The user has:
- Cloned it at `C:\Projects\thepopebot`, with git remote named `upstream` (not `origin` — meaning no personal fork/publish target is configured).
- The only local commit ahead of upstream is titled "POPE BOT WIP" and its diff only deletes files (`bin/cli.js`, `bin/sync.js`, `bin/postinstall.js`, etc. — ~1958 lines removed, 0 added). This looks like an in-progress/broken local edit, not a feature the user added.
- Also installed globally via npm (`C:\nvm\v24.11.0\node_modules\thepopebot`), and there's a `C:\Projects\t2\data\db\thepopebot.sqlite` suggesting a scaffolded instance was run somewhere (`t2` project) via `npx thepopebot init`.

**What it does (per its own docs, `C:\Projects\thepopebot\README.md` and `docs\ARCHITECTURE.md`):** ThePopeBot is a self-hosted personal agent + coding-agent platform — "your personal agent, coding environment, and communication platform, all in one app." Concretely:
- A single Next.js process ("the event handler") running in Docker, backed by SQLite via Drizzle ORM, orchestrates: web chat, Telegram chat (Slack/Discord "coming soon"), scheduled cron jobs, webhook triggers, and Docker containers that run coding agents.
- Supports six pluggable coding-agent backends: Claude Code, Pi, Codex CLI, Gemini CLI, OpenCode, Kimi CLI — genuinely swappable per job/session via admin UI config (`/admin/event-handler/coding-agents`).
- Supports ten+ LLM providers for a separate "Helper LLM" role (one-shot calls like chat titles/summaries): Anthropic, OpenAI, Google, DeepSeek, MiniMax, Mistral, xAI, Kimi, OpenRouter, NVIDIA, or any OpenAI-compatible endpoint.
- Two work modes: live chat (question/answer, runs in-process via `@anthropic-ai/claude-agent-sdk` for Claude, or in an ephemeral headless Docker container for other agents) vs. agent jobs (fire-and-forget: spawns a Docker container, agent commits code, opens a GitHub PR, an Actions workflow auto-merges it, then DMs the user back via Telegram).
- Has live coding workspaces (in-browser terminal attached to a persistent Docker container via `ttyd` + WebSocket proxy) and "clusters" (groups of containers spawned from role definitions, with cron/webhook/file-watch triggers).

**Architecture summary (from its own `ARCHITECTURE.md`):** one Next.js "event handler" host talks to a Docker socket to launch per-job/per-session containers; GitHub is used for repo I/O (branches, PRs); Telegram/webhooks come in via `/api/*` routes; runtime config lives in SQLite (`settings` table), `.env` only holds bootstrap variables.

**Does it share code/patterns with AIOS?** No shared code. But there is a striking architectural resemblance: both are "one central process routes multiple chat channels to a pluggable coding agent, tracks sessions, and can fire background jobs" — ThePopeBot just implements this properly as a real app (Next.js + Docker + Postgres/SQLite + GitHub Actions), whereas AIOS's equivalent (`gateway.py`) is a single 57KB Python script that shells out to the Claude CLI with no database, no multi-agent abstraction, and no job/PR automation.

**Is it standalone or does it depend on AIOS?** Fully standalone — it has zero references to AIOS, Hermes, or any of the user's other tools. It is its own product with its own database, its own Docker images, its own GitHub Actions. The user appears to be evaluating/tinkering with it (broken WIP commit, no meaningful customization yet) rather than running it in production.

---

## 3. SDLC repo — reusable infrastructure (raw notes)

Quick scan of `C:\Projects\SDLC\.claude\hooks/` and settings confirms this repo has real, non-trivial Python orchestration code, distinct from prompts/skills:
- **`state_writer.py`** — a shared library enforcing atomic backup-then-write semantics on a JSON `state.json` "shared memory" file (retries, pruning of old backups, error logging) — a small but genuine state-management primitive.
- **Guard hooks** (`manifest-step-guard.py`, `self-review-gate.py`, `manifest-exists-guard.py`, `manifest-worklog-guard.py`) — mechanically enforce a multi-step task manifest/workflow ordering (can't PR until steps checked off, can't mark complete without a logged review) — this is a genuine workflow/state-machine enforcement engine, gating tool calls via Claude Code's hook system (`PreToolUse`/`PostToolUse`/`SessionStart`/`UserPromptSubmit` in `.claude/settings.json`).
- **~30 "trigger" scripts** (`code-trigger.py`, `qa-trigger.py`, `groom-trigger.py`, etc.) — a keyword-based dispatcher/router layer: `UserPromptSubmit` hooks pattern-match trigger words in the user's message and invoke specific agent skills — effectively a hand-rolled command-routing/orchestration engine sitting in front of Claude Code.
- **`jira-status-cache-hook.py`, `jira-archival-hook.py`, `sta-gate-hook.py`** — Jira-integration side-effects and state caching, tied to this specific SDLC domain (less generically reusable).
- **`compact-checkpoint-hook.py`, `state_archiver.py`, `state_cleanup.py`** — checkpoint/recovery logic around context compaction.

**Verdict on reusability:** Yes — the hook-registration pattern itself (Claude Code's `settings.json` hooks + Python scripts doing state-machine gating), the `state_writer.py` backup-write primitive, and the keyword-trigger routing pattern are all generic, extractable pieces of infrastructure — genuinely different from "just prompts." They could plausibly be lifted out as a reusable "Claude Code orchestration hooks" module that AIOS's gateway.py currently lacks entirely (AIOS has no state-machine, no manifest/gate system, no structured hook layer — it's still a bare subprocess wrapper).

---

## 4. Concrete interoperability facts

- **Language/runtime overlap:** AIOS's real code (gateway.py, chat-ui, scripts) is Python + a bit of PowerShell/batch. ThePopeBot is Node.js/Next.js/JSX. SDLC's hooks are Python. So AIOS and SDLC share a language (Python) and could share code directly; ThePopeBot cannot be imported into either — any interop with it would have to be over its documented HTTP API (`/api/create-agent-job`, `/api/send-dm`, `/api/users`, all keyed by `x-api-key`), not code-level integration.
- **Shared LLM-invocation pattern:** All three "call Claude" by shelling out to a CLI or SDK, not a raw HTTP client: AIOS's gateway.py subprocesses `claude.exe`; ThePopeBot uses `@anthropic-ai/claude-agent-sdk` in-process for Claude Code and Docker containers for other agents; SDLC's hooks run inside an actual Claude Code session (no separate invocation needed, they're first-party hooks). This means the "swap the model" conversation is really "swap the CLI backend or SDK client," not "swap an API parameter" in any of the three.
- **No existing dependency in either direction.** AIOS does not import ThePopeBot or SDLC. ThePopeBot doesn't know AIOS exists. SDLC's hooks are entirely self-contained to that repo. Any "AIOS is central and things plug into it" narrative should be scoped honestly: today AIOS is central only insofar as its context files are read by multiple tools (Hermes, Claude Code, agy/Gemini) — it is not central in the sense of being a runtime hub other services register with or call into.

**Key file paths for reference:**
- `C:\Personal\AIOS\CLAUDE.md` — real operating manual
- `C:\Personal\AIOS\README.md` — inherited AIS-OS template README
- `C:\Personal\AIOS\claude-gateway\gateway.py`, `PERSONAS.md`, `gateway_personas.json`
- `C:\Personal\AIOS\chat-ui\server.py`, `index.html`
- `C:\Personal\AIOS\wiki\wiki\aios-architecture-overview.md`, `aios-enhancement-master.md`, `index.md`
- `C:\Personal\AIOS\scripts\hermes-persona-sync.py`, `sync_claude_to_gemini.py`, `aios-dreaming.py`
- `C:\Users\MarthinusR\AppData\Local\hermes\hermes-agent\` — separate Hermes CLI tool
- `C:\Projects\thepopebot\README.md`, `docs\ARCHITECTURE.md`, `.git` remotes (upstream only)
- `C:\Projects\SDLC\.claude\hooks\README.md`, `state_writer.py`, `manifest-step-guard.py`, `self-review-gate.py`
- `C:\Projects\SDLC\.claude\settings.json` — hook registration wiring
