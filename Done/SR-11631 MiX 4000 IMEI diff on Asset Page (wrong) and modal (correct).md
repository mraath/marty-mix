# SR-11631 MiX 4000 IMEI diff on Asset Page (wrong) and modal (correct)

	SR-11470

	assetlist.html
	field: imei
	BE: assetDetails.AssetConfigDetails.Imei
	property = MobileUnitProperties for UNIT_IMEI = 9188780602356317147
	property ?? mobileUnit.UniqueIdentifier

	diagnostics modal
	Request URL: http://localhost/DynaMiX.API/fleet-admin/assets/organisations/3222089765699420885/1042482923749302272/diagnostics/MiX4000/mobiledevice/0
	mobileUnit?.UniqueIdentifier
