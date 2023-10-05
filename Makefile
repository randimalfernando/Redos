.PHONY: check-docker install-docker start-docker pull-docker run-container

all: check-docker start-docker

check-docker:
    @command -v docker >/dev/null 2>&1 || { echo >&2 "Docker is not installed. Installing Docker..."; make install-docker; }

install-docker: check-docker
    @echo "Installing Docker on Ubuntu..."
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker

start-docker: check-docker
    @echo "Starting Docker daemon on Ubuntu..."
    sudo systemctl start docker

pull-docker: start-docker
    @echo "Pulling Docker image..."
    docker pull randimalfernando/redos:latest

run-container: pull-docker
    @echo "Running Docker container..."
    docker run -d -p 3000:3000 randimalfernando/redos:latest
