---
tags: [aios, hackathon, icubed, sdlc, interface, wiki]
created: 2026-07-13
status: active
---

# AIOS / SDLC-as-OS — Web Interface Layer (running wiki)

Running log for the iCubed hackathon thread: putting a web interface on top of **SDLC** (not STLC — corrected 2026-07-13) so a user can kick off SDLC actions (agent dispatch, ticket work, etc.) from a browser instead of only through Claude Code's CLI/chat.

See [[AIOS-Hackathon-Architecture-Brief]] for the full technical ground-truth on AIOS, SDLC, and ThePopeBot — this page is scoped narrowly to the **interface layer** decision thread and stays updated as that work progresses. Don't duplicate the brief's content here; link to it.

> **Thread discipline:** this conversation is iCubed-only. The SDLC repo's own cron-fired skills (`agent_watchdog.py`, `ticket_dispatch_poller.py`, grooming queue sweep, advisory scratchpad) fire automatically as Stop-hook prompts in this same working directory, but per explicit request they are declined here and left for a dedicated SDLC-ops session/thread instead.

---

## 2026-07-13 — Framing & survey

**Goal stated by user:** *"we're going to start using SDLC as the OS. So as an AIOS... we want to put a web app on top of SDLC, so it is easier for user to kick start certain actions in SDLC. So it might just be as simple as buttons or it might be having a chat inside a web interface."*

Surveyed three local codebases for reusable interface patterns (full pointers in `.claude` memory at `project_aios_icubed_web_interface.md`, session-scoped):

- **`C:\Projects\thepopebot`** — best template. Next.js. Two reusable patterns:
  - Streaming chat: `lib/chat/api.js` `/stream/chat` POST handler → Claude Agent SDK → Vercel AI SDK `createUIMessageStream`.
  - Button/fire-and-forget: `lib/actions.js` `executeAction()` (`agent|command|webhook` types) → `lib/tools/create-agent-job.js` `createAgentJob()` → git branch + disposable Docker container running Claude Code.
  - Per the architecture brief: genuinely working but convention-based multi-agent plumbing, not a clean interface — useful validation, not a component to lift wholesale.
- **`C:\Personal\AIOS\claude-gateway`** — Discord bot, `gateway.py`, subprocess wrapper around `claude.exe` (`--resume`/`--session-id --print`), persona = Discord channel = workdir + session UUID (`gateway_personas.json`). No state machine, no multi-step gating — this is the "bare subprocess wrapper" the architecture brief flags as the gap SDLC's hook+state pattern would fill.
- **`C:\Personal\paperclip`** — heaviest, adapter-plugin orchestrator (TS/Node), `execute.ts` spawns Claude Code as subprocess, streams via `onLog` callbacks to a server the web UI subscribes to. Overkill for hackathon MVP; adapter abstraction worth studying only if this grows past a demo.

**Critical constraint already established in the brief (2026-07-10) — carries directly into this interface work:** SDLC's governance layer (hooks, `state.json`, backup-before-write) is **Claude-Code-native**, not portable to other agent backends (Gemini/agy, Hermes, Copilot) without a hand-built equivalent per tool. Any web interface that dispatches into SDLC needs to either (a) go exclusively through Claude Code sessions to keep the governance intact, or (b) explicitly reimplement a tool-agnostic version of the state-file + gating pattern — not assume the hooks "just work" from a different backend.

**Recommended MVP sequencing (not yet built):**
1. Buttons → subprocess/Docker call into Claude Code with a canned prompt driving an SDLC trigger (e.g. `code <TICKET>`), following thepopebot's `actions.js` pattern.
2. Once proven, layer in streaming chat via the `/stream/chat` pattern for freeform interaction.
3. Windows-specific gotcha to carry over regardless of framework: claude-gateway's daemon-thread + `asyncio.Queue` workaround for the ProactorEventLoop pipe-buffer deadlock on large stdout.

**Open / not yet decided:**
- Which process actually hosts this web app (new service inside `C:\Projects\SDLC`? inside AIOS? standalone?).
- Whether the web UI talks to SDLC hooks directly (Claude-Code-only) or needs the tool-agnostic state-file reimplementation described in the brief.
- Scaffold not yet built — next concrete step is a minimal Next.js or Express button → Claude Code subprocess call against an SDLC trigger.

