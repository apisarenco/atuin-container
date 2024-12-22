# Docker container for atuin binary

This Dockerfile gets the binary from the [official releases](https://github.com/atuinsh/atuin/releases).

## Build the container
```bash
docker build --build-arg GIT_TAG=v18.3.0 .
```

## Using docker-compose
```bash
services:
  atuin:
    image: atuin
    build:
      context: .
    args:
      - GIT_TAG=v18.3.0
```
