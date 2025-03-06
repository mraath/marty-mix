# AWS / SAM

## Install basics

- Watch beginning of vid
	- 
- Then the doc online
	- [Developing AWS Lambda Functions Locally With VSCode (travis.media)](https://travis.media/developing-aws-lambda-functions-locally-vscode/)
- Hmmmm
	- [AWS Serverless Application Model for ASP.Net Core Apps | by Ravi Aakula | Medium](https://medium.com/@ravi.aakula/aws-serverless-application-model-for-asp-net-core-apps-1ce03e0e389d)
	- dotnet add package --version 6.4.0 Swashbuckle.AspNetCore
		- [A clean way to add Swagger to ASP.NET Core application (talkingdotnet.com)](https://www.talkingdotnet.com/clean-way-to-add-swagger-asp-net-core-application/)
	- 
## Email

You mentioned that there is some concerns around dev’s that need programmatic access to AWS through the CLI. I have found a good solution called “saml2aws”.

Saml2aws will log into Okta, send a push notification to the Okta app, retrieve temporary credentials for the specified role and save these new credentials to the AWS credentials file.

[https://github.com/Versent/saml2aws](https://github.com/Versent/saml2aws)

- Commands
	- saml2aws configure -a int
	- https://mixtelematics.okta.com/home/amazon_aws/0oasvup9dMjldsRgO5d6/272
	- marthinusr@production.local
	- saml2aws login -a int

After the install, you can run **saml2aws configure -a profilename** and follow the IdP setup steps.  
![](file:///C:/Users/MARTHI~1/AppData/Local/Temp/msohtmlclip1/01/clip_image001.jpg)

It will create a config file like the one below.

![](file:///C:/Users/MARTHI~1/AppData/Local/Temp/msohtmlclip1/01/clip_image002.jpg)

Then run **_saml2aws login -a profilename_**

![](file:///C:/Users/MARTHI~1/AppData/Local/Temp/msohtmlclip1/01/clip_image003.jpg)

Now, the new temporary credentials will be saved to the AWS credentials file and you can run AWS cli commands with the --profile option.

Please let me know if you have any questions or concerns.

Danie van Heerden

## Eg

- mkdir lambda-local && cd lambda-local && touch app.py template.yaml
- add code
- sam build
- mkdir events && cd events && touch events.json
- sam local invoke HelloNameFunction -e events/events.json
- 

## Other

[[AWS]]

saml2aws login -a default
aws configure

saml2aws configure -a int --profile=int --idp-provider=Okta --mfa=PUSH --role=arn:aws:iam::601704920959:role/MiX-DevOpsPowerUser --url=https://mixtelematics.okta.com/home/amazon_aws/0oasvup9dMjldsRgO5d6/272 --session-duration=14400 --region=eu-west-1

------------
saml2aws login -a int

npm run build

cdk list --profile int --app="node ./dist/stacks/configlambdastack.js" -c environment=INT



cdk diff INT-DI-PopulateCanDB --profile int --app="node ./dist/stacks/configlambdastack.js" -c environment=INT

cdk deploy INT-DI-PopulateCanDB --profile int --app="node ./dist/stacks/configlambdastack.js" -c environment=INT

cdk destroy INT-DI-PopulateCanDB --profile int --app="node ./dist/stacks/configlambdastack.js" -c environment=INT


------------




SAM
  Clone
  sam build 
  sam deploy --guided (helps with setup

  go into aws cloudformation
    should see (create in progress or something)

  LOCAL testing / changes
    need docker
    sam local start-api


Event message received: {0} for Vehicle Id {1}
Event Timestamp: {JsonConvert.SerializeObject(dsiEvent)}

{https://integration.mixtelematics.com/}
"/dynamix.api/authentication/token"

"DynaMiX.DeviceConfig.FMTimeAdjuster.Api"
"/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/2364975042774694384/null/null"
"https://integration.mixtelematics.com/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/sendcommand/2364975042774694384/null/null"
2364975042774694384

INT > DSINTIIS01 > IIS

L:/WebServices/DynaMiX.DeviceConfig.FMTimeAdjuster.Api/DynaMiX.DeviceConfig.FMTimeAdjuster.Api.log

https://app.logz.io/#/dashboard/kibana/discover?_a=(columns:!(AppName,message),filters:!(('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:Env,negate:!f,params:(query:UK),type:phrase),query:(match_phrase:(Env:UK))),('$state':(store:appState),meta:(alias:!n,disabled:!t,index:'logzioCustomerIndex*',key:message,negate:!f,params:!('Daylight%20savings%20adjustment'),type:phrases,value:'Daylight%20savings%20adjustment'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(message:'Daylight%20savings%20adjustment')))))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:message,negate:!f,params:!('3522792081055458809'),type:phrases,value:'3522792081055458809'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(message:'3522792081055458809')))))),('$state':(store:appState),meta:(alias:!n,disabled:!f,index:'logzioCustomerIndex*',key:AppName,negate:!t,params:!(MiX.GHOS.Incoming.Generic.Service,MiX.GHOS.Translation.Generic.Service,MiX.GHOS.LegacyTranslation.Generic.Service,Fleet.Services.Tracking.UI.API,MiX.GHOS.Services.Api,Fleet.Services.Tracking.Redis),type:phrases,value:'MiX.GHOS.Incoming.Generic.Service,%20MiX.GHOS.Translation.Generic.Service,%20MiX.GHOS.LegacyTranslation.Generic.Service,%20Fleet.Services.Tracking.UI.API,%20MiX.GHOS.Services.Api,%20Fleet.Services.Tracking.Redis'),query:(bool:(minimum_should_match:1,should:!((match_phrase:(AppName:MiX.GHOS.Incoming.Generic.Service)),(match_phrase:(AppName:MiX.GHOS.Translation.Generic.Service)),(match_phrase:(AppName:MiX.GHOS.LegacyTranslation.Generic.Service)),(match_phrase:(AppName:Fleet.Services.Tracking.UI.API)),(match_phrase:(AppName:MiX.GHOS.Services.Api)),(match_phrase:(AppName:Fleet.Services.Tracking.Redis))))))),index:'logzioCustomerIndex*',interval:auto,query:(language:lucene,query:''),sort:!(!('@timestamp',desc)))&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-5m,to:now))&discoverTab=logz-logs-tab&accountIds=true&switchToAccountId=157279