---

## 2026-07-13 — chat-ui already IS the web bridge; session mechanics wireframed

**Key finding:** `C:\Personal\AIOS\chat-ui\server.py` + `index.html` is already a fully working web-chat-to-Claude-Code bridge, and it's already pointed at SDLC. Verified by reading the source, not inferred:

- FastAPI + WebSocket server that reuses **exactly** claude-gateway's subprocess pattern: `subprocess.Popen([CLAUDE_EXE, "--output-format", "stream-json", "--verbose", "--print", "--dangerously-skip-permissions", "--resume"/"--session-id", ...])`, prompt piped over stdin, stdout parsed as `stream-json` events and forwarded over the WebSocket. Same Windows daemon-thread + `asyncio.Queue` workaround as claude-gateway (dodges the ProactorEventLoop deadlock — uvicorn uses SelectorEventLoop).
- Loads personas from the **same file** claude-gateway uses — `gateway_personas.json`. That file already has a `"Work"` persona: `workdir: C:\Projects\SDLC`, its own fixed session UUID, and a work-specific `CLAUDE.md` context file.
- **Upshot: chat-ui can already drive SDLC via freeform chat today, right now, no new backend code.** The only gap for "buttons" is a row in `index.html` that pre-fills the prompt box with canned SDLC trigger strings (`code OPEN-XXXX`, `test OPEN-XXXX`, `groom`, etc.) against the existing Work persona.

### How each of the three surveyed systems sends/receives and maintains sessions

**1. Paperclip**

```
┌─────────────┐        HTTP/WS         ┌──────────────────────┐
│   Web UI     │ ─────────────────────▶│  Orchestrator Server  │
│ (React)      │◀───────────────────── │  (Node, server/src)   │
└─────────────┘   onLog stream events  └───────────┬───────────┘
                                                    │ execute()
                                                    ▼
                                     ┌──────────────────────────┐
                                     │  claude-local ADAPTER     │
                                     │  execute.ts               │
                                     │  buildClaudeRuntimeConfig │
                                     └──────────────┬────────────┘
                                                    │ spawn subprocess
                                                    ▼
                                     ┌──────────────────────────┐
                                     │   claude  (CLI process)   │
                                     │  cwd = workspace/agentHome│
                                     └──────────────────────────┘

SESSION HANDLING:
  runId (per orchestrator run) ──▶ maps to a workspace dir on disk
  (agentHome / worktreePath) ──▶ session continuity = which WORKTREE
  you resume into, not a bare --resume <uuid> flag alone.
  Server owns the run's lifecycle (start/stop/log) — session state
  lives in the orchestrator's own DB (tickets/runs), not just Claude's
  own session file.
```

**2. ThePopeBot**

```
┌─────────────┐   POST /stream/chat    ┌───────────────────────┐
│  Browser     │ ─────────────────────▶│  Next.js route         │
│  Chat UI     │◀───────────────────── │  lib/chat/api.js        │
└─────────────┘   SSE (AI SDK stream)  └───────────┬─────────────┘
                                                    │ chatStream(threadId, ...)
                                                    ▼
                                     ┌───────────────────────────┐
                                     │  Claude Agent SDK           │
                                     │  (in-process, NOT a         │
                                     │   subprocess for Claude)    │
                                     └──────────────┬──────────────┘
                                                    │ reads/writes
                                                    ▼
                                     ┌───────────────────────────┐
                                     │  SQLite (Drizzle ORM)       │
                                     │  chats / messages tables    │
                                     └───────────────────────────┘

SESSION HANDLING:
  chatId (from browser, or new uuid) ──▶ threadId
  threadId is the DB primary key for a "chats" row.
  Every message persisted to SQLite; history reloaded from DB,
  NOT from a Claude CLI session file. Session = a database thread,
  portable/inspectable, not tied to a claude.exe process at all.

  (Separate, unrelated path: buttons/webhooks spawn a Docker
   container running Claude Code fire-and-forget — no session
   concept there, it's one-shot per job.)
```

**3. claude-gateway (+ its twin, chat-ui — same pattern, two front ends)**

