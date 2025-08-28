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

Go to ./git/

---

# 🐳 Docker Missions

Go to ./docker/


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

# Amend last commit
git commit --amend

# Reword last commit message only
git commit --amend -m "<new message>"

# Abort a rebase in trouble
git rebase --abort

# Resolve conflicts, then continue rebase
git add -A && git rebase --continue

# Create and switch branch
git switch -c feature/x

# Commit
git add . && git commit -m "msg"

# Merge branch into main
git checkout main && git merge feature/x

# Rebase branch onto main
git checkout feature/x && git rebase main

# Interactive rebase (last N commits)
git rebase -i HEAD~N

# Cherry-pick commit
git cherry-pick <hash>

# View commit graph
git log --oneline --graph --decorate --all
```

## 🔹 Docker

```bash
# Build image
docker build -t myapp:dev .

# Run container
docker run --rm -p 5000:5000 myapp:dev

# List containers
docker ps -a

# Stop container
docker stop <name>

# Compose up
docker compose up --build

# Compose down
docker compose down

# Logs
docker compose logs -f

# Exec into container shell
docker compose exec web sh
```

---

## 🏎️ Final Task — Formula Student Integration

**Scenario:** You are working in the Formula Student Autonomous Racing team. The control team created a small Flask telemetry app (`app.py`) that streams vehicle speed and cone positions. You need to prepare it for collaboration and deployment.

### Your mission:

1. **Git (collaboration)**

   * Create a feature branch `feature/telemetry_{your_name}`.
   * Add a new route `/status` to the Flask app returning `{ "status": "ok" }`.
   * Commit changes with a clear message.
   * Amend the commit to also include an update to `requirements.txt`.
   * Rebase your branch on top of `main`.
   * Squash commits with interactive rebase.
   * Push to GitHub and open a Pull Request.

2. **Git (advanced)**

   * From feature/planner branch, cherry‑pick just the `important_bugfix` commit onto `feature/telemetry_{your_name}`.

3. **Docker (deployment)**

   * Write a Dockerfile to containerize the telemetry app.
   * Build and run the container on port 5000.
   * Add a second service with `docker-compose.yml` called `logger` that prints "🏎️ logging telemetry..." every 5s.
   * Run both services with `docker compose up`.

✅ **Completion:** Submit the GitHub PR link and show both containers running locally via `docker compose ps`. This proves you mastered commits, amend, rebase, cherry‑pick, PRs, Dockerfile, and docker‑compose — all in a Formula Student context.

---

## 🧩 Starter Files (copy into `docker/app/`)

### `app.py`

```python
from flask import Flask, jsonify
import os

app = Flask(__name__)

# --- Mock telemetry (replace with real data wiring) ---
STATE = {
    "speed_mps": 12.3,
    "cones": [
        {"x": 3.2, "y": 1.1, "color": "blue"},
        {"x": 6.8, "y": -0.7, "color": "yellow"},
    ],
}

@app.get("/")
def index():
    host = os.getenv("HOSTNAME", "unknown")
    return f"FS Telemetry running on {host}"

@app.get("/telemetry")
def telemetry():
    return jsonify(STATE)

@app.get("/status")
def status():
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

### `requirements.txt`

```
flask==3.0.3
```

### `.dockerignore`

```
__pycache__
*.pyc
*.log
.env
.git
```

### `Dockerfile`

```Dockerfile
# syntax=docker/dockerfile:1
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt \
    && adduser --disabled-password --gecos "" appuser \
    && chown -R appuser:appuser /app
COPY . .
USER appuser
EXPOSE 5000
CMD ["python", "app.py"]
```

### `logger.py`

```python
import time
import os

if __name__ == "__main__":
    while True:
        print("🏎️ logging telemetry...", os.getenv("SERVICE_NAME", "logger"))
        time.sleep(5)
```

### `docker-compose.yml`

```yaml
services:
  web:
    build: .
    ports:
      - "5000:5000"
    environment:
      - FLASK_ENV=development
    restart: unless-stopped

  logger:
    build: .
    command: ["python", "logger.py"]
    environment:
      - SERVICE_NAME=telemetry-logger
    restart: unless-stopped
```

### Quick run

```bash
cd docker/app
# build images and start both services
docker compose up --build
# then open http://localhost:5000 and http://localhost:5000/telemetry
```

### Suggested Git steps (apply in repo root)

```bash
# create feature branch and commit starter files
git switch -c feature/telemetry_{your_name}
# (copy files above into docker/app/)
git add docker/app
git commit -m "feat(telemetry): add Flask app, Dockerfile and compose"

# amend to include a small fix
echo "# dev note" >> docker/app/README.md || true
git add docker/app/README.md
git commit --amend -m "feat(telemetry): add app + Docker + compose (with README)"

# rebase on main & squash later if needed
git fetch origin || true
git rebase origin/main || true

# push and open PR
git push -u origin feature/telemetry
```

> Replace the mock `STATE` with real speed/cone data when integrating with your simulator or ROS bridge.
