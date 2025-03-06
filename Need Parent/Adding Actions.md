Date: 2022-05-23 Time: 10:59
Status: #closed  
Parent:: [[Teaching]]

# Adding Actions

## Development work

| Lang  | UI    | BE    |
| ----- | ----- | ----- |
| Local | Local | Local |

## BE

eg. file: 
..\DynaMiX.Backend\API\DynaMiX.API\NancyModules\ConfigAdmin\TemplateLevel\ConfigurationGroupsModule.cs

``` c#
//ACTION: Define the action for the dropdown
private string _downloadMobileunitConfigFileAction = AssetConfigurationAction.DownloadMobileunitConfigFile.GetDescription(); //79 "DownloadMobileunitConfigFile"


//ROUTE: Define the route to be called from the UI
public static readonly RouteDefinition GET_MOBILEUNIT_CONFIG_FILE = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/organisations/{orgId}/asset/{assetId}/downloadMobileUnitConfigFile", Core.Http.Constants.HTTPVerbs.GET); //99

//ROUTE: Handling the call
RegisterRouteUnhandled(ModuleRoutes.GET_MOBILEUNIT_CONFIG_FILE, args => GetMobileunitConfigFile(AuthToken, (long)args["orgId"], (long)args["assetId"])); //118



//GetConfigGroupAssetList
//Calls the ConvertToCarrier for each item
//Add hypermedia for calling the route from the UI
carrier.HyperMedia = new HyperMediaCarrier()
{
	Links = new List<LinkCarrier>()
	{
		...,
		ModuleRoutes.GET_MOBILEUNIT_CONFIG_FILE.ToLinkCarrier("downloadMobileunitConfigFile", new { orgId = organisationId }) //758 //ROUTE
	}
};

//The method used to handle the call
public Response GetMobileunitConfigFile... //942 //ROUTE



//Adding the action for the UI dropdown
//ConvertToCarrier(...
carrier.Actions.Add(_downloadMobileunitConfigFileAction); //1355 //ACTION

```

## UI
eg. file:
..\MiXFleet\UI\Js\ConfigAdmin\ConfigGroups\IConfigGroupsLandingData.d.ts
``` c#
downloadMobileunitConfigFile: DynaMiX.Services.HyperMedia.ComplexMethod<{ assetId: string }, Timeline.ITextSummaryData>; //34 //ROUTE
```

..\MiXFleet\UI\Js\ConfigAdmin\Controllers\ConfigGroupsLandingController.ts

``` c#
downloadMobileunitConfigFileClicked(row): void {... //657 //handles the click


private defaultColumns
...
<MiXFleet.UI.Grid.IRowActionColumnDefintion>{
	field: 'actions',
	cellType: MiXFleet.UI.Grid.RowActionColumn,
	actions: [
		
		...
		{ title: 'Asset configuration file', key: 'DownloadMobileunitConfigFile', iconCssClass: 'icon-report', clickFn: (row) => this.downloadMobileunitConfigFileClicked(row) } //931 //Key connects to ACTION on BE
		
```

## Lang
- Remember to add your languaging in for all actions, column headers, etc