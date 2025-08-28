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

**Verification:**
```bash
# Check if container is running
docker ps | grep hello-flask
# Should show running container

# Test the application
curl http://localhost:5000
# Should return "Hello from <container-name>!"
```

**🚨 Troubleshooting:**
- **Port already in use** → Use different port: `docker run -p 5001:5000 ...`
- **Container won't start** → Check logs: `docker logs hello`
- **Can't connect to localhost:5000** → Verify port mapping with `docker ps`

---