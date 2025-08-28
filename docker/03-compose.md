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

**Exercise:** Add a second service named `worker` running the same image printing a message every 5s (hint: use `command:` override).