```
 DISCORD                                   WEB (chat-ui — same pattern!)
┌─────────────┐                           ┌─────────────┐
│  Discord     │                           │  Browser     │
│  channel     │                           │  index.html  │
└──────┬───────┘                           └──────┬───────┘
       │ on_message                                │ WebSocket /ws
       ▼                                           ▼
┌──────────────────┐                      ┌──────────────────┐
│   gateway.py       │                      │   server.py        │
│   run_claude()      │                      │  handle_chat()      │
└─────────┬──────────┘                      └─────────┬──────────┘
          │ subprocess.Popen (stdin=prompt)             │ subprocess.Popen (stdin=prompt)
          ▼                                             ▼
   ┌─────────────────────────────────────────────────────────┐
   │                    claude.exe  (CLI)                       │
   │   --session-id <uuid>   (first turn, new)                  │
   │   --resume <uuid>       (later turns, same persona)         │
   │   --print --dangerously-skip-permissions                    │
   │   cwd = persona.workdir   (e.g. C:\Projects\SDLC)            │
   └─────────────────────────────────────────────────────────┘
          │ stdout (daemon thread → asyncio.Queue)
          ▼
   back to Discord message / WebSocket frame

SESSION HANDLING:
  persona (Discord channel_id  OR  web UI persona picker)
    ──▶ fixed session_id (UUID) in gateway_personas.json
    ──▶ same UUID reused across turns via --resume
  session_is_live(id) checks a last-active timestamp; if stale,
  conversation history is re-injected as text (--resume --print
  doesn't reliably reload history by itself — this is a documented
  workaround in the code comments).
  One persona = one continuous "session" = one working directory.
```

**Comparison / reuse verdict:**

| | How it talks to Claude | Reuse for iCubed? |
|---|---|---|
| Paperclip | TS adapter spawns subprocess, streams via callbacks to its own orchestrator server | Overkill — same idea as chat-ui with far more orchestration machinery |
| ThePopeBot | In-process Claude Agent SDK + SSE; separate Docker path for fire-and-forget jobs | Good reference for job/button model, but more infra (Docker + Next.js) than needed |
| claude-gateway | Raw CLI subprocess via Discord | **Already reused** — chat-ui IS this pattern, web front end instead of Discord |

**Direct answer to "can claude-gateway be used via web?":** yes — trivially, because it already is. chat-ui is the identical subprocess/session/persona logic, just triggered by a WebSocket message instead of a Discord event, reading the same `gateway_personas.json`. Not "would work well via web" — it already runs via web today; it's just unused for SDLC because nobody's opened the page and picked the Work persona yet.

## 2026-07-13 — Next direction: Teams + Web as the two channels to focus on

User's steer: session persistence is expected to be straightforward (chat-ui/claude-gateway already prove the pattern), and the real ask is doing **everything SDLC currently does, via Discord / Teams / Web** — but the two channels to actually focus effort on are **Teams and Web**, not Discord (Discord is already solved/proven via claude-gateway; Teams is the new channel that needs a bridge analogous to claude-gateway's Discord bot, and Web already has chat-ui as a head start).

**Not yet decided / next to figure out:**
- ~~Teams bot architecture — not yet researched.~~ **Researched 2026-07-13, see below.**
- Whether Teams and Web should share one backend process (one persona store, one subprocess-spawning core) with just two different front-end adapters — analogous to how chat-ui and claude-gateway already share `gateway_personas.json` today. This seems like the natural architecture given the proof-of-pattern already established.

## 2026-07-13 — Teams bot architecture research: it's a genuinely different shape, not a drop-in

**Bottom line: Teams has no equivalent to Discord's outbound-only gateway connection.** Discord's bot sits behind NAT/no public IP and still receives messages via a persistent outbound connection. Teams is the opposite — Microsoft's Bot Framework Connector Service **POSTs each message to your bot's public HTTPS endpoint**. There is no long-poll/gateway mode for receiving Teams messages. This is the single most important finding — it changes the deployment shape, not just the code.

