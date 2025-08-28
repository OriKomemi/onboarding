## 3) Branching: merge vs rebase

**Mission:** create a feature branch, diverge, then combine.

```bash
# branch off main
git checkout -b feature/wave

echo "\nWave 1" >> notes.txt
git commit -am "feat: wave 1 changes"

# switch back and diverge on main
git checkout main
echo "\nMain hotfix" >> notes.txt
git commit -am "fix: main hotfix"

# merge option
git checkout feature/wave
git merge main      # creates a merge commit (keeps history shape)

# alternatively, rebase option
# git rebase main   # replays your commits on top of main (linear history)
```

**When to merge?** shared branches, preserve context.
**When to rebase?** your own feature branch for linear history.

---
