!/bin/bash

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

echo "===== Starting Minikube ====="
minikube start --driver=docker --memory=1900 --cpus=2

echo "===== Enabling Nginx Ingress ====="
minikube addons enable ingress

echo "===== Restarting System in 10 Seconds ====="
sleep 10
sudo reboot
