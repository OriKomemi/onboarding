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