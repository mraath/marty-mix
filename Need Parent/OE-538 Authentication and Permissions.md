---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-11-01T16:45
---

# OE-538

Date: 2024-10-28 Time: 16:47
Parent:: [[OE-513]]
Friend:: [[2024-10-28]]
Friend:: [[OE-496 API Config Groups and columns]]
Friend:: [[OE-497 API Load Assets]]
JIRA:OE-538
[OE-538 Authentication and Permissions - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-538)

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

## Description

- OLD CG 
	- FE:
		- POST: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/config_groups
	- BE:
		- ConfigurationGroupsModule: 
		- ROUTE: GET_CONFIG_GROUPS_LIST
		- Method: GetConfigGroupListPage
		- As far as I can see it only gets the data without considering Authorisation
- OLD Assets
	- FE:
		- POST: https://integration.mixtelematics.com/DynaMiX.API/config-admin/organisations/-7094567047859310012/config_groups/0/assetlist
	- BE:
		- ROUTE: GET_CONFIG_GROUP_ASSETS
		- Method: GetConfigGroupAssetList
			- GetMobileUnitSummariesForConfigurationGroupMobileUnitSummary (later: orgAssets !!!)
				- man.GetMobileUnitSummariesForConfigurationGroup
			- assetManager.GetAssetSummaries
				- GetAssetSummaries
					- var securityAccounts = AuthenticationManager.GetSecurityAccountsFor(authToken);

## Fleet Search

- [AssetSummaries - Search Code - Search](https://dev.azure.com/MiXTelematics/Fleet/_search?action=contents&text=AssetSummaries&type=code&lp=dashboard-Project&filters=ProjectFilters%7BFleet%7D&pageSize=25&result=DefaultCollection/Fleet/Fleet.Services/GBIntegration//MiX.Fleet.Services.Logic/Assets/AssetsManager.cs)

## Message to Tim

Hi Tim, I hope you are doing well!!
We are busy re-writing the Config Groups page (as you might know).
At first I focused on speed and getting functionality out.
I now realised that I need to consider Authorisation again, after looking into the Fleet way of doing things :-)
### Here is an example.

I just get all the Config Groups for the current Org for the current User. I don't look if the user is allowed to see those config groups.
Next I get all the assets for these config groups, also not considering the user.
### Problem

I saw that in the old BE logic, the config groups work the same, however, getting the assets looks at the user's permissions.
It then also looks if the current user can see the assets before showing them.
### Question

What is the best Fleet Service Client method to call for the above problem?
Basically I will keep my logic as it is, but then before showing the assets, I will compare the assetIds I want to show with the assetIds the user is allowed to view and then just through out the ones the user may not view. I saw in the code it also considers the sites the current user have access to... etc.
So I purely need to get a list of assetIds the user may view for this organisation. 
I have all the authToken, OrgId, assetIds I want to show.
Is the following the correct one to use, or is there a faster simpler one for me to use: GetSummariesAsync

## TEsting

- a1f2450a-fde9-4f8d-b3ae-571a8d10284b
- -4493495256567590976
- -4366193155933191679,7270785342402232596,-4067179943998429825

PR: [Pull request 113880: OE-538: Ensure only Assets the user has Authorisation for is shown - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/113880)

- NOT IN AssetSummary

8591433084324666187
MiX6000 + Iridium


9041905456165491651
MR FM 2
assetId=1489278657468002304

---

FROM this list
groupId = -4493495256567590976
AccountId = 40000000010003

```txt
Count = 12
    [0]: 1214706184788545536
    [1]: 1214711596240871424
    [2]: 1214723089276506112
    [3]: 1214969692863340544
    [4]: 1489265894188347392
    [5]: 1489278657468002304
    [6]: 1489564718297899008
    [7]: 1489566850975653888
    [8]: 1489581881708634112
    [9]: 1489953277617930240
    [10]: 8591433084324666187
    [11]: 9041905456165491651
```

These two are not coming through... why not?
8591433084324666187 (MiX6000 + Iridium)
9041905456165491651 (MR FM 2)


---

id=1588489224532598784
orgId=-5401647754082838271
Config Groups sent: 

-3858128754413928384,-2936352154978177021,-2285220521801808649,-231807250189285465,-5878214226497422713,-5322542706332715080,-133855804881703573,-5579545911740947113,-6151267166848528093,-6644804808631025429,2406271002898770158,1040893382572996736,3611817551964232733,3959284584608886081,-3132820852874418386,-4225283288011955553,-2440320943995442748,-6300261974712159873,-2221726257111617269,6956525315613478272



https://integration.mixtelematics.com/#/fleet-admin/asset/details?id=5220957640519426075&orgId=-7094567047859310012



## Fix Duplicates

- [Pull request 114004: OE-538: Remove duplicates - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/114004)
- 