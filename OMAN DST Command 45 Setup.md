---
created: 2025-03-12T08:09
updated: 2025-03-12T08:30
---
## IIS

- Server: HSOMNIIS18
- **FMTimeAdjuster.Api** needs to be running
![[OMAN DST Command 45 Setup IIS.png]]
- Ensure that this is runing without error
![[OMAN DST Command 45 Setup Running.png]]
- Before we saw this green 404, which is good for the Api... we saw the below error
![[SAAS-10447 DST Tool in OMAN 18.17 Result IIS18.png]]
- IF there were errors, most likely it is inside it's **config** file ensure the following is correct
	- For our situation the Automapper was giving an error and we fixed the below:
![[OMAN DST Command 45 Setup Automapper fix.png]]
- After this the Api loaded successfully, green 404 monster
## Utils

- 