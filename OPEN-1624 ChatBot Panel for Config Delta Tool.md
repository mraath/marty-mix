# OPEN-1624 Child — ChatBot Panel for Configuration Delta Tool

> **Draft JIRA Story** — Parent: [[OPEN-1624 Config change analysis tool]]
> Status: Draft | Labels: OpsTools | Assignee: Marthinus Raath

---

## Start Here Tomorrow — Priority Checklist

- [ ] Review and confirm JIRA description below
- [ ] Paste into JIRA as a new Story under OPEN-1624
- [ ] Set up `.env` with OpenRouter API key
- [ ] Place `agents/json_diff_analyst.md` system prompt into the Automation UI project

---

## JIRA Story Description (Copy-Paste Ready)

---

### Summary

Add an AI-powered ChatBot panel to the Configuration Delta Tool that lets users interrogate the active `diff.json` in natural language.

---

### Background

The Configuration Delta Tool currently supports two views — **Grouped View** and **Matrix View** — for visualising JSON drift between device configurations and a fleet standard template.

Users can identify *what* changed but have no way to quickly understand *why it matters*, *what the risk is*, or *how changes relate to each other*. A contextual AI assistant embedded alongside the existing views addresses this gap.

---

### Feature Description

Add a **Chat Bot** toggle button to the view-selector row (alongside "Grouped View" and "Matrix View").

When activated:
- A chat panel slides in from the right edge of the screen.
- The currently active view (grouped or matrix) shrinks horizontally to the left to make room.
- The chatbot automatically loads the active test case's `diff.json` as its working context.
- The user can ask questions in natural language and receive structured analysis.
- Suggested prompt chips appear above the input bar based on the current diff content.
- The chatbot can be trained by the user — corrections and interpretations are persisted to a `user_feedback.json` file alongside the diff.

---

### Acceptance Criteria

**View Toggle**
- [ ] A "Chat Bot" button appears in the view toggle row, to the right of "Matrix View".
- [ ] Clicking "Chat Bot" opens the chat panel; the current view (grouped or matrix) reflows to occupy the remaining left width.
- [ ] Clicking "Chat Bot" again (or a close button inside the panel) collapses the panel and restores the full-width view.

**Chat Panel — Layout & Style**
- [ ] Panel is a right-aligned sidebar (approx. 380–420px wide, full-height of the content area).
- [ ] Panel style: glassmorphism card, consistent with the Powerfleet Operations Tools premium aesthetic.
- [ ] User messages appear on the **right** (bubble, accent colour).
- [ ] AI responses appear on the **left** (bubble, neutral/white card).
- [ ] Typing/loading state: animated "..." indicator while the AI is responding.

**Chat Panel — Suggested Prompts**
- [ ] Above the input field, display 2–4 context-aware prompt chips (e.g. "What changed?", "Any risks?", "Summarise the drift", "What fields were removed?").
- [ ] Chips update dynamically based on the content of the loaded diff.
- [ ] Clicking a chip populates the input field and submits immediately.

**Chat Panel — AI Behaviour**
- [ ] The chatbot is initialised with the system prompt defined in `agents/json_diff_analyst.md` (already authored — see reference file).
- [ ] On panel open, the chatbot automatically performs a startup analysis: identifies major change categories and provides a high-level summary of the active diff.
- [ ] The chatbot operates strictly on the loaded `diff.json`; it does not invent information outside the diff.
- [ ] Responses use structured output: **Summary**, **Key Changes**, **Relationships**, **Possible Meaning**, **Potential Risks**, and optional **Questions**.

**Chat Panel — Training / Learning**
- [ ] The user can correct or annotate chatbot interpretations by typing feedback (e.g. "When CANPROTOCOL changes it means a CAN bus reconfiguration happened").
- [ ] User feedback is persisted to `public/data/<testCaseName>/user_feedback.json`.
- [ ] On subsequent loads for the same test case, the chatbot reads `user_feedback.json` and incorporates stored patterns into its reasoning.

**AI Provider — OpenRouter**
- [ ] All AI calls are made via the OpenRouter API (free tier compatible).
- [ ] API key is read from `OPENROUTER_API_KEY` in the project `.env` file (root of `Powerfleet.Automation.UI`).
- [ ] The `.env.local.example` file must be updated to include the `OPENROUTER_API_KEY` placeholder.
- [ ] Model selection: configurable via env var `OPENROUTER_MODEL` (default: `mistralai/mistral-7b-instruct:free` or similar free model).

**Error States**
- [ ] If `diff.json` is not found for the active test case, the panel shows: _"No diff file available for this test case."_
- [ ] If the OpenRouter call fails, show a friendly error with a retry button.
- [ ] If the API key is missing, show: _"OpenRouter API key not configured. Add OPENROUTER_API_KEY to your .env file."_

---

### Technical Notes

**Files to create:**
- `src/components/delta/ChatBotPanel.tsx` — The sliding chat sidebar component
- `src/services/chatbotService.ts` — OpenRouter API integration + diff context loader
- `public/data/<testCaseName>/user_feedback.json` — Per-case learning store (auto-created on first feedback)
- `agents/json_diff_analyst.md` — AI system prompt (already authored, copy from `C:\Projects\Chat Bot Ideas\Chat Bot Prompt.md`)

