## 1) Git Setup & First Repository

**🎯 Goal:** Set up Git with your identity and create your first repository

### Step 1: Configure Your Identity
```bash
# Set your name (replace with your actual name)
git config --global user.name "Your Name"

# Set your email (use your real email)
git config --global user.email "you@example.com"
```

💡 **Why this matters:** Every Git commit includes author information. This helps teammates know who made what changes.

### Step 2: Create Your Practice Repository
```bash
# Create a new directory for practice
mkdir git-docker-onboarding

# Enter the directory
cd git-docker-onboarding

# Initialize Git repository (creates hidden .git folder)
git init
```

### Step 3: Make Your First Commit
```bash
# Create a simple text file
echo "Hello Git" > notes.txt

# Stage the file (prepare it for commit)
git add notes.txt

# Create your first commit with a message
git commit -m "chore: initial commit"
```

**🔍 What just happened?**
1. `git add` moved your file to the "staging area" 
2. `git commit` permanently saved the staged changes
3. The message describes what you did

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

