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



