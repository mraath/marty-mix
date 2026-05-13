---
status: In Progress Dev
priority: 1
created: 2026-04-07T00:00
updated: 2026-04-08T07:36
---

# OPEN-1843 Enhance AI ChatBot Follow-Up Question Generation

JIRA: [OPEN-1843](https://powerfleet.atlassian.net/browse/OPEN-1843)
Parent: [[OPEN-1624]] — Config change analysis tool
Labels: —
Assignee: Marthinus Raath
Status: In Progress Dev

## Start Here Tomorrow — Priority Checklist

- [ ] Update `json_diff_analyst.md` system prompt — add structured SUGGESTIONS format with intent tags + ranking instructions
- [ ] Update `parseAIResponse()` in `chatbotService.ts` — parse `[category]` tags from structured suggestions
- [ ] Add `SuggestedQuestion` interface (text + intent category)
- [ ] Update `deriveContextualSuggestions()` to return categorised questions with domain-aware prompts
- [ ] Update `ChatBotPanel.tsx` — render chips with intent category badge (colour-coded)
- [ ] Test two system prompt variants, pick the better one

## TODO

```dataviewjs
function callout(text, type) {
	const allText = `> [!${type}]\n` + text;
	const lines = allText.split('\n');
	return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Description (from Jira)

**Background:** After the AI ChatBot produces a summary of its delta findings, it appends follow-up questions to guide the user. The current question generation is generic — not derived from the specific findings in the current diff. This story makes follow-up questions context-aware, ranked, categorised, and clickable.

**User Story:** As a support engineer using the Configuration Delta ChatBot, I want follow-up questions that are relevant to the specific changes detected in the diff, so that I can quickly drill into the most important findings without having to manually compose follow-up queries.

**Functional Requirements:**
1. **Context-aware generation** — questions derived from specific delta findings, not generic prompts
2. **Limit and rank** — 3–5 questions per response, ranked by relevance to detected differences
3. **Categorise by intent** — each question tagged as: `drill-down`, `root-cause`, `remediation`, or `impact`
4. **Clickable auto-submit** — questions rendered as chips/buttons; clicking auto-submits as next message
5. **System prompt iteration** — evaluate ≥2 prompt variants, ship the better one

**Notes from Jira:**
- `parseAIResponse()` in `chatbotService.ts` already strips a SUGGESTIONS section — build on/replace this
- Clickable auto-submit already works (chips call `handleSend(prompt)`) — just needs category UI
- Intent category tagging: simplest is LLM emits category inline in structured response

**Out of Scope:** Token optimisation (OPEN-1842), persisting question history across sessions, user-defined categories.

## Further Chat Notes

User also wants brainstormed follow-up questions that are domain-aware for fleet telematics device configs. Key domains identified from codebase:
- CAN bus protocol settings
- Firmware/R-Watch version mismatches
- Event conditions and thresholds
- GPS reporting intervals and distance triggers
- Speed, harsh braking, cornering thresholds
- Geofence entry/exit event configs
- Driver behaviour parameters
- Temperature/cargo sensor thresholds
- Structural mismatches in device properties

Four intent categories to drive question brainstorming:
- `drill-down` — explore specific changed values
- `root-cause` — why did this change happen
- `remediation` — how to fix/align the config
- `impact` — operational consequences of the change

## Test on INT

![[Pasted image 20260408073618.png]]

## Branch

> Branch: `Config/MR/Feature/OPEN-1843_EnhanceChatbotFollowUp`
> Repo: `Powerfleet.Automation.UI` (Next.js UI)

## PR Checklist

- [ ] OPEN-1843 → DEV
- [ ] OPEN-1843 → INT
- [ ] OPEN-1843 → UAT
- [ ] OPEN-1843 → PROD