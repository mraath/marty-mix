Date: 2022-07-07 Time: 13:30
Status: #closed
Friend: 
JIRA:AC-361
[AC-361 Fuel Type to be populated in the GetAvailableScriptsInfo - MiX Telematics JIRA](https://jira.mixtelematics.com/browse/AC-361)

# AC-361 Fuel Type shows as null

## Image


## Development work

- Lambda

## Branch
Config/MR/Bug/AC-361_FuelType_null.INT.22.11.ORI

## Notes
- Run **Pipeline**
	- [Pipelines - Runs for MiX.DIConfig.DCAN.GetAvailableScriptsInfo (visualstudio.com)](https://mixtelematics.visualstudio.com/DeviceIntegration/_build?definitionId=918&_a=summary)
- **Release** from that pipeline
	- eg. [MiX DynamicCan GetAvailableScriptsInfo - Release-43 - Pipelines (visualstudio.com)](https://mixtelematics.visualstudio.com/DeviceIntegration/_releaseProgress?releaseId=24747&_a=release-pipeline-progress)
- Ensure online that it shows the latest **Lambda**
	- [Functions - Lambda (amazon.com)](https://eu-west-1.console.aws.amazon.com/lambda/home?region=eu-west-1#/functions?fo=and&o0=%3A&v0=DCAN)
- The Lambda is found here
	- [INT-DIConfig-DCAN-GetAvailableScriptsInfo - Lambda (amazon.com)](https://eu-west-1.console.aws.amazon.com/lambda/home?region=eu-west-1#/functions/INT-DIConfig-DCAN-GetAvailableScriptsInfo?tab=code)
- The **scripts** are found here
	- [Items | Amazon DynamoDB Management Console](https://eu-west-1.console.aws.amazon.com/dynamodbv2/home?region=eu-west-1#item-explorer?initialTagKey=&maximize=true&table=INT-DynamicCAN_CANScripts)
	- 

