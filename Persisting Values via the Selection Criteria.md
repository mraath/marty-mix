---
created: 2025-10-08T07:28
updated: 2025-10-08T07:53
---

## Introduction

We sometimes need a method to persist user selections between sessions. The mechanism we use is the **selection criteria**. Examples would be persisting selected columns, column widths, etc. 
I will explain the basics of doing this in this article.

## Example: persisting column width

Column widths is not the most simple example, however, this is the last one I worked on and I should be able to remember what I did :-)

This example can therefore be simplified to your needs, but here it goes.

### Need

When the user changes column widths for the Config Groups Panel within the Configuration Groups (BETA) page.  This needs to be persisted between sessions and page changes.

### Mechanism

We make use of the Selection Criteria. 
The selection criteria will need a **key** to persist these values, it will also need a **class** which will specify eg. column names and widths.

### HTML


### TS file

Whenever the width changes save that to Selectioncriteria by using the Settings you specified.


![[Persisting Values via the Selection Criteria Column Resize Example.png]]

