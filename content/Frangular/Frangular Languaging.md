---
created: 2024-07-25T16:51
updated: 2024-08-20T12:22
---
## Intro

Herewith some notes from the original video.
Please watch Pallavi's video if you need more help.
25th July 2024
## Languaging (Repo) - Clone

Create a new language set

In the folder:
MiXFleetManager > mixfleet_configui (new folder) //Folder created
Then create this folder:
Templates (new)
Create this file:
.pot

Typically you will have a string combination like this which will get translated in .po files
```txt
msgid "STRING TO LANGUAGE"
msgstr ""
```

There is also a folder:
LinqPad Scripts
Open the following file:
CreateInitialLanguageFolders.linq
change: 
string newTranslationComponent = "mixfleet_configui"; //Folder created

Open this in LinqPad 5
run
(this creates all the language folders)

Check all this into **master**

BE Deploy needed to deploy languaging

### Amazon S3

- Our language strings lives here
- Need to create a login
- [[AWS Login for SDK access]]
	- It will make use of Chocolatey
	- You will need this twice a day: saml2aws login -a default
	- The SAML setup will create a file inside ...\\users\\USERNAME\\.saml2aws
	- On OKTA App you will also need to verify

### Frangular API Swagger (test lanuage strings)

![[Frangular Languaging Swagger test.png]]

Breakpoint in Frangular API

![[Frangular Languaging Frangular API Breakpoint.png]]

## Translations

Not our issue, external people do this.
We just check PigLatin

## Frangular API: CultureModule

Needs the hypermedia for "getHypermedia"

## OLD UI

Pass into the controller, the LanguageService.Servicename
(This forms part of the angular module)
Translationservice is then sent to the FR UI via the translationService value

![[Frangular Languaging LanguageService OLD UI.png]]

## Frangular UI

### app.component.ts

![[Frangular Languaging FR UI Setup.png]]

Ensure you have the correct languaging service code in:
- ngOnInit
- moduleService.getModule... culture...
It also needs to be in the **modulelist**

```ts
 this.languageService.languageSet.onLanguageSetChanged
  .pipe(takeWhile(() => this.alive))
  .subscribe(() => {
	if (this.authTokenSet) {
	  this.languageStringsSet = true;
	}
  });
```

### mix-modules.ts

![[Frangular Languaging mix modules.png]]

### Component you work on (eg. video-event-configuration)

![[Frangular Languaging Component ts.png]]

Calling the translate service to translate the above text

![[Frangular Languaging Call Translate Service.png]]

The HTML side of this

![[Frangular Languaging HTML call.png]]

Inside the contructor

![[Frangular Languaging Constructor.png]]

Hide HTML if no languageset

![[Frangular Languaging Hide if No Languageset.png]]

## Testing locally

In FR UI, change this line: 
export const APIURL_DEV = "http://localhost:5000";
 to:
 export const APIURL_DEV = "https://mixconfigfrangularapi.mixdevelopment.com";

## PRs

[Pull request 106849: STM-1074: Setup for languaging angular application - Repos (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_git/MiX.Config.Frangular.UI/pullrequest/106849?_a=files)

## Links From Pallavi


- [Confluence AWS Login for OKTA](https://confluence.mixtelematics.com/pages/viewpage.action?spaceKey=softwaredevelopment&title=AWS%20Login%20for%20SDK%20access%20using%20OKTA "https://confluence.mixtelematics.com/pages/viewpage.action?spacekey=softwaredevelopment&title=aws%20login%20for%20sdk%20access%20using%20okta") 
- [AWS Login for SDK access using OKTA](https://confluence.mixtelematics.com/display/softwaredevelopment/AWS+Login+for+SDK+access+using+OKTA "https://confluence.mixtelematics.com/display/softwaredevelopment/aws+login+for+sdk+access+using+okta")
- [https://community.chocolatey.org/packages?q=saml2aws](https://community.chocolatey.org/packages?q=saml2aws "https://community.chocolatey.org/packages?q=saml2aws")

