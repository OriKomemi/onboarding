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