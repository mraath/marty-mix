---
wiki_ingested: 2026-05-28
created: 2026-03-04T19:25
updated: 2026-03-04T22:31
tags:
  - claude
  - claude-code
  - troubleshooting
  - remote-control
status: done
---

# Claude Code: /remote-control Prerequisites

The `/remote-control` command in Claude Code allows users to control a local terminal session from other devices (mobile app or browser).

## Current Prerequisites

1.  **Subscription Tier (Crucial)**: 
    - Currently requires a **Claude Max** plan.
    - Support for the **Claude Pro** plan is expected soon but is **not yet available**.
    - API keys are not supported for this feature.
2.  **Authentication**:
    - Must be signed in via `claude.ai` using the `/login` command.
3.  **Workspace Trust**:
    - You must have accepted the workspace trust dialog for the current project directory.
4.  **Version**:
    - Requires Claude Code **v2.1.52** or later (Verify with `claude --version`).
5.  **Persistence**:
    - The local terminal must remain open. Using `tmux` or `screen` is recommended for stability.

## Troubleshooting "Remote Control connecting..."
If you see the message "Remote Control connecting..." followed by a message stating the skill is unavailable, it is almost certainly because the account is on the **Pro** (or Free) tier rather than **Max**.

## Links
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
