---
created: 2022-07-15T10:27
updated: 2025-01-31T09:57
---
<%*
const startOfMonth = moment().startOf('month');
const endOfMonth = moment().endOf('month');

for (let date = moment(startOfMonth); date.isSameOrBefore(endOfMonth); date.add(1, 'day')) { %>
- {{<% date.format("YYYY-MM-DD") %>}}
  ![[<% date.format("YYYY-MM-DD") %>#Worked on]]
<% } %>
