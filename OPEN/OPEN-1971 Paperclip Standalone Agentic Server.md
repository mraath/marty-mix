---
created: 2026-03-31T07:42
updated: 2026-03-31T07:42
---

# OPEN-1971 — [POC] Paperclip Standalone Agentic Server - Centralised AI Orchestration

> [Jira Ticket](https://powerfleet.atlassian.net/browse/OPEN-1971) | Status: **In Progress Dev** | Assignee: Marthinus Raath

## Background

Setting up [Paperclip](https://github.com/paperclipai/paperclip) as a self-hosted standalone agentic server to centralise AI orchestration for the team. Currently each developer manages their own API keys, MCP configs, and Claude sessions locally. This POC investigates using a single shared Paperclip instance — authenticated under one Pro/team account — to handle Jira triage, agentic task execution, and tool access on behalf of all developers.

- **Reference**: [YouTube demo](https://youtu.be/HJ-dwefABss?si=0RbaGBod88kRzhYz)
- **Sprint Intake Note**: [[Operations Tools]] → Sprint Intake 2026-03-30, Item 1

## Scope

- Self-host Paperclip locally or on AWS
- Single shared Pro/team account — centralised API key management
- Jira triage and agentic task execution via shared instance
- Evaluate for agentic UI development workflow integration
- Team rollout approach documented as ADR in Obsidian

## Output / Definition of Done

A running Paperclip POC (locally or on AWS) with at least one successful Jira query executed through it, plus an architecture decision record in Obsidian covering the team rollout approach.

## Notes