### Q1 — Webhook vs long-poll
Confirmed inbound-webhook-only. The one persistent-connection feature that exists (Bot Framework Streaming Extensions) is scoped to Direct Line/Web Chat, not Teams, and is being deprecated. Disabling public inbound access on the Azure Bot resource breaks the Teams channel outright (per Microsoft's own Q&A).

### Q2 — Minimal setup path for a hackathon demo
1. Azure Portal → create an **Azure Bot** resource (single-tenant recommended) → get App ID + secret.
2. Python: `botbuilder-core`, `botbuilder-integration-aiohttp`, `botbuilder-schema`, `botframework-connector`.
3. An aiohttp server exposes POST `/api/messages`; `BotFrameworkAdapter.process()` authenticates + converts the request into a `TurnContext`; override `ActivityHandler.on_message_activity()` and call `turn_context.send_activity()` to reply — this is the direct equivalent of the Discord `on_message` handler, just HTTP-triggered instead of gateway-pushed.
4. Enable the Teams channel on the bot resource; real in-Teams testing needs a `manifest.json` (with a `bots` array referencing the App ID) sideloaded into a dev tenant.
5. **Local dev needs a public tunnel** — Microsoft's current docs still point at **ngrok** for this. No newer replacement documented for this SDK path.

**⚠️ Flag:** `botbuilder-python` / `BotBuilder-Samples` are now **archived** (Jan 2026), support ends Dec 2025. Successor is the **Microsoft 365 Agents SDK** (Python 3.10+) — webhook shape presumed similar but not independently verified.

### Q3 — Lighter-weight alternatives: none avoid the public-endpoint requirement
| Mechanism | Status | Arbitrary messages? | Needs public inbound HTTPS? |
|---|---|---|---|
| Classic Incoming Webhooks | Retired (final rollout May 2026) | No, send-only | No |
| Workflows app (Power Automate) | Current replacement | No, send-only | No |
| Outgoing Webhooks | Current | Only `@mention`-triggered, public channels only | **Yes**, plus HMAC-SHA256 sig validation, ~5s SLA |
| Messaging Extensions | Current | No, UI-invoked only | Yes, plus full Bot Framework registration |

Even the lightest option (Outgoing Webhook) still needs a public callback, works only on `@mention` in public channels — no 1:1, no free-flowing chat like Discord gives today.

### Q4 — Persona/session mapping
No stable ID like Discord's channel ID exists. `activity.conversation.id` is thread-scoped (changes per top-level post) — unusable as a persona key. Closest stable identifiers: `channelData.channel.id` (`19:...@thread.tacv2`), `channelData.team.id`, `channelData.tenant.id`. Microsoft recommends persisting the full `ConversationReference` object (not a bare ID) since `service_url` can go stale. **Practical mapping: composite key of `tenant.id` + `channel.id`** (or `team.id` for General, where `channel.id == team.id`) replacing Discord's single channel ID as the persona lookup key.

### Net effect on the plan
Web stays the easy win — chat-ui already works, just needs buttons. Teams is real, scoped engineering work, not a port: Azure Bot resource → Bot Framework/M365 Agents SDK → aiohttp `/api/messages` endpoint → ngrok tunnel for the demo → the existing subprocess/persona core reused underneath, fronted by this new webhook adapter instead of a WebSocket or Discord gateway.

## ⏳ OPEN DECISION (unanswered as of 2026-07-14)

**Given the Teams setup cost (Azure Bot registration + mandatory ngrok tunnel + risk of building on the now-archived `botbuilder-python` SDK), is Teams worth it for the hackathon timeline — or should the demo lean on Web + Discord (both already proven/working) and treat Teams as a stretch goal?**

Asked repeatedly across 2026-07-13 into 2026-07-14 with no answer yet — check here before assuming either direction on resume.

## Thread-discipline note

This working thread is scoped to iCubed only. The SDLC repo's own cron-fired skills (`agent_watchdog.py`, `ticket_dispatch_poller.py`, grooming queue sweep, advisory scratchpad, DQ audit, deployment-watch-expiry) fire repeatedly as Stop-hook prompts in this same working directory throughout 2026-07-13 and into 2026-07-14 — all declined here per explicit user request, left for a dedicated SDLC-ops session instead. This has held consistently across 10+ separate firings; treat it as a durable standing instruction for this thread, not a one-time call.

---

## Log format going forward

Append dated entries above this line as the interface work progresses — decisions made, code scaffolded, dead ends hit. Keep entries terse; link out to code/PRs rather than pasting large blocks.
