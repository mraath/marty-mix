---
created: 2024-03-25T08:31
updated: 2024-10-28T11:45
---
Parent:: [[OE-513 Configuration Groups - Frangularisation and enhancements]]

- Copied something from Fleet Operations API
- Saved as JSON (YML didn't work)
- Imported and just changed the name
- Current status:
	- [MiX.Config.Frangular.API - Azure DevOps Services](https://dev.azure.com/MiXTelematics/DeviceIntegration/_apps/hub/ms.vss-ciworkflow.build-ci-hub?_a=edit-build-definition&id=1427&view=Tab_Tasks)
	- Test Run: [Pipelines - Run Development_2024.03.22.1 logs (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_build/results?buildId=332307&view=logs&j=275f1d19-1bd8-5591-b06b-07d489ea915a&t=ff44e5f8-4d79-5f05-21e3-42769c983609)
		- [x] Currently can't deploy ✅ 2024-10-28
			- See where it tries to deploy
			- Fix up
				- DSINTBLD01
				- Deployed 52588967
				- NO IDEA where... looking for it to see what it looks like
					- Went on the deploy
					- Saw the following: 1 published: 1 consumed
					- Clicked on it to see this: [Pipelines - Run Development_2024.03.25.2 artifacts (azure.com)](https://dev.azure.com/MiXTelematics/DeviceIntegration/_build/results?buildId=332612&view=artifacts&pathAsName=false&type=publishedArtifacts)
					- Clicked on ... to get to copy url:
					- https://dev.azure.com/MiXTelematics/7e68f82d-170c-4f4c-9770-8b8e7897d626/_apis/build/builds/332612/artifacts?artifactName=webapi&api-version=7.1&%24format=zip
	- 