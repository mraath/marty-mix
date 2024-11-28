---
created: 2024-11-26T15:41
updated: 2024-11-28T15:27
---
If the npm install doesn't run, try the following.
(I spoke to Tim from Fleet)

(Ensure you have opened Visual Studio Code as ==Administrator==)

1) Your .npmrc file needs to have the correct url
   (This should already be checking in correctly)

```.npmrc
registry=https://mixtelematics.pkgs.visualstudio.com/_packaging/NPMPackages/npm/registry/ 
                        
always-auth=true
```

2) Add the script in your package.json script
   `"refreshVSToken": "vsts-npm-auth -config .npmrc"`
   (In my case the above was there, it will be for config FR UI)

3) In the folder: package.json,  run
   npm run refreshVSToken
   (If the above doesn't work, Delete: eg. C:\Users\MartyR\.npmrc)

	You might need to install the below package first, just do it globally
```
npm install -g vsts-npm-auth
```

4) IF the above doesn't work, try running
   vsts-npm-auth -config .npmrc

5) Try running it again now:
	`npm install`

## TEST

https://mixtelematics.visualstudio.com/Common/_artifacts/feed/NPMPackages
(Should be able to navigate the below)

![[Frangular fix the npm install.png]]

![[Frangular fix the npm install-1.png]]

- eg. [[Update MiXTel Styles]]
