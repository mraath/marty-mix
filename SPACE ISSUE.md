---
created: 2025-07-15T07:53
updated: 2025-07-15T08:44
---
- Was: 660MB
- Delete TMP
	- %TEMP%
	- now: 13.9 GB
- Clean GIT
	- Cleanup used REPOS - not sure
		- Ensure each dir checked in > INT
		- git gc --aggressive && git repack -a -d --depth=250 --window=250
		- now: 
	- Use Shallow Clones for Rarely Used Repos
		- after ensuring it’s backed up on a remote
		- get repo-url: xxxxxxxx
		- rm -rf repo-dir
		- git clone --depth 1 xxxxxxxx
- [[Grok Space Clean]]