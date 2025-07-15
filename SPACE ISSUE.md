---
created: 2025-07-15T07:53
updated: 2025-07-15T09:14
---
- Was: 660MB

1. Delete TMP
   - %TEMP%
   - now: 13.9 GB

2) Clean used **REPOS** - not sure
- Ensure each dir checked in > INT

```gitbash
git gc --aggressive && git repack -a -d --depth=250 --window=250 && git gc --prune=now
```


- Use Shallow Clones for **Rarely** Used Repos
	- after ensuring it’s backed up on a remote
	- get repo-url: xxxxxxxx
	- rm -rf repo-dir

```gitbash
git clone --depth 1 https://MiXTelematics@dev.azure.com/MiXTelematics/DynaMiX/_git/DynaMiX.UI.Framework && git gc --prune=now
```

- now: xxxxxxxxxxxxx

- [[Grok Space Clean]]

Not often used:
- https://MiXTelematics@dev.azure.com/MiXTelematics/DeviceIntegration/_git/Config.EventAnalyserSettings
- https://MiXTelematics@dev.azure.com/MiXTelematics/DynaMiX/_git/DynaMiX.UI.Framework