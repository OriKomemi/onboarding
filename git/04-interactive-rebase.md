
## 4) Interactive rebase: clean up history

**Mission:** squash two noisy commits into one.

```bash
# open an interactive editor for the last 3 commits
git rebase -i HEAD~3
# mark some commits as `squash` or `fixup`, save & quit
```

After success: `git log --oneline` shows fewer, cleaner commits.

---
