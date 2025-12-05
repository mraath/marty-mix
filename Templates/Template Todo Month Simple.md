---
created: 2025-10-28T07:06
updated: 2025-12-05T11:12
---

```dataviewjs
function callout(text, type) {
	const allText = `> [!${type}]\n` + text;
	const lines = allText.split('\n');
	return lines.join('\n> ') + '\n';
}

const now = moment();
const cutoff = moment().subtract(4, "weeks");

// Helper to safely convert Obsidian date fields to moment objects
function asMoment(dateField) {
	if (!dateField) return null;
	if (moment.isMoment(dateField)) return dateField;
	return moment(dateField.toString());
}

// 1. Filter pages created or updated within the last 4 weeks and exclude the Templates folder
const recentPages = dv.pages()
    .where(p => !p.file.path.startsWith("Templates/"))
    .filter(p => {
	const created = asMoment(p.created);
	const updated = asMoment(p.updated);
	return (created && created.isAfter(cutoff)) || (updated && updated.isAfter(cutoff));
});

// 2. Gather undone tasks and collect the unique files associated with them
const filesWithUndoneTasks = new Set();
recentPages.forEach(p => {
    // Check if the file has any incomplete tasks
	const hasUndoneTasks = p.file.tasks.some(t => !t.completed);
    
    // If it has undone tasks, add the file path to our Set
    if (hasUndoneTasks) {
        filesWithUndoneTasks.add(p.file.path);
    }
});

// 3. Filter the recent pages list to only include files with tasks
const filesToList = recentPages
	.filter(p => filesWithUndoneTasks.has(p.file.path))
	.sort(p => p.file.name, 'asc');

// 4. Format the output
if (filesToList.length === 0) {
	dv.paragraph(callout("No outstanding todos from recently active files 🎉", "info"));
} else {
	let output = "";
    
    // Iterate over the list of files that passed all filters
	for (const p of filesToList) {
        // Create the display name: JIRA:Filename
		const displayName = `JIRA:${p.file.name}`;
        
        // Create the clickable markdown link using the full file path
		output += `- ${dv.fileLink(p.file.path, false, displayName)}\n`;
	}

    // Wrap the final list in a 'todo' callout
	dv.paragraph(callout(output.trim(), "todo"));
}
```
