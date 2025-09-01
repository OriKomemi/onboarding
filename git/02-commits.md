## 2) Making Atomic Commits

**🎯 Goal:** Learn to make small, focused commits that represent one logical change each

### Understanding Atomic Commits
**Atomic** = each commit represents exactly one complete change
- ✅ Good: "Add user login validation"
- ❌ Bad: "Fix login, update CSS, add new API endpoint"

### Practice: Create 3 Focused Commits

#### Commit 1: Add Content
```bash
# Add new content to your file
echo "Line A" >> notes.txt

# Check what changed (optional but helpful)
git diff

# Stage and commit this specific change
git add notes.txt
git commit -m "feat: add line A"
```

#### Commit 2: Add More Content  
```bash
# Add different content
echo "Line B" >> notes.txt

# See the current state (what's staged vs unstaged)
git status

# Stage and commit
git add notes.txt
git commit -m "feat: add line B"
```

#### Commit 3: Fix Something
```bash
# Add a fix
echo "Fix typo" >> notes.txt

# Stage and commit the fix
git add notes.txt
git commit -m "fix: add typo fix"
```

### Verify Your Work
```bash
# See your commit history
git log --oneline

# Should show 4 commits total (including initial)
```

💡 **Rule of thumb:** 1 logical change = 1 commit

**🔍 Why atomic commits matter:**
- Easier to understand what each change does
- Easier to revert specific changes if needed
- Better collaboration with teammates
- Cleaner project history

---
