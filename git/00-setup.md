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

---

