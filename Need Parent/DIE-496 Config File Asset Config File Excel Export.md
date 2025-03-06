Date: 2022-03-18 Time: 11:55
Status: #done
Friend: [[DIE-485 DI Config Asset config file]]
[[Export]] [[Excel]]
JIRA:DIE-496
[DIE-496](https://jira.mixtelematics.com/browse/DIE-496)

# DIE-496 Config File Asset Config File Excel Export

## Description

1) Read all the information from the previously mentioned stored procs
2) Should we split the mentioned sections into separate tabs? UX.
3) Add logic to create an excel report
4) Download this for the user (as used other places in the system)

## Learned

### Exporting class

```c#
using ClosedXML.Excel;

namespace DynaMiX.ImportExport
{
	public static class AssetConfigFileXlsxExporter
	{
		public static void AddSheet<T>(XLWorkbook xlWorkbook, string sheetname, List<T> items) where T: new()
		{
			IXLWorksheet worksheet = xlWorkbook.AddWorksheet(sheetname);
			if (items.Count > 0)
			{
				worksheet.Cell(1, 1).InsertTable(items, sheetname, false);
				worksheet.SheetView.FreezeRows(1);
			}
			worksheet.Columns().AdjustToContents();
		}

		public static void Export(Stream stream, XLWorkbook xlWorkbook)
		{
			using (var ms = new MemoryStream())
			{
				xlWorkbook.SaveAs(ms);
				ms.Position = 0;
				ms.CopyTo(stream);
			}
		}
	}
}
```

### Mapping class eg.

```c#
using ClosedXML.Attributes;

namespace DynaMiX.Api.NancyModules.ConfigAdmin.TemplateLevel.ImportExport
{
	public class AssetConfigFileXlsxGeneralClassMap
	{
		[XLColumn (Header = "Asset Id", Order = 1, Ignore = false)]
		public string AssetId { get; set; }
	}
}
```
### Use case

```c#
//Build up all the sheets
XLWorkbook xlWorkbook = new XLWorkbook();
AssetConfigFileXlsxExporter.AddSheet(xlWorkbook, "Asset", dummyDataAsset);
AssetConfigFileXlsxExporter.AddSheet(xlWorkbook, "Locations", dummyDataLocations);
AssetConfigFileXlsxExporter.AddSheet(xlWorkbook, "Lines", dummyDataLines);

//Download as a stream
response.Contents = stream => { 
	AssetConfigFileXlsxExporter.Export(stream, xlWorkbook); 
	stream.Flush(); 
	stream.Close(); 
};
```

## Ideas (not relevant)

![[Pasted image 20220318122535.png]]


**BEST Example**: 
C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\UserManagement\Users\UserAdminModule.cs
	ExportUser(...

A LOT Happens in here:
C:\Projects\DynaMiX.Backend\Components\ImportExport\DynaMiX.ImportExport\XlsxExporter.cs

Handled in here: C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetImportExportModule.cs 

GET_IMPORT_TEMPLATE_FOR_UPDATE

```c#
carrier.ImportTemplateForUpdateLink = GetAbsoluteUrl(AssetImportExportModule.ModuleRoutes.GET_IMPORT_TEMPLATE_FOR_UPDATE.ToLinkCarrier("importTemplateForUpdate", new { groupId = groupId }));
```
				
**Busy**

```c#
public static readonly RouteDefinition GET_MOBILEUNIT_CONFIG_FILE = new RouteDefinition(APISettings.Current.ApiBaseUrl, BasePath, "/organisations/{orgId}/asset/{assetId}/downloadMobileUnitConfigFile", Core.Http.Constants.HTTPVerbs.GET);

RegisterRouteUnhandled(ModuleRoutes.GET_MOBILEUNIT_CONFIG_FILE, args => GetMobileunitConfigFile(AuthToken, (long)args["orgId"], (long)args["assetId"]));


```
