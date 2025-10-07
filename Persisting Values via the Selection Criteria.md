---
created: 2025-10-08T07:28
updated: 2025-10-08T07:49
---

## Introduction

We sometimes need a method to persist user selections between sessions. The mechanism we use is the **selection criteria**. Examples would be persisting selected columns, column widths, etc. 
I will explain the basics of doing this in this article.

## Example: persisting column width



If the User makes a changes to the widths of Panels, and navigates away from the page and then returns, the widths should be retained for each user.

You can look at how the column widths were persisted - however - there is a LOT happening there....
This should be more straight forward
I think you will need an eg. SplitterSettings
And then whenever the width changes save that to Selectioncriteria by using SplitterSettings

For now you can look at the columnResize
You should be able to simplify this a lot for you need
Also adapt to the splitter
If I find a simpler eg. I will send it on to you 

![[Persisting Values via the Selection Criteria Column Resize Example.png]]

