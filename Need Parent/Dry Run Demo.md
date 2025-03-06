## Overview
### ==OLD SLCs (William)==
#### Starting position
- GPS drifting
	- Maybe William to paint the client issue
	- Marty to tell his idea how ML can potentially solve this
#### Initial findings
- Started off
	- Getting data
		- William got old data
		- Converted it to Log files to be used
		- Analysed the results on his side
	- Using the data
		- Plotted these onto maps
			- Got more issues
			- Highligted these in orange
			- Found some interesting results
- Address in position even jumps between Texas and New Mexico
- Gps Drifting (graph)
	- Show nice August diagram

### ==CURRENT Mapping (Marthinus)==
#### Current Result
- **Using** the data
	- August and Marty pulled it into Jupiter Notebooks
	- Plotted it onto maps
	- Added new **columns**
		- Velocity
		- Speed
		- More
- Findings for this part
	
	- **Mapping** layer issues we found
		- Show an image with old map and SLC triggers
		- Show image with new map and how it is better
	- Show weird **Jump**
		- Orange dots on my map
		- Potential reason to follow in Experimental Analysis
- Show **video** of current status
	- Explain OLD SLC in red
	- Explain map layer changed - August
	- Show trip and how SLC occur
	- Zoom into map to show Map Layer RED line and how it crosses
	- Explain importance of correct Map layer
- Show trips in video
	- Show trip with OLD SLC
	- Show new trip
	- Show trip with logic added to eliminate incorrect, but technical, points
- [[Still to be done]]

### ==LOOKING AHEAD (August)==
#### Assumptions
- Get rid of the orange ones
	- AVL
	- 
#### Experimental Analysis
- Questions
	- Why would there be two log entries at the same time
- Steps
	- Dropping where TimeDiff is inf or NaN helps
- Talk about experimental analysis
	- Mention Two log entries
		- Mention TimeDiff inf and NaN
		- Show some graphs?
	- Mention the speed worked out vs speed reported
		- Show the speed graph
- Currently were are here (like on a map in a mall)
	- Show image of "you are here" in mall
	- Summarise findings
		- GPS drift
		- Mapping layer
		- AVL or multiple reports at same time
	- Where we should go
		- Some form of API to report potential issues - end of day
		- Move it closer to live reporting
		- Auto fix the issues
#### Going forward
- Maybe look at heading - William
- Radius from border
- Amount of positions from border - can't be two in a row
- Distance between SLCs

#### Python ideas
- Cut out jumps
	- Where there is distance without timediff
- Day layer not working well
- [x] Distance between SLCs as check for color marker
- [x] 








## Templates
-  [![​Folder icon](file:///C:/Users/MARTHI~1/AppData/Local/Temp/msohtmlclip1/01/clip_image002.gif) Presentation Template](https://mixtelematics.sharepoint.com/:f:/g/EuadMIerB3hCqXqotZV-20EBBC7D__mt_F066Or80ia9NA?e=NObVMp)
-  [![​Folder icon](file:///C:/Users/MARTHI~1/AppData/Local/Temp/msohtmlclip1/01/clip_image002.gif) Content Templates_2022](https://mixtelematics.sharepoint.com/:f:/g/Er5s77EY3aFKnG6bAK_6qXQBjIjhVtJtBCzGXQCnrvYoGw?e=Evr4Cf)










