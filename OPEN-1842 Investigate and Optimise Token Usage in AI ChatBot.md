---
status: In Progress Dev
priority: 1
created: 2026-03-17T00:00
updated: 2026-04-08T08:58
---

# OPEN-1842 Investigate and Optimise Token Usage in AI ChatBot

JIRA: [OPEN-1842](https://powerfleet.atlassian.net/browse/OPEN-1842)
Parent: [[OPEN-1624]] — Config change analysis tool
Labels: None
Assignee: Marthinus Raath
Status: In Progress Dev

## Start Here Tomorrow — Priority Checklist

- [ ] Replace personal Groq/OpenRouter keys with organisational keys (or Gemini free-tier)
- [ ] Clarify OpenAI "cross domain" situation — code already uses server-side proxy, so likely a key scope issue
- [ ] Add proper token estimation + conversation history pruning
- [ ] Improve DIRF payload compression (relevance-based, not just field count)
- [ ] Add per-request token logging (before/after metrics)
- [ ] Consider YAML format for DIRF input (20–30% token savings over JSON)

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

### Background and Goal

The AI ChatBot in the Configuration Delta Tool currently sends the full DIRF payload to the LLM on every request. As DIRF can be very large, this leads to excessive token consumption and increased cost/latency. This story investigates and delivers at least one implemented optimisation with measurable before/after metrics.

### User Story

As an Operations Tools engineer, I want the Configuration Delta ChatBot to consume fewer tokens per request, so that AI costs are reduced and response latency improves without degrading answer quality.

### Functional Requirements

1. Measure current token usage (baseline)
2. Implement at least one optimisation technique
3. Measure post-optimisation token usage
4. Ensure answer quality is not degraded
5. Document findings and chosen approach
6. Fix API key management (remove personal keys, use organisational/free-tier keys)
7. Resolve OpenAI cross-domain key restriction OR move to a free-tier provider

## Further Chat Notes

> **Session 2026-04-08:**
> User flagged additional context beyond the Jira description:
> - **Personal API keys in use**: Groq and OpenRouter keys are personal keys — must be replaced with organisational or free-tier keys.
> - **OpenAI "cross domain" issue**: The company's OpenAI key has restrictions (possibly org-scoped or IP-restricted). The code already uses Next.js API routes as server-side proxies (no browser CORS issue). The restriction is at the key/org level.
> - **Preferred path forward**: Fix OpenAI so it works properly (get an unrestricted company key, or move to Azure OpenAI), OR provision a company Groq + Gemini key and drop OpenAI dependency.
> - **Note**: The chatbot already has a 4-provider fallback chain (OpenAI → Groq → Gemini → OpenRouter). All calls are server-side (no CORS risk from browser).

### Current Architecture Summary

| Layer | Detail |
|---|---|
| Route | `src/app/api/chat/route.ts` — server-side, 4-provider fallback |
| Fallback order | OpenAI → Groq → Gemini → OpenRouter |
| Context trimming | `src/services/chatbotService.ts` — 28,000 char limit (~8K tokens) |
| History management | Full conversation history sent each turn (no pruning) |
| Token counting | Character-based estimation (~3.5 chars/token) |
| Caching | localStorage hash-based (avoids re-analysis on same diff) |
| Keys in .env.local | None — env vars must be set in deployment |

### Token Optimisation Opportunities

1. **History pruning** — Currently no limit on conversation turns; older turns waste tokens
2. **YAML format** — JSON→YAML for DIRF input saves 20–30% tokens
3. **Relevance-based field selection** — Current trimming is field-count-based; smarter: only include fields that actually changed
4. **Token logging** — Add server-side logging of estimated token count per request for before/after comparison
5. **max_tokens tuning** — Current output cap is 1,024; may need 2,048 for complex analyses

## Branch

> Branch: Config/MR/Feature/OPEN-1842_TokenOptimisation (Powerfleet.Automation.UI)

## PR Checklist

- [ ] OPEN-1842 → DEV
- [ ] OPEN-1842 → INT
- [ ] OPEN-1842 → UAT
- [ ] OPEN-1842 → PROD
