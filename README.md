# Docker

A non-interactive Bash script that installs Docker Engine on Ubuntu using Docker's official APT repository. It also installs Docker Buildx and the Docker Compose plugin, starts Docker, and runs a `hello-world` verification container.

## What is Docker?

Docker is a platform for packaging an application together with its runtime, libraries, and configuration into a portable unit. This helps the application run consistently across a developer machine, test environment, and server.

### What is a Docker image?

A Docker image is an immutable, read-only template used to create containers. An image can contain an operating-system base, application code, dependencies, and default configuration. Images are usually built from a `Dockerfile` or downloaded from a registry such as Docker Hub.

### What is a Docker container?

A Docker container is a runnable instance of an image. It adds a writable layer and runtime settings, such as environment variables, network ports, and mounted volumes. Containers can be started, stopped, removed, and recreated without changing the original image.

### Image vs. container

| Docker image | Docker container |
| --- | --- |
| A reusable, read-only blueprint. | A running or stopped instance created from an image. |
| Built locally or pulled from an image registry. | Created with `docker run` or `docker create`. |
| Does not execute by itself. | Executes the application process. |
| One image can create many containers. | Has its own writable changes and runtime configuration. |

## Requirements

- An Ubuntu system with `apt`, `systemd`, and internet access
- A user with `sudo` privileges
- Bash

> This script is intended for Ubuntu only. Do not run it on Debian, macOS, Windows, or other Linux distributions without adapting the repository configuration.

## Install Docker

Clone this repository, then run the script:

```bash
git clone <repository-url>
cd Docker
chmod +x docker-install.sh
./docker-install.sh
```

The script will request your `sudo` password if required. It performs these actions:

1. Updates the APT package index and installs `ca-certificates` and `curl`.
2. Adds Docker's official GPG key and stable APT repository.
3. Installs Docker Engine, Docker CLI, containerd, Buildx, and Docker Compose.
4. Enables and starts the Docker service.
5. Checks that Docker is active, prints version information, and runs `hello-world`.

## Verify the installation

After the script completes, confirm that Docker is available:

```bash
docker --version
docker compose version
sudo docker run --rm hello-world
```

## Optional: run Docker without `sudo`

By default, Docker commands require `sudo`. To allow the current user to run them directly, add the user to the `docker` group and then sign out and back in:

```bash
sudo usermod -aG docker "$USER"
```

Membership in the `docker` group provides privileges equivalent to root access. Only grant it to trusted users.

## Files

| File | Description |
| --- | --- |
| `docker-install.sh` | Installs and validates Docker Engine and its official plugins on Ubuntu. |

## Troubleshooting

- Ensure the host is a supported Ubuntu release and can reach `download.docker.com`.
- If the service check fails, inspect logs with `sudo journalctl -u docker --no-pager`.
- If Docker was previously installed from Ubuntu packages, remove or reconcile conflicting packages before rerunning the script.

For supported platforms and Docker's official installation guidance, see the [Docker Engine installation documentation](https://docs.docker.com/engine/install/ubuntu/).

## Common Docker commands

Run `docker <command> --help` to see all available options for a command.

### Image commands

| Command | Purpose |
| --- | --- |
| `docker image ls` | List local images. |
| `docker pull nginx:latest` | Download an image from a registry. |
| `docker build -t my-app:1.0 .` | Build an image from the `Dockerfile` in the current directory. |
| `docker tag my-app:1.0 my-registry/my-app:1.0` | Apply a new repository name and tag to an image. |
| `docker push my-registry/my-app:1.0` | Upload an image to a registry after logging in. |
| `docker image inspect <image>` | Display detailed image metadata. |
| `docker rmi <image>` | Remove a local image. |
| `docker image prune` | Remove unused dangling images. |

Replace `<image>` with an image name, tag, or ID from `docker image ls`.

### Container commands

| Command | Purpose |
| --- | --- |
| `docker ps` | List running containers. |
| `docker ps -a` | List all containers, including stopped containers. |
| `docker run -d --name web -p 8080:80 nginx` | Create and start a detached Nginx container, exposing it on port 8080. |
| `docker start <container>` | Start an existing stopped container. |
| `docker stop <container>` | Gracefully stop a running container. |
| `docker restart <container>` | Restart a container. |
| `docker rm <container>` | Remove a stopped container. |
| `docker rm -f <container>` | Force-remove a running or stopped container. |
| `docker logs -f <container>` | View and follow a container's logs. |
| `docker exec -it <container> sh` | Open an interactive shell inside a running container. |
| `docker inspect <container>` | Display detailed container configuration and state. |
| `docker cp <container>:/path/in/container ./local-path` | Copy files from a container to the local machine. |

Replace `<container>` with a container name or ID from `docker ps -a`.

### Useful system commands

| Command | Purpose |
| --- | --- |
| `docker version` | Show client and server version details. |
| `docker info` | Show Docker system-wide information. |
| `docker login` | Authenticate with a container registry. |
| `docker system df` | Show Docker disk usage. |
| `docker system prune` | Remove unused Docker objects; review the prompt carefully before confirming. |

For additional Docker commands and examples, refer to the [NextKodeschool Docker command reference](https://academy.nextkodeschool.com/devops/docker-setup/#docker-commands).
