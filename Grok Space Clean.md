---
wiki_ingested: 2026-05-28
created: 2025-07-15T08:40
updated: 2025-07-15T08:47
---
Running out of space on your work laptop due to numerous Git repositories is a common issue for developers. Let’s explore solutions, including quick wins and longer-term strategies, to free up space while keeping your repos accessible. I’ll also address your idea of removing local branches and provide practical steps.

### Quick Win: Remove Unnecessary Local Git Branches
Yes, deleting local branches you no longer need can free up some space, as each branch may have associated objects in the `.git` directory. However, the space savings from this alone are often minimal unless you have many branches with large, divergent histories or significant binary files. Here’s how to do it safely:

1. **List All Local Branches**:
   Run the following in each repo to see all local branches:
   ```bash
   git branch
   ```
   Identify branches you no longer need (e.g., old feature branches merged into `main` or `master`).

2. **Delete Local Branches**:
   For each unneeded branch, run:
   ```bash
   git branch -d <branch-name>
   ```
   Use `-D` instead of `-d` to force deletion if the branch isn’t merged. Be cautious—ensure the branch is merged or backed up on a remote (e.g., GitHub, GitLab).

3. **Clean Up Git Objects**:
   After deleting branches, run Git’s garbage collection to remove unreferenced objects:
   ```bash
   git gc --prune=now
   ```
   This compacts the `.git` directory and removes objects no longer needed by any branch.

4. **Check Space Savings**:
   Use `du` to measure the repo size before and after:
   ```bash
   du -sh .git
   ```

**Impact**: This is a quick win if you have many branches with unique commits or large files. However, if most branches share similar histories or your repos are small, the space saved may be limited (e.g., a few MB per repo). For larger savings, consider the following strategies.

### Comprehensive Solutions for Freeing Up Space
Since you have “a LOT of repos” but need them, here are more effective ways to reclaim space without losing access to your code:

#### 1. **Move Repos to an External/Cloud Storage and Use Sparse Checkouts**
   If you don’t need all repos actively checked out on your laptop, move some to an external drive or cloud-synced folder (e.g., Google Drive, Dropbox) and access them only when needed.

   - **Steps**:
     1. Move repo directories to an external drive or cloud folder (e.g., `/Volumes/ExternalDrive/repos/`).
     2. Clone repos only when needed, or use `git sparse-checkout` to check out specific files/folders:
        ```bash
        git clone --no-checkout <repo-url>
        cd <repo>
        git sparse-checkout init --cone
        git sparse-checkout set <path/to/needed/folder>
        git checkout main
        ```
     3. When done, delete the local clone to free space.

   - **Pros**: Keeps your laptop’s disk free while retaining access to repos. Sparse checkouts reduce disk usage by only downloading needed files.
   - **Cons**: Requires external storage or cloud setup; accessing repos may be slower if not local.

#### 2. **Use Shallow Clones for Rarely Used Repos**
   If you need repos locally but don’t require their full history, re-clone them as shallow clones to save space.

   - **Steps**:
     1. Delete the repo’s local copy (after ensuring it’s backed up on a remote):
        ```bash
        rm -rf <repo-dir>
        ```
     2. Re-clone with a limited history:
        ```bash
        git clone --depth 1 <repo-url>
        ```
        The `--depth 1` flag fetches only the latest commit, significantly reducing the `.git` directory size.

     3. If you later need the full history:
        ```bash
        git fetch --unshallow
        ```

   - **Pros**: Drastically reduces disk usage for repos with long histories (e.g., saving hundreds of MB per repo).
   - **Cons**: You lose access to older commits locally unless you fetch them later. Not ideal for repos you actively develop.

#### 3. **Clean Up Large Files with Git LFS or Remove Them**
   If your repos contain large binary files (e.g., images, datasets, or build artifacts), they can bloat the `.git` directory. Use Git Large File Storage (LFS) or remove unnecessary files.

   - **Option 1: Migrate to Git LFS**:
     1. Install Git LFS: `git lfs install`.
     2. Track large files (e.g., `*.png`, `*.zip`):
        ```bash
        git lfs track "*.png"
        ```
     3. Commit the `.gitattributes` file and push to the remote.
     4. Migrate existing large files to LFS:
        ```bash
        git lfs migrate import --include="*.png"
        ```
     5. Run `git gc --prune=now` to clean up.

   - **Option 2: Remove Large Files**:
     If large files aren’t needed, remove them from the repo’s history using `git filter-repo` (safer than `git filter-branch`):
     1. Install `git-filter-repo` (e.g., via `pip install git-filter-repo`).
     2. Remove large files:
        ```bash
        git filter-repo --path <file-to-remove> --invert-paths
        ```
     3. Force-push to the remote (coordinate with your team first):
        ```bash
        git push --force
        ```
     4. Run `git gc --prune=now` locally.

   - **Pros**: Can free up significant space (e.g., GBs) if large files are the culprit.
   - **Cons**: LFS requires setup and may incur costs on hosted platforms. Rewriting history can disrupt collaborators.

