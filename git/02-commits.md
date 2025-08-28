## 1) Commits: small & atomic

**Mission:** make 3 small commits.

```bash
echo "Line A" >> notes.txt
git add notes.txt
git commit -m "feat: add line A"

echo "Line B" >> notes.txt
git add notes.txt
git commit -m "feat: add line B"

echo "Fix typo" >> notes.txt
git add notes.txt
git commit -m "fix: add typo fix"
```

💡 *Rule of thumb:* 1 logical change = 1 commit.

---