**Files to modify:**
- `src/components/delta/ConfigDeltaView.tsx` — Add ChatBot toggle state; apply conditional layout split
- `.env.local` — Add `OPENROUTER_API_KEY` and `OPENROUTER_MODEL`
- `.env.local.example` — Add placeholder entries

**Layout split approach:**
```
[chatOpen=false]  |  <main content 100%>
[chatOpen=true]   |  <main content ~60%>  |  <ChatBotPanel ~40%>
```
Use CSS flex on the wrapper; the panel animates in via a CSS transition on `width` (0 → 420px).

**OpenRouter call structure:**
```
POST https://openrouter.ai/api/v1/chat/completions
Authorization: Bearer ${OPENROUTER_API_KEY}
Body: {
  model: "mistralai/mistral-7b-instruct:free",
  messages: [
    { role: "system", content: <json_diff_analyst system prompt> },
    { role: "user", content: "Here is the diff:\n" + JSON.stringify(diffData) },
    ...conversation history
  ]
}
```

---

### Out of Scope (Future Stories)

- Multi-asset diff comparison via chatbot (currently single diff.json)
- Admin UI for managing `user_feedback.json`
- Real-time streaming responses (SSE/WebSocket)
- Persisting chat history across sessions

---

## ASCII Wireframe

```
┌──────────────────────────────────────────────────────────────────────────────────────┐
│ POWERFLEET  Operations Tools                                        DEV  Sign Out     │
├──────────────────────────────────────────────────────────────────────────────────────┤
│  Configuration Delta Tool    [testCase1 ▼]                                           │
│  Comparing 4 assets against fleet standard template.                                 │
│  Last updated: 27/2/2026, 11:40:50 AM                                                │
│                                                                                      │
│   ┌──────────────┐  ┌─────────────┐  ┌──────────────┐   ← View toggles             │
│   │ Grouped View │  │ Matrix View │  │  💬 Chat Bot │                               │
│   └──────────────┘  └─────────────┘  └──────────────┘                               │
│                                                                                      │
│  ┌─────────────────────────────────────┐  ┌──────────────────────────────────┐      │
│  │                                     │  │  💬 JSON Diff Analyst            │      │
│  │  [Grouped / Matrix View Content]    │  │──────────────────────────────────│      │
│  │                                     │  │                                  │      │
│  │  ┌ ASSETS ANALYZED: 4 ┐             │  │  ╭─────────────────────────────╮ │      │
│  │  │ ASSETS DEVIATED: 3 │             │  │  │ 🤖 I found 439 total drift  │ │      │
│  │  │ TOTAL DRIFT: 439   │             │  │  │ items. Key findings:        │ │      │
│  │  └────────────────────┘             │  │  │  • 19 Device Property drifts│ │      │
│  │                                     │  │  │  • 303 Param/Event drifts   │ │      │
│  │  FILTER BY ASSET   FILTER BY SECTION│  │  │  • 117 Structural mismatches│ │      │
│  │  ┌──────────────┐  ┌──────────────┐ │  │  │ Highest risk: CANPROTOCOL  │ │      │
│  │  │ Mercedes 534 │  │ Device Props │ │  │  │ removal on 3 assets.       │ │      │
│  │  │ OL-553/Sino  │  │ Parameters   │ │  │  ╰─────────────────────────────╯ │      │
│  │  │ H2298-Sino   │  │ Event Conds  │ │  │                                  │      │
│  │  └──────────────┘  └──────────────┘ │  │     ╭──────────────────────╮    │      │
│  │                                     │  │     │ What are the risks?  │    │      │
│  │  ┌─────────────────────────────────┐│  │     ╰──────────────────────╯    │      │
│  │  │ Field     │ Standard │ OL-553   ││  │                        ↑        │      │
│  │  │─────────────────────────────────││  │           Suggested prompt chip │      │
│  │  │ CANPROTOC │ (missing)│ J1939    ││  │                                  │      │
│  │  │ CANBAUDRT │ (missing)│ 2        ││  │  ╭──────────────────────────────╮│      │
│  │  └─────────────────────────────────┘│  │  │ What changed? │ Any risks?  ││      │
│  │                                     │  │  ╰──────────────────────────────╯│      │
│  │   [Shrinks ~60% width when chat     │  │  ┌────────────────────────────┐  │      │
│  │    panel is open]                   │  │  │ Ask about this diff...  →  │  │      │
│  └─────────────────────────────────────┘  │  └────────────────────────────┘  │      │
│                                           └──────────────────────────────────┘      │
└──────────────────────────────────────────────────────────────────────────────────────┘

PANEL CLOSED STATE:
┌──────────────────────────────────────────────────────────────────────────────────────┐
│   ┌──────────────┐  ┌─────────────┐  ┌──────────────┐                               │
│   │ Grouped View │  │ Matrix View │  │  💬 Chat Bot │  ← Click to open panel        │
│   └──────────────┘  └─────────────┘  └──────────────┘                               │
│  ┌──────────────────────────────────────────────────────────────────────────────┐    │
│  │                 [Full-width Grouped or Matrix content]                        │    │
│  └──────────────────────────────────────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Related

- [[OPEN-1624 Config change analysis tool]] — Parent Epic
- [[Chat Bot Prompt]] — System prompt for the JSON Diff Analyst agent
- Skill: `C:\Projects\Skills\.agent\skills\brainstorming-superpowers`
- Skill: `C:\Projects\Skills\.agent\skills\planning-superpowers`
