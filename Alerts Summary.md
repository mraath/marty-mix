---
created: 2025-04-10T08:43
updated: 2025-04-10T08:52
---

## Four main Alerts

### Alert 1: Assets in config Upload requested state for more than 5 days

TEST Ideas:

- [ ] **Scenario A (Config Alert):** A unit whose _latest_ message of type 254 or 255 is older than 5 days AND has a status NOT IN (10, 12, 13, 25, 28). (Expected output: '10' or '11')
- [ ] **Scenario D (Old but Good Status):** A unit whose latest relevant message(s) are older than the thresholds BUT have a status IN (10, 12, 13, 25, 28). (Expected output: '00')

### Alert 2: Assets in FW upload requested state for more than 3 days

- [ ] **Scenario B (Firmware Alert):** A unit whose _latest_ message of type 103 is older than 3 days AND has a status NOT IN (10, 12, 13, 25, 28). (Expected output: '01' or '11')
- [ ] **Scenario C (Both Alerts):** A unit meeting conditions for both Scenario A and Scenario B. (Expected output: '11')
- [ ] **Scenario E (Recent / No Relevant Messages):** A unit whose latest relevant messages are recent OR has no relevant messages at all. (Expected output: '00')
- [ ] **Scenario D (Old but Good Status):** A unit whose latest relevant message(s) are older than the thresholds BUT have a status IN (10, 12, 13, 25, 28). (Expected output: '00')

- [ ] Try these, but change them going forward:
	- C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2.sql
	- C:\Projects\_MiXTelematicsFiles\SQL\OE-614 Original and Refactor compare Alerts 1_2 BULK.sql
	- 

### Alert 3: 
### Alert 4: Missing Parameters

Have a lot to test already
- 