#### 4. **Optimize All Repos with Git Maintenance**
   Run Git maintenance commands across all repos to optimize storage:

   - **Commands**:
     ```bash
     git gc --aggressive
     git repack -a -d --depth=250 --window=250
     ```
   - **Script to Apply to All Repos**:
     ```bash
     find ~/path/to/repos -type d -name ".git" -exec sh -c 'cd {}/.. && git gc --aggressive && git repack -a -d --depth=250 --window=250' \;
     ```
     Replace `~/path/to/repos` with your repos’ parent directory.

   - **Pros**: Reduces `.git` directory size across all repos with minimal effort.
   - **Cons**: Savings vary; may not be significant for small repos.

#### 5. **Archive Old Repos**
   For repos you rarely access, archive them into compressed tarballs:

   - **Steps**:
     1. Archive a repo:
        ```bash
        tar -czf repo-name.tar.gz <repo-dir>
        ```
     2. Move the archive to external/cloud storage.
     3. Delete the local repo:
        ```bash
        rm -rf <repo-dir>
        ```
     4. Restore when needed:
        ```bash
        tar -xzf repo-name.tar.gz
        ```

   - **Pros**: Frees up space while keeping repos accessible. Compressed archives save more space than shallow clones.
   - **Cons**: Inconvenient if you frequently need to access archived repos.

#### 6. **General Disk Cleanup**
   Beyond repos, free up space on your laptop:

   - **Clear Temporary Files**:
     On macOS/Linux:
     ```bash
     rm -rf ~/Library/Caches/* ~/.cache/*
     ```
     On Windows, use Disk Cleanup or clear `%TEMP%`.

   - **Remove Old Docker Images/Containers** (if applicable):
     ```bash
     docker system prune -a
     ```

   - **Uninstall Unused Applications**:
     Check for large, unused apps (e.g., via `du -sh /Applications/*` on macOS/Linux).

   - **Check Large Files**:
     Find large files outside repos:
     ```bash
     find / -type f -size +100M
     ```

### Assessing Your Situation
To recommend the best approach, it’d help to know:
- **Repo Sizes**: Run `du -sh * | sort -h` in your repos’ parent directory to identify the largest ones.
- **Usage Patterns**: Do you actively work on all repos, or are some rarely touched?
- **File Types**: Do your repos contain large binary files (e.g., media, datasets)?
- **Remote Availability**: Are all repos backed up on a remote (e.g., GitHub)?

Without this, I suggest starting with these steps:
1. **Quick Win**: Delete unneeded local branches (`git branch -d`) and run `git gc --prune=now` on active repos. Expect modest savings (e.g., 10-100 MB per repo).
2. **High Impact**: Identify rarely used repos and re-clone them as shallow clones (`git clone --depth 1`). This can save GBs if you have many repos with deep histories.
3. **Check for Large Files**: Use `git lfs` or `git filter-repo` if large files are bloating repos.
4. **General Cleanup**: Clear caches and unused apps to free additional space.

### Example Workflow
Here’s a quick script to clean up branches and optimize all repos:
```bash
for repo in ~/path/to/repos/*; do
  if [ -d "$repo/.git" ]; then
    cd "$repo"
    echo "Cleaning $repo"
    git fetch --prune  # Remove stale remote-tracking branches
    git branch | grep -v "main\|master" | xargs -r git branch -d  # Delete non-main branches (if merged)
    git gc --prune=now
    git repack -a -d --depth=250 --window=250
  fi
done
```

### Notes
- **Backup First**: Ensure all repos are pushed to a remote before deleting branches or rewriting history.
- **Team Coordination**: If others use the same repos, coordinate before force-pushing (e.g., after `git filter-repo`).
- **Monitor Space**: Use `df -h` to track free disk space before and after.

If you share more details (e.g., repo sizes, OS, or specific constraints), I can tailor the solution further. Would you like me to analyze anything specific or guide you through one of these steps in detail?

SOURCE: https://grok.com/chat/862d0a4f-2863-42e0-ac49-f8ce0825d0e0