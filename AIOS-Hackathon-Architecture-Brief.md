---
tags: [aios, hackathon, architecture, reference]
created: 2026-07-10
---

# AIOS Hackathon — Technical Architecture Brief

Backup reference for [[AIOS-Hackathon-Pitch-Script]]. Use this for slide diagrams and to answer technical follow-up questions — not for the spoken script itself.

---

## What AIOS actually is (ground truth, 2026-07-10)

AIOS is **not a coded runtime engine** — it's a personal "mission control" folder: a structured set of context/memory/routing files that multiple separate AI tools read before acting.

- **Origin:** cloned from a public template ("AIS-OS" by Nate Herk — Context / Connections / Capabilities / Cadence, "The Four Cs"), then heavily extended.
- **Real operating manual:** `C:\Personal\AIOS\CLAUDE.md` (not the inherited `README.md`, which is still the generic template text).
- **The one piece of real infrastructure the user wrote:** `claude-gateway\gateway.py` — a ~57KB Python Discord bot. Each Discord channel = a "persona" (fixed working directory + fixed session UUID + optional system prompt), configured in `gateway_personas.json` (aios, work, personal, financial, plumb, au-marketing, au-finance). It works by shelling out to the installed `claude.exe` CLI (`subprocess.Popen([CLAUDE_EXE, "--resume", ...])`) and streaming stdout back to Discord.
- **Second interface:** `chat-ui\server.py` + `index.html` — a small local web chat UI.
- **Memory / persistence (the most developed part):**
  - Obsidian wiki as explicit source of truth (`wiki/raw/` → ingested `wiki/wiki/*.md`, "Karpathy method") — three separate wikis for Personal / Work / AIOS domains.
  - `decisions/log.md` — append-only decision history.
  - **Graphify** — a knowledge-graph index of the codebase (god nodes, community structure) queried before raw file reads, for token efficiency.
  - **MemPalace** — ChromaDB + SQLite structured memory layer, referenced in the wiki architecture doc.
  - `aios-dreaming.py` — a nightly cron job doing autonomous analysis.
- **Multi-model support today:** parallel context files per tool — `CLAUDE.md` for Claude Code, `GEMINI.md` (mirrored via `scripts/sync_claude_to_gemini.py`) for a Gemini-based CLI called "agy." There is **no single internal LLM-client abstraction** — each surface hard-codes its own invocation method (subprocess for Claude, separate CLI for Gemini).
- **Hermes:** a separate, fully third-party, open-source multi-provider agent CLI installed at `C:\Users\MarthinusR\AppData\Local\hermes\hermes-agent` (own `providers/`, `gateway/`, `acp_adapter/`, Docker, i18n locales). AIOS does not contain it — AIOS has sync scripts (`hermes-persona-sync.py`, `hermes-priorities-sync.py`, `hermes-memory-bridge.py`) that push AIOS's context into Hermes's format so Hermes sessions stay aligned.

**Honest positioning:** AIOS is "central" only in the sense that its *context files* are read by several tools (Claude Code, Hermes, agy/Gemini). It is not central in the sense of being a runtime hub that other services register with or call into — there's no message bus, no service registry, no shared runtime process.

---

## SDLC (`C:\Projects\SDLC`) — the governed multi-agent pattern

- Coordinates **13 specialized agent roles** (PO, Architect, Coding, Review, QA, Scrum Master, Compliance, Documentation, Deployment, Self-Healing, Triage, UI Test, Researcher) across the software delivery lifecycle for real team repos.
- **Core primitive:** `state.json` — a single shared JSON file every agent reads; only the Central Orchestrator writes most sections (a few "ephemeral handshake" sections are written directly by specific agents). This is the closest thing to genuine reusable engineering found across all three systems.
- **Backup-before-write discipline:** `state_writer.py` — every write to `state.json` is preceded by an automatic backup (last 10 retained); raises on backup failure rather than risking a corrupt write.
- **Hook-based governance:** Claude Code `PreToolUse`/`PostToolUse`/`SessionStart`/`UserPromptSubmit` hooks enforce workflow rules mechanically — e.g. can't open a PR until manifest steps are checked off, can't mark a task complete without a logged self-review. This is a genuine state-machine/gating engine, not a prompt.
- **Keyword-trigger routing:** ~30 "trigger" scripts pattern-match keywords in user messages (`code <TICKET>`, `test <TICKET>`, `groom`, etc.) and dispatch to the right agent skill — a hand-rolled command router in front of Claude Code.
- **Jira integration:** all reads/writes go through an MCP Jira service — tickets, comments, transitions, all agent-driven.

