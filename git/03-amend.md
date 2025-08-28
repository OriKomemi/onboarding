## 2) Amend: fix the **last** commit

**Mission:** you forgot a file in the last commit; amend it.

```bash
echo "Forgotten" > forgotten.txt
git add forgotten.txt
git commit --amend -m "fix: add typo fix + forgotten file"
```

⚠️ Amending **rewrites** the last commit hash. Avoid on shared branches.

---

