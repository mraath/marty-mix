---
created: 2025-10-28T07:06
updated: 2025-10-28T07:07
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

// Filter pages created or updated within the last 4 weeks
const recentPages = dv.pages().filter(p => {
	const created = asMoment(p.created);
	const updated = asMoment(p.updated);
	return (created && created.isAfter(cutoff)) || (updated && updated.isAfter(cutoff));
});

// Gather undone tasks
const tasks = recentPages.flatMap(p =>
	p.file.tasks
		.filter(t => !t.completed)
		.map(t => ({ ...t, file: p.file }))
);

if (tasks.length === 0) {
	dv.paragraph(callout("No outstanding todos from the last 2 weeks 🎉", "info"));
} else {
	// Group tasks by filename manually
	const grouped = {};
	for (const t of tasks) {
		if (!grouped[t.file.name]) grouped[t.file.name] = [];
		grouped[t.file.name].push(t);
	}

	let output = "";
	for (const [fileName, fileTasks] of Object.entries(grouped)) {
		output += `**[[${fileName}]]**\n`;
		for (const t of fileTasks) {
			output += `- [ ] ${t.text}\n`;
		}
		output += `\n`;
	}

	dv.paragraph(callout(output.trim(), "todo"));
}


```
