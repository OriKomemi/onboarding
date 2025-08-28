# 🎯 Git & Docker Self-Assessment

Complete this checklist to verify your mastery of Git and Docker concepts.

## 📋 Knowledge Check

### Git Fundamentals
- [ ] I can explain the difference between `git add` and `git commit`
- [ ] I understand what the staging area is
- [ ] I can create meaningful commit messages following conventions
- [ ] I know how to view commit history with `git log`

### Git Branching & Merging
- [ ] I can create and switch between branches
- [ ] I understand the difference between merge and rebase
- [ ] I can resolve merge conflicts
- [ ] I know when to use `git cherry-pick`

### Git Advanced Operations  
- [ ] I can amend the last commit without creating a new one
- [ ] I can perform interactive rebase to clean up commit history
- [ ] I understand the dangers of rewriting shared history
- [ ] I can create and manage pull requests

### Docker Basics
- [ ] I can explain the difference between an image and a container
- [ ] I can write a basic Dockerfile
- [ ] I can build and run containers with proper port mapping
- [ ] I understand Docker layering and caching

### Docker Compose
- [ ] I can define multi-service applications with docker-compose.yml
- [ ] I can configure volumes and environment variables
- [ ] I understand service networking in Docker Compose
- [ ] I can debug container issues using logs and exec

## 🧪 Practical Challenges

### Challenge 1: Git Workflow (15 min)
```bash
# Starting from main branch:
# 1. Create feature branch 'fix/telemetry-bug'
# 2. Make 3 commits with different changes
# 3. Squash them into 1 commit using interactive rebase
# 4. Create a PR

# Your commands here:
# ___________________
```

**Expected outcome:** Clean single commit ready for PR

### Challenge 2: Docker Multi-stage Build (20 min)
Create a Dockerfile that:
- Uses multi-stage build (builder + runtime)
- Installs dependencies in builder stage
- Copies only necessary files to runtime stage
- Runs as non-root user
- Includes health check

**Expected outcome:** Smaller, more secure image

### Challenge 3: Docker Compose Services (15 min)
Create a compose file with:
- Web service (Flask app)
- Database service (PostgreSQL)
- Redis service for caching
- Proper networking and volumes

**Expected outcome:** All services communicate correctly

## 🏎️ Formula Student Scenarios

### Scenario 1: Collaboration Conflict
Your teammate pushed changes to main while you were working on telemetry features. How do you:
1. Get the latest changes?
2. Integrate them with your work?
3. Resolve any conflicts?

**Your approach:**
```
___________________
```

### Scenario 2: Production Deployment
You need to deploy the telemetry system to the car's embedded computer. How do you:
1. Ensure the Docker image is optimized for ARM architecture?
2. Handle environment-specific configuration?
3. Set up health monitoring?

**Your approach:**
```
___________________
```

### Scenario 3: Emergency Hotfix
During a race, you discover a critical bug in the telemetry display. How do you:
1. Quickly create a hotfix without disrupting ongoing development?
2. Test the fix in isolation?
3. Deploy it rapidly?

**Your approach:**
```
___________________
```

## 📊 Self-Scoring

### Git Mastery (25 points)
- Basic operations (5 points): ___ / 5
- Branching & merging (5 points): ___ / 5
- Advanced operations (10 points): ___ / 10
- Challenge completion (5 points): ___ / 5

### Docker Mastery (25 points)
- Container basics (5 points): ___ / 5
- Dockerfile creation (5 points): ___ / 5
- Compose orchestration (10 points): ___ / 10
- Challenge completion (5 points): ___ / 5

### Formula Student Application (10 points)
- Scenario solutions (10 points): ___ / 10

**Total Score: ___ / 60**

## 🎖️ Mastery Levels

- **🥉 Bronze (36-45 points):** You have solid fundamentals and can work effectively in a team environment.

- **🥈 Silver (46-55 points):** You demonstrate advanced skills and can handle complex scenarios independently.

- **🥇 Gold (56-60 points):** You have mastery-level expertise and can mentor others in Git and Docker practices.

## 🚀 Next Steps

Based on your score, consider these next steps:

### If Bronze:
- Review challenging concepts
- Practice more complex workflows
- Pair program with experienced team members

### If Silver:
- Explore advanced Git features (hooks, submodules)
- Learn Docker security best practices
- Study CI/CD integration

### If Gold:
- Share knowledge through mentoring
- Contribute to team standards and processes
- Explore advanced orchestration (Kubernetes)

---

## 📚 Additional Resources

- [Git Documentation](https://git-scm.com/doc)
- [Docker Documentation](https://docs.docker.com/)
- [Formula Student Software Guidelines](https://github.com/formula-student-sw)
- [Conventional Commits](https://www.conventionalcommits.org/)

**💡 Tip:** Bookmark this assessment and retake it periodically to track your progress!