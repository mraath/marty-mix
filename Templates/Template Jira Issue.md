---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-12-01T09:36
---

# {{title}}

Date: {{date}} Time: {{time}}
Parent:: ==xxxx==
Friend:: [[{{date}}]]
JIRA:{{title}}
==URL TO JIRA==


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


## Branch

> Branch: Config/MR/Feature/{{title}}.INT

## PR

- [ ] {{title}} > DEV
- [ ] {{title}} > INT
- [ ] {{title}} > UAT
- [ ] {{title}} > PROD
