## 0) Setup (once)

```bash
# Configure identity
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# Create repo
mkdir git-docker-onboarding && cd $_
git init

echo "Hello Git" > notes.txt
git add notes.txt
git commit -m "chore: initial commit"
```

✅ **Checkpoint**: `git log --oneline` shows one commit.

**Verification:**
```bash
# Check if Git is configured correctly
git config --list | grep -E "user\.(name|email)"
# Should show your name and email

# Verify repository initialization
git status
# Should show "On branch main" or "On branch master"
```

**🚨 Troubleshooting:**
- **Error: "fatal: not a git repository"** → Run `git init` in the correct directory
- **Missing user config** → Run the `git config` commands again with your details
- **Wrong branch name** → Use `git branch -M main` to rename to main

---