**Why this is the natural donor to AIOS:** AIOS's `gateway.py` today is a bare subprocess wrapper — no state machine, no multi-step gating, no structured routing. SDLC's hook + state-file pattern is the exact missing piece for "AIOS personas doing governed, multi-step work" instead of one-shot chat replies.

**Critical caveat — hooks are NOT portable across agent tools (verified 2026-07-10 by reading `C:\Projects\SDLC\.claude\settings.json` directly):**
- `PreToolUse`/`PostToolUse`/`SessionStart`/`UserPromptSubmit` hooks are a **Claude-Code-native mechanism**. Only the `claude` binary reads `.claude/settings.json` and fires those events at those moments.
- If a request goes through Gemini CLI (`agy`), GitHub Copilot, or Hermes instead of Claude Code, **none of these hook scripts execute** — those tools have their own, different extensibility models, not this one.
- **What's actually portable is the *pattern*, not the code:** a shared `state.json` file and backup-before-write discipline (`state_writer.py`) are just JSON + a Python function — any tool *could* be made to read/write them, but each tool needs its own hand-built integration. Same for keyword-trigger routing — the concept transfers, the Claude-Code-hook implementation doesn't.
- **Correct framing:** we are not "copying SDLC's governance layer into AIOS." We are building a **new, tool-agnostic version of the same pattern** — one that works whichever backend (Claude, Gemini, Hermes, Copilot) AIOS happens to be routing through at the time. This is real, novel engineering work for the hackathon, not a lift-and-shift.

---

## ThePopeBot — third-party proof point (not code we're adopting)

- `github.com/stephengpope/thepopebot`, npm package `thepopebot`, MIT-ish licensed, tied to a paid "AI Architects" community. **Not built by us** — cloned/evaluated only, no meaningful local customization (the one local commit is a broken WIP that only deletes files).
- **Architecture:** a single Next.js "event handler" process + Docker, SQLite (Drizzle ORM). Talks to the Docker socket to launch per-job/per-session containers. GitHub used for repo I/O (branches, PRs, Actions auto-merge).
- **Channels:** web chat, Telegram (Slack/Discord "coming soon").
- **Pluggable coding agents:** Claude Code, Pi, Codex CLI, Gemini CLI, OpenCode, Kimi CLI — swappable per job via admin UI.
- **Pluggable "Helper LLM"** (for one-shot calls like chat titles): 10+ providers (Anthropic, OpenAI, Google, DeepSeek, Mistral, xAI, Kimi, OpenRouter, NVIDIA, or any OpenAI-compatible endpoint).
- **Two work modes:** live chat (in-process via `@anthropic-ai/claude-agent-sdk` for Claude, ephemeral Docker for others) vs. agent jobs (fire-and-forget: container → commit → PR → auto-merge → Telegram DM back).
- **Live coding workspaces:** in-browser terminal via `ttyd` + WebSocket, attached to a persistent container.

**No code-level relationship to AIOS or SDLC exists today** — no imports, no shared runtime, no shared database. The resemblance is purely architectural: "one hub routes multiple chat channels to a pluggable coding agent, with background job + PR automation" is a pattern ThePopeBot arrived at independently, which is exactly why it's useful as *external validation* rather than a component to integrate.

### Is ThePopeBot's multi-agent support a real abstraction? (verified by reading source, 2026-07-10)

**Partially — it's real and working, but convention-based rather than a clean interface.**

- All 6 coding-agent backends (Claude Code, Pi, Codex CLI, Gemini CLI, OpenCode, Kimi CLI) are genuinely wired end-to-end — verified by reading actual dispatch code (`lib/tools/docker.js`), shell scripts (`docker/coding-agent/scripts/agents/<agent>/`), and output parsers (`lib/ai/line-mappers.js`).
- **There is no `CodingAgent` interface/abstract class anywhere in the codebase** (plain JS, no TypeScript). "Pluggability" is achieved via: (a) a documented convention — every agent directory must contain 6 identically-named shell scripts (`auth.sh`, `setup.sh`, `run.sh`, `interactive.sh`, `start-coding-session.sh`, `merge-back.sh`), enforced only by a runtime directory-existence check, not a compiler/type system; (b) parallel hardcoded `if/else` branches keyed on the agent-name string, repeated across at least 4 separate places (`buildAgentAuthEnv()`, the NDJSON mapper lookup table, the provider-key lookup table, and `lib/config.js`'s key registries).
- **Only Claude Code runs in-process** (via `@anthropic-ai/claude-agent-sdk`, `getSdkAdapter()` in `lib/ai/sdk-adapters/index.js`). All other 5 agents always shell out to a Docker container and the system parses raw stdout.
- **What's genuinely different per agent, not just config:** CLI flags/prompt positioning, auth mechanics (Codex CLI notably does NOT read its API key from env — requires an active `codex login` step), system-prompt delivery method (5 different mechanisms across the 6 agents), session-resume mechanics (5 distinct patterns: native hooks, a Bun plugin, per-port session dirs, filename-scraping hacks), and full custom NDJSON output parsers per agent.
- **The project's own docs (`docker/coding-agent/CLAUDE.md`) list "Adding a New Coding Agent" as an explicit numbered checklist of ~8-10 touch points** across a new Dockerfile, 6 new shell scripts, a build-registration entry, a new auth branch, config keys in 3 separate places, a new UI settings card, and a new output-mapper function. This is documented as manual, repetitive work — not a drop-in adapter.
- **Contrast — the Helper LLM layer (for one-shot calls like summaries) is genuinely clean:** built on the Vercel AI SDK's real `LanguageModelV2` interface (confirmed in `package.json`: `ai`, `@ai-sdk/anthropic`, `@ai-sdk/openai`, `@ai-sdk/google`, `@ai-sdk/openai-compatible`). Adding a new one-shot LLM provider here is close to a one-line addition to a declarative provider table (`lib/llm-providers.js`) — a real contrast to the coding-agent layer's hand-wired approach.

**Takeaway for the pitch:** ThePopeBot demonstrates both patterns side by side — a genuinely universal adapter for simple one-shot LLM calls, and hand-wired, convention-based (not interface-based) plumbing for the harder problem of swappable coding agents. Even a serious, actively-developed third-party project hasn't found a clean universal interface for *that* harder problem. This is useful validation that "build a tool-agnostic governed pipeline" (our own ambition, informed by the SDLC hooks-portability finding) is a real, unsolved, valuable problem — not something we'd be behind on, and not something to copy wholesale.

---

## Interoperability facts (for the "how would we actually connect these" question)

- **Language overlap:** AIOS's real code (gateway.py, chat-ui, scripts) and SDLC's hooks are both Python — these two could share code directly (e.g., lifting `state_writer.py`'s pattern into AIOS). ThePopeBot is Node.js/Next.js — no direct code sharing possible; any integration would go through its documented HTTP API (`/api/create-agent-job`, `/api/send-dm`, `/api/users`, keyed by `x-api-key`).
- **Shared "how do we call the model" pattern:** all three invoke Claude via a CLI or SDK rather than a raw HTTP client — AIOS subprocesses `claude.exe`; ThePopeBot uses `@anthropic-ai/claude-agent-sdk` in-process (or Docker for other agents); SDLC's hooks run *inside* an actual Claude Code session already. So "swap the model" in practice means "swap the CLI/SDK backend," not a simple API parameter change, in all three systems.
- **No existing dependency in any direction today.** Any slide showing arrows between these three systems should be labeled as **proposed**, not existing.

---

## Suggested slide breakdown for NotebookLM

1. Title / hook
2. The problem (stateless AI chat vs. an assistant that remembers + acts)
3. AIOS today — diagram: wiki/memory → routing/personas → Discord + web interfaces
4. SDLC today — diagram: shared state file + hooks + 13 agents + Jira
5. ThePopeBot — diagram: their hub/container/PR-automation model, labeled "external validation"
6. The consolidation proposal — table from the pitch script section 5
7. Roadmap milestone: background jobs + auto-PR + notify-back
8. Close / ask
