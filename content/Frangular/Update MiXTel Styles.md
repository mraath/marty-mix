---
created: 2024-11-28T15:27
updated: 2024-11-28T15:38
---
>[!Note]
>In short, I only did the following.
>1) Replaced the version.
>   ![[Update MiXTel Styles Version update.png|300]]
>2) Removed the package-lock.json file
>3) Made a Pull-request to INT
>   (Once it was deployed it worked)

## Intro

I was asked to update the mix css for our Frangular page.
Even when changing the version, locally it never changed.
I then got the "npm install" to work, as I was informed to do this. 
	[[Frangular fix the npm install]]
	(Even this didn't work)
I then just pushed it to INT to see if our pipeline resolves this, it did

## Some problems I ran into

- After pushing it into INT, with the -lock file included, I got the following errors
	- "styles-1.1.19.tgz (sha1-h9h99rTBIN3dxAmopSsomHZmql4=) seems to be corrupted."
	- npm _error_ sha1-h9h99rTBIN3dxAmopSsomHZmql4= integrity checksum _failed_ when using sha1: wanted sha1-h9h99rTBIN3dxAmopSsomHZmql4= but got sha1-lYGnLlDSLtl8b+wfuN1fi6TKoZs=. (4154168 bytes)
	- [Pipelines - Run Integration_2024.11.27.3 logs](https://dev.azure.com/MiXTelematics/DeviceIntegration/_build/results?buildId=416676&view=logs&j=3da7f08f-8160-546a-4596-3407ad18ac70&t=a33579b4-aa2b-5558-b7c5-8b4d0d22e6dd "https://dev.azure.com/mixtelematics/deviceintegration/_build/results?buildid=416676&view=logs&j=3da7f08f-8160-546a-4596-3407ad18ac70&t=a33579b4-aa2b-5558-b7c5-8b4d0d22e6dd")
- Removing the package-lock.json file fixed this, thanks Rudolf... who also spoke to Eddie

## mixtel/styles

The mixtel styles are updated manually
To check what the latest version is here:
https://mixtelematics.visualstudio.com/Common/_artifacts/feed/NPMPackages
 
If any  problems arise, it could have to do with package version missmatches.
Unfortunately NPM sometimes fails as a package manager 😄

## Styles.scss

The following lines need to be in this file:

![[Frangular fix the npm install Styles scss.png]]


