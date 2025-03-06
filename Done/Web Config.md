Date: 2022-03-08 Time: 15:45
Status: #done 
Friend: 

Let's go back to [[Code]]
# Web Config

## Code sections

  System.Xml.ReaderWriter
  System.Text.RegularExpressions
  System.Security.Cryptography.Algorithms

  ConfigServicesApiServerUrl="http://localhost/DynaMiX.DeviceConfig.Services.API"
  ConfigServicesApiServerUrl="http://api.deviceconfig.int.development.domain.local"

  replace DSINTSQL01 with 10.105.1.234

  sometimes it's easier to run your device config api locally on IIS Express, in which case it will be http://localhost:<portnumber>/DynaMiX.DeviceConfig.Services.API

  PRODUCTION VM
  Host: HSDUBDQA01
  RD Gateway: dubtsg.mixtelematics.com
  Log in with PRODUCTION\<username> credentials
  
  UAT VM
  Host: UATMSSDEV01
  RD Gateway: uattsg1.mixtelematics.com
  Log in with UAT\<username> credentials


  DeviceConfig.API:  
  https://dev.azure.com/MiXTelematics/DeviceIntegration/_releaseProgress?_a=release-pipeline-progress&releaseId=13332

  Backend Devices: (This one changed)
  https://dev.azure.com/MiXTelematics/Common/_releaseProgress?releaseId=20986&_a=release-pipeline-progress

  (old) https://dev.azure.com/MiXTelematics/Common/_releaseProgress?releaseId=20960&_a=release-pipeline-progress