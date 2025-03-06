---
created: 2024-01-16T08:31
updated: 2024-01-16T08:32
---

- Unresolved/Legacy Nugets: Jono Makepeace: FYI, if you're referencing an older package that you can't get from the package source, to fix it you have to remove the line for the package from package.config for each module referencing it and re-add it for the modules that require it via manage nuget for solution. Can then install it. The uninstall button doesn't work if it can't find that specific version on the package source 
- 