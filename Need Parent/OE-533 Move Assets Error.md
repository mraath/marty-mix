---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-02-28T16:12
---

# OE-543 Move Assets Error

Date: 2024-11-01 Time: 15:31
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-11-01]]
JIRA:OE-543 Move Assets Error
[OE-543 Verify the behaviour when the move operation fails - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-543)


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

## Shorter Description

OK - changed it to
- Reload all config groups
- Removed allAssets that related to: Selected CGs and Moved To CG
	- [MoveTpConfigError.mov](https://mixtelematics-my.sharepoint.com/:v:/p/marthinus_raath/ERh08Hs_lA1KlmzXeyUw3RUBsOk2QOQf7rSyCTXgm5WTAQ?e=uhn70e)
- [x] Check why BE is only handling first ✅ 2025-02-28
	- http://localhost:5000/api/configuration-groups-multiselect/groupId/-1983255592473789111/assets/configuration-groups/-1452809276394549164/update-assets-config-group
	- 1. assetIds: "1471470736609681408,1471493801774899200,1471569989004386304"
	- OrgId: -1983255592473789111
	- ConfigGroupID: -1452809276394549164
	- update-assets-config-group
	- [1471470736609681408,1471493801774899200,1471569989004386304]
	- ANOTHER TEST
		- "1471451662105927680,1471101195350568960,1466019926734364672,1471493801774899200,1469654901081403392,1447989472206643200"
		- http://localhost:5000/api/configuration-groups-multiselect/groupId/-1983255592473789111/assets/configuration-groups/-1452809276394549164/update-assets-config-group
		- ORG: -1983255592473789111
		- CG: -1452809276394549164
		- UI: Still only one
		- Lets try the Config API, then see if the UI changed...
		- TEST: xxxxxxxxxxxxxxxxxxxxxxxxxx
		- LOG: [OSD - Logz.io](https://app.logz.io/#/dashboard/osd/discover/?_a=\(columns:!\(AppName,message\),filters:!\(\('$state':\(store:appState\),meta:\(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:message,negate:!f,params:!\('1471451662105927680','1471101195350568960','1466019926734364672','1471493801774899200','1469654901081403392'\),type:phrases,value:'1471451662105927680,%201471101195350568960,%201466019926734364672,%201471493801774899200,%201469654901081403392'\),query:\(bool:\(minimum_should_match:1,should:!\(\(match_phrase:\(message:'1471451662105927680'\)\),\(match_phrase:\(message:'1471101195350568960'\)\),\(match_phrase:\(message:'1466019926734364672'\)\),\(match_phrase:\(message:'1471493801774899200'\)\),\(match_phrase:\(message:'1469654901081403392'\)\)\)\)\)\)\),index:'logzioCustomerIndex*',interval:auto,query:\(language:lucene,query:''\),sort:!\(!\('@timestamp',desc\)\)\)&_g=\(filters:!\(\),refreshInterval:\(pause:!t,value:30000\),time:\(from:now-55m,to:now\)\)&switchToAccountId=157279&accountIds=true)
	- [x] Config: Seems to wait ✅ 2025-02-18
	- [x] Client: ✅ 2025-02-27
		- It seems like if I test the client, it doesn't wait for a result - it should
		- OK NO - it SEEMS OK after testing many times
	- [x] FR API: ✅ 2025-02-28
	- [x] Languaging ✅ 2025-02-28
		- Error
		- 

Config.Api > UpdateAssetsConfigurationGroup = "groupId/{groupId}/assets/configuration-groups/{configGroupId}/update-assets-config-group";
DynaMiX.DeviceConfig > OLD
Client > $"{PostPutApiUrl}/groupId/{groupId}/assets/configuration-groups/{configGroupId}/update-assets-config-group?authToken={authToken}"
FRAPI > UpdateAssetsConfigurationGroup = "api/configuration-groups-multiselect/groupId/{groupId}/assets/configuration-groups/{configGroupId}/update-assets-config-group"



top


## Reloading the correct information

- [x] Reload all assets at the correct ✅ 2025-02-28
- PR: [Pull request 120044: OE-533: Fixed a few move asset issues - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/120044)
- 

## Notify if no need to move

- [x] No asset(s) to be moved ✅ 2025-02-28

## Current Issue

Ok - I finally found something that makes sense.... we call multiple threads to change the config group - and then this error is raised - but the error never bubbles up to the UI.

- [x] I will now show the error (if it happens again) ✅ 2025-02-28
- [x] I will try to fix this as well ✅ 2025-02-28

![[OE-543 Move Assets Error Multiple Threads error.png]]

- OE-543: Show errors
	- [x] PR: [Pull request 119363: OE-543: Added a field to show Error Message to UI - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/119363) ✅ 2025-02-19
	- **MiX.DeviceIntegration.Common.2025.5.20250219.1**
	- BRANCH: Config/MR/Bug/OE-543_Move_Assets_Error.INT
	- API (605)
		- [x] PR: [Pull request 119423: OE-543: Upgraded nuget. Return error. - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.Api/pullrequest/119423) ✅ 2025-02-21
		- NA: One by one (Now only allowing one)
	- Client (543)
		- [x] PR: [Pull request 119425: OE-543: Upgraded Nuget - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/119425) ✅ 2025-02-21
		- **MiX.ConfigInternal.Api.Client.2025.5.20250220.1**
		- MiX.ConfigInternal.Api.Client.2025.5.20250220.1-_alpha_.
		- MiX.Core.Serialization.Jil
	- FR API (605)
		- Own local client used. BUT use above one and PR
		- Also Common
		- [x] PR: [Pull request 119495: OE-543: Upgraded nuget to return multithread DbContext EF error. - Repos](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/119495) ✅ 2025-02-21
	- FR FE

```c#
// OLD Config.Api
if (!a.Success)
{
	if (a.Message.Contains(ErrorMessages.ConfigAdmin.CONFIG_GROUP_ASSET_MOBILE_DEVICE_TYPE_CONFLICT))
		incompatibleAssets.IncompatibleAssetIds.Add(item.Key);
	else
		incompatibleAssets.ErrorMessage += a.Message;
}

// Config.Api
foreach (long assetId in assetIds)
{
	UpdateResult a = await UpdateAssetConfigGroupAsync(authToken, groupId, assetId, configurationGroupId).ConfigureAwait(false);
	if (!a.Success)
	{
		if (a.Message.Contains(ErrorMessages.ConfigAdmin.CONFIG_GROUP_ASSET_MOBILE_DEVICE_TYPE_CONFLICT))
			incompatibleAssets.IncompatibleAssetIds.Add(assetId);
		else
		{
			incompatibleAssets.ErrorMessage += assetId.ToString() + ": ";
			incompatibleAssets.ErrorMessage += (a.Message.Count > 0) ? a.Message[0] : "Failed";
			incompatibleAssets.ErrorMessage += " ";
		}
	}
}
```

## FE Add Error Message

- assetsMoveErrorMessage
- 

## Threads issue

I get an error like the following when trying to call the "Update Configuration Groups for Asset" asynchronically with multiple assets.

System.InvalidOperationException: 'A second operation was started on this context instance before a previous operation completed. This is usually caused by different threads concurrently using the same instance of DbContext. For more information on how to avoid threading issues with DbContext, see https://go.microsoft.com/fwlink/?linkid=2097913.'

For now I will call them one by one, however, I think this could potentially happen in other areas in our code as well.
We just happened to see this as we were testing something else.
The place where it falls over is called from many places in our code.
(It seems to happen here: var mu = await deviceConfigRepo.GetMobileUnitAggregate(assetId).ConfigureAwait(false);

- [x] Maybe this could be a nice tech debt story in future.

- [[DbContext Multithread Issue]]
- [CONFIG-4604 DbContext Multithread Issue - Jira](https://csojiramixtelematics.atlassian.net/browse/CONFIG-4604)
