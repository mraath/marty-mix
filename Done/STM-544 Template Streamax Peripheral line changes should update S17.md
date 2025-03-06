# STM-544 Template: Streamax Peripheral line changes should update S17

API | Local | INT
Client | Local | INT | NUGET
BE | Local | PR INT

templateId: -2889481404669600628
GroupId : -8386191436408769566

Config/MR/Feature/STM-544_ChangeTemplatePeripheral.21.16.INT.ORI

DONNY INT UNIT: 1187448574767980544

		UpdateMobileDeviceTemplateStreamaxDeviceDescriptions = "groupId/{groupId}/mobiledevicetemplateId/{mobileDeviceTemplateId}/devicetypeId/{deviceTypeId}/devicedescription/{deviceDescription}/update-streamax-device-descriptions"


API: New Route & Controller calling same manager
CLient: New method
BE: Call new method

THIS IS IT!
Maybe change the endpoint to receive a list of assets to change - then loop through them
ELSE: 
Loop through them from BE - this will make too many API calls... previous idea it is then!!
