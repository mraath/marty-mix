
### Get Latest <mark class="hltr-green">Development</mark>

```cmd
git checkout Config/Development
git fetch origin
git pull

```

**Client**
```cmd
git checkout Development
git fetch origin
git pull

```

**Core**
```cmd
git checkout development
git fetch origin
git pull

```

### Get Latest <mark class="hltr-blue">Integration</mark>

```cmd
git checkout Integration
git fetch origin
git pull

```

**Core**
```cmd
git checkout integration
git fetch origin
git pull
```


### <mark class="hltr-red">Merge</mark> the two

```cmd
git checkout -b Config/MR/DailyMerge/{{date}} Config/Development
git merge --no-ff  Integration

```
**Client**
```cmd
git checkout -b Config/MR/DailyMerge/{{date}} Development
git merge --no-ff  Integration

```

**Core**
```cmd
git checkout -b Config/MR/DailyMerge/{{date}} development
git merge --no-ff  integration

```

After this, 
- open VS, 
- ensure all is fine, 
- push and 
- PR

## Open folder VS Code
code .
