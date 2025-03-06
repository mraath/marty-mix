---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2024-10-16T10:37
---

# OE-532 Add Remove action and Hyperlink Edit

Date: 2024-10-08 Time: 09:31
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]
Friend:: [[2024-10-08]]
Friend:: [[OE-496 API Config Groups and columns]]
JIRA:OE-532 Add Remove action and Hyperlink Edit
[OE-532 Configuration Group panel drop down does not work when you click edit, compile and upload within the drop down - Jira (atlassian.net)](https://csojiramixtelematics.atlassian.net/browse/OE-532)

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

After our discussion with Nicole the implementation on this bug will be:  
- [x] Only add a Remove drop-down per row, ✅ 2024-10-11
	- [x] IN data that comes back from the BE... add the "removeAccess" part.... see how Fleet does it ✅ 2024-10-11
	- FE: detailsAccess
	- API: detailsAccess
	- Here are the touch points
		- Carrier: public bool DetailsAccess { get; set; }
		- Permissions:
		- NA: authorisedGroupIds
```c#
var resolvedPermissions = await _authorisationRepository.GetResolvedPermissionsByPermissionIdsAsync(_sessionService.CurrentUser.Id, permissionIds, _sessionService.CorrelationId).ConfigureAwait(false);
var resolvedPermissionsMap = new Dictionary<long, HashSet<long>>(resolvedPermissions.ConvertAll(x => new KeyValuePair<long, HashSet<long>>(x.PermissionId, x.GroupIds)));
carrier.DetailsAccess = resolvedPermissionsMap.TryGetValue(Permissions.ASSET_UPDATE, out authorisedGroupIds) && authorisedGroupIds.Contains(asset.SiteId);
```
- .
	- .
		- FR FE: Read this from the carrier
```c#
private linkColumnSettings: Record<string, ILink> = {
	"description": { field: "detailsAccess", handler: this.detailsClicked.bind(this) }

IAssetSearchCarrier {
	public bool DetailsAccess { get; set; }
```

- [x] The Hyperlink on the name will be used to edit ✅ 2024-10-16
	- No specific permissions needed

## Remove ideas

- [template].[Template_DeleteEventTemplate]
- 

## Old Code

### Remove

FE:
- Remove
- ConfigGroupsLandingController.RemoveEvent "onRemove"
- this.removeGroup(row)
- Has assets show: 
	- removeGroupErrorModal
- No assets: pageData.remove <- getConfigGroups
	- alert.show(MiXFleet.Services.AlertType.Success, "Group successfully removed")
	- [x] Language ✅ 2024-10-16


BE:
- getConfigGroups
	- Route: GET_CONFIG_GROUPS_LIST
	- GetConfigGroupListPage
	- "remove"
- Route: DELETE_CONFIGURATION_GROUP
	- [x] ? Common: CAN_DELETE_CONFIGURATION_GROUPS = 500000035 ✅ 2024-10-10
	- DeleteConfigurationGroup(AuthToken, (long)args["orgId"], (long)args["id"])
	- configurationGroupManager.DeleteConfigurationGroup(authToken, orgId, configurationGroupId)
		- VoidGatewayResult(GatewayResultStatus.Success)
	- IF NO Assets (ConfigAdminRepository.GetMobileUnitCountForConfigGroup(configurationGroupId) == 0)
		- ConfigAdminRepository.DeleteConfigurationGroup(configurationGroup)
			- ConfigurationGroups.Remove(configurationGroup)
			- [x] DELETE [template].ConfigurationGroups WHERE... ✅ 2024-10-15
		- [x] Caching: ConfigInternalClient.Caching.InvalidateMobileUnitConfigurationGroupCache(authToken, configurationGroupId, null).ConfigureAwait(false).GetAwaiter().GetResult(); ✅ 2024-10-16
			- InvalidateMobileUnitConfigurationGroupHashCache(long configurationGroupId)
			- Double check with Justus
	- Assets:
		- Common: CONFIG_GROUP_DELETE = "Cannot delete configuration group without moving assets to another configuration group";

### Hyperlink Edit

- Is Pallavi working on Edit Config Group?
- https://integration.mixtelematics.com/#/config-admin/configuration-groups/edit?id=2557659825063191210
	- TEST
		- Went to: http://localhost/MiXFleet.UI/#/config-admin/configuration-groups/edit?id=-2803813420773469362
		- Should have: https://integration.mixtelematics.com/#/config-admin/configuration-groups/edit?id=-2803813420773469362
		- WORKS
![[OE-532 Add Remove action and Hyperlink Edit Opens old Edit.png|700]]

## Repos

- Config/MR/Bug/OE-532_Remove_Edit_ConfigGroup.INT
- Common: 
	- [Pull request 112102: OE-532: Added a field to store permissions for Removing Config Groups - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/112102)
	- MiX.DeviceIntegration.Common.2024.16.20241009.1
	- RemoveAccess (added)
	- [Pull request 112105: OE-532: Added Remove permission for CG (prev was for asset) - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceIntegration.Core/pullrequest/112105)
	- Added for CG, prev was for Asset
	- MiX.DeviceIntegration.Common.2024.16.20241009.2
- API: [Pull request 112209: OE-532: Added Remove Access logic - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/112209)
- Client: [Pull request 112210: OE-532: Upgraded the return class to include the RemoveAccess - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/112210)
	- MiX.ConfigInternal.Api.Client.2024.16.20241010.1
- FR API: Issues:
	- MiX.Core.Serialization.Jil (Upgraded)
	- MiX.ConfigInternal.Api.Client (MiX.Config.Frangular.API) <<
	- [Pull requests - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequestcreate?sourceRef=Config/MR/Bug/OE-532_Remove_Edit_ConfigGroup.INT&targetRef=Integration&sourceRepositoryId=d8682da1-443f-455b-ac1e-831e3afb6a48&targetRepositoryId=d8682da1-443f-455b-ac1e-831e3afb6a48)
- FR UI: 

```c#
bool canRemoveConfigurationGroup = allPermissions[ConfigConstants.Permissions.CAN_DELETE_CONFIGURATION_GROUPS];
if (canRemoveConfigurationGroup && carrier.AssetCount == 0)
{
	carrier.Actions.Add(_removeAction);

allPermissions = AuthorisationManager.Authorise(authToken,
	new List<long>()

//FLEET
readonly IAuthorisationManager _authorisationManager
_authorisationManager = authorisationManager;
var authorised = await _authorisationManager.AuthoriseAsync(SessionService.CurrentUserId, Permissions.MANAGE_ORGANISATION_SUB_GROUPS, organisationId).ConfigureAwait(false);

## Test

Org:
-4493495256567590976

curl -X GET --header 'Accept: application/json' 'http://localhost/DynaMiX.DeviceConfig.Services.API/api/configuration-groups-multiselect/groupId/-4493495256567590976?authToken=954abd58-5149-4c4e-913b-6d59f94eed82'
```
- DB:
	- [template].[Template_DeleteConfigurationGroup]
		- [template].ConfigurationGroups < @configurationGroupId
		- [Pull request 112337: OE-532: Added DELETE Config Group - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/Database/pullrequest/112337)
- API: DeleteConfigurationGroup
	- public const string DeleteConfigurationGroup = "configuration-groups-delete/{configurationGroupId}/groupId/{groupId}";
	- [Pull request 112339: OE-532: Added the API end-point to delete a config group - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/DynaMiX.DeviceConfig/pullrequest/112339)
- Client:
	- [Pull request 112348: OE-532: Added internal client method to delete a config group - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.DeviceConfig/pullrequest/112348)
	- MiX.ConfigInternal.Api.Client.2024.16.20241011.1
- FR API:
	- [Pull request 112515: OE-532: Added FR API method to delete a config group - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/112515)
- FR UI:
	- deleteConfigurationGroup
```c#
//string groupId, string configurationGroupId
this.spinnerService.show(true);
this.module.uploadMobileUnitsFirmware({ groupId: this.organisationId }, { assets: uploadAssetFWCarrier })
  .pipe(takeWhile(() => this.alive))
  .subscribe(
	(carrier: ResultCarrier) => {

	  //This will be if no "errors" happened
	  if (carrier === undefined || carrier.resultMessage === undefined || carrier.resultMessage === "" || carrier.resultMessage.length === 0) {
		//Show notification to the user
		  this.layoutService.showUserNotification({ showModal: true, messageText: this.languageService.translate("Group successfully removed"), success: true });
	  }

	  this.loadSpinnerConfigGroups = false;
	  this.spinnerService.show(false);
	}
  );


({ groupId: this.organisationId, configGroupId: currentConfigGroup }, { assetIds: assetSelectedKeys })
this.module.getConfigurationGroupsMultiselect({ groupId: this.organisationId })
```
- .
	- [Pull request 112524: OE-532: Added logic to delete a config group - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/112524)
	- this.allAssets = this.allAssets.filter(a => a.configurationGroupId !== currentConfigGroup);
		- this.FilterAssets();
### Delete Type

- FR API:
	- Changed to Delete
	- [Pull request 112619: OE-532: Changed the type to Delete - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/112619)
- FR UI:
	- Check in the logic to Delete
	- [Pull request 112620: OE-532: Added the UI Logic to call the API to delete the config group - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/112620)

### Hypermedia to Edit Config Group - OLD link

- FE: [Pull request 112646: OE-532: Added the logic to link to Edit Config Group - Repos (azure.com)](https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/112646)
- FR FE: [Pull request 112644: OE-532: Added the link to Edit Config Group - old link - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/112644)

### Delete Cache

- [Pull request 112720: OE-532: Added removing the Cache for this Config Group - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.API/pullrequest/112720)

## Progress

![[OE-532 Add Remove action and Hyperlink Edit Added action to remove.png|300]]

![[OE-532 Add Remove action and Hyperlink Edit Successfully Removed with message.png|500]]

## Test


OrgID
-4493495256567590976
ConfigID
8248102713445417311

---

3496445143949211329
OrgId
5970601461602553094
groupId
3496445143949211329

---
Org
-7094567047859310012
CG
5393406227254394582
2774332741699767269

---

011b779b-290c-4fde-8505-d8365d93c924
## Flow

- FR UI: deleteConfigurationGroup({ groupId: this.organisationId, configurationGroupId: dataItem.configurationGroupId })
	- configurationGroupId: 2774332741699767269
	- groupId:-7094567047859310012
- FR API: 
	- Controller: configurationGroupManager.DeleteConfigurationGroup(sessionService.AuthToken, groupIdL, configurationGroupIdL, sessionService.CorrelationId
		- 
	- Manager: ConfigInternalClient.InternalConfigurationGroupsRepository.DeleteConfigurationGroup(authToken, groupIdL, configurationGroupIdL
	- Repo: 
## Errors

```C#
CorrelationId:1582380743825395712|
/api/configuration-groups-delete/5970601461602553094/groupId/3496445143949211329|
10/14/2024 03:14:39|Error:System.NullReferenceException: Object reference not set to an instance of an object. at MiX.Config.Frangular.API.Controllers.ConfigurationGroupController.DeleteConfigurationGroup(String groupId, String configurationGroupId) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Controllers/ConfigurationGroupController.cs:line 285 
at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments) at 
Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask) at 
Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at 
Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context) at 
Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted) at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at 
Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope) at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger) at 
MiX.Core.Web.Abstractions.ConfigurationExtensions.<>c__DisplayClass1_0.<<UseMiXRequestLogging>b__0>d.MoveNext() --- End of stack trace from previous location --- at 
Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext) at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider) at 
Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context) at MiX.Config.Frangular.Web.API.Middelware.SessionMiddelware.Invoke(HttpContext httpContext, ISessionService sessionService, ILoggerService loggerService) in /home/vsts/work/1/s/MiX.Config.Frangular.API/Middleware/SessionMiddelware.cs:line 119 
at Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware.<Invoke>g__Awaited|6_0(ExceptionHandlerMiddleware middleware, HttpContext context, Task task)
```


## Error 2

1582418487322710016|/api/configuration-groups-delete/2774332741699767269/groupId/-7094567047859310012


## Current Status

- Busy with Delete
- 