# GeoTab Overview Transcript

Teams meeting recap transcript — "AU Test Steps," 2026-07-09. Kameel Leeda (our PO-equivalent) walking Kritiya Shrestha (AU QC) through the install-QA process. See [[GeoTab]] for full context, [[GeoTab System Map]] for the automation tool's C4 diagrams, and [[GeoTab Manual QA Workflow]] for the C4 diagram of the manual workflow described in this transcript.

**Note:** transcript as pasted has a large gap — jumps from 3:16 to 56:07. Middle ~53 minutes not captured here. Add more if you have it.

---

**Kameel Leeda** 0:03
has quite a few accessories maybe or something like that. And then you guys have can units as well, right? Where you'll probably look for like fuel, RPM, I don't know, handbrake, lights. I'm not too sure exactly what you'll check.

**Kritiya Shrestha** 0:06 — Mhm.
0:12 — Yeah.
0:15 — Uh...
0:17 — Through the OBD, we don't really check those stuff unless it is asked for. Through the CAN system, we don't really check those unless the customer is really looking for those data, because that is something solution would already give, because depending on what vehicle it is.

**Kameel Leeda** 0:22 — Sorry, you don't.
0:28 — Okay.
0:31 — Okay.

**Kritiya Shrestha** 0:40
the Geotab Go units are, they can give those data into the system, like they can read those data from the vehicle. So we don't really have to check anything, but if it's pretty much a straightforward install.
0:58
Basic thing we check is GPS ignition, whether it's reporting through the, is it RPM based or any other source. So that is the basic thing we check, but depending on other accessories connected, it would be a bit.

**Kameel Leeda** 1:04 — Yeah.

**Kritiya Shrestha** 1:19 — Complex.
1:22 — So, I'm just looking at this one had iridium.

**Kameel Leeda** 1:26 — Yeah.

**Kritiya Shrestha** 1:28 — I de.
1:44 — Alright, I'll share my screen.

**Kameel Leeda** 1:49 — 2.

**Kritiya Shrestha** 1:58
So, this is the four platform where all our QAs are recorded, all the work orders and stuff are there, so...

**Kameel Leeda** 2:08 — Okay.

**Kritiya Shrestha** 2:09 — For any new install?

**Kameel Leeda** 2:11
OK, so these are, yeah, so these are new work orders for the installers, basically, so they come up here to tell you what's installed, etc. OK.

**Kritiya Shrestha** 2:18
Yeah, so these work order numbers, yeah. But generally, technicians, they just give you the device serial numbers, these ones. We just search by the device serial numbers and it should pop up. So anything sitting in new is like...

**Kameel Leeda** 2:27 — Yes, OK.
2:33 — Sure.

**Kritiya Shrestha** 2:37
just add it to the system. It's a brand new work order. Nothing's been done yet. And then in progress is when the installer starts the install process. For example, if I open one of these new one.

**Kameel Leeda** 2:44 — Yeah.
2:49 — Yeah.

**Kritiya Shrestha** 2:54 — So, it will share.
3:00 — It will say at the bottom of the page start device install. So once you do that, it will come up to in progress. And then from that, if they hit.

**Kameel Leeda** 3:05 — Okay.

**Kritiya Shrestha** 3:16 — Let me open.
3:20
So this is how it would be in the progress and then you have to verify status. If it's a Geotab product, Geotab device type, then it will check on my admin for the device status, which is in this.

*— [gap: 3:20 to 56:07 not captured in this transcript] —*

**Screenshot at 39:39 (2026-08-27, from the user)** falls inside this gap — Kritiya has SharePoint open at
`https://mixtelematics.sharepoint.com/sites/AUS-Intranet/Fleet%20Complete%20Intranet/CS/SitePages/DatabaseList.aspx`,
a flat alphabetised list of plain-text Geotab database names (one per line, e.g. `telstra_business_centre`,
`Temporary_Tracking`, `Tenterfield_Shire`, **`terra_cat`** — highlighted in the screenshot, confirming this really
is the literal Geotab database name behind "Terra Cat" and independently corroborating the earlier raw-`Authenticate`
test result). This is the "customers database" SharePoint page previously only inferred from context — now
confirmed real, with its exact URL and confirmation Kritiya's side reads it during a live case lookup. Access
gate for our own Ops Tools team (AUS-Intranet site permissions) still unconfirmed — see [[GeoTab Test Plan]] §8a
item 5.

**Kameel Leeda** 56:07
And then if there's any specific questions, then I'll just, you know, drop you a line or e-mail or something. Just to ask you, but yeah, I think I've got bulk of the information that I require. Finally, thank you so much. Appreciate it.

**Kritiya Shrestha** 56:08 — Mhm.
56:13 — Yeah.
56:18 — Okay.
56:20 — Yeah, all good. No worries.

**Kameel Leeda** 56:22
Alright, yeah, thank you for all the information. Have a great afternoon.

**Kritiya Shrestha** 56:26 — Good, thank you. Have a good morning as well.

**Kameel Leeda** 56:27 — Gates.
56:30 — Thanks, cheers, bye.

**Kritiya Shrestha** 56:32 — Bye.

---

## Key takeaways (first 3.5 minutes only — bulk of the call not covered here)

- **CAN/OBD data (fuel, RPM, handbrake, lights) is only checked when the customer specifically asks for it** — matches the AU spec doc's Section 4 exactly (conditional, OBD-only, not standard QA).
- **Geotab GO units self-report** — the platform reads the data directly from the vehicle, so a straightforward install needs minimal manual checking.
- **Basic check, confirmed verbally:** GPS + ignition, and whether ignition is reporting via RPM or another source — matches the doc's Section 3 basic checks exactly.
- Complexity scales with accessories connected (Iridium mentioned as one example).
- **"Four platform"** (likely misheard/mistranscribed — probably "FC platform," i.e. the legacy Fleet Complete / Unity Hub system) is where QAs and work orders are recorded.
- **Workflow confirmed:** New work order → installer starts install → status moves to "In Progress" → reviewer looks it up **by device serial number** → clicks "verify status" → for a Geotab device type, this checks MyGeotab/MyAdmin for device status.
- Techs typically hand over just the **device serial number** to look up the work order — consistent with the doc's serial-number-driven lookup flow.

Nothing in this excerpt contradicts the AU Installation Test Procedure doc — it reads as Kameel getting a live walkthrough of exactly the same manual process the doc describes in writing.
