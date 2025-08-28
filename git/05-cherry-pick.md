## 5) Cherry‑pick: surgical copy

**Mission:** copy a specific commit from `feature/wave` onto `main`.

```bash
# find the commit hash on feature branch
git log --oneline feature/wave
# copy just that commit onto main
git checkout main
git cherry-pick <hash>
```

Use when you need **one** change without merging the whole branch.

---

