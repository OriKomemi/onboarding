## 3) Docker Compose: Managing Multiple Services

**🎯 Goal:** Learn to orchestrate multiple containers working together

### What is Docker Compose?
- **Orchestration tool** for running multiple containers as a single application
- **YAML configuration** defines all your services, networks, and volumes
- **Single command** to start/stop entire application stack

### Why Use Docker Compose?
- **Real applications** often need multiple services (web, database, cache)
- **Development environment** that matches production
- **Team consistency** - everyone gets the same setup

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
    healthcheck:
      test: ["CMD", "python", "-c", "import urllib.request; urllib.request.urlopen('http://localhost:5000/')"]
      interval: 30s
      timeout: 10s
      retries: 3
    deploy:
      resources:
        limits:
          memory: 512M
        reservations:
          memory: 256M
```

Run:

```bash
docker compose up --build
# open another shell to tail logs or exec into container
# docker compose logs -f
# docker compose exec web sh
# docker compose down
```

### Understanding the Compose File

```yaml
services:                    # Define all containers
  web:                      # Service name
    build: .                # Build from local Dockerfile
    ports:                  # Map ports (host:container)
      - "5000:5000"
    volumes:                # Mount local files into container
      - .:/app:delegated    # Live code reloading for development
    environment:            # Set environment variables
      - FLASK_ENV=development
    healthcheck:            # Monitor service health
      test: ["CMD", "python", "-c", "..."]
      interval: 30s         # Check every 30 seconds
    deploy:                 # Resource constraints
      resources:
        limits:
          memory: 512M      # Maximum memory usage
```

### Run Your Multi-Service Application

```bash
# Start all services (builds images if needed)
docker compose up --build

# In another terminal, check running services
docker compose ps

# View logs from all services
docker compose logs -f

# Stop and clean up
docker compose down
```

**🔍 Key Compose Commands:**
- `up` - Start services
- `down` - Stop and remove services  
- `ps` - List running services
- `logs` - View service logs
- `exec` - Run commands in running containers

### Hands-On Exercise
**Challenge:** Add a second service named `worker` that prints a message every 5 seconds

**Hint:** Use `command:` to override the default startup command:
```yaml
worker:
  build: .
  command: ["sh", "-c", "while true; do echo 'Worker running...'; sleep 5; done"]
```

**Test:** After adding the worker service, run `docker compose up` and verify both services start.