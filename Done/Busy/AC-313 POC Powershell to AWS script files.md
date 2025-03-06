---
status : closed
date : 2020-08-05
comment : close with ac-124
priority: 8
---

 #ac #powershell #aws

[[Powershell]], [[AWS]], [[AC-124 Build pipeline]]
JIRA:AC-313

# AC-313 POC Powershell to AWS script files

## Overview
![[Pasted image 20220826084245.png]]

## Notes
- lambda: [mrac313b - Lambda (amazon.com)](https://eu-west-1.console.aws.amazon.com/lambda/home?region=eu-west-1#/functions/mrac313b?tab=code)
- AWS API Gateway: [API Gateway (amazon.com)](https://eu-west-1.console.aws.amazon.com/apigateway/home?region=eu-west-1#/apis/q6opn14h1e/resources/efsa5a5876)
- pipeline: [mrac313 (1) - Pipelines (visualstudio.com)](https://mixtelematics.visualstudio.com/DeviceIntegration/_apps/hub/ms.vss-build-web.ci-designer-hub?pipelineId=907&branch=main)
- SNS: [Simple Notification Service (amazon.com)](https://eu-west-1.console.aws.amazon.com/sns/v3/home?region=eu-west-1#/topic/arn:aws:sns:eu-west-1:601704920959:mrac313)
- git: [mrac313 - Repos (visualstudio.com)](https://mixtelematics.visualstudio.com/DeviceIntegration/_git/mrac313)
- cloudwatch: [CloudWatch Management Console (amazon.com)](https://eu-west-1.console.aws.amazon.com/cloudwatch/home?region=eu-west-1#logsV2:log-groups/log-group/$252Faws$252Flambda$252Fmrac313b)

## Deploy
- Build: [Pipelines - Runs for MiX DynamicCan ScriptCapture Lambda (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_build?definitionId=902)
- Deploy: [Releases - Pipelines (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_release?definitionId=68&view=mine&_a=releases)
- 

?? # /aws/lambda/INT-DIConfig-DCAN-WriteCANDbEntry
mrac313WriteApi

## DynamicCan
- Config/MR/Feature/AC-313_LoggingToTrackError.INT.ORI



- Now get it to work with the actual one...
- WriteDynamicCANScriptEntry
- There is a test for this... and I need local files....
- {PostPutApiUrl}/WriteCANDbEntry

mrac313
arn:aws:sns:eu-west-1:601704920959:mrac313

arn:aws:lambda:eu-west-1:601704920959:function:mrac313




2hepbp7xbvn2l5t26s2wdpef7uo4ppwzjz24rze7xxno3qppyyoq

https://q6opn14h1e.execute-api.eu-west-1.amazonaws.com/mrac313test/mrac313


curl -v -X POST "https://q6opn14h1e.execute-api.eu-west-1.amazonaws.com/test/helloworld?name=John&city=Seattle" -H "content-type: application/json" -H "day: Thursday" -d "{ \"time\": \"evening\" }"

