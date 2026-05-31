---
created: 2026-04-10T00:00
updated: 2026-04-10T14:51
wiki_ingested: 2026-05-28
---

> Ideas for future diff/analysis features. Not yet in sprint. Capture here so nothing is lost.

## Future Diff Ideas

### VO (Video / Camera) Settings Diff
- Pull in video/camera settings and include them in config diffs
- This is a **big** area — considered quite complex
- Future ticket, not near-term
- Why it matters: video config drift can be significant for clients

### Trip Integrity Ratios
- Per-asset analysis of trips over time
- Check: positions, events, and trips — do they have integrity over time?
- There is apparently a **sweet spot where ratios work** — worth investigating
- Essentially: does this trip make sense? Do the numbers add up consistently?
- Could surface data quality / device health issues automatically

### Asset-to-Asset Config Diff (via Chatbot)
- In the chatbot, allow the user to say "compare this asset to that asset"
- Would diff the two asset configs and allow Q&A on the differences
- Currently we only store the diff per asset — this would need a **separate flow**: select two assets → compute diff on demand → chat about it
- May need a dedicated UI section for this (not the same as version diff)
