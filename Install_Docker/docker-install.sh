#!/bin/bash

# ============================================================
# Docker Installation Script for Ubuntu
# ============================================================
# This script:
#   1. Updates the APT package index
#   2. Installs required dependencies
#   3. Adds Docker's official GPG key
#   4. Adds Docker's official APT repository
#   5. Installs Docker Engine and related plugins
#   6. Enables and starts the Docker service
#   7. Verifies that Docker is running
#   8. Runs the Docker hello-world test container
#
# Designed to run non-interactively.
# ============================================================

# Exit immediately if any command fails
set -e

# Prevent package installation prompts
export DEBIAN_FRONTEND=noninteractive


# ------------------------------------------------------------
# 1. Update the APT package index
# ------------------------------------------------------------
echo "Updating package index..."
sudo apt-get update -y


# ------------------------------------------------------------
# 2. Install required dependencies
# ------------------------------------------------------------
echo "Installing required packages..."
sudo apt-get install -y ca-certificates curl


# ------------------------------------------------------------
# 3. Add Docker's official GPG key
# ------------------------------------------------------------
echo "Adding Docker GPG key..."

# Create the APT keyrings directory if it does not exist
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker's official GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc

# Make the GPG key readable by APT
sudo chmod a+r /etc/apt/keyrings/docker.asc


# ------------------------------------------------------------
# 4. Add Docker's official APT repository
# ------------------------------------------------------------
echo "Adding Docker APT repository..."

sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF


# ------------------------------------------------------------
# 5. Update APT after adding the Docker repository
# ------------------------------------------------------------
echo "Updating package index with Docker repository..."
sudo apt-get update -y


# ------------------------------------------------------------
# 6. Install Docker Engine and plugins
# ------------------------------------------------------------
echo "Installing Docker..."

sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin


# ------------------------------------------------------------
# 7. Enable and start Docker
# ------------------------------------------------------------
# --now enables Docker at boot and starts it immediately.
echo "Enabling and starting Docker..."
sudo systemctl enable --now docker


# ------------------------------------------------------------
# 8. Verify Docker service
# ------------------------------------------------------------
# Do NOT use:
#   sudo systemctl status docker
#
# "systemctl status" may launch a pager such as "less", which
# waits for keyboard input and makes automation appear to stop.
#
# "systemctl is-active --quiet" performs the check without
# opening an interactive pager.
echo "Checking Docker service..."

if sudo systemctl is-active --quiet docker; then
    echo "Docker service is running."
else
    echo "ERROR: Docker service is not running."
    exit 1
fi


# ------------------------------------------------------------
# 9. Display installed Docker versions
# ------------------------------------------------------------
echo "Docker version:"
sudo docker --version

echo "Docker Compose version:"
sudo docker compose version


# ------------------------------------------------------------
# 10. Test Docker installation
# ------------------------------------------------------------
echo "Running Docker hello-world test..."
sudo docker run --rm hello-world


# ------------------------------------------------------------
# Installation complete
# ------------------------------------------------------------
echo "============================================================"
echo "Docker installation completed successfully."
echo "============================================================"
