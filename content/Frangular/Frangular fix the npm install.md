---
created: 2024-11-26T15:41
updated: 2024-11-26T16:04
---
If the npm install doesn't run, try the following.
(I spoke to Tim from Fleet)

(Ensure you have opened Visual Studio Code as Administrator)

1) Your .npmrc file needs to have the correct url
then set it up correctly, here is the .npmrc file example
[.npmrc - Repos](https://mixtelematics.visualstudio.com/DynaMiX/_git/DynaMiX.UI.Framework.2?path=/UI/projects/leafletframework/.npmrc "https://mixtelematics.visualstudio.com/dynamix/_git/dynamix.ui.framework.2?path=/ui/projects/leafletframework/.npmrc")

2) Add the script in your package.json script
`"refreshVSToken": "vsts-npm-auth -config .npmrc"`
(In my case the above was there, it will be for config FR UI)

3) In the folder: package.json,  run
npm run refreshVSToken

You might need to install the below package first, just do it globally
```
npm install -g vsts-npm-auth
```

4) Try running it again now:
`npm install`

