---
status: busy
comment: 
priority: 1
created: 2023-03-27T07:35
updated: 2025-03-05T12:28
---

# OE-568 Default Column Width

Date: 2025-03-04 Time: 11:04
Parent:: [[OE-513]]
Friend:: [[2025-03-04]]
JIRA:OE-568 Default Column Width
[OE-568 Default column width does not auto-fit to text/content - Jira](https://csojiramixtelematics.atlassian.net/browse/OE-568)


## TODO
```dataviewjs
function callout(text, type) {
    const allText = `> [!${type}]\n` + text;
    const lines = allText.split('\n');
    return lines.join('\n> ') + '\n'
}

const query = `
not done
path includes ${dv.current().file.path}
# you can add any number of extra Tasks instructions, for example:
# group by heading
`;

dv.paragraph(callout('```tasks\n' + query + '\n```', 'todo'));
```

## Shorter Description

A few of the column widths are not correct by default.
Let's fix this

## Findings

- Forms part of the [[Selectioncriteria]]
- The following thing is not updating:
	- https://selectioncriteria.intss.mixdevelopment.com/api/selectioncriteria/query?datacentre=INT
- configAssetsColumnWidths

```c#
save(query: SelectionCriteriaUpdate): Observable<SelectionCriteriaQueryCarrier> {
	this.updateCache(query);
	let carrier = this.convertToCarrier(query);
	let newRequest = {update: this.provider.update};
	return newRequest.update({}, carrier).pipe(mergeMap((result: SelectionCriteriaQueryCarrier) => {
		this.updateCacheLatestDates(result);
		return of(result);
	}));
}
```
- updateColumnSettings
- changeColumnWidth
- api/selectioncriteria/update
- Selection Criteria
	- [Swagger UI](https://selectioncriteria.intss.mixdevelopment.com/swagger/index.html)
	- 