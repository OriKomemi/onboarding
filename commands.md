# Git & Docker Onboarding — Commands Cheatsheet

## 🔹 Git

```bash
# Commit
git add . && git commit -m "msg"

# Amend last commit
git commit --amend

# Create branch
git checkout -b feature/x

# Switch branch
git checkout main

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
