#!/bin/bash

set -e

echo "===== Updating System ====="
sudo apt update && sudo apt upgrade -y

echo "===== Installing Required Packages ====="
sudo apt install -y curl wget apt-transport-https ca-certificates software-properties-common conntrack

echo "===== Installing Docker ====="
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

echo "===== Installing kubectl ====="
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "===== Installing Minikube ====="
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "===== Starting Minikube Cluster ====="
minikube start --driver=docker

echo "===== Enabling Nginx Ingress ====="
minikube addons enable ingress

echo "===== Installation Complete ====="
echo "Please logout and login again for Docker group changes."
echo "Check versions:"
echo "docker --version"
echo "kubectl version --client"
echo "minikube version"