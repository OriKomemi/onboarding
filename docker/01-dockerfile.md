## 1) Understanding Docker & Creating Your First Container

**🎯 Goal:** Learn Docker fundamentals and build your first containerized application

### What is Docker?
- **Container**: A lightweight, standalone package that includes everything needed to run an application
- **Image**: A template used to create containers (like a recipe)
- **Dockerfile**: Instructions for building an image

### The Demo Application
We'll containerize a simple Flask web app that shows the container's hostname:

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
RUN pip install --no-cache-dir -r requirements.txt \
    && adduser --disabled-password --gecos "" appuser \
    && chown -R appuser:appuser /app
COPY . .
USER appuser
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/')"
CMD ["python", "app.py"]
```

### Understanding the Dockerfile

Each line in the Dockerfile represents a "layer":

1. **`FROM python:3.11-slim`** - Start with a minimal Python base image
2. **`WORKDIR /app`** - Set the working directory inside container  
3. **`COPY requirements.txt ./`** - Copy dependency list first (for caching)
4. **`RUN pip install...`** - Install Python packages and create user
5. **`COPY . .`** - Copy application code
6. **`USER appuser`** - Switch to non-root user for security
7. **`EXPOSE 5000`** - Document which port the app uses
8. **`HEALTHCHECK`** - Automatically test if container is working
9. **`CMD ["python", "app.py"]`** - Command to run when container starts

**🔒 Security improvements:**
- **Non-root user** (`appuser`) prevents privilege escalation attacks
- **Health check** automatically detects if the app stops working
- **Proper file ownership** ensures appuser can access needed files

### Build and Run Your First Container

```bash
# Navigate to the app directory
cd docker/app

# Build the image (creates the template)
docker build -t hello-flask:dev .

# Run a container from the image
docker run --rm -p 5000:5000 --name hello hello-flask:dev

# Test in another terminal
curl http://localhost:5000
```

**🔍 What happened?**
- `docker build` created an image following the Dockerfile recipe
- `docker run` started a container from that image
- `-p 5000:5000` maps your computer's port 5000 to container's port 5000
- `--rm` automatically deletes the container when it stops



