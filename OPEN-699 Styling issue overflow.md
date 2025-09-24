---
status: busy
comment:
priority: 1
created: 2023-03-27T07:35
updated: 2025-09-24T11:59
---

# OPEN-699 Styling issue overflow

Date: 2025-09-15 Time: 08:25
Parent:: [[OPEN-505 Identify channels for blurring]]
Friend:: [[2025-09-15]]
JIRA:OPEN-699 Styling issue overflow
[JIRA](https://powerfleet.atlassian.net/browse/OPEN-699)


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

![[OPEN-699 Styling issue overflow 1.png|400]]

CSS Line 2159
.strong-grid.fleet-grid-container{overflow-y:scroll}

## Styling issue - move there

Mixfleet.css
2159: .strong-grid.fleet-grid-container{overflow-y: auto;}

Let's analyze the grid overflow issue based on your screenshot.

**Probable reasons for the overflow:**
- **Height or max-height** is set and content doesn't fit (causes scroll).
- **Overflow** CSS property is set to `auto` or `scroll` on the grid's container.
- **Padding/margin** or box-sizing configuration causes the scroll bar to show.

**How to fix this:**

1. **Make the grid grow with the content:**
   - Ensure the grid container does **not** have a fixed height/max-height unless intended.
   - Use `overflow: visible` on the grid container to allow growth.

   ```css
   .your-grid-container {
     height: auto;
     max-height: none;
     overflow: visible;
   }
   ```

2. **If a maximum height is required:**  
   Use `overflow-y: auto` only if needed and ensure padding/margin doesn't create unnecessary scrollbars.

   ```css
   .your-grid-container {
     max-height: 400px; /* or whatever fits your layout */
     overflow-y: auto;
     box-sizing: border-box; /* avoids padding/margin overflow */
   }
   ```

3. **Inspect for inner container mismatches:**
   - If there's a grid inside another container, ensure **both** have compatible heights and overflows.
   - For libraries like Material UI DataGrid, ensure the outer container has `height: auto` (or `100%` if you want full parent height).

4. **Remove unnecessary scroll:**
   - Try setting `overflow: hidden` (use cautiously if scroll is not needed).

   ```css
   .your-grid-container {
     overflow: hidden;
   }
   ```

**Typical Fix for React/MUI DataGrid:**
If using something like MUI DataGrid, ensure you do **not** set both a fixed height and `overflow: auto` on the parent container. Allow the DataGrid to handle scrolling if needed.

***

### **ACTION STEPS:**
1. **Inspect the container in DevTools** to see where the overflow style and height originate.
2. **Apply one of the above CSS fixes** to the grid’s main container.
3. **Reload and check** if the scrollbar still appears unnecessarily.

***

If you can share the relevant HTML/CSS or React code, I can tailor the exact solution! For now, try the CSS above on the grid's container and see if the overflow disappears.

[1](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/490415/380777af-dc73-4050-9055-8c4d1e4a0344/image.jpg?AWSAccessKeyId=ASIA2F3EMEYESW65EHEI&Signature=F6JAqiyBHaL%2F2UrBq3jJFQX7UA4%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEFEaCXVzLWVhc3QtMSJGMEQCIAcTtpMfUXonJF2VKZu7ISTJNqm5yUXFCFby68Jl8bUUAiBaCaEts%2Be87IZVSDSVYFTr330HAm8aE1%2FQQdxn8daO%2Byr6BAi5%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAEaDDY5OTc1MzMwOTcwNSIMKDzrL9SW%2F3GuVlPdKs4Evm4pUmgZVe4DE9Gm7CrXsf6t8Pwd%2Fx%2B4L2tU%2FSmRCFjMuSIo5QEJQbIfzRiOZHZkqG2ikeq7ETK50WARZuQiWMJvckd2%2BaDq2X7CG964pnJW3yVIoWh5EsLprbHPxyYLP9o5Y1Lk9IUpYStM0w3P5T%2F%2BqqNYJMbskwLJiYbPeZQxkV%2BvaH8o27YsXDda8MVmpPT2yiW3yBiqAXEsEOz5rH%2BhelIIxmrynjPqiWKJsxpwfrWCXg4qFwIWb3rywhfIuLLMhCRUFF6SPWGmFFUrTA3wriE5yCgb%2BcbQM0VP%2FGQNvJ3qJM0ZZCbxYA7SKin70dyj75sFVxE3HJuppNenbm9i8nwYm7Q76go%2BswZxM%2BaAQ8pIEBEKWq53q7dWIPQXixjnzLHhMO%2FoHzGIB8rhUo4McFj2macV5OHbgrhZ6ANRuDaa2%2BPec8y1KCix%2FJrjlb%2FSR%2Ba12SflWejelokN1dMSgdJC2Z0zxvoyYyqF4RtSd9c7IR1v4TSxtDBPnt5r8DJCiFd1BHUQVvUKhTQfMjK%2BC3vlFAC7W0seyZeJDSCnNwEQXpA034c%2BcbDkaQvGkJBTXbVLg2cP%2B%2FBTWzWDyOnXQw4trLaAtYjvhJnwmQCm0%2BI%2FaQ4IkYs6Qnni9b9zRKBoU5YnydOfeT0gsDoCCdDcXyMIExq9X%2Fm3xtwzffskBsvG1fffO9JCbGDTNw94indgLNk9%2FSouS7fMzRAAJ%2BvKTjj3wIHKvGm0cy0SByggSNY80bEe%2FLLpx1qi0PmFB6D4XFKuYtisEVznGn8w3KH6xQY6mwGFlrIIZiuHq017cP0cGWB%2FTHbreVaK3HKrwtS0LRo986lZZbRIgss16Ld9U%2B2L6KWGR8AF2H4a4tkY7EC6Di0zCEQUR5XuxjjVc1%2FxJQdgzitGdLWROasVrrmmWvWLiI7tADGr3IfmL4WGlvNnOkLBWlrl8e8c8ozbS3wWOKonh2x0Fqm6w0TiAZWJJK6snCqIvoj%2FnPZ812%2BB%2BQ%3D%3D&Expires=1757320496)
[2](https://integration.mixtelematics.com/#/config-admin/peripherals/edit?id=-565349616809011552)

## From Shawn

![[OPEN-699 Styling issue overflow.png]]

- [x] Remove the <div class="clear">&nbsp;</div> ✅ 2025-09-24

Fixing this in OPEN-505