---
created: 2026-03-25T14:55
updated: 2026-03-25T15:01
---
# Claude Agent Server — Research & Decisions

> Research session: 2026-03-25
> Status: Planning complete, not yet built

---

## Problem Statement

Agent work (skills, workflows, multi-agent tasks) consumes a lot of tokens and ties up a developer's local machine. The goal is to move this work to a **dedicated server** that other devs can submit tasks to, running long/unattended agent jobs centrally.

---

## Key Insight: Tokens Are API-Side

Running Claude Code on a dedicated machine does **not** reduce token costs — those are charged by the Anthropic API regardless of where the client runs. What centralization buys you:

- One API key / account to manage
- Shared rate limits and spend control
- Devs don't tie up their own machines on long tasks
- Shared tooling (skills, MCPs, CLAUDE.md) always available

---

## Option Considered: Claude Code Remote / MCP Server Mode

Claude Code can run as an MCP server, allowing other devs' Claude Code instances to connect and use the server's tools (filesystem, bash, skills, MCPs).

**Rejected for primary use** because:
- API calls still happen on the **connecting dev's machine** using their API key
- Tokens are NOT centralized
- Long unattended tasks are still tied to the dev's session

✅ Still useful as a **secondary capability** for shared tooling access.

---

## Decision: Custom Wrapper Service

### Architecture

```
Dev → POST /run { prompt, skills[] }
         ↓
   [Server: one API key / Pro account]
   [Claude Code headless (-p flag)]
   [Shared skills, MCPs, filesystem]
         ↓
   Task queue (SQLite)
         ↓
   Results + live log per task
         ↓
Dev → GET /task/{id}/status → feedback loop
```

### Stack

| Component | Choice | Reason |
|---|---|---|
| Agent engine | Claude Code CLI (`-p` headless mode) | Reuses all existing skills/MCPs as-is |
| HTTP wrapper | FastAPI (Python) | Lightweight, fast to build |
| Task queue | SQLite | Simple enough for internal use; upgrade to Redis if needed |
| Auth | Org/shared API key OR Pro/Max account OAuth | One account for all tasks |

---

## Authentication Decision

Claude Code CLI supports **OAuth login** to a Claude.ai Pro or Max account — no API key required. Run `claude` on the server once, log in via browser, stays authenticated.

**Recommendation**: Start with Pro for testing. Move to **Max plan** for production team use — Pro has usage limits that will be hit quickly with multiple devs running agent tasks.

---

## Feedback Loop Design

Claude Code headless mode streams stdout as it works (tool calls, file reads, bash runs, etc.). Capture this per-task into a log file and expose via status endpoint.

### Status Endpoint: `GET /task/{id}/status`

```json
{
  "id": "abc123",
  "status": "running",
  "elapsed_seconds": 47,
  "last_activity": "Reading file: C:/Projects/DynaMiX.Backend/...",
  "recent_output": [
    "Tool: Read → src/controllers/AssetController.cs",
    "Tool: Bash → running tests...",
    "Tool: Edit → updated 3 lines in AssetController.cs"
  ],
  "completed_steps": 8,
  "last_updated": "2026-03-25T10:23:11Z"
}
```

**Hang detection**: If `last_updated` goes stale for 60+ seconds while status is still `running`, flag task as `possibly_stuck`.

---

## Hardware

An old Windows/Linux machine is sufficient for testing. Requirements:

| Requirement | Notes |
|---|---|
| Always-on internet | API calls to Anthropic |
| Node.js 18+ | Claude Code CLI |
| Python 3.10+ | FastAPI wrapper |
| 4GB RAM min | Claude Code is lightweight locally |
| Internal network | So devs can reach the HTTP endpoint |

Mac Minis are popular for this because they're silent and low power — but any always-on machine works.

---

## Future Upgrades (Not Now)

- **n8n as orchestration layer** — already configured via MCP, could visually manage agent workflows on top of this service
- **Streaming via SSE/WebSocket** — watch agent work in real time instead of polling
- **MCP server mode** — expose server's tools to devs' local Claude Code instances for shared tooling (complementary, not a replacement)

---

## Next Steps

- [ ] Set up old machine with Node.js + Python
- [ ] Log in to Claude Code on the server with Pro/Max account
- [ ] Build FastAPI wrapper + SQLite queue
- [ ] Test with a long-running skill task
- [ ] Evaluate if Pro limits are sufficient or if Max is needed
