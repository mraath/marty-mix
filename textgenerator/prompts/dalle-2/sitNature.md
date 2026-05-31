---
wiki_ingested: 2026-05-28
PromptInfo:
 promptId: sitNature
 name: 🖼️ Generate a Nature photo
 description: Photographs in the dataset with these captions tend to showcase animals/nature in extraordinary positions and situations, works similarly to “Award-Winning” but is only for nature. This will also make animals/nature look more real and accurate.
 author: Prompt Engineering Guide
 tags: photo, dalle-2, situational
 version: 0.0.1
config:
 append:
  bodyParams: false
  reqParams: true
 context: "prompt"
 output: '`\n![](${requestResults.data[0].url})`'
bodyParams:
 n: 1
 size: "1024x1024"
reqParams:
 url: "https://api.openai.com/v1/images/generations"
---
{{selection}}, Nature Photography