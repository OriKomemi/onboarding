# Git & Docker Onboarding

A hands‑on, bite‑size path to get comfortable with Git (including amend, interactive rebase, cherry‑pick, merge vs rebase, PRs) and Docker (Dockerfile + docker‑compose).

---

## 🎯 Goals

* Build intuition by **doing** small, focused missions.
* Understand **why** each command exists and when to use it.
* Produce a clean GitHub PR that passes simple checks.

## 🧰 Prerequisites

* Git ≥ 2.35
* Docker Engine & Docker Compose Plugin (compose v2)
* GitHub account (fork/PR flow)

> Tip: run `git --version` and `docker --version` to confirm installs.

---

## 📦 Repository Structure

```
.
├── README.md                        # you are here
├── git/                             # Git missions
│   ├── 01-setup.md
│   ├── 02-commits.md
│   ├── 03-amend.md
│   ├── 04-branches-merge-vs-rebase.md
│   ├── 05-interactive-rebase.md
│   ├── 06-cherry-pick.md
│   └── 07-pull-requests.md
├── docker/                          # Docker missions
│   ├── 01-dockerfile.md
│   ├── 02-images-containers.md
│   ├── 03-compose.md
│   └── app/                         # tiny demo app
│       ├── Dockerfile
│       ├── docker-compose.yml
│       ├── .dockerignore
│       ├── app.py
│       └── requirements.txt
└── .github/
    └── workflows/
        └── basic-check.yml          # lint + container build check (optional)
```

> If you’re starting from scratch, copy the file contents below into matching paths.

---

## 🗺️ Learning Path (90–120 min)

1. **Git basics → commits** (15m)
2. **Amend mistakes** (10m)
3. **Branching: merge vs rebase** (20m)
4. **Interactive rebase (clean history)** (20m)
5. **Cherry‑pick (surgical copy)** (10m)
6. **Open a Pull Request (PR) on GitHub** (10m)
7. **Dockerfile → build/run** (15m)
8. **docker‑compose: services, ports, volumes** (15m)

---

# 🧪 Git Missions

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

## 2) Amend: fix the **last** commit

**Mission:** you forgot a file in the last commit; amend it.

```bash
echo "Forgotten" > forgotten.txt
git add forgotten.txt
git commit --amend -m "fix: add typo fix + forgotten file"
```

⚠️ Amending **rewrites** the last commit hash. Avoid on shared branches.

---

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

## 4) Interactive rebase: clean up history

**Mission:** squash two noisy commits into one.

```bash
# open an interactive editor for the last 3 commits
git rebase -i HEAD~3
# mark some commits as `squash` or `fixup`, save & quit
```

After success: `git log --oneline` shows fewer, cleaner commits.

---

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

## 6) GitHub PR flow

1. Create remote & push:

```bash
git remote add origin git@github.com:<you>/git-docker-onboarding.git
git push -u origin main
```

2. Create a new feature branch, push it, then open a PR on GitHub UI.
3. Request review, address comments, and **merge via squash** to keep main tidy.

---

# 🐳 Docker Missions

### App used in exercises

A tiny Flask app: responds with hostname and a counter.

#### `docker/app/app.py`

```python
from flask import Flask
import os
app = Flask(__name__)

@app.route("/")
def hello():
    host = os.uname().nodename if hasattr(os, "uname") else os.getenv("HOSTNAME", "unknown")
    return f"Hello from {host}!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

#### `docker/app/requirements.txt`

```
flask==3.0.3
```

#### `.dockerignore`

```
__pycache__
*.pyc
*.log
.env
```

#### `docker/app/Dockerfile`

```Dockerfile
# syntax=docker/dockerfile:1
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
```

### 7) Build & run a container

```bash
cd docker/app
# build image
docker build -t hello-flask:dev .
# list images
docker images | head
# run container
docker run --rm -p 5000:5000 --name hello hello-flask:dev
# open http://localhost:5000
```

Common ops:

```bash
# new shell, stop the container
docker stop hello
# see past containers/images
docker ps -a; docker images
```

---

### 8) docker‑compose: services & volumes

#### `docker/app/docker-compose.yml`

```yaml
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/app:delegated
    environment:
      - FLASK_ENV=development
```

Run:

```bash
docker compose up --build
# open another shell to tail logs or exec into container
# docker compose logs -f
# docker compose exec web sh
# docker compose down
```

**Exercise:** Add a second service named `worker` running the same image printing a message every 5s (hint: use `command:` override).

---

## ✅ Mission Checklists

* Git

  * [ ] 3 small commits created
  * [ ] Last commit amended once
  * [ ] Feature branch merged **or** rebased onto main
  * [ ] Interactive rebase squashed history
  * [ ] Cherry‑picked one commit to main
  * [ ] Opened a PR and merged it
* Docker

  * [ ] Image built and container runs locally
  * [ ] Compose spins up `web` service
  * [ ] Added a `worker` service to compose

---

## 🧭 When to use what (cheat sheet)

* **amend**: fix last commit only (unshared branch)
* **merge**: combine histories; keep branch graph; safe for shared work
* **rebase**: rewrite your branch on top of main; keep linear history
* **interactive rebase**: squash/fixup/rename commits before opening PRs
* **cherry‑pick**: copy one commit without merging full branch
* **Dockerfile**: define immutable image; great for CI/CD
* **compose**: define multi‑service local dev stack

---

## 🧪 Optional CI (GitHub Actions)

#### `.github/workflows/basic-check.yml`

```yaml
name: basic-check
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - name: Lint
        run: |
          pip install ruff
          ruff --version
      - name: Build container
        run: |
          docker --version
          docker build -t hello-flask:ci ./docker/app
```

---

## 🧠 Stretch Ideas

* Add a Makefile with `make build`, `make run`, `make down`.
* Tag images (`hello-flask:1.0.0`) and push to GHCR.
* Add a `.pre-commit-config.yaml` for linting before commits.

---

## 📚 Reference Snippets

```bash
# Git graph view
git log --oneline --graph --decorate --all

# Reword last commit message only
git commit --amend -m "<new message>"

# Abort a rebase in trouble
git rebase --abort

# Resolve conflicts, then continue rebase
git add -A && git rebase --continue

# Create and switch branch
git switch -c feature/x
```

---

## 🙌 What next?

* Copy these files into a fresh repo and start missions.
* Push to GitHub and open a PR titled: `feat: complete onboarding missions`.
* Want this as a ready‑to‑download ZIP or a pre‑initialized GitHub repo? Let me know and I’ll generate it with the file layout above.
