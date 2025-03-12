---
created: 2025-03-12T08:09
updated: 2025-03-12T08:27
---
## IIS

- Server: HSOMNIIS18
- **FMTimeAdjuster.Api** needs to be running
![[OMAN DST Command 45 Setup IIS.png]]
- Ensure that this is runing without error
![[OMAN DST Command 45 Setup Running.png]]
- IF there were errors, most likely it is inside it's **config** file ensure the following is correct
	- For our situation the Automapper was giving an error and we fixed the below:


## Utils

