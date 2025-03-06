# STM-533 STM change peripheral

API | Local | INT
Client | INT | nuget | test app
BE | local | INT

Config/MR/Feature/STM-533_ChangePeripheral.21.16.INT.ORI


  <device id="311792233444052589" type="96" systemName="System.Standalone.Streamax.C6DAI"  legacyId="-140000">
    <peripheral description="Streamax C6D AI">

  <device id="-7099857649368562188" type="96" systemName="System.Standalone.Streamax.ADPlus"  legacyId="-140100">
    <peripheral description="Streamax AD Plus">
        
  <dependency id="8798083488271105956" parentId="311792233444052589" type="1" autoConnect="1" childRequired="1" info="System.Standalone.Streamax.C6DAI" />
  <dependency id="2583768499898299715" parentId="-7099857649368562188" type="1" autoConnect="1" childRequired="1" info="System.Standalone.Streamax.ADPlus" />


    UpdateStreamaxDeviceDescription
    public const string UpdateStreamaxDeviceDescription = "asset/{assetId}/update-streamax-device-description/devicetypeid/{deviceTypeId}/devicedescription/{deviceDescription}";


http://localhost/DynaMiX.API/config-admin/organisations/-8386191436408769566/assets/1179100901469630464/lines/4376715893163448311/settings
Request Method: GET



Request URL: http://localhost/DynaMiX.API/config-admin/organisations/-8386191436408769566/assets/1179100901469630464/lines/4376715893163448311/settings
Request Method: PUT
