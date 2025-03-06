---
created: 2022-07-15T16:27
updated: 2024-05-30T14:45
---
## MiXFleet

- Open the page where the languaging is incomplete.
- Find some text which seems unique
- Use this to search the *.pot* files

![[Pasted image 20220524100651.png]]
## Search the POT files

- Specify the directory and filter on the file type... *.pot*
- Search for the unique string
- Once it searched all the pot files - chose the one(s) that relates to the area in code you are working in

![[Pasted image 20220524101136.png]]

## Add the strings

- Add the string(s) in that same place in the *pot* files
- Save those files and check it into the languaging repo
- Make use of the Master branch

![[Pasted image 20220524101454.png]]

## The front-end check

- Just ensure that the front-end had decorated the string with "dmx-translate"
- If not add it and also check in that file then

![[Pasted image 20220524101612.png]]


## Building

The BE for the environment you want to test the languaging on needs to be built