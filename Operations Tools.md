---
created: 2025-05-05T11:56
updated: 2026-02-25T09:42
---
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
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```


> [!Information] Writing tools to make the clients' lives easer.

## Links

- [Sprint Board](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/7014/backlog)
- [Repo Overview](https://dev.azure.com/MiXTelematics/OperationsTools)
- [Kanban](https://powerfleet.atlassian.net/jira/software/c/projects/OPEN/boards/6981)
- [Repo Dev](https://dev.azure.com/MiXTelematics/OperationsTools/_git/Powerfleet.Automation?path=%2F&version=GBdevelopment&_a=contents)
- 

## Stories

- Spike QC Automation: https://powerfleet.atlassian.net/browse/OPEN-1223 **Investigate QC Automation**
	- Epic na API: https://powerfleet.atlassian.net/browse/OPEN-1264 Unity MX Installation QC Automation - **Phase 1**
		- https://powerfleet.atlassian.net/browse/OPEN-1539: Consolidated Customer/Subscriber **Database EPIC**
			- https://powerfleet.atlassian.net/browse/OPEN-1495 Investigate **Customer Database** requirements
		- https://powerfleet.atlassian.net/browse/OPEN-1293: **API** End point
			- https://powerfleet.atlassian.net/browse/OPEN-1493 Add **UI** for support to supply Salesforce case info and start QC Automation manually
				- [x] [[OPEN-1493 UI for Salesforce case Info]] ✅ 2026-02-24
					- DEV
						- **1 instance**
						- [x] Drop down ✅ 2026-02-25
							- AU (kan dit inlog op ander API)
							- etc
							- [ ] Auth > config.api > authentication service
								- dalk users sonder login
					- [x] **Velde**: ✅ 2026-02-25
						- Legacy ID (remove)
						- Device Type: Dropdown - API
							- 4k, 6k (spelling)
					- [x] Menu with Decommissioning place holder ✅ 2026-02-24
			- [ ] **VIDEO**: https://powerfleet.atlassian.net/browse/OPEN-1299
				- Ook nou gecheck oor video. Ons toets alreeds of daar kameras opgestel is as die peripheral connect is. Al wat nou moet gebeur is om deur die List te hardloop, elke channel te kyk of daar video op die channel is na installation.
			- Decommissioning Automation - Phase 1: https://powerfleet.atlassian.net/browse/OPEN-1545
				- Add Decommissioning Endpoint: https://powerfleet.atlassian.net/browse/OPEN-1567
			- https://powerfleet.atlassian.net/browse/OPEN-1494 Meeting: Investigate **Config** **analyses** tool to see where changes happened
				- [[OPEN-1494 Config Analysis Tool]]
- 
- Operations Enablement Engineering Improvements: https://powerfleet.atlassian.net/browse/PFI-3133
	- CAN Logger App Enhancements: https://powerfleet.atlassian.net/browse/OPEN-455
- [ ] FC Plus
- [ ] Config change analysis tool - SPLIT!
	- https://powerfleet.atlassian.net/browse/OPEN-1624

- **AI** to work with Salesforce: https://powerfleet.atlassian.net/browse/OPEN-1526
- **Trigger** QC API Endpoint: https://powerfleet.atlassian.net/browse/OPEN-1356
- **Salesforce** EndPoint: [[OPEN-1328] Create endpoint in Salesforce - Jira](https://powerfleet.atlassian.net/browse/OPEN-1328 "https://powerfleet.atlassian.net/browse/open-1328")

Jira


## Examples

- [[QBR Report for clients]]
- [[AI python to see data issues]]
- [[Operations Enablement]]

