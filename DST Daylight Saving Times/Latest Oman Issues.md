# Latest Oman DST Issues (Feb 2026)

## Summary of Findings

**Issue:** Daylight Saving Time (DST) adjustments are failing for specific FM units on the Oman server (Version 18.17).
**Reporter:** Riaan Serfontein
**Date Range:** Feb 11, 2026 - Present

### Key Points:
1.  **Environment:** Oman Server (`HSOMNIIS18` / `HSOMNATS01`), Database: `Schlumberger-OPG-Oman`.
2.  **Org ID:** `700083822000352569`
3.  **Symptoms:**
    *   The TimeAdjuster app (Support utility) works for Mix4000 units but fails for some FM units.
    *   Both old and new apps report authentication issues, though the old one allows login before failing.
    *   Specific error: "Authentication error" or simply failing to adjust.
4.  **Constraints:**
    *   The Oman environment is on version **18.17** (older technology).
    *   The latest DST tools are incompatible with this version.
    *   Tools must likely be run directly on the server due to authentication changes.
    *   **CRITICAL URL:** When running the old tool, you MUST use: `https://om.mixtelematics.com`.

---

## Specific Examples (Failed Vehicles)

Riaan provided the following list of vehicles that failed to update even when attempted individually.

**Database:** `Schlumberger-OPG-Oman`
**Org ID:** `700083822000352569`

| ID | FM Vehicle ID | Registration Number |
| :--- | :--- | :--- |
| -5059187462885730598 | 768 | 1047 MS |
| -91969000178729676 | 925 | 1126 WA |
| 4855187782355671943 | 881 | 1220 BK |
| -1956273178738781837 | 840 | 2584 DA |
| 843258748896216425 | 1000 | 3032 MS |
| -3512887242421783741 | 1001 | 3174 MA~ |
| -346828344956229991 | 916 | 4005 BM |
| -3699420126742982453 | 579 | 4120 WK |
| 7528555069186003893 | 589 | 4290 MA |
| -8204281797198858810 | 1011 | 4672 DK |
| -3890793920675579590 | 847 | 7598 MS |
| 1676695123364614970 | 10210 | 9960 TB |

---

## Chat Log (Relevant Excerpts)

**Riaan (02/11 16:32):**
Is there no log where I can see which vehicles were not adjusted?

**Marthinus (02/11 16:32):**
Can you log into Oman's mixfleet with that user? (I'm going into a meeting with Zonika).

**Riaan (02/11):**
Yes I can.

**Marthinus (02/11 16:34):**
I'm checking quickly where that log lies. Your screenshot looks like it doesn't have access or can't find a server. Can you restore my access to that server? I THINK my OMN Mixtelematics user is marthinus.raath@mixtelematics.com

**Riaan (02/11 16:45):**
Your account shows as active.

**Marthinus (02/11 17:20):**
Hey - sorry - was in meeting... I also asked NOC to activate my account because when I try to log in it just says I can't authenticate. I'm looking for those Log files for you - it's not where I expected it to be. As soon as I find something I'll let you know. Could you perhaps send me an OrgID that I can test tomorrow morning... Or an AssetID... or whatever you are trying - then we figure it out.

**Riaan (02/11 17:25):**
IDC: OM server
Database: Schlumberger-OPG-Oman
orgId=700083822000352569

If I use the Timeadjuster app on the Support utility it adjusts the Mix4000, but on FMs I get that not all are adjusted. Both the old and new app under Project seem to have Authentication issues, but the old one allows you to log in and then gives Authentication error.

**Marthinus (02/11 17:26):**
Thanks for all the feedback... So where do you get the Timeadjuster Support utility? Which server on OMN is it?

**Riaan (02/11 17:26):**
[Image]
It is also on HSOMNATS01.

**Marthinus (02/11 17:27):**
Oh is it on your LOCAL machine where you run it?

**Riaan (02/11 17:27):**
No from the jumpbox.

**Marthinus (02/11 17:32):**
So there are 3 main parts...
1) FMTimeAdjuster.API.... (which lets the TOOL log in)
2) The TOOL
3) The BE Deviceconfiguration.API (or whatever it's called here) (which does the adjustments)

I can see the TimeAdjust.api is running at least... So now we just need to figure out which tool is the right one (2) and where the logs lie for the other API where the errors happen (3).

**Marthinus (02/12 08:33):**
So I tried that orgId you said with NO issues. Do you have one I can use that gives issues - maybe like you said for the FMs?

**Marthinus (02/12 10:34):**
OK - I've looked and searched for 4 hours now - but I think I should rather get an example that fails because the code has changed SO much from ver 18.17 to now.

**Riaan (Monday 14:18):**
Morning, could you dig further? We really must try to make the new one work, the old time adjuster seems not to set everything.

**Marthinus (Monday 15:42):**
Hey - man - the problem is they don't want to run the newest version - they are still on 18.17 and it now comes with all these issues we have every now and then... the new one is based on the new versions - so it will never work with 18.17. I would also rather want that because the new one gives good feedback. Did you manage to get a few examples? Then I can look more specifically.

**Riaan (Tuesday 17:45):**
Hi, so here is a list of vehicles. I tried to set them individually, but get the error.

OM
Schlumberger-OPG-Oman
orgId=700083822000352569

[List of vehicles provided in the table above]
