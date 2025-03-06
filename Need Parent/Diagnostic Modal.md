- Old Diagnostics modal Used by:
	- [[MiX2310i]]
	- 
![[Diagnostic Modal Old.png]]

- New Diagnostics Modal
	- [[MiX4000]]
	- [[DME]] A call eg.
		- https://integration.mixtelematics.com/DynaMiX.API/fleet-admin/assets/organisations/8071296543227367712/1307418444008112128/diagnostics/DigitalMatterGeneral/trip/0
			- status.Odometer = (entity.AssetStatus.VehicleLastOdo * 1000) ?? 0
				- entity = AssetsManager.GetAssetDiagnosticInfo
				- AssetStatus = AssetStatusBagConverter.Convert(statusValues
				- statusValues = fleetStatusValues = AssetsClient.GetStatusValuesAsync
				- GetStatusValues = "/api/assets/organisation/{organisationId:long}/asset/{assetId}/statusvalues";
				- [dynamix].[AssetStatusValues_Get]
				- [VehicleLastOdo] = dbo.Vehicles.fLastOdo
![[Diagnostic Modal New.png]]
