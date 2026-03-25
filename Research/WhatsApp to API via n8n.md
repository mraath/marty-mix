---
created: 2026-03-25T14:56
updated: 2026-03-25T15:01
---
# WhatsApp → API Endpoint via n8n

**Date:** 2026-03-25
**Status:** Planning — Discord test phase next, then WhatsApp production

---

## Problem Statement

We need a way to trigger API endpoints on our server via WhatsApp messages. The solution needs a middleware layer because WhatsApp does not support direct HTTP calls — messages must flow through the **WhatsApp Business Cloud API** (Meta), which fires webhooks.

---

## Decision: Use n8n

**We chose n8n** as the middleware layer. Reasons:
- Already set up and have experience with it
- Handles webhook receiving, Meta challenge verification, message parsing, and HTTP requests visually
- No code to write or maintain
- Swapping WhatsApp ↔ Discord is just changing the trigger node — the rest of the workflow stays identical

A pure webhook server (Express/ASP.NET) was considered but rejected — ~50 lines of code and an extra service to maintain for no real gain when n8n is already available.

---

## Architecture

### Phase 1 — Discord (Test / Proof of Concept)
```
Discord Message
  → n8n Discord Trigger node
  → Parse message / extract intent
  → HTTP Request node → Our API endpoint
  → (Optional) Reply back to Discord
```

### Phase 2 — WhatsApp (Production)
```
WhatsApp User sends message
  → Meta WhatsApp Business Cloud API
  → Fires POST webhook → n8n Webhook Trigger
  → Parse message payload
  → HTTP Request node → Our API endpoint
  → (Optional) HTTP Request → WhatsApp Cloud API (send reply)
```

The n8n workflow barely changes between phases — **swap the trigger node, keep the rest**.

---

## Phase 1: Discord Setup

**Option A (Recommended): Discord Bot → n8n Discord Trigger**
1. Create a Discord bot at https://discord.com/developers
2. n8n: add **Discord Trigger** node (listens for messages in a channel)
3. **Function/Code node**: extract message text
4. **HTTP Request node**: call our API
5. (Optional) Discord node to send a reply

**Option B: Discord Slash Command → n8n Webhook**
- Register slash command on the bot
- Discord fires Interaction Webhook to n8n Webhook URL
- Must respond within 3 seconds (more complex)
- **Not preferred**

---

## Phase 2: WhatsApp Setup

### Requirements

| Requirement | Cost | Notes |
|---|---|---|
| Meta Developer Account | Free | developers.facebook.com |
| WhatsApp Business App (Cloud API) | Free | Up to 1000 conversations/month free |
| Phone number | Free | Meta provides a test number, or use own |
| Public HTTPS webhook URL | Already have | n8n's URL |

### Setup Steps

1. **Meta Developer Account**
   - Go to https://developers.facebook.com
   - Create a Meta App → Add "WhatsApp" product
   - Use **Cloud API** (Meta-hosted — no server needed on our side)
   - Get `PHONE_NUMBER_ID` and `ACCESS_TOKEN` (set up a permanent System User token for production)

2. **n8n Webhook Configuration**
   - Add a **Webhook** trigger node to the workflow
   - Copy the webhook URL (e.g., `https://your-n8n.com/webhook/whatsapp`)
   - Register this URL in Meta dashboard as the webhook endpoint
   - Meta sends a `hub.challenge` GET verification request — handle with a Respond to Webhook node

3. **The Verification Handshake (important)**
   Meta sends a GET to your webhook with:
   ```
   hub.mode=subscribe&hub.challenge=XXXXX&hub.verify_token=YOUR_TOKEN
   ```
   n8n must respond with just the challenge value. Requires a second Webhook node (GET) or IF branch to detect and echo it.

---

## n8n Workflow Nodes (WhatsApp)

| Node | Type | Purpose |
|---|---|---|
| Webhook | Trigger | Receives Meta POST events |
| IF | Logic | Filter non-message events (delivery receipts, status updates) |
| Set | Transform | Extract `messages[0].text.body` |
| HTTP Request | Action | Call our API endpoint |
| HTTP Request | Action | (Optional) POST reply via WhatsApp Cloud API |

---

## Rollout Plan

- [ ] **Step 1** — Discord bot → n8n → API (prove the concept, test message parsing)
- [ ] **Step 2** — Meta Developer account + WhatsApp test number (~30 min)
- [ ] **Step 3** — Swap Discord trigger for WhatsApp webhook trigger in n8n
- [ ] **Step 4 (Optional)** — Add command parsing (e.g., `/status` → `/api/status`, `/deploy` → `/api/deploy`)

---

## Notes

- WhatsApp Cloud API free tier: 1000 conversations/month (sufficient for internal/dev use)
- The only real friction is the Meta setup (~30 mins, requires Meta Business account)
- Once Meta is set up, the n8n side is 4–5 nodes
- n8n workflow JSON can be drafted once Discord phase is validated

---

## Related
- [[Claude Agent Server]